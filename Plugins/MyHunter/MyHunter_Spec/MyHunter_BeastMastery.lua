-- ===================================================
-- MyHunter - MyHunter_BeastMastery.lua
-- Spécialisation Maîtrise des Bêtes - Turtle WoW
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_BeastMastery = {}

-- Héritage de la classe de base
setmetatable(MyHunter_BeastMastery, { __index = EmzTools.MyHunter_SpecBase })

MyHunter_BeastMastery.specName = "EMZTOOLS_MYHUNTER_SPEC_BEASTMASTERY"
MyHunter_BeastMastery.supportedClasses = { "HUNTER" }

-- ===================================================
-- ROTATION MAÎTRISE DES BÊTES
-- ===================================================

-- ROTATION PRINCIPALE - Distance
MyHunter_BeastMastery.spellPriority = {
    "Hunter's Mark",    -- Debuff single target
    "Kill Command",     -- Interaction familier mono-cible
    "Baited Shot",      -- Proc familier mono-cible
    "Aimed Shot",       -- Burst mono-cible
    "Serpent Sting",    -- Maintien DOT
    "Arcane Shot",      -- Filler mono-cible
    "Auto Shot",        -- Si plus de mana
}

-- ROTATION SECOURS MÊLÉE
MyHunter_BeastMastery.meleeSpellPriority = {
    "Mongoose Bite",    -- PRIORITÉ - Proc gratuit
    "Raptor Strike",    -- Secondaire - Coût mana
    "Attack",           -- Mêlée auto
}

-- ===================================================
-- ÉTAT SPÉCIFIQUE BEAST MASTERY
-- ===================================================

MyHunter_BeastMastery.specificState = {
    lastAimedShotTime = 0,
    lastKillCommandTime = 0,
    lastBaitedShotTime = 0,
    lastRaptorStrikeTime = 0,
    lastMongooseBiteTime = 0,
    aimedShotCooldown = 6,
    killCommandCooldown = 10,
    baitedShotCooldown = 8,
    raptorStrikeCooldown = 6,
    mongooseBiteCooldown = 5,
    petCriticalThisCycle = false,
}

-- ===================================================
-- STATISTIQUES SPÉCIFIQUES
-- ===================================================

MyHunter_BeastMastery.specificStats = {
    totalKillCommands = 0,
    totalBaitedShots = 0,
    totalAimedShots = 0,
    totalSerpentStings = 0,
    totalArcaneShots = 0,
    totalRaptorStrikes = 0,
    totalMongooseBites = 0,
    totalPetCriticals = 0,
}

-- ===================================================
-- INITIALISATION SPÉCIFIQUE
-- ===================================================

function MyHunter_BeastMastery:Initialize()
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

function MyHunter_BeastMastery:ResetSpecificStats()
    self.specificStats = {
        totalKillCommands = 0,
        totalBaitedShots = 0,
        totalAimedShots = 0,
        totalSerpentStings = 0,
        totalArcaneShots = 0,
        totalRaptorStrikes = 0,
        totalMongooseBites = 0,
        totalPetCriticals = 0,
    }
end

function MyHunter_BeastMastery:ResetSpecificState()
    self.specificState.lastAimedShotTime = 0
    self.specificState.lastKillCommandTime = 0
    self.specificState.lastBaitedShotTime = 0
    self.specificState.lastRaptorStrikeTime = 0
    self.specificState.lastMongooseBiteTime = 0
    self.specificState.petCriticalThisCycle = false
end

-- ===================================================
-- SYSTÈME D'ÉVÉNEMENTS SPÉCIFIQUE
-- ===================================================

function MyHunter_BeastMastery:InitializeEventFrame()
    if not self.eventFrame then
        self.eventFrame = CreateFrame("Frame", "MyHunterBeastMasteryEventFrame")
    end

    self.eventFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS")
    self.eventFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_SELF_MISSES")
    self.eventFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS")
    self.eventFrame:RegisterEvent("CHAT_MSG_COMBAT_CREATURE_VS_PARTY_MISSES")
    self.eventFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE")
    self.eventFrame:RegisterEvent("CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE")
    self.eventFrame:RegisterEvent("UNIT_PET")
    self.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

    self.eventFrame:SetScript("OnEvent", function()
        local event = arg1
        local message = arg2
        MyHunter_BeastMastery:OnEvent(event, message)
    end)

    self:UpdatePetGUID()
end

function MyHunter_BeastMastery:OnEvent(event, message)
    if event == "CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS" or
       event == "CHAT_MSG_COMBAT_CREATURE_VS_PARTY_HITS" or
       event == "CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE" or
       event == "CHAT_MSG_SPELL_CREATURE_VS_PARTY_DAMAGE" then

        self:ProcessCombatMessage(event, message)

    elseif event == "UNIT_PET" then
        if arg1 == "player" then
            self:UpdatePetGUID()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        self.specificState.petCriticalThisCycle = false
    end
end

function MyHunter_BeastMastery:ProcessCombatMessage(event, message)
    if not message then return end

    local petName = self:GetPetName()
    if not petName or not string.find(message, petName) then
        return
    end

    -- Détection des critiques du familier
    if string.find(message, "critique") or string.find(message, "critical") then
        if string.find(message, petName .. " crit") or string.find(message, petName .. " hit") then
            self:OnPetCriticalHit()
        end
    end
end

function MyHunter_BeastMastery:UpdatePetGUID()
    if self:HasPet() then
        self.petGUID = UnitGUID("pet")
    else
        self.petGUID = nil
    end
end

function MyHunter_BeastMastery:OnPetCriticalHit()
    self.specificState.petCriticalThisCycle = true
    self.specificStats.totalPetCriticals = self.specificStats.totalPetCriticals + 1
end

-- ===================================================
-- VÉRIFICATIONS DE SORTS SPÉCIFIQUES
-- ===================================================

function MyHunter_BeastMastery:HasKillCommand()
    return self:HasSpell("Kill Command")
end

function MyHunter_BeastMastery:HasBaitedShot()
    return self:HasSpell("Baited Shot")
end

function MyHunter_BeastMastery:HasRaptorStrike()
    return self:HasSpell("Raptor Strike")
end

function MyHunter_BeastMastery:HasMongooseBite()
    return self:HasSpell("Mongoose Bite")
end

function MyHunter_BeastMastery:CanUseAimedShotForPull()
    return self:HasSpell("Aimed Shot") and
           self:IsReady("Aimed Shot") and
           self:HasEnoughMana("Aimed Shot") and
           not self:IsPlayerMoving() and
           not self:InCombat()
end

-- ===================================================
-- ROTATIONS SPÉCIFIQUES
-- ===================================================

function MyHunter_BeastMastery:ExecuteRangedRotation(target)
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

function MyHunter_BeastMastery:ExecuteMeleeRotation(target)
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
-- LOGIQUE DE DÉCISION SPÉCIFIQUE
-- ===================================================

function MyHunter_BeastMastery:ShouldCastSpell(spellName, target)
    if spellName == "Kill Command" then
        return self:ShouldCastKillCommand(target)
    elseif spellName == "Baited Shot" then
        return self:ShouldCastBaitedShot(target)
    elseif spellName == "Aimed Shot" then
        return self:ShouldCastAimedShot(target)
    elseif spellName == "Serpent Sting" then
        return self:ShouldCastSerpentSting(target)
    elseif spellName == "Arcane Shot" then
        return self:ShouldCastArcaneShot(target)
    elseif spellName == "Hunter's Mark" then
        return self:ShouldCastHunterMark(target)
    end

    return false
end

function MyHunter_BeastMastery:ShouldCastMeleeSpell(spellName, target)
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

function MyHunter_BeastMastery:ShouldCastKillCommand(target)
    if not self:HasKillCommand() then return false end
    if not self:IsReady("Kill Command") then return false end
    if not self:HasEnoughMana("Kill Command") then return false end
    if self.combatState.inMeleeRange then return false end

    if self:IsSpellOnCooldown(self.specificState.lastKillCommandTime, self.specificState.killCommandCooldown) then
        return false
    end

    if not self:IsPetInCombat() then
        return false
    end

    return true
end

function MyHunter_BeastMastery:ShouldCastBaitedShot(target)
    if not self:HasBaitedShot() then return false end
    if not self:IsReady("Baited Shot") then return false end
    if not self:HasEnoughMana("Baited Shot") then return false end
    if self.combatState.inMeleeRange then return false end

    if self:IsSpellOnCooldown(self.specificState.lastBaitedShotTime, self.specificState.baitedShotCooldown) then
        return false
    end

    if not self.specificState.petCriticalThisCycle then
        return false
    end

    return true
end

function MyHunter_BeastMastery:ShouldCastAimedShot(target)
    if not self:HasSpell("Aimed Shot") then return false end
    if not self:IsReady("Aimed Shot") then return false end
    if not self:HasEnoughMana("Aimed Shot") then return false end
    if self:IsPlayerMoving() then return false end
    if self.combatState.inMeleeRange then return false end

    return not self:IsSpellOnCooldown(self.specificState.lastAimedShotTime, self.specificState.aimedShotCooldown)
end

function MyHunter_BeastMastery:ShouldCastRaptorStrike(target)
    if not self:HasRaptorStrike() then return false end
    if not self:IsReady("Raptor Strike") then return false end
    if not self:HasEnoughMana("Raptor Strike") then return false end
    if not self.combatState.inMeleeRange then return false end

    if self:IsSpellOnCooldown(self.specificState.lastRaptorStrikeTime, self.specificState.raptorStrikeCooldown) then
        return false
    end

    return true
end

function MyHunter_BeastMastery:ShouldCastMongooseBite(target)
    if not self:HasMongooseBite() then return false end
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

function MyHunter_BeastMastery:UpdateSpecificTiming(spellName)
    local currentTime = GetTime()

    if spellName == "Aimed Shot" then
        self.specificState.lastAimedShotTime = currentTime
    elseif spellName == "Kill Command" then
        self.specificState.lastKillCommandTime = currentTime
    elseif spellName == "Baited Shot" then
        self.specificState.lastBaitedShotTime = currentTime
        self.specificState.petCriticalThisCycle = false
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

function MyHunter_BeastMastery:RecordSpellCast(spellName)
    if spellName == "Kill Command" then
        self.specificStats.totalKillCommands = self.specificStats.totalKillCommands + 1
    elseif spellName == "Baited Shot" then
        self.specificStats.totalBaitedShots = self.specificStats.totalBaitedShots + 1
    elseif spellName == "Aimed Shot" then
        self.specificStats.totalAimedShots = self.specificStats.totalAimedShots + 1
    elseif spellName == "Serpent Sting" then
        self.specificStats.totalSerpentStings = self.specificStats.totalSerpentStings + 1
    elseif spellName == "Arcane Shot" then
        self.specificStats.totalArcaneShots = self.specificStats.totalArcaneShots + 1
    elseif spellName == "Raptor Strike" then
        self.specificStats.totalRaptorStrikes = self.specificStats.totalRaptorStrikes + 1
    elseif spellName == "Mongoose Bite" then
        self.specificStats.totalMongooseBites = self.specificStats.totalMongooseBites + 1
    end
end

-- ===================================================
-- STATISTIQUES COMBINÉES
-- ===================================================

function MyHunter_BeastMastery:GetStats()
    local baseStats = self.super.GetStats(self)
    local specificStats = self.specificStats

    local elapsedTime = GetTime() - self.stats.lastResetTime
    local minutes = math.max(1, math.floor(elapsedTime / 60))

    local stats = {}

    -- Statistiques de base
    stats["EMZTOOLS_MYHUNTER_STATS_DURATION"] = baseStats["EMZTOOLS_MYHUNTER_STATS_DURATION"] or string.format("%dm", minutes)

    -- Statistiques spécifiques
    stats["EMZTOOLS_MYHUNTER_STATS_KILL_COMMANDS"] = tostring(specificStats.totalKillCommands)
    stats["EMZTOOLS_MYHUNTER_STATS_BAITED_SHOTS"] = tostring(specificStats.totalBaitedShots)
    stats["EMZTOOLS_MYHUNTER_STATS_AIMED_SHOTS"] = tostring(specificStats.totalAimedShots)
    stats["EMZTOOLS_MYHUNTER_STATS_SERPENT_STINGS"] = tostring(specificStats.totalSerpentStings)
    stats["EMZTOOLS_MYHUNTER_STATS_ARCANE_SHOTS"] = tostring(specificStats.totalArcaneShots)
    stats["EMZTOOLS_MYHUNTER_STATS_RAPTOR_STRIKES"] = tostring(specificStats.totalRaptorStrikes)
    stats["EMZTOOLS_MYHUNTER_STATS_MONGOOSE_BITES"] = tostring(specificStats.totalMongooseBites)
    stats["EMZTOOLS_MYHUNTER_STATS_PET_CRITICALS"] = tostring(specificStats.totalPetCriticals)

    -- Statistiques calculées
    stats["EMZTOOLS_MYHUNTER_STATS_KILL_COMMANDS_PER_MIN"] = string.format("%.1f", specificStats.totalKillCommands / minutes)
    stats["EMZTOOLS_MYHUNTER_STATS_BAITED_SHOTS_PER_MIN"] = string.format("%.1f", specificStats.totalBaitedShots / minutes)
    stats["EMZTOOLS_MYHUNTER_STATS_MELEE_RATIO"] = string.format("%.1f%%", ((specificStats.totalRaptorStrikes + specificStats.totalMongooseBites) / math.max(1, specificStats.totalAimedShots + specificStats.totalRaptorStrikes + specificStats.totalMongooseBites)) * 100)

    if specificStats.totalPetCriticals > 0 then
        local baitedEfficiency = (specificStats.totalBaitedShots / specificStats.totalPetCriticals) * 100
        stats["EMZTOOLS_MYHUNTER_STATS_BAITED_EFFICIENCY"] = string.format("%.1f%%", baitedEfficiency)
    else
        stats["EMZTOOLS_MYHUNTER_STATS_BAITED_EFFICIENCY"] = "0%"
    end

    return stats
end

-- ===================================================
-- COMMANDES SLASH SPÉCIFIQUES
-- ===================================================

function MyHunter_BeastMastery:SlashCommandHandler(msg)
    local command = string.lower(strtrim(msg))

    if command == "" or command == "help" then
        self:PrintSpecificHelp()
    elseif command == "forceproc" then
        self:ForcePetProc()
    else
        -- Utiliser la gestion de commandes de base
        self.super.SlashCommandHandler(self, msg)
    end
end

function MyHunter_BeastMastery:PrintSpecificHelp()
    if not EmzTools or not EmzTools.Print then return end

    self.super.PrintHelp(self)
    EmzTools:Print("EMZTOOLS_MYHUNTER_BEASTMASTERY_COMMAND_FORCE_PROC", "noPrefix")
end

function MyHunter_BeastMastery:ForcePetProc()
    self.specificState.petCriticalThisCycle = true
    self.specificStats.totalPetCriticals = self.specificStats.totalPetCriticals + 1
    EmzTools:Print("EMZTOOLS_MYHUNTER_BEASTMASTERY_FORCE_PROC", "success")
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

if EmzTools then
    EmzTools.MyHunter_BeastMastery = MyHunter_BeastMastery
end

if MyHunter then
    MyHunter.Specs = MyHunter.Specs or {}
    MyHunter.Specs.BeastMastery = MyHunter_BeastMastery
end

return MyHunter_BeastMastery
