-- ===================================================================
-- EmzTools - Thresholds.lua
-- Système de seuils dynamiques unifié pour l'optimisation du farming
-- ===================================================================

-- Module principal Thresholds
EmzTools.Thresholds = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.Thresholds:Initialize()
    -- Initialiser les valeurs par défaut dans la base de données
    if not EmzTools.Database:Get("Thresholds", "initialized", false) then
        EmzTools.Database:Set("Thresholds", "aggressiveMode", false)
        EmzTools.Database:Set("Thresholds", "inGroup", false)
        EmzTools.Database:Set("Thresholds", "inPvPZone", false)
        EmzTools.Database:Set("Thresholds", "safetyMargin", 15)
        EmzTools.Database:Set("Thresholds", "initialized", true)
    end

    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Thresholds")
    return true
end

EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Thresholds = EmzTools.Data.Thresholds or {}

-- ===================================================
-- CONFIGURATION VIA BASE DE DONNÉES
-- ===================================================

-- Fonctions d'accès à la configuration
function EmzTools.Data.Thresholds:GetConfig(key, default)
    return EmzTools.Database:Get("Thresholds", key, default)
end

function EmzTools.Data.Thresholds:SetConfig(key, value)
    EmzTools.Database:Set("Thresholds", key, value)
end

-- ===================================================
-- SEUILS PAR NIVEAU ET CLASSE
-- ===================================================

-- Seuils de HP recommandés par niveau
local hpThresholds = {
    [1] = 50,   -- Niveau 1-10
    [10] = 45,  -- Niveau 10-20
    [20] = 40,  -- Niveau 20-30
    [30] = 35,  -- Niveau 30-40
    [40] = 35,  -- Niveau 40-50
    [50] = 30,  -- Niveau 50-60
    [60] = 30,  -- Niveau 60-70
}

-- Seuils de mana recommandés par niveau
local manaThresholds = {
    [1] = 30,   -- Niveau 1-10
    [10] = 25,  -- Niveau 10-20
    [20] = 20,  -- Niveau 20-30
    [30] = 20,  -- Niveau 30-40
    [40] = 15,  -- Niveau 40-50
    [50] = 15,  -- Niveau 50-60
    [60] = 15,  -- Niveau 60-70
}

-- Ajustements par classe
local classModifiers = {
    WARRIOR = { hp = 1.0, mana = 0, tank = true },
    ROGUE = { hp = 0.9, mana = 0, melee = true },
    HUNTER = { hp = 0.8, mana = 1.2, ranged = true },
    PALADIN = { hp = 1.1, mana = 1.0, hybrid = true },
    PRIEST = { hp = 0.7, mana = 1.3, caster = true },
    SHAMAN = { hp = 0.9, mana = 1.2, hybrid = true },
    MAGE = { hp = 0.6, mana = 1.4, caster = true },
    WARLOCK = { hp = 0.7, mana = 1.3, caster = true },
    DRUID = { hp = 0.8, mana = 1.2, hybrid = true },
}

-- ===================================================
-- CALCUL DES SEUILS DE BASE
-- ===================================================

-- Calcule le seuil de HP pour le niveau et la classe
function EmzTools.Data.Thresholds:GetHPThreshold(level, class)
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return 40 -- Valeur par défaut
    end

    level = level or UnitLevel("player")
    class = class or EmzTools.Data.Utils:GetPlayerClass()

    -- Trouver le seuil de base pour le niveau
    local baseThreshold = 40
    for lvl, threshold in pairs(hpThresholds) do
        if level >= lvl then
            baseThreshold = threshold
        end
    end

    -- Appliquer le modificateur de classe
    local modifier = 1.0
    if classModifiers[class] then
        modifier = classModifiers[class].hp
    end

    local threshold = baseThreshold * modifier

    -- Ajouter la marge de sécurité
    local aggressiveMode = self:GetConfig("aggressiveMode", false)
    if not aggressiveMode then
        local safetyMargin = self:GetConfig("safetyMargin", 15)
        threshold = threshold + safetyMargin
    end

    -- Limiter entre 20% et 80%
    threshold = math.max(20, math.min(80, threshold))

    return math.floor(threshold)
end

-- Calcule le seuil de mana pour le niveau et la classe
function EmzTools.Data.Thresholds:GetManaThreshold(level, class)
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return 25 -- Valeur par défaut
    end

    level = level or UnitLevel("player")
    class = class or EmzTools.Data.Utils:GetPlayerClass()

    -- Vérifier si la classe utilise de la mana
    if not EmzTools.Data.Utils:PlayerHasMana() then
        return 0
    end

    -- Trouver le seuil de base pour le niveau
    local baseThreshold = 25
    for lvl, threshold in pairs(manaThresholds) do
        if level >= lvl then
            baseThreshold = threshold
        end
    end

    -- Appliquer le modificateur de classe
    local modifier = 1.0
    if classModifiers[class] then
        modifier = classModifiers[class].mana
    end

    local threshold = baseThreshold * modifier

    -- Ajouter la marge de sécurité
    local aggressiveMode = self:GetConfig("aggressiveMode", false)
    if not aggressiveMode then
        local safetyMargin = self:GetConfig("safetyMargin", 15)
        threshold = threshold + (safetyMargin * 0.5)
    end

    -- Limiter entre 10% et 60%
    threshold = math.max(10, math.min(60, threshold))

    return math.floor(threshold)
end

-- Calcule le seuil de soin du pet
function EmzTools.Data.Thresholds:GetPetHealThreshold(level, class)
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return 60 -- Valeur par défaut
    end

    level = level or UnitLevel("player")
    class = class or EmzTools.Data.Utils:GetPlayerClass()

    -- Vérifier si la classe peut avoir un pet
    if not EmzTools.Data.Utils:PlayerCanHavePet() then
        return 0
    end

    -- Le pet doit être soigné plus tôt que le joueur
    local threshold = 60

    local aggressiveMode = self:GetConfig("aggressiveMode", false)
    if aggressiveMode then
        threshold = 50
    end

    return threshold
end

-- ===================================================
-- AJUSTEMENTS CONTEXTUELS
-- ===================================================

-- Ajuste les seuils en fonction du groupe/raid
function EmzTools.Data.Thresholds:GetGroupAdjustedThresholds(inGroup)
    inGroup = inGroup or self:GetConfig("inGroup", false)
    local level = UnitLevel("player")
    local class = EmzTools.Data.Utils:GetPlayerClass()

    local hp = self:GetHPThreshold(level, class)
    local mana = self:GetManaThreshold(level, class)

    if inGroup then
        -- En groupe, on peut se permettre de descendre plus bas
        hp = hp - 10
        if mana > 0 then mana = mana - 10 end
    end

    -- Limiter les valeurs
    hp = math.max(20, math.min(80, hp))
    mana = math.max(10, math.min(60, mana))

    return hp, mana
end

-- Ajuste les seuils en fonction de la zone PvP
function EmzTools.Data.Thresholds:GetPvPAdjustedThresholds(inPvP)
    inPvP = inPvP or self:GetConfig("inPvPZone", false)
    local level = UnitLevel("player")
    local class = EmzTools.Data.Utils:GetPlayerClass()

    local hp = self:GetHPThreshold(level, class)
    local mana = self:GetManaThreshold(level, class)

    if inPvP then
        -- En PvP, garder plus de ressources
        hp = hp + 15
        if mana > 0 then mana = mana + 15 end
    end

    -- Limiter les valeurs
    hp = math.max(20, math.min(80, hp))
    mana = math.max(10, math.min(60, mana))

    return hp, mana
end

-- ===================================================
-- ESTIMATION DES DÉGÂTS
-- ===================================================

-- Estime les dégâts reçus par mob selon le niveau
function EmzTools.Data.Thresholds:EstimateDamagePerMob(level, class)
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return 15 -- Valeur par défaut
    end

    level = level or UnitLevel("player")
    class = class or EmzTools.Data.Utils:GetPlayerClass()

    local damagePercent

    -- Dégâts de base selon le niveau
    if level <= 10 then
        damagePercent = 25
    elseif level <= 20 then
        damagePercent = 20
    elseif level <= 30 then
        damagePercent = 15
    elseif level <= 40 then
        damagePercent = 12
    else
        damagePercent = 10
    end

    -- Ajustements selon la classe
    if classModifiers[class] and classModifiers[class].tank then
        damagePercent = damagePercent * 0.7
    elseif classModifiers[class] and classModifiers[class].melee then
        damagePercent = damagePercent * 0.85
    elseif classModifiers[class] and classModifiers[class].caster then
        damagePercent = damagePercent * 1.2
    end

    return damagePercent
end

-- ===================================================
-- SEUILS PERSONNALISÉS
-- ===================================================

-- Définit un seuil personnalisé de HP
function EmzTools.Data.Thresholds:SetCustomHPThreshold(threshold)
    if threshold then
        threshold = math.max(10, math.min(90, threshold))
        self:SetConfig("customHPThreshold", threshold)
        EmzTools:Print("EMZTOOLS_THRESHOLDS_HP_SET", "success", threshold)
    else
        self:SetConfig("customHPThreshold", nil)
        EmzTools:Print("EMZTOOLS_THRESHOLDS_HP_RESET", "success")
    end
end

-- Définit un seuil personnalisé de mana
function EmzTools.Data.Thresholds:SetCustomManaThreshold(threshold)
    if threshold then
        threshold = math.max(5, math.min(80, threshold))
        self:SetConfig("customManaThreshold", threshold)
        EmzTools:Print("EMZTOOLS_THRESHOLDS_MANA_SET", "success", threshold)
    else
        self:SetConfig("customManaThreshold", nil)
        EmzTools:Print("EMZTOOLS_THRESHOLDS_MANA_RESET", "success")
    end
end

-- Récupère le seuil effectif de HP (personnalisé ou automatique)
function EmzTools.Data.Thresholds:GetEffectiveHPThreshold()
    local customThreshold = self:GetConfig("customHPThreshold")
    if customThreshold then
        return customThreshold
    end

    -- Appliquer les ajustements contextuels
    local hp, _ = self:GetGroupAdjustedThresholds()
    hp, _ = self:GetPvPAdjustedThresholds()

    return hp
end

-- Récupère le seuil effectif de mana (personnalisé ou automatique)
function EmzTools.Data.Thresholds:GetEffectiveManaThreshold()
    local customThreshold = self:GetConfig("customManaThreshold")
    if customThreshold then
        return customThreshold
    end

    -- Appliquer les ajustements contextuels
    local _, mana = self:GetGroupAdjustedThresholds()
    _, mana = self:GetPvPAdjustedThresholds()

    return mana
end

-- ===================================================
-- RECOMMANDATIONS INTELLIGENTES
-- ===================================================

-- Vérifie si le joueur devrait se reposer
function EmzTools.Data.Thresholds:ShouldRest()
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return false
    end

    local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()

    local hpThreshold = self:GetEffectiveHPThreshold()
    local manaThreshold = self:GetEffectiveManaThreshold()

    -- Vérifier HP
    if hpPercent <= hpThreshold then
        return true
    end

    -- Vérifier mana si applicable
    if EmzTools.Data.Utils:PlayerHasMana() and manaPercent <= manaThreshold then
        return true
    end

    return false
end

-- Estime le nombre de mobs que le joueur peut tuer avant de se reposer
function EmzTools.Data.Thresholds:EstimateMobsBeforeRest()
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return 5 -- Valeur par défaut
    end

    local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()

    local hpThreshold = self:GetEffectiveHPThreshold()
    local manaThreshold = self:GetEffectiveManaThreshold()

    -- HP disponible avant repos
    local hpBuffer = math.max(0, hpPercent - hpThreshold)

    -- Mana disponible avant repos
    local manaBuffer = 0
    if EmzTools.Data.Utils:PlayerHasMana() then
        manaBuffer = math.max(0, manaPercent - manaThreshold)
    end

    -- Estimation basée sur les dégâts par mob
    local damagePerMob = self:EstimateDamagePerMob()
    local mobsFromHP = math.floor(hpBuffer / damagePerMob)

    -- Estimation mana (simplifiée)
    local mobsFromMana = 10
    if EmzTools.Data.Utils:PlayerHasMana() then
        mobsFromMana = math.floor(manaBuffer / 15)
    end

    -- Prendre le minimum des deux
    local estimatedMobs = mobsFromHP
    if EmzTools.Data.Utils:PlayerHasMana() then
        estimatedMobs = math.min(mobsFromHP, mobsFromMana)
    end

    -- Limiter entre 0 et 10
    return math.max(0, math.min(10, estimatedMobs))
end

-- Recommandation intelligente de consommation
function EmzTools.Data.Thresholds:GetConsumeRecommendation()
    local shouldEat, shouldDrink = self:ShouldConsume()

    if shouldEat and shouldDrink then
        return "EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"
    elseif shouldEat then
        return "EMZTOOLS_CONSUME_REASON_LOW_HP"
    elseif shouldDrink then
        return "EMZTOOLS_CONSUME_REASON_LOW_MANA"
    else
        return "EMZTOOLS_CONSUME_REASON_OK"
    end
end

-- Détermine si c'est le bon moment pour consommer
function EmzTools.Data.Thresholds:ShouldConsume()
    -- Ne jamais consommer en combat
    if UnitAffectingCombat("player") then
        return false, false
    end

    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return false, false
    end

    local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()

    local hpThreshold = self:GetEffectiveHPThreshold()
    local manaThreshold = self:GetEffectiveManaThreshold()

    local shouldEat = hpPercent < hpThreshold
    local shouldDrink = EmzTools.Data.Utils:PlayerHasMana() and manaPercent < manaThreshold

    return shouldEat, shouldDrink
end

-- Obtient un message de recommandation complet
function EmzTools.Data.Thresholds:GetRecommendationMessage()
    if self:ShouldRest() then
        return "EMZTOOLS_FARMING_RECOMMEND_REST"
    end

    local mobsLeft = self:EstimateMobsBeforeRest()

    if mobsLeft == 0 then
        return "EMZTOOLS_THRESHOLDS_REST_NOW"
    elseif mobsLeft <= 2 then
        return string.format("EMZTOOLS_THRESHOLDS_REST_SOON", mobsLeft)
    else
        return string.format("EMZTOOLS_THRESHOLDS_GOOD_CONTINUE", mobsLeft)
    end
end

-- ===================================================
-- MODE AGRESSIF ET CONFIGURATION
-- ===================================================

-- Active/désactive le mode agressif
function EmzTools.Data.Thresholds:ToggleAggressiveMode()
    local current = self:GetConfig("aggressiveMode", false)
    self:SetConfig("aggressiveMode", not current)

    if not current then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON", "warning")
    else
        EmzTools:Print("EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF", "success")
    end
end

-- Définit le statut de groupe
function EmzTools.Data.Thresholds:SetGroupStatus(inGroup)
    self:SetConfig("inGroup", inGroup)
    if inGroup then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_GROUP_MODE", "info")
    else
        EmzTools:Print("EMZTOOLS_THRESHOLDS_SOLO_MODE", "info")
    end
end

-- Définit le statut PvP
function EmzTools.Data.Thresholds:SetPvPStatus(inPvP)
    self:SetConfig("inPvPZone", inPvP)
    if inPvP then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_PVP_MODE", "warning")
    else
        EmzTools:Print("EMZTOOLS_THRESHOLDS_PVE_MODE", "info")
    end
end

-- ===================================================
-- AFFICHAGE ET RAPPORTS
-- ===================================================

-- Affiche les seuils actuels
function EmzTools.Data.Thresholds:PrintThresholds()
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return
    end

    local level = UnitLevel("player")
    local class = EmzTools.Data.Utils:GetPlayerClass()

    local hp = self:GetEffectiveHPThreshold()
    local mana = self:GetEffectiveManaThreshold()
    local petHeal = self:GetPetHealThreshold(level, class)
    local mobsLeft = self:EstimateMobsBeforeRest()

    EmzTools:Print("EMZTOOLS_THRESHOLDS_HEADER", "info", level, class)

    if EmzTools.Data.Utils:PlayerHasMana() then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_HP_MANA", "info", hp, mana)
    else
        EmzTools:Print("EMZTOOLS_THRESHOLDS_HP_ONLY", "info", hp)
    end

    if EmzTools.Data.Utils:PlayerCanHavePet() then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_PET_HEAL", "info", petHeal)
    end

    EmzTools:Print("EMZTOOLS_THRESHOLDS_MOBS_LEFT", "info", mobsLeft)

    local aggressiveMode = self:GetConfig("aggressiveMode", false)
    local aggressiveStatus = aggressiveMode and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED"
    EmzTools:Print("EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS", "info", aggressiveStatus)

    -- Afficher le contexte
    local inGroup = self:GetConfig("inGroup", false)
    local inPvPZone = self:GetConfig("inPvPZone", false)

    if inGroup then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_GROUP_ACTIVE", "info")
    end
    if inPvPZone then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_PVP_ACTIVE", "info")
    end
end

-- Affiche l'efficacité de farming
function EmzTools.Data.Thresholds:PrintFarmingEfficiency()
    -- Vérifier que Utils est chargé
    if not EmzTools.Data.Utils then
        EmzTools:Print("EMZTOOLS_UTILS_NOT_LOADED", "error")
        return
    end

    local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()
    local hpThreshold = self:GetEffectiveHPThreshold()
    local manaThreshold = self:GetEffectiveManaThreshold()
    local mobsLeft = self:EstimateMobsBeforeRest()
    local damagePerMob = self:EstimateDamagePerMob()

    EmzTools:Print("EMZTOOLS_FARMING_EFFICIENCY_HEADER", "info")

    if EmzTools.Data.Utils:PlayerHasMana() then
        EmzTools:Print("EMZTOOLS_FARMING_HP_MANA", "info", hpPercent, hpThreshold, manaPercent, manaThreshold)
    else
        EmzTools:Print("EMZTOOLS_FARMING_HP_ONLY", "info", hpPercent, hpThreshold)
    end

    EmzTools:Print("EMZTOOLS_FARMING_HP_BUFFER", "info", hpPercent - hpThreshold)
    EmzTools:Print("EMZTOOLS_FARMING_DAMAGE_PER_MOB", "info", damagePerMob)
    EmzTools:Print("EMZTOOLS_FARMING_MOBS_REMAINING", "info", mobsLeft)

    local recommendation = self:GetRecommendationMessage()
    EmzTools:Print(recommendation, "info")
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

-- Commande principale via /emz thresholds
function EmzTools.Thresholds:SlashCommand(msg)
    local command, arg1 = strsplit(" ", msg)
    command = string.lower(command or "")

    if command == "" or command == "help" then
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMANDS_HEADER", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_SHOW", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_HP", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_MANA", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_RESET", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_GROUP", "info")
        EmzTools:Print("EMZTOOLS_THRESHOLDS_COMMAND_PVP", "info")

    elseif command == "show" or command == "print" then
        EmzTools.Data.Thresholds:PrintThresholds()

    elseif command == "efficiency" or command == "eff" then
        EmzTools.Data.Thresholds:PrintFarmingEfficiency()

    elseif command == "sethp" then
        local value = tonumber(arg1)
        if value then
            EmzTools.Data.Thresholds:SetCustomHPThreshold(value)
        else
            EmzTools:Print("EMZTOOLS_THRESHOLDS_USAGE_HP", "error")
        end

    elseif command == "setmana" then
        local value = tonumber(arg1)
        if value then
            EmzTools.Data.Thresholds:SetCustomManaThreshold(value)
        else
            EmzTools:Print("EMZTOOLS_THRESHOLDS_USAGE_MANA", "error")
        end

    elseif command == "reset" then
        EmzTools.Data.Thresholds:SetCustomHPThreshold(nil)
        EmzTools.Data.Thresholds:SetCustomManaThreshold(nil)
        EmzTools:Print("EMZTOOLS_THRESHOLDS_RESET_ALL", "success")

    elseif command == "aggressive" or command == "aggro" then
        EmzTools.Data.Thresholds:ToggleAggressiveMode()

    elseif command == "group" then
        local inGroup = (arg1 == "on" or arg1 == "1" or arg1 == "true")
        EmzTools.Data.Thresholds:SetGroupStatus(inGroup)

    elseif command == "pvp" then
        local inPvP = (arg1 == "on" or arg1 == "1" or arg1 == "true")
        EmzTools.Data.Thresholds:SetPvPStatus(inPvP)

    else
        EmzTools:Print("EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND", "warning")
    end
end

-- ===================================================
-- ENREGISTREMENT DES COMMANDES
-- ===================================================

-- Enregistrement dans le système de commandes principal EmzTools
EmzTools.SlashCommands["thresholds"] = function(msg)
    EmzTools.Thresholds:SlashCommand(msg)
end

EmzTools.SlashCommands["thresh"] = function(msg)
    EmzTools.Thresholds:SlashCommand(msg)
end
