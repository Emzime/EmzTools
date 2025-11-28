-- ===================================================
-- EmzTools - Consumables.lua
-- Base de données de la nourriture et de l'eau
-- ===================================================

-- Module principal Consumables
EmzTools.Consumables = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.Consumables:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Consumables")
    return true
end

EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Consumables = EmzTools.Data.Consumables or {}

-- ===================================================
-- BASE DE DONNÉES DE LA NOURRITURE
-- ===================================================

-- Nourriture classée par niveau
EmzTools.Data.Consumables.Food = {
    -- Niveau 1-10
    {
        name = "Tough Jerky",
        itemId = 117,
        minLevel = 1,
        maxLevel = 10,
        hpPerTick = 61,
        duration = 18,
    },
    {
        name = "Melon Juice",
        itemId = 1205,
        minLevel = 1,
        maxLevel = 10,
        hpPerTick = 61,
        duration = 18,
    },
    -- Niveau 10-20
    {
        name = "Haunch of Meat",
        itemId = 2287,
        minLevel = 10,
        maxLevel = 20,
        hpPerTick = 243,
        duration = 21,
    },
    {
        name = "Mutton Chop",
        itemId = 3770,
        minLevel = 10,
        maxLevel = 20,
        hpPerTick = 243,
        duration = 21,
    },
    -- Niveau 20-30
    {
        name = "Roasted Quail",
        itemId = 2679,
        minLevel = 20,
        maxLevel = 30,
        hpPerTick = 552,
        duration = 24,
    },
    {
        name = "Cured Ham Steak",
        itemId = 3771,
        minLevel = 20,
        maxLevel = 30,
        hpPerTick = 552,
        duration = 24,
    },
    -- Niveau 30-40
    {
        name = "Roast Raptor",
        itemId = 12209,
        minLevel = 30,
        maxLevel = 40,
        hpPerTick = 874,
        duration = 27,
    },
    {
        name = "Smoked Bear Meat",
        itemId = 2685,
        minLevel = 30,
        maxLevel = 40,
        hpPerTick = 874,
        duration = 27,
    },
    -- Niveau 40-50
    {
        name = "Tender Wolf Steak",
        itemId = 12210,
        minLevel = 40,
        maxLevel = 50,
        hpPerTick = 1392,
        duration = 30,
    },
    {
        name = "Hot Smoked Bass",
        itemId = 6887,
        minLevel = 40,
        maxLevel = 50,
        hpPerTick = 1392,
        duration = 30,
    },
    -- Niveau 50-60
    {
        name = "Smoked Desert Dumplings",
        itemId = 8952,
        minLevel = 50,
        maxLevel = 60,
        hpPerTick = 2148,
        duration = 30,
    },
    {
        name = "Runn Tum Tuber Surprise",
        itemId = 18254,
        minLevel = 50,
        maxLevel = 60,
        hpPerTick = 2148,
        duration = 30,
    }
}

-- ===================================================
-- BASE DE DONNÉES DE L'EAU
-- ===================================================

-- Eau classée par niveau
EmzTools.Data.Consumables.Water = {
    -- Niveau 1-10
    {
        name = "Refreshing Spring Water",
        itemId = 159,
        minLevel = 1,
        maxLevel = 10,
        manaPerTick = 151,
        duration = 18,
    },
    -- Niveau 10-20
    {
        name = "Ice Cold Milk",
        itemId = 1179,
        minLevel = 10,
        maxLevel = 20,
        manaPerTick = 436,
        duration = 21,
    },
    -- Niveau 20-30
    {
        name = "Melon Juice",
        itemId = 1205,
        minLevel = 20,
        maxLevel = 30,
        manaPerTick = 835,
        duration = 24,
    },
    -- Niveau 30-40
    {
        name = "Sweet Nectar",
        itemId = 1708,
        minLevel = 30,
        maxLevel = 40,
        manaPerTick = 1344,
        duration = 27,
    },
    -- Niveau 40-50
    {
        name = "Morning Glory Dew",
        itemId = 8766,
        minLevel = 40,
        maxLevel = 50,
        manaPerTick = 2934,
        duration = 30,
    }
}

-- ===================================================
-- BANDAGES
-- ===================================================

-- Bandages classés par niveau
EmzTools.Data.Consumables.Bandages = {
    {
        name = "Linen Bandage",
        itemId = 1251,
        minLevel = 1,
        maxLevel = 10,
        healing = 66,
    },
    {
        name = "Heavy Linen Bandage",
        itemId = 2581,
        minLevel = 10,
        maxLevel = 20,
        healing = 114,
    },
    {
        name = "Wool Bandage",
        itemId = 3530,
        minLevel = 20,
        maxLevel = 30,
        healing = 161,
    },
    {
        name = "Heavy Wool Bandage",
        itemId = 3531,
        minLevel = 30,
        maxLevel = 40,
        healing = 301,
    },
    {
        name = "Silk Bandage",
        itemId = 6450,
        minLevel = 40,
        maxLevel = 50,
        healing = 400,
    },
    {
        name = "Heavy Silk Bandage",
        itemId = 6451,
        minLevel = 50,
        maxLevel = 60,
        healing = 640,
    },
    {
        name = "Mageweave Bandage",
        itemId = 8544,
        minLevel = 60,
        maxLevel = 60,
        healing = 800,
    },
    {
        name = "Heavy Mageweave Bandage",
        itemId = 8545,
        minLevel = 60,
        maxLevel = 60,
        healing = 1104,
    },
    {
        name = "Runecloth Bandage",
        itemId = 14529,
        minLevel = 60,
        maxLevel = 60,
        healing = 1360,
    },
    {
        name = "Heavy Runecloth Bandage",
        itemId = 14530,
        minLevel = 60,
        maxLevel = 60,
        healing = 2000,
    }
}

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

-- Trouve la meilleure nourriture pour le niveau du joueur
-- @return: Table contenant les infos de la nourriture, ou nil
function EmzTools.Data.Consumables:GetBestFood()
    local level = UnitLevel("player")

    for i = table.getn(self.Food), 1, -1 do
        local food = self.Food[i]
        if level >= food.minLevel then
            if EmzTools.Data.Utils:HasItem(food.itemId) then
                return food
            end
        end
    end

    return nil
end

-- Trouve la meilleure eau pour le niveau du joueur
-- @return: Table contenant les infos de l'eau, ou nil
function EmzTools.Data.Consumables:GetBestWater()
    local level = UnitLevel("player")

    for i = table.getn(self.Water), 1, -1 do
        local water = self.Water[i]
        if level >= water.minLevel then
            if EmzTools.Data.Utils:HasItem(water.itemId) then
                return water
            end
        end
    end

    return nil
end

-- Trouve le meilleur bandage pour le niveau du joueur
-- @return: Table contenant les infos du bandage, ou nil
function EmzTools.Data.Consumables:GetBestBandage()
    local level = UnitLevel("player")

    for i = table.getn(self.Bandages), 1, -1 do
        local bandage = self.Bandages[i]
        if level >= bandage.minLevel then
            if EmzTools.Data.Utils:HasItem(bandage.itemId) then
                return bandage
            end
        end
    end
    
    return nil
end

-- Utilise la meilleure nourriture disponible
-- @return: true si la nourriture a été utilisée
function EmzTools.Data.Consumables:Eat()
    local food = self:GetBestFood()
    
    if not food then
        EmzTools:Print("EMZTOOLS_NO_FOOD_AVAILABLE", "warning")
        return false
    end

    -- Vérifier qu'on n'est pas déjà en train de manger
    if EmzTools.Data.Utils:IsSitting() then
        EmzTools:Print("EMZTOOLS_ALREADY_EATING_DRINKING", "info")
        return false
    end

    if EmzTools.Data.Utils:UseItemByName(food.name) then
        EmzTools:Print("EMZTOOLS_EATING", "success", food.name)
        return true
    end

    return false
end

-- Utilise la meilleure eau disponible
-- @return: true si l'eau a été utilisée
function EmzTools.Data.Consumables:Drink()
    local water = self:GetBestWater()

    if not water then
        EmzTools:Print("EMZTOOLS_NO_WATER_AVAILABLE", "warning")
        return false
    end

    -- Vérifier qu'on n'est pas déjà en train de boire
    if EmzTools.Data.Utils:IsSitting() then
        EmzTools:Print("EMZTOOLS_ALREADY_EATING_DRINKING", "info")
        return false
    end

    if EmzTools.Data.Utils:UseItemByName(water.name) then
        EmzTools:Print("EMZTOOLS_DRINKING", "success", water.name)
        return true
    end

    return false
end

-- Utilise le meilleur bandage disponible
-- @return: true si le bandage a été utilisé
function EmzTools.Data.Consumables:UseBandage()
    local bandage = self:GetBestBandage()

    if not bandage then
        EmzTools:Print("EMZTOOLS_NO_BANDAGE_AVAILABLE", "warning")
        return false
    end

    -- Vérifier qu'on n'est pas en combat
    if EmzTools.Data.Utils:IsInCombat() then
        EmzTools:Print("EMZTOOLS_CANNOT_BANDAGE_IN_COMBAT", "warning")
        return false
    end

    if EmzTools.Data.Utils:UseItemByName(bandage.name) then
        EmzTools:Print("EMZTOOLS_USING_BANDAGE", "success", bandage.name)
        return true
    end

    return false
end

-- Utilise intelligemment nourriture et/ou eau
-- @return: true si quelque chose a été utilisé
function EmzTools.Data.Consumables:Rest()
    local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()
    local hasMana = EmzTools.Data.Utils:PlayerHasMana()

    local needHP = hpPercent < 90
    local needMana = hasMana and manaPercent < 90

    if not needHP and not needMana then
        EmzTools:Print("EMZTOOLS_HP_MANA_FULL", "info")
        return false
    end

    -- Si on a besoin des deux
    if needHP and needMana then
        -- Essayer de trouver un item qui restaure les deux
        -- Pour l'instant, utiliser séparément
        local success = false
        if self:Eat() then
            success = true
        end
        if self:Drink() then
            success = true
        end
        return success
    end

    -- Si on a besoin seulement de HP
    if needHP then
        return self:Eat()
    end

    -- Si on a besoin seulement de mana
    if needMana then
        return self:Drink()
    end

    return false
end

-- ===================================================
-- INFORMATIONS
-- ===================================================

-- Affiche les consommables disponibles
function EmzTools.Data.Consumables:PrintAvailableConsumables()
    EmzTools:Print("EMZTOOLS_AVAILABLE_CONSUMABLES_HEADER", "info")

    -- Nourriture
    local food = self:GetBestFood()
    if food then
        local count = EmzTools.Data.Utils:GetItemCount(food.itemId)
        EmzTools:Print("EMZTOOLS_FOOD_INFO", "debug", food.name, count)
    else
        EmzTools:Print("EMZTOOLS_NO_FOOD", "debug")
    end

    -- Eau
    if EmzTools.Data.Utils:PlayerHasMana() then
        local water = self:GetBestWater()
        if water then
            local count = EmzTools.Data.Utils:GetItemCount(water.itemId)
            EmzTools:Print("EMZTOOLS_WATER_INFO", "debug", water.name, count)
        else
            EmzTools:Print("EMZTOOLS_NO_WATER", "debug")
        end
    end

    -- Bandages
    local bandage = self:GetBestBandage()
    if bandage then
        local count = EmzTools.Data.Utils:GetItemCount(bandage.itemId)
        EmzTools:Print("EMZTOOLS_BANDAGE_INFO", "debug", bandage.name, count)
    else
        EmzTools:Print("EMZTOOLS_NO_BANDAGE", "debug")
    end
end

-- ===================================================
-- GESTIONNAIRE DE COMMANDES POUR LE MODULE CONSUMABLES
-- ===================================================

-- Gestionnaire de commandes pour le module Consumables
-- @param command: La sous-commande
function EmzTools.Data.Consumables:SlashCommandHandler(command)
    if command == "" or command == "help" then
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMANDS_HEADER", "info")
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMAND_LIST", "noPrefix")
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMAND_EAT", "noPrefix")
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMAND_DRINK", "noPrefix")
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMAND_BANDAGE", "noPrefix")
        EmzTools:Print("EMZTOOLS_CONSUMABLES_COMMAND_REST", "noPrefix")

    elseif command == "list" then
        self:PrintAvailableConsumables()

    elseif command == "eat" or command == "food" then
        self:Eat()

    elseif command == "drink" or command == "water" then
        self:Drink()

    elseif command == "bandage" or command == "band" then
        self:UseBandage()

    elseif command == "rest" then
        self:Rest()

    else
        EmzTools:Print("EMZTOOLS_UNKNOWN_COMMAND_CONSUMABLES", "warning")
    end
end

-- ===================================================
-- ENREGISTREMENT DU MODULE
-- ===================================================

-- Enregistrer le module dans le système principal
EmzTools.Consumables = EmzTools.Data.Consumables

-- Définir les classes supportées (toutes les classes)
EmzTools.Consumables.supportedClasses = {
    "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST",
    "SHAMAN", "MAGE", "WARLOCK", "DRUID"
}

-- Fonction d'initialisation du module
function EmzTools.Consumables:Initialize()
    return true
end
