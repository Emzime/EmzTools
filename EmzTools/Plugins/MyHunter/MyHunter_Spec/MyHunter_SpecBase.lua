-- ===================================================
-- MyHunter - MyHunter_SpecBase.lua
-- Classe de base pour toutes les spécialisations
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_SpecBase = {}

-- Héritage des fonctions utilitaires
setmetatable(MyHunter_SpecBase, { __index = EmzTools.MyHunter_Utils })

MyHunter_SpecBase.supportedClasses = { "HUNTER" }

-- ===================================================
-- ÉTAT DE COMBAT STANDARD
-- ===================================================

MyHunter_SpecBase.combatState = {
    hasPulled = false,
    inMeleeRange = false,
    combatStartTime = 0,
    rapidFireActive = false,
    lastShotTimes = {}
}

-- ===================================================
-- STATISTIQUES STANDARD
-- ===================================================

MyHunter_SpecBase.stats = {
    lastResetTime = 0
}

-- ===================================================
-- MÉTHODES DE BASE
-- ===================================================

function MyHunter_SpecBase:Initialize()
    -- S'assurer que l'héritage fonctionne correctement
    if not getmetatable(self) or not getmetatable(self).__index then
        if EmzTools and EmzTools.MyHunter_Utils then
            setmetatable(self, { __index = EmzTools.MyHunter_Utils })
        end
    end

    -- Réinitialisation des statistiques
    self:ResetStats()
    self:ResetCombatState()

    if EmzTools then
        EmzTools:LoadPluginLocalization("MyHunter")
    end

    return true
end

function MyHunter_SpecBase:ResetStats()
    self.stats.lastResetTime = GetTime()
end

function MyHunter_SpecBase:ResetCombatState()
    self.combatState.hasPulled = false
    self.combatState.inMeleeRange = false
    self.combatState.combatStartTime = 0
    self.combatState.rapidFireActive = false
    self.combatState.lastShotTimes = {}
end

-- ===================================================
-- MÉTHODES DE LANCEMENT DE SORTS STANDARDISÉES
-- ===================================================

function MyHunter_SpecBase:CastSpell(spellName, target)
    -- VÉRIFICATIONS DE SÉCURITÉ
    if not spellName or type(spellName) ~= "string" then
        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print("CastSpell: nom de sort invalide", "error")
        end
        return false
    end

    if not EmzTools.MyHunter_Utils:CanCast() then
        return false
    end

    -- GESTION D'ERREUR POUR TOUS LES APPELS
    local success, result = pcall(function()
        -- VÉRIFICATIONS ORIGINALES (sécurisées)
        if not EmzTools.MyHunter_Utils:HasSpell(spellName) then
            return false
        end

        if not EmzTools.MyHunter_Utils:IsReady(spellName) then
            return false
        end

        if not EmzTools.MyHunter_Utils:HasEnoughMana(spellName) then
            return false
        end

        -- Vérifier la portée pour les sorts sur cible
        if target and target ~= "player" then
            if not EmzTools.MyHunter_Utils:IsInRange(spellName, target) then
                return false
            end
        end

        -- Lancer le sort avec gestion d'erreur
        CastSpellByName(spellName)

        -- Gérer le ciblage si nécessaire
        if SpellIsTargeting() then
            if target and target ~= "player" then
                SpellTargetUnit(target)
            else
                SpellStopTargeting()
                return false
            end
        end

        return true
    end)

    -- GESTION DES ERREURS
    if not success then
        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print(string.format("Erreur CastSpell %s: %s", spellName, result), "error")
        end
        return false
    end

    return result
end

-- ===================================================
-- VÉRIFICATIONS DE DISTANCE STANDARDISÉES
-- ===================================================

function MyHunter_SpecBase:IsInMeleeRange(target)
    target = target or "target"

    if not self:HasTarget(target) then
        self.combatState.inMeleeRange = false
        return false
    end

    local inRange = CheckInteractDistance(target, 3) -- 3 = portée de mêlée
    self.combatState.inMeleeRange = inRange

    return inRange
end

function MyHunter_SpecBase:ShouldUseMeleeRotation()
    return self.combatState.inMeleeRange
end

function MyHunter_SpecBase:ShouldUseRangedRotation()
    return not self.combatState.inMeleeRange
end

-- ===================================================
-- GESTION DES TEMPS DE RECHARGE STANDARDISÉE
-- ===================================================

function MyHunter_SpecBase:CanCastShot()
    local lastShotTimes = self.combatState.lastShotTimes or {}
    return EmzTools.MyHunter_Utils:CanCastShot(lastShotTimes, 1.5)
end

function MyHunter_SpecBase:UpdateShotTiming(spellName)
    EmzTools.MyHunter_Utils:UpdateShotTiming(self.combatState, spellName)
end

-- ===================================================
-- ACTIONS DE BASE STANDARDISÉES
-- ===================================================

function MyHunter_SpecBase:StartAutoShot()
    if not EmzTools.MyHunter_Utils:InCombat() then
        AttackTarget()
    end
    return true
end

function MyHunter_SpecBase:StartMeleeAttack()
    if self.combatState.inMeleeRange and not EmzTools.MyHunter_Utils:InCombat() then
        AttackTarget()
    end
    return true
end

-- ===================================================
-- SÉQUENCE DE PULL STANDARDISÉE
-- ===================================================

function MyHunter_SpecBase:ExecutePullSequence(target)
    if not EmzTools.MyHunter_Utils:CanCast() or not EmzTools.MyHunter_Utils:HasTarget(target) then
        return false
    end

    self:IsInMeleeRange(target)

    -- Si en mêlée, utiliser la rotation mêlée
    if self.combatState.inMeleeRange then
        return self:ExecuteMeleeRotation(target)
    end

    -- Hunter's Mark en pull
    if not EmzTools.MyHunter_Utils:TargetHasHunterMark(target) and self:ShouldCastHunterMark(target) then
        if self:CastSpell("Hunter's Mark", target) then
            return true
        end
    end

    -- Attaque du familier
    if EmzTools.MyHunter_Utils:HasPet() and not EmzTools.MyHunter_Utils:IsPetInCombat() then
        PetAttack()
    end

    self.combatState.hasPulled = true
    return false
end

-- ===================================================
-- VÉRIFICATIONS DE SORTS STANDARDISÉES
-- ===================================================

function MyHunter_SpecBase:ShouldCastHunterMark(target)
    if not EmzTools.MyHunter_Utils:HasSpell("Hunter's Mark") then return false end
    if not EmzTools.MyHunter_Utils:IsReady("Hunter's Mark") then return false end
    if EmzTools.MyHunter_Utils:TargetHasHunterMark(target) then return false end
    return EmzTools.MyHunter_Utils:HasEnoughMana("Hunter's Mark")
end

function MyHunter_SpecBase:ShouldCastSerpentSting(target)
    if not EmzTools.MyHunter_Utils:HasSpell("Serpent Sting") then return false end
    if not EmzTools.MyHunter_Utils:IsReady("Serpent Sting") then return false end
    if not EmzTools.MyHunter_Utils:HasEnoughMana("Serpent Sting") then return false end
    if EmzTools.MyHunter_Utils:IsTargetBlacklistedForPoison(target) then return false end
    if self.combatState.inMeleeRange then return false end

    -- Vérification simplifiée : si le debuff est déjà présent, ne pas relancer
    if EmzTools.MyHunter_Utils:TargetHasSerpentSting(target) then
        return false
    end

    return true
end

function MyHunter_SpecBase:ShouldCastArcaneShot(target)
    if not EmzTools.MyHunter_Utils:HasSpell("Arcane Shot") then return false end
    if not EmzTools.MyHunter_Utils:IsReady("Arcane Shot") then return false end
    if not EmzTools.MyHunter_Utils:HasEnoughMana("Arcane Shot") then return false end
    if self.combatState.inMeleeRange then return false end

    return true
end

-- ===================================================
-- GESTION DU COMBAT
-- ===================================================

function MyHunter_SpecBase:ExecuteRotation(target)
    -- VÉRIFICATIONS DE SÉCURITÉ
    if not EmzTools.MyHunter_Utils:CanCast() or not EmzTools.MyHunter_Utils:HasTarget(target) then
        return false
    end

    if not EmzTools.MyHunter_Utils:CanCastShot() then
        return false
    end

    -- EXÉCUTION SÉCURISÉE
    local success, result = pcall(function()
        self:IsInMeleeRange(target)

        -- Séquences d'attaque initiale
        if not self.combatState.hasPulled and not EmzTools.MyHunter_Utils:InCombat() then
            return self:ExecutePullSequence(target)
        end

        -- Gestion du familier
        EmzTools.MyHunter_Utils:ManagePet()

        -- Gestion de Rapid Fire
        if EmzTools.MyHunter_Utils:ShouldUseRapidFire() then
            if self:CastSpell("Rapid Fire", "player") then
                EmzTools.MyHunter_Utils:OnRapidFireUsed()
                self:RecordSpellCast("Rapid Fire")
                return true
            end
        end

        -- Choix de la rotation selon la distance
        if self.combatState.inMeleeRange then
            return self:ExecuteMeleeRotation(target)
        else
            return self:ExecuteRangedRotation(target)
        end
    end)

    -- GESTION DES ERREURS
    if not success then
        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print(string.format("Erreur ExecuteRotation: %s", result), "error")
        end
        -- Réinitialiser l'état en cas d'erreur critique
        self:ResetCombatState()
        return false
    end

    return result
end

-- ===================================================
-- MÉTHODES ABSTRAITES (À IMPLÉMENTER PAR LES SPÉCIALISATIONS)
-- ===================================================

function MyHunter_SpecBase:ExecuteMeleeRotation(target)
    -- À implémenter par les spécialisations
    return false
end

function MyHunter_SpecBase:ExecuteRangedRotation(target)
    -- À implémenter par les spécialisations
    return false
end

function MyHunter_SpecBase:GetStats()
    -- À implémenter par les spécialisations
    return {}
end

function MyHunter_SpecBase:RecordSpellCast(spellName)
    -- À implémenter par les spécialisations
end

-- ===================================================
-- COMMANDES SLASH STANDARD
-- ===================================================

function MyHunter_SpecBase:SlashCommandHandler(msg)
    local command = string.lower(strtrim(msg))

    if command == "" or command == "help" then
        self:PrintHelp()
    elseif command == "stats" then
        self:PrintStats()
    elseif command == "reset" then
        self:ResetStats()
    elseif command == "rotation" then
        self:PrintRotation()
    elseif command == "blacklist" then
        self:PrintBlacklist()
    elseif command == "clearblacklist" then
        self:ClearBlacklist()
    elseif command == "addblacklist" then
        self:AddCurrentTargetToBlacklist()
    elseif command == "debug" then
        self:PrintDebugInfo()
    else
        self:PrintHelp()
    end
end

function MyHunter_SpecBase:PrintHelp()
    if not EmzTools or not EmzTools.Print then return end

    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMANDS_HEADER", "info")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_STATS", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_RESET", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_ROTATION", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_BLACKLIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_CLEAR_BLACKLIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_ADD_BLACKLIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_COMMAND_DEBUG", "noPrefix")
end

function MyHunter_SpecBase:PrintStats()
    if not EmzTools or not EmzTools.Print then return end

    local stats = self:GetStats()
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_STATS_HEADER", "info")
    for key, value in pairs(stats) do
        EmzTools:Print("EMZTOOLS_MYHUNTER_STAT_LINE", "noPrefix", EmzTools:GetText(key), value)
    end
end

function MyHunter_SpecBase:PrintDebugInfo()
    if not EmzTools or not EmzTools.Print then return end

    EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_DEBUG_HEADER", "info")
    EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_IN_MELEE_RANGE", "noPrefix", tostring(self.combatState.inMeleeRange))
    EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_IN_COMBAT", "noPrefix", tostring(EmzTools.MyHunter_Utils:InCombat()))
    EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_RAPID_FIRE", "noPrefix", tostring(self.combatState.rapidFireActive))

    if EmzTools.MyHunter_Utils:HasTarget() then
        EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_TARGET_NAME", "noPrefix", UnitName("target"))
        EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_TARGET_SERPENT_STING", "noPrefix", tostring(EmzTools.MyHunter_Utils:TargetHasSerpentSting("target")))
        EmzTools:Print("EMZTOOLS_MYHUNTER_DEBUG_TARGET_BLACKLISTED", "noPrefix", tostring(EmzTools.MyHunter_Utils:IsTargetBlacklistedForPoison("target")))
    end
end

function MyHunter_SpecBase:AddCurrentTargetToBlacklist()
    if not EmzTools.MyHunter_Utils:HasTarget() then
        return
    end
    EmzTools.MyHunter_Utils:AddToPoisonBlacklist("target")
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

EmzTools.MyHunter_SpecBase = MyHunter_SpecBase

return MyHunter_SpecBase
