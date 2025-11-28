-- ===================================================
-- MyHunter - MyHunter_Survival.lua
-- Spécialisation Survie (Mêlée) - Turtle WoW
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_Survival = {}

-- Héritage de la classe de base
setmetatable(MyHunter_Survival, { __index = EmzTools.MyHunter_SpecBase })

MyHunter_Survival.specName = "EMZTOOLS_MYHUNTER_SPEC_SURVIVAL"
MyHunter_Survival.supportedClasses = { "HUNTER" }

-- ===================================================
-- ROTATION SURVIE - MÊLÉE PRINCIPALE
-- ===================================================

-- ROTATION PRINCIPALE SURVIE - Mêlée (PRIORITÉ)
MyHunter_Survival.meleeSpellPriority = {
    "Mongoose Bite",    -- PRIORITÉ ABSOLUE - Proc gratuit
    "Raptor Strike",    -- Secondaire - Coût mana
    "Attack",           -- Mêlée auto
}

-- ROTATION SECOURS DISTANCE
MyHunter_Survival.rangedSpellPriority = {
    "Serpent Sting",    -- DoT à distance
    "Arcane Shot",      -- Filler instantané
    "Auto Shot",        -- Si plus de mana
}

-- ===================================================
-- ÉTAT SPÉCIFIQUE SURVIE
-- ===================================================

MyHunter_Survival.specificState = {
    lastRaptorStrikeTime = 0,
    lastMongooseBiteTime = 0,
    lastSerpentStingTime = 0,
    lastArcaneShotTime = 0,
    raptorStrikeCooldown = 6,
    mongooseBiteCooldown = 5,
    serpentStingDuration = 15,
    arcaneShotCooldown = 6,
    hasRapidStrikes = false,
    serpentStingEndTime = 0,
}

-- ===================================================
-- STATISTIQUES SPÉCIFIQUES
-- ===================================================

MyHunter_Survival.specificStats = {
    totalRaptorStrikes = 0,
    totalMongooseBites = 0,
    totalSerpentStings = 0,
    totalArcaneShots = 0,
    totalAutoShots = 0,
    totalRapidFireUses = 0,
}

-- ===================================================
-- INITIALISATION SPÉCIFIQUE
-- ===================================================

function MyHunter_Survival:Initialize()
    -- Appel de la méthode parente
    if not self.super then
        self.super = getmetatable(self).__index
    end
    self.super.Initialize(self)

    self:ResetSpecificStats()
    self:ResetSpecificState()
    self:InitializeEventFrame()

    return true
end

function MyHunter_Survival:ResetSpecificStats()
    self.specificStats = {
        totalRaptorStrikes = 0,
        totalMongooseBites = 0,
        totalSerpentStings = 0,
        totalArcaneShots = 0,
        totalAutoShots = 0,
        totalRapidFireUses = 0,
    }
end

function MyHunter_Survival:ResetSpecificState()
    self.specificState.lastRaptorStrikeTime = 0
    self.specificState.lastMongooseBiteTime = 0
    self.specificState.lastSerpentStingTime = 0
    self.specificState.lastArcaneShotTime = 0
    self.specificState.hasRapidStrikes = self:HasRapidStrikesTalent()
    self.specificState.serpentStingEndTime = 0
end

-- ===================================================
-- SYSTÈME D'ÉVÉNEMENTS SPÉCIFIQUE
-- ===================================================

function MyHunter_Survival:InitializeEventFrame()
    if not self.eventFrame then
        self.eventFrame = CreateFrame("Frame", "MyHunterSurvivalEventFrame")
    end

    self.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    self.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    self.eventFrame:RegisterEvent("SPELLCAST_START")
    self.eventFrame:RegisterEvent("SPELLCAST_STOP")

    self.eventFrame:SetScript("OnEvent", function()
        local event = arg1
        local spellName = arg2
        MyHunter_Survival:OnEvent(event, spellName)
    end)
end

function MyHunter_Survival:OnEvent(event, spellName)
    if event == "PLAYER_REGEN_ENABLED" then
        self:OnCombatEnd()
    elseif event == "PLAYER_REGEN_DISABLED" then
        self:OnCombatStart()
    elseif event == "SPELLCAST_START" then
        if spellName == "Rapid Fire" then
            self.combatState.rapidFireActive = true
        end
    elseif event == "SPELLCAST_STOP" then
        if spellName == "Rapid Fire" then
            self.combatState.rapidFireActive = false
        end
    end
end

function MyHunter_Survival:OnCombatStart()
    self.combatState.combatStartTime = GetTime()
    self.specificState.hasRapidStrikes = self:HasRapidStrikesTalent()

    -- Attaquer avec le familier si disponible
    if self:HasPet() and not self:IsPetInCombat() then
        PetAttack()
    end
end

function MyHunter_Survival:OnCombatEnd()
    self.combatState.hasPulled = false
    self.combatState.rapidFireActive = false
    self.combatState.combatStartTime = 0
end

-- ===================================================
-- VÉRIFICATIONS DE SORTS SPÉCIFIQUES
-- ===================================================

function MyHunter_Survival:HasRaptorStrike()
    return self:HasSpell("Raptor Strike")
end

function MyHunter_Survival:HasMongooseBite()
    return self:HasSpell("Mongoose Bite")
end

function MyHunter_Survival:HasRapidStrikesTalent()
    return self:GetCurrentSpec() == "Survival"
end

-- ===================================================
-- COOLDOWNS AJUSTÉS AVEC TALENTS
-- ===================================================

function MyHunter_Survival:GetAdjustedRaptorStrikeCooldown()
    local baseCooldown = 6
    if self.specificState.hasRapidStrikes then
        return baseCooldown - 1
    end
    return baseCooldown
end

function MyHunter_Survival:GetAdjustedMongooseBiteCooldown()
    local baseCooldown = 5
    if self.specificState.hasRapidStrikes then
        return baseCooldown - 1
    end
    return baseCooldown
end

-- ===================================================
-- ROTATIONS SPÉCIFIQUES (SURVIE - MÊLÉE PRIORITAIRE)
-- ===================================================

function MyHunter_Survival:ExecuteRotation(target)
    if not self:CanCast() or not self:HasTarget(target) then
        return false
    end

    if not self:CanCastShot() then
        return false
    end

    self:IsInMeleeRange(target)

    -- Séquences d'attaque initiale
    if not self.combatState.hasPulled and not self:InCombat() then
        return self:ExecutePullSequence(target)
    end

    -- Gestion du familier
    self:ManagePet()

    -- Gestion de Rapid Fire
    if self:ShouldUseRapidFire() then
        if self:CastSpell("Rapid Fire", "player") then
            self:OnRapidFireUsed()
            self:RecordSpellCast("Rapid Fire")
            return true
        end
    end

    -- 🔥 SURVIE : Mêlée PRIORITAIRE, distance secondaire
    if self.combatState.inMeleeRange then
        return self:ExecuteMeleeRotation(target)
    else
        return self:ExecuteRangedRotation(target)
    end
end

function MyHunter_Survival:ExecuteMeleeRotation(target)
    -- SURVIE : Rotation mêlée prioritaire
    for i = 1, #self.meleeSpellPriority do
        local spellName = self.meleeSpellPriority[i]
        if self:ShouldCastMeleeSpell(spellName, target) then
            if self:CastSpell(spellName, target) then
                self:RecordSpellCast(spellName)
                self:UpdateSpecificTiming(spellName)
                return true
            end
        end
    end

    -- Attaque de mêlée de secours
    if self.combatState.inMeleeRange then
        self:StartMeleeAttack()
        return true
    end

    return false
end

function MyHunter_Survival:ExecuteRangedRotation(target)
    -- SURVIE : Rotation distance secondaire
    for i = 1, #self.rangedSpellPriority do
        local spellName = self.rangedSpellPriority[i]
        if self:ShouldCastRangedSpell(spellName, target) then
            if self:CastSpell(spellName, target) then
                self:RecordSpellCast(spellName)
                self:UpdateSpecificTiming(spellName)
                return true
            end
        end
    end

    -- Tir auto de secours
    if self:ShouldCastAutoShot(target) then
        self:StartAutoShot()
        return true
    end

    return false
end

-- ===================================================
-- LOGIQUE DE DÉCISION SPÉCIFIQUE SURVIE
-- ===================================================

function MyHunter_Survival:ShouldCastMeleeSpell(spellName, target)
    if not self.combatState.inMeleeRange then
        return false
    end

    if spellName == "Raptor Strike" then
        return self:ShouldCastRaptorStrike(target)
    elseif spellName == "Mongoose Bite" then
        return self:ShouldCastMongooseBite(target)
    elseif spellName == "Attack" then
        return self.combatState.inMeleeRange
    end

    return false
end

function MyHunter_Survival:ShouldCastRangedSpell(spellName, target)
    if self.combatState.inMeleeRange then
        return false -- SURVIE : Priorité à la mêlée
    end

    if spellName == "Serpent Sting" then
        return self:ShouldCastSerpentSting(target)
    elseif spellName == "Arcane Shot" then
        return self:ShouldCastArcaneShot(target)
    elseif spellName == "Auto Shot" then
        return self:ShouldCastAutoShot(target)
    end

    return false
end

function MyHunter_Survival:ShouldCastRaptorStrike(target)
    if not self:HasRaptorStrike() then return false end
    if not self:IsReady("Raptor Strike") then return false end
    if not self:HasEnoughMana("Raptor Strike") then return false end
    if not self.combatState.inMeleeRange then return false end

    local cooldown = self:GetAdjustedRaptorStrikeCooldown()
    return not self:IsSpellOnCooldown(self.specificState.lastRaptorStrikeTime, cooldown)
end

function MyHunter_Survival:ShouldCastMongooseBite(target)
    if not self:HasMongooseBite() then return false end
    if not self:IsReady("Mongoose Bite") then return false end
    if not self:HasEnoughMana("Mongoose Bite") then return false end
    if not self.combatState.inMeleeRange then return false end

    local cooldown = self:GetAdjustedMongooseBiteCooldown()
    return not self:IsSpellOnCooldown(self.specificState.lastMongooseBiteTime, cooldown)
end

-- ===================================================
-- GESTION DES TEMPORISATIONS SPÉCIFIQUES
-- ===================================================

function MyHunter_Survival:UpdateSpecificTiming(spellName)
    local currentTime = GetTime()

    if spellName == "Raptor Strike" then
        self.specificState.lastRaptorStrikeTime = currentTime
    elseif spellName == "Mongoose Bite" then
        self.specificState.lastMongooseBiteTime = currentTime
    elseif spellName == "Serpent Sting" then
        self.specificState.lastSerpentStingTime = currentTime
        self.specificState.serpentStingEndTime = currentTime + 15
    elseif spellName == "Arcane Shot" then
        self.specificState.lastArcaneShotTime = currentTime
    end

    -- Mise à jour de la base
    self:UpdateShotTiming(spellName)
end

-- ===================================================
-- ENREGISTREMENT DES STATISTIQUES
-- ===================================================

function MyHunter_Survival:RecordSpellCast(spellName)
    if spellName == "Raptor Strike" then
        self.specificStats.totalRaptorStrikes = self.specificStats.totalRaptorStrikes + 1
    elseif spellName == "Mongoose Bite" then
        self.specificStats.totalMongooseBites = self.specificStats.totalMongooseBites + 1
    elseif spellName == "Serpent Sting" then
        self.specificStats.totalSerpentStings = self.specificStats.totalSerpentStings + 1
    elseif spellName == "Arcane Shot" then
        self.specificStats.totalArcaneShots = self.specificStats.totalArcaneShots + 1
    elseif spellName == "Auto Shot" then
        self.specificStats.totalAutoShots = self.specificStats.totalAutoShots + 1
    elseif spellName == "Rapid Fire" then
        self.specificStats.totalRapidFireUses = self.specificStats.totalRapidFireUses + 1
    end
end

-- ===================================================
-- STATISTIQUES COMBINÉES
-- ===================================================

function MyHunter_Survival:GetStats()
    local baseStats = self.super.GetStats(self)
    local specificStats = self.specificStats

    local elapsedTime = GetTime() - self.stats.lastResetTime
    local minutes = math.max(1, math.floor(elapsedTime / 60))

    local stats = {}

    -- Statistiques de base
    stats["EMZTOOLS_MYHUNTER_STATS_DURATION"] = baseStats["EMZTOOLS_MYHUNTER_STATS_DURATION"] or string.format("%dm", minutes)

    -- Statistiques spécifiques
    stats["EMZTOOLS_MYHUNTER_STATS_RAPTOR_STRIKES"] = tostring(specificStats.totalRaptorStrikes)
    stats["EMZTOOLS_MYHUNTER_STATS_MONGOOSE_BITES"] = tostring(specificStats.totalMongooseBites)
    stats["EMZTOOLS_MYHUNTER_STATS_SERPENT_STINGS"] = tostring(specificStats.totalSerpentStings)
    stats["EMZTOOLS_MYHUNTER_STATS_ARCANE_SHOTS"] = tostring(specificStats.totalArcaneShots)
    stats["EMZTOOLS_MYHUNTER_STATS_AUTO_SHOTS"] = tostring(specificStats.totalAutoShots)
    stats["EMZTOOLS_MYHUNTER_STATS_RAPID_FIRE_USES"] = tostring(specificStats.totalRapidFireUses)

    -- Statistiques calculées
    stats["EMZTOOLS_MYHUNTER_STATS_RAPTOR_STRIKES_PER_MIN"] = string.format("%.1f", specificStats.totalRaptorStrikes / minutes)
    stats["EMZTOOLS_MYHUNTER_STATS_MONGOOSE_BITES_PER_MIN"] = string.format("%.1f", specificStats.totalMongooseBites / minutes)
    stats["EMZTOOLS_MYHUNTER_STATS_ARCANE_SHOTS_PER_MIN"] = string.format("%.1f", specificStats.totalArcaneShots / minutes)

    local totalMeleeAttacks = specificStats.totalRaptorStrikes + specificStats.totalMongooseBites
    local totalRangedAttacks = specificStats.totalArcaneShots + specificStats.totalAutoShots + specificStats.totalSerpentStings
    local totalAttacks = totalMeleeAttacks + totalRangedAttacks

    if totalAttacks > 0 then
        stats["EMZTOOLS_MYHUNTER_STATS_MELEE_RATIO"] = string.format("%.1f%%", (totalMeleeAttacks / totalAttacks) * 100)
        stats["EMZTOOLS_MYHUNTER_STATS_RANGED_RATIO"] = string.format("%.1f%%", (totalRangedAttacks / totalAttacks) * 100)
    else
        stats["EMZTOOLS_MYHUNTER_STATS_MELEE_RATIO"] = "0%"
        stats["EMZTOOLS_MYHUNTER_STATS_RANGED_RATIO"] = "0%"
    end

    if self.specificState.hasRapidStrikes then
        stats["EMZTOOLS_MYHUNTER_STATS_RAPID_STRIKES"] = "EMZTOOLS_STATE_ACTIVE"
    else
        stats["EMZTOOLS_MYHUNTER_STATS_RAPID_STRIKES"] = "EMZTOOLS_STATE_INACTIVE"
    end

    return stats
end

-- ===================================================
-- COMMANDES SLASH SPÉCIFIQUES
-- ===================================================

function MyHunter_Survival:SlashCommandHandler(msg)
    local command = string.lower(strtrim(msg))

    if command == "" or command == "help" then
        self:PrintSpecificHelp()
    elseif command == "rapidfire" then
        self:ToggleRapidFire()
    else
        -- Utiliser la gestion de commandes de base
        self.super.SlashCommandHandler(self, msg)
    end
end

function MyHunter_Survival:PrintSpecificHelp()
    if not EmzTools or not EmzTools.Print then return end

    self.super.PrintHelp(self)
    EmzTools:Print("EMZTOOLS_MYHUNTER_SURVIVAL_COMMAND_RAPIDFIRE", "noPrefix")
end

function MyHunter_Survival:ToggleRapidFire()
    if self.combatState.rapidFireActive then
        self.combatState.rapidFireActive = false
        EmzTools:Print("EMZTOOLS_MYHUNTER_RAPIDFIRE_DEACTIVATED", "info")
    else
        if self:ShouldUseRapidFire() then
            if self:CastSpell("Rapid Fire", "player") then
                self.combatState.rapidFireActive = true
                EmzTools:Print("EMZTOOLS_MYHUNTER_RAPIDFIRE_ACTIVATED", "success")
            end
        end
    end
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

if EmzTools then
    EmzTools.MyHunter_Survival = MyHunter_Survival
end

if MyHunter then
    MyHunter.Specs = MyHunter.Specs or {}
    MyHunter.Specs.Survival = MyHunter_Survival
end

return MyHunter_Survival
