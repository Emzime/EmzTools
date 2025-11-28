-- ===================================================
-- MyHunter - MyHunter_Marksman.lua
-- Spécialisation Précision - Turtle WoW
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_Marksman = {}

-- Héritage de la classe de base
setmetatable(MyHunter_Marksman, { __index = EmzTools.MyHunter_SpecBase })

MyHunter_Marksman.specName = "EMZTOOLS_MYHUNTER_SPEC_MARKSMANSHIP"
MyHunter_Marksman.supportedClasses = { "HUNTER" }

-- ===================================================
-- ROTATION PRÉCISION
-- ===================================================

-- ROTATION PRINCIPALE - Distance
MyHunter_Marksman.spellPriority = {
    "Rapid Fire",       -- 🎯 Burst DPS - PRIORITÉ ABSOLUE
    "Hunter's Mark",    -- Debuff single target
    "Aimed Shot",       -- Burst mono-cible
    "Serpent Sting",    -- Maintien DOT
    "Steady Shot",      -- DPS soutenu
    "Arcane Shot",      -- Filler instantané mono-cible
    "Auto Shot",        -- Si plus de mana
}

-- ROTATION SECOURS MÊLÉE
MyHunter_Marksman.meleeSpellPriority = {
    "Mongoose Bite",    -- PRIORITÉ - Proc gratuit
    "Raptor Strike",    -- Secondaire - Coût mana
    "Attack",           -- Mêlée auto
}

-- ===================================================
-- ÉTAT SPÉCIFIQUE PRÉCISION
-- ===================================================

MyHunter_Marksman.specificState = {
    lastAimedShotTime = 0,
    lastSteadyShotTime = 0,
    lastRaptorStrikeTime = 0,
    lastMongooseBiteTime = 0,
    aimedShotCooldown = 6,
    steadyShotDelay = 2.0,
    raptorStrikeCooldown = 6,
    mongooseBiteCooldown = 5,
    trueshotAuraActive = false,
    rapidFireEndTime = 0,
}

-- ===================================================
-- STATISTIQUES SPÉCIFIQUES
-- ===================================================

MyHunter_Marksman.specificStats = {
    totalAimedShots = 0,
    totalSteadyShots = 0,
    totalArcaneShots = 0,
    totalSerpentStings = 0,
    totalRaptorStrikes = 0,
    totalMongooseBites = 0,
    totalRapidFireUses = 0,
}

-- ===================================================
-- INITIALISATION SPÉCIFIQUE
-- ===================================================

function MyHunter_Marksman:Initialize()
    -- Appel de la méthode parente
    if not self.super then
        self.super = getmetatable(self).__index
    end
    self.super.Initialize(self)

    self:ResetSpecificStats()
    self:ResetSpecificState()
    self:InitializeUpdateFrame()

    return true
end

function MyHunter_Marksman:ResetSpecificStats()
    self.specificStats = {
        totalAimedShots = 0,
        totalSteadyShots = 0,
        totalArcaneShots = 0,
        totalSerpentStings = 0,
        totalRaptorStrikes = 0,
        totalMongooseBites = 0,
        totalRapidFireUses = 0,
    }
end

function MyHunter_Marksman:ResetSpecificState()
    self.specificState.lastAimedShotTime = 0
    self.specificState.lastSteadyShotTime = 0
    self.specificState.lastRaptorStrikeTime = 0
    self.specificState.lastMongooseBiteTime = 0
    self.specificState.trueshotAuraActive = false
    self.specificState.rapidFireEndTime = 0
end

-- ===================================================
-- MISE À JOUR SPÉCIFIQUE
-- ===================================================

function MyHunter_Marksman:InitializeUpdateFrame()
    if not self.updateFrame then
        self.updateFrame = CreateFrame("Frame", "MyHunterMarksmanUpdateFrame")
        self.updateFrame:SetScript("OnUpdate", function(self, elapsed)
            MyHunter_Marksman:OnUpdate(elapsed)
        end)
    end
end

function MyHunter_Marksman:OnUpdate(elapsed)
    -- Vérifier la fin de Rapid Fire
    if self.combatState.rapidFireActive and self.specificState.rapidFireEndTime > 0 then
        if GetTime() >= self.specificState.rapidFireEndTime then
            self.combatState.rapidFireActive = false
            self.specificState.rapidFireEndTime = 0
        end
    end
end

-- ===================================================
-- VÉRIFICATIONS DE SORTS SPÉCIFIQUES
-- ===================================================

function MyHunter_Marksman:HasTrueshotAura()
    return self:HasSpell("Trueshot Aura")
end

function MyHunter_Marksman:ShouldActivateTrueshotAura()
    return self:HasTrueshotAura() and
           not self.specificState.trueshotAuraActive and
           self:HasEnoughMana("Trueshot Aura")
end

-- ===================================================
-- GESTION DE RAPID FIRE SPÉCIFIQUE
-- ===================================================

function MyHunter_Marksman:ShouldUseRapidFire()
    if not self:HasSpell("Rapid Fire") then return false end
    if not self:IsReady("Rapid Fire") then return false end
    if self.combatState.rapidFireActive then return false end
    if not self:InCombat() then return false end
    if not UnitExists("target") then return false end

    -- Utiliser en début de combat ou pour burst
    local targetHealthPercent = (UnitHealth("target") / UnitHealthMax("target")) * 100

    -- Utiliser Rapid Fire si la cible a plus de 50% de PV pour maximiser le burst
    if targetHealthPercent > 50 then
        return true
    end

    -- Ou si on est en combat depuis plus de 10 secondes
    if self.combatState.combatStartTime and (GetTime() - self.combatState.combatStartTime) > 10 then
        return true
    end

    return false
end

function MyHunter_Marksman:OnRapidFireUsed()
    self.combatState.rapidFireActive = true
    self.specificState.rapidFireEndTime = GetTime() + 15 -- Durée de Rapid Fire
    self.specificStats.totalRapidFireUses = self.specificStats.totalRapidFireUses + 1
end

-- ===================================================
-- ROTATIONS SPÉCIFIQUES
-- ===================================================

function MyHunter_Marksman:ExecuteRangedRotation(target)
    for i = 1, #self.spellPriority do
        local spellName = self.spellPriority[i]
        if self:ShouldCastSpell(spellName, target) then
            if self:CastSpell(spellName, target) then
                self:RecordSpellCast(spellName)
                self:UpdateSpecificTiming(spellName)
                return true
            end
        end
    end

    -- Auto Shot de secours
    if self:ShouldCastAutoShot(target) then
        self:StartAutoShot()
        return true
    end

    return false
end

function MyHunter_Marksman:ExecuteMeleeRotation(target)
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

-- ===================================================
-- SÉQUENCE DE PULL SPÉCIFIQUE
-- ===================================================

function MyHunter_Marksman:ExecutePullSequence(target)
    if not self:CanCast() or not self:HasTarget(target) then
        return false
    end

    self:IsInMeleeRange(target)

    -- Si en mêlée, utiliser la rotation mêlée directement
    if self.combatState.inMeleeRange then
        return self:ExecuteMeleeRotation(target)
    end

    -- En combat à distance
    if not self:InCombat() then
        -- Activer Trueshot Aura si disponible
        if not self.specificState.trueshotAuraActive and self:ShouldActivateTrueshotAura() then
            if self:CastSpell("Trueshot Aura", "player") then
                self.specificState.trueshotAuraActive = true
                return true
            end
        end

        -- Appliquer Hunter's Mark
        if not self:TargetHasHunterMark(target) and self:ShouldCastHunterMark(target) then
            if self:CastSpell("Hunter's Mark", target) then
                return true
            end
        end
    end

    local pullExecuted = false

    -- Pull avec Aimed Shot si possible
    if self:CanUseAimedShotForPull() then
        if self:CastSpell("Aimed Shot", target) then
            self.specificState.lastAimedShotTime = GetTime()
            pullExecuted = true
        end
    end

    -- Sinon avec Serpent Sting
    if not pullExecuted and not self:TargetHasSerpentSting(target) and self:ShouldCastSerpentSting(target) then
        if self:CastSpell("Serpent Sting", target) then
            pullExecuted = true
        end
    end

    -- Ou avec Steady Shot
    if not pullExecuted and self:ShouldCastSteadyShot(target) then
        if self:CastSpell("Steady Shot", target) then
            self.specificState.lastSteadyShotTime = GetTime()
            pullExecuted = true
        end
    end

    if pullExecuted then
        self.combatState.hasPulled = true
        if not self.combatState.combatStartTime then
            self.combatState.combatStartTime = GetTime()
        end
        return true
    end

    self.combatState.hasPulled = true
    return false
end

function MyHunter_Marksman:CanUseAimedShotForPull()
    return self:HasSpell("Aimed Shot") and
           self:IsReady("Aimed Shot") and
           self:HasEnoughMana("Aimed Shot") and
           not self:IsPlayerMoving() and
           not self:InCombat()
end

-- ===================================================
-- LOGIQUE DE DÉCISION SPÉCIFIQUE
-- ===================================================

function MyHunter_Marksman:ShouldCastSpell(spellName, target)
    if spellName == "Rapid Fire" then
        return self:ShouldUseRapidFire()
    elseif spellName == "Aimed Shot" then
        return self:ShouldCastAimedShot(target)
    elseif spellName == "Steady Shot" then
        return self:ShouldCastSteadyShot(target)
    elseif spellName == "Serpent Sting" then
        return self:ShouldCastSerpentSting(target)
    elseif spellName == "Arcane Shot" then
        return self:ShouldCastArcaneShot(target)
    elseif spellName == "Hunter's Mark" then
        return self:ShouldCastHunterMark(target)
    end

    return false
end

function MyHunter_Marksman:ShouldCastMeleeSpell(spellName, target)
    if not self.combatState.inMeleeRange then
        return false
    end

    if spellName == "Raptor Strike" then
        return self:ShouldCastRaptorStrike(target)
    elseif spellName == "Mongoose Bite" then
        return self:ShouldCastMongooseBite(target)
    end

    return false
end

function MyHunter_Marksman:ShouldCastAimedShot(target)
    if not self:HasSpell("Aimed Shot") then return false end
    if not self:IsReady("Aimed Shot") then return false end
    if not self:HasEnoughMana("Aimed Shot") then return false end
    if self:IsPlayerMoving() then return false end
    if self.combatState.inMeleeRange then return false end

    return not self:IsSpellOnCooldown(self.specificState.lastAimedShotTime, self.specificState.aimedShotCooldown)
end

function MyHunter_Marksman:ShouldCastSteadyShot(target)
    if not self:HasSpell("Steady Shot") then return false end
    if not self:IsReady("Steady Shot") then return false end
    if not self:HasEnoughMana("Steady Shot") then return false end
    if self:IsPlayerMoving() then return false end
    if self.combatState.inMeleeRange then return false end

    return not self:IsSpellOnCooldown(self.specificState.lastSteadyShotTime, self.specificState.steadyShotDelay)
end

function MyHunter_Marksman:ShouldCastRaptorStrike(target)
    if not self:HasSpell("Raptor Strike") then return false end
    if not self:IsReady("Raptor Strike") then return false end
    if not self:HasEnoughMana("Raptor Strike") then return false end
    if not self.combatState.inMeleeRange then return false end

    if self:IsSpellOnCooldown(self.specificState.lastRaptorStrikeTime, self.specificState.raptorStrikeCooldown) then
        return false
    end

    return true
end

function MyHunter_Marksman:ShouldCastMongooseBite(target)
    if not self:HasSpell("Mongoose Bite") then return false end
    if not self:IsReady("Mongoose Bite") then return false end
    if not self:HasEnoughMana("Mongoose Bite") then return false end
    if not self.combatState.inMeleeRange then return false end

    if self:IsSpellOnCooldown(self.specificState.lastMongooseBiteTime, self.specificState.mongooseBiteCooldown) then
        return false
    end

    return true
end

-- ===================================================
-- GESTION DES TEMPORISATIONS SPÉCIFIQUES
-- ===================================================

function MyHunter_Marksman:UpdateSpecificTiming(spellName)
    local currentTime = GetTime()

    if spellName == "Aimed Shot" then
        self.specificState.lastAimedShotTime = currentTime
    elseif spellName == "Steady Shot" then
        self.specificState.lastSteadyShotTime = currentTime
    elseif spellName == "Raptor Strike" then
        self.specificState.lastRaptorStrikeTime = currentTime
    elseif spellName == "Mongoose Bite" then
        self.specificState.lastMongooseBiteTime = currentTime
    end

    -- Mise à jour de la base
    self:UpdateShotTiming(spellName)
end

-- ===================================================
-- ENREGISTREMENT DES STATISTIQUES
-- ===================================================

function MyHunter_Marksman:RecordSpellCast(spellName)
    if spellName == "Aimed Shot" then
        self.specificStats.totalAimedShots = self.specificStats.totalAimedShots + 1
    elseif spellName == "Steady Shot" then
        self.specificStats.totalSteadyShots = self.specificStats.totalSteadyShots + 1
    elseif spellName == "Arcane Shot" then
        self.specificStats.totalArcaneShots = self.specificStats.totalArcaneShots + 1
    elseif spellName == "Serpent Sting" then
        self.specificStats.totalSerpentStings = self.specificStats.totalSerpentStings + 1
    elseif spellName == "Raptor Strike" then
        self.specificStats.totalRaptorStrikes = self.specificStats.totalRaptorStrikes + 1
    elseif spellName == "Mongoose Bite" then
        self.specificStats.totalMongooseBites = self.specificStats.totalMongooseBites + 1
    elseif spellName == "Rapid Fire" then
        self.specificStats.totalRapidFireUses = self.specificStats.totalRapidFireUses + 1
    end
end

-- ===================================================
-- STATISTIQUES COMBINÉES
-- ===================================================

function MyHunter_Marksman:GetStats()
    local baseStats = self.super.GetStats(self)
    local specificStats = self.specificStats

    local elapsedTime = GetTime() - self.stats.lastResetTime
    local minutes = math.max(1, math.floor(elapsedTime / 60))

    local stats = {}

    -- Statistiques de base
    stats["EMZTOOLS_MYHUNTER_STATS_DURATION"] = baseStats["EMZTOOLS_MYHUNTER_STATS_DURATION"] or string.format("%dm", minutes)

    -- Statistiques spécifiques
    stats["EMZTOOLS_MYHUNTER_STATS_AIMED_SHOTS"] = tostring(specificStats.totalAimedShots)
    stats["EMZTOOLS_MYHUNTER_STATS_STEADY_SHOTS"] = tostring(specificStats.totalSteadyShots)
    stats["EMZTOOLS_MYHUNTER_STATS_ARCANE_SHOTS"] = tostring(specificStats.totalArcaneShots)
    stats["EMZTOOLS_MYHUNTER_STATS_SERPENT_STINGS"] = tostring(specificStats.totalSerpentStings)
    stats["EMZTOOLS_MYHUNTER_STATS_RAPTOR_STRIKES"] = tostring(specificStats.totalRaptorStrikes)
    stats["EMZTOOLS_MYHUNTER_STATS_MONGOOSE_BITES"] = tostring(specificStats.totalMongooseBites)
    stats["EMZTOOLS_MYHUNTER_STATS_RAPID_FIRE_USES"] = tostring(specificStats.totalRapidFireUses)

    -- Statistiques calculées
    stats["EMZTOOLS_MYHUNTER_STATS_AIMED_SHOTS_PER_MIN"] = string.format("%.1f", specificStats.totalAimedShots / minutes)
    stats["EMZTOOLS_MYHUNTER_STATS_STEADY_SHOTS_PER_MIN"] = string.format("%.1f", specificStats.totalSteadyShots / minutes)

    local totalShots = specificStats.totalAimedShots + specificStats.totalSteadyShots
    if totalShots > 0 then
        stats["EMZTOOLS_MYHUNTER_STATS_STEADY_SHOT_RATIO"] = string.format("%.1f%%", (specificStats.totalSteadyShots / totalShots) * 100)
    else
        stats["EMZTOOLS_MYHUNTER_STATS_STEADY_SHOT_RATIO"] = "0%"
    end

    local totalActions = totalShots + specificStats.totalRaptorStrikes + specificStats.totalMongooseBites
    if totalActions > 0 then
        stats["EMZTOOLS_MYHUNTER_STATS_MELEE_RATIO"] = string.format("%.1f%%", ((specificStats.totalRaptorStrikes + specificStats.totalMongooseBites) / totalActions) * 100)
    else
        stats["EMZTOOLS_MYHUNTER_STATS_MELEE_RATIO"] = "0%"
    end

    return stats
end

-- ===================================================
-- COMMANDES SLASH SPÉCIFIQUES
-- ===================================================

function MyHunter_Marksman:SlashCommandHandler(msg)
    local command, param = msg:match("^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "" or command == "help" then
        self:PrintSpecificHelp()
    elseif command == "trueshot" then
        self:ToggleTrueshotAura()
    else
        -- Utiliser la gestion de commandes de base
        self.super.SlashCommandHandler(self, msg)
    end
end

function MyHunter_Marksman:PrintSpecificHelp()
    if not EmzTools or not EmzTools.Print then return end

    self.super.PrintHelp(self)
    EmzTools:Print("EMZTOOLS_MYHUNTER_MARKSMAN_COMMAND_TRUESHOT", "noPrefix")
end

function MyHunter_Marksman:ToggleTrueshotAura()
    if self.specificState.trueshotAuraActive then
        self.specificState.trueshotAuraActive = false
        EmzTools:Print("EMZTOOLS_MYHUNTER_TRUESHOT_DEACTIVATED", "info")
    else
        if self:ShouldActivateTrueshotAura() then
            if self:CastSpell("Trueshot Aura", "player") then
                self.specificState.trueshotAuraActive = true
                EmzTools:Print("EMZTOOLS_MYHUNTER_TRUESHOT_ACTIVATED", "success")
            end
        end
    end
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

if EmzTools then
    EmzTools.MyHunter_Marksman = MyHunter_Marksman
end

if MyHunter then
    MyHunter.Specs = MyHunter.Specs or {}
    MyHunter.Specs.Marksmanship = MyHunter_Marksman
end

return MyHunter_Marksman
