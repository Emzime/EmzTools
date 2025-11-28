-- ===============================================
-- EmzTools - Potions.lua
-- Base de données des potions de soin et de mana
-- ===============================================

-- Module principal Potions
EmzTools.Potions = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.Potions:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Potions")
    return true
end

EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Potions = EmzTools.Data.Potions or {}

-- ===================================================
-- FONCTION D'AIDE INTERNE
-- ===================================================

local function TableSize(t)
    if not t then return 0 end
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- ===================================================
-- BASE DE DONNÉES DES POTIONS DE SOIN
-- ===================================================

-- Potions de soin classées par niveau
EmzTools.Data.Potions.HealthPotions = {
    -- Niveau 1-10
    {
        name = "Minor Healing Potion",
        itemId = 118,
        minLevel = 1,
        maxLevel = 10,
        healing = 100,
    },
    -- Niveau 10-20
    {
        name = "Lesser Healing Potion",
        itemId = 858,
        minLevel = 10,
        maxLevel = 20,
        healing = 200,
    },
    -- Niveau 20-30
    {
        name = "Healing Potion",
        itemId = 929,
        minLevel = 20,
        maxLevel = 30,
        healing = 500,
    },
    -- Niveau 30-40
    {
        name = "Greater Healing Potion",
        itemId = 1710,
        minLevel = 30,
        maxLevel = 40,
        healing = 800,
    },
    -- Niveau 40-50
    {
        name = "Superior Healing Potion",
        itemId = 3928,
        minLevel = 40,
        maxLevel = 50,
        healing = 1200,
    },
    -- Niveau 50-60
    {
        name = "Major Healing Potion",
        itemId = 13446,
        minLevel = 50,
        maxLevel = 60,
        healing = 1800,
    }
}

-- ===================================================
-- BASE DE DONNÉES DES POTIONS DE MANA
-- ===================================================

-- Potions de mana classées par niveau
EmzTools.Data.Potions.ManaPotions = {
    -- Niveau 1-10
    {
        name = "Minor Mana Potion",
        itemId = 2455,
        minLevel = 1,
        maxLevel = 10,
        mana = 140,
    },
    -- Niveau 10-20
    {
        name = "Lesser Mana Potion",
        itemId = 3385,
        minLevel = 10,
        maxLevel = 20,
        mana = 280,
    },
    -- Niveau 20-30
    {
        name = "Mana Potion",
        itemId = 3827,
        minLevel = 20,
        maxLevel = 30,
        mana = 560,
    },
    -- Niveau 30-40
    {
        name = "Greater Mana Potion",
        itemId = 6149,
        minLevel = 30,
        maxLevel = 40,
        mana = 1000,
    },
    -- Niveau 40-50
    {
        name = "Superior Mana Potion",
        itemId = 13443,
        minLevel = 40,
        maxLevel = 50,
        mana = 1500,
    },
    -- Niveau 50-60
    {
        name = "Major Mana Potion",
        itemId = 13444,
        minLevel = 50,
        maxLevel = 60,
        mana = 2200,
    }
}

-- ===================================================
-- POTIONS SPÉCIALES
-- ===================================================

-- Pierres de soins (Warlock)
EmzTools.Data.Potions.Healthstones = {
    {
        name = "Minor Healthstone",
        itemId = 5512,
        minLevel = 1,
        maxLevel = 20,
        healing = 100,
    },
    {
        name = "Lesser Healthstone",
        itemId = 19004,
        minLevel = 20,
        maxLevel = 30,
        healing = 250,
    },
    {
        name = "Healthstone",
        itemId = 19005,
        minLevel = 30,
        maxLevel = 40,
        healing = 500,
    },
    {
        name = "Greater Healthstone",
        itemId = 19006,
        minLevel = 40,
        maxLevel = 50,
        healing = 800,
    },
    {
        name = "Major Healthstone",
        itemId = 19007,
        minLevel = 50,
        maxLevel = 60,
        healing = 1200,
    }
}

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

-- Trouve la meilleure potion de soin pour le niveau du joueur
function EmzTools.Data.Potions:GetBestHealthPotion()
    local level = UnitLevel("player")

    -- Chercher de la plus puissante à la plus faible
    for i = TableSize(self.HealthPotions), 1, -1 do
        local potion = self.HealthPotions[i]
        if level >= potion.minLevel then
            if EmzTools.Data.Utils and EmzTools.Data.Utils.HasItem then
                if EmzTools.Data.Utils:HasItem(potion.itemId) then
                    return potion
                end
            end
        end
    end

    return nil
end

-- Trouve la meilleure potion de mana pour le niveau du joueur
function EmzTools.Data.Potions:GetBestManaPotion()
    local level = UnitLevel("player")

    -- Chercher de la plus puissante à la plus faible
    for i = TableSize(self.ManaPotions), 1, -1 do
        local potion = self.ManaPotions[i]
        if level >= potion.minLevel then
            if EmzTools.Data.Utils and EmzTools.Data.Utils.HasItem then
                if EmzTools.Data.Utils:HasItem(potion.itemId) then
                    return potion
                end
            end
        end
    end

    return nil
end

-- Trouve la meilleure pierre de soin disponible
function EmzTools.Data.Potions:GetBestHealthstone()
    local level = UnitLevel("player")

    -- Chercher de la plus puissante à la plus faible
    for i = TableSize(self.Healthstones), 1, -1 do
        local stone = self.Healthstones[i]
        if level >= stone.minLevel then
            if EmzTools.Data.Utils and EmzTools.Data.Utils.HasItem then
                if EmzTools.Data.Utils:HasItem(stone.itemId) then
                    return stone
                end
            end
        end
    end

    return nil
end

-- Utilise la meilleure potion de soin disponible
function EmzTools.Data.Potions:UseHealthPotion()
    local potion = self:GetBestHealthPotion()

    if not potion then
        EmzTools:Print("EMZTOOLS_POTIONS_NO_HEALTH", "warning")
        return false
    end

    if EmzTools.Data.Utils and EmzTools.Data.Utils.UseItemByName then
        if EmzTools.Data.Utils:UseItemByName(potion.name) then
            EmzTools:Print("EMZTOOLS_POTIONS_USED", "success", potion.name)
            return true
        end
    end

    return false
end

-- Utilise la meilleure potion de mana disponible
function EmzTools.Data.Potions:UseManaPotion()
    local potion = self:GetBestManaPotion()

    if not potion then
        EmzTools:Print("EMZTOOLS_POTIONS_NO_MANA", "warning")
        return false
    end

    if EmzTools.Data.Utils and EmzTools.Data.Utils.UseItemByName then
        if EmzTools.Data.Utils:UseItemByName(potion.name) then
            EmzTools:Print("EMZTOOLS_POTIONS_USED", "success", potion.name)
            return true
        end
    end

    return false
end

-- Utilise la meilleure pierre de soin disponible
function EmzTools.Data.Potions:UseHealthstone()
    local stone = self:GetBestHealthstone()

    if not stone then
        EmzTools:Print("EMZTOOLS_POTIONS_NO_HEALTHSTONE", "warning")
        return false
    end

    if EmzTools.Data.Utils and EmzTools.Data.Utils.UseItemByName then
        if EmzTools.Data.Utils:UseItemByName(stone.name) then
            EmzTools:Print("EMZTOOLS_POTIONS_USED", "success", stone.name)
            return true
        end
    end

    return false
end

-- Choisit intelligemment la meilleure option de soin
function EmzTools.Data.Potions:SmartHeal()
    local hpPercent = 100
    if EmzTools.Data.Utils and EmzTools.Data.Utils.GetPlayerHPPercent then
        hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
    end

    if hpPercent >= 90 then
        EmzTools:Print("EMZTOOLS_POTIONS_FULL_HEALTH", "info")
        return false
    end

    -- Essayer pierre de soin en premier
    if self:GetBestHealthstone() then
        return self:UseHealthstone()
    end

    -- Puis potion de soin
    if self:GetBestHealthPotion() then
        return self:UseHealthPotion()
    end

    EmzTools:Print("EMZTOOLS_POTIONS_NO_HEALING_ITEMS", "warning")
    return false
end

-- ===================================================
-- INFORMATIONS
-- ===================================================

-- Affiche les potions disponibles
function EmzTools.Data.Potions:PrintAvailablePotions()
    EmzTools:Print("EMZTOOLS_POTIONS_AVAILABLE", "info")

    -- Potions de soin
    local healthPotion = self:GetBestHealthPotion()
    if healthPotion then
        local count = 0
        if EmzTools.Data.Utils and EmzTools.Data.Utils.GetItemCount then
            count = EmzTools.Data.Utils:GetItemCount(healthPotion.itemId)
        end
        EmzTools:Print("EMZTOOLS_POTIONS_HEALTH_INFO", "info", healthPotion.name, count)
    else
        EmzTools:Print("EMZTOOLS_POTIONS_NONE_HEALTH", "info")
    end

    -- Potions de mana
    local hasMana = true
    if EmzTools.Data.Utils and EmzTools.Data.Utils.PlayerHasMana then
        hasMana = EmzTools.Data.Utils:PlayerHasMana()
    end

    if hasMana then
        local manaPotion = self:GetBestManaPotion()
        if manaPotion then
            local count = 0
            if EmzTools.Data.Utils and EmzTools.Data.Utils.GetItemCount then
                count = EmzTools.Data.Utils:GetItemCount(manaPotion.itemId)
            end
            EmzTools:Print("EMZTOOLS_POTIONS_MANA_INFO", "info", manaPotion.name, count)
        else
            EmzTools:Print("EMZTOOLS_POTIONS_NONE_MANA", "info")
        end
    end

    -- Pierres de soin
    local healthstone = self:GetBestHealthstone()
    if healthstone then
        local count = 0
        if EmzTools.Data.Utils and EmzTools.Data.Utils.GetItemCount then
            count = EmzTools.Data.Utils:GetItemCount(healthstone.itemId)
        end
        EmzTools:Print("EMZTOOLS_POTIONS_HEALTHSTONE_INFO", "info", healthstone.name, count)
    else
        EmzTools:Print("EMZTOOLS_POTIONS_NONE_HEALTHSTONE", "info")
    end
end

-- Liste toutes les potions du niveau actuel
function EmzTools.Data.Potions:PrintRecommendedPotions()
    local level = UnitLevel("player")

    EmzTools:Print("EMZTOOLS_POTIONS_RECOMMENDED", "info", level)

    -- Potions de soin
    for _, potion in pairs(self.HealthPotions) do
        if level >= potion.minLevel and level <= potion.maxLevel then
            EmzTools:Print("EMZTOOLS_POTIONS_HEALTH_RECOMMEND", "info", potion.name, potion.healing)
            break
        end
    end

    -- Potions de mana
    local hasMana = true
    if EmzTools.Data.Utils and EmzTools.Data.Utils.PlayerHasMana then
        hasMana = EmzTools.Data.Utils:PlayerHasMana()
    end

    if hasMana then
        for _, potion in pairs(self.ManaPotions) do
            if level >= potion.minLevel and level <= potion.maxLevel then
                EmzTools:Print("EMZTOOLS_POTIONS_MANA_RECOMMEND", "info", potion.name, potion.mana)
                break
            end
        end
    end
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

-- Commande principale via /emz potions
function EmzTools.Potions:SlashCommand(msg)
    local command = string.lower(msg or "")

    if command == "" or command == "help" then
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_TITLE", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_LIST", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_RECOMMEND", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_HP", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_MANA", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_STONE", "info")
        EmzTools:Print("EMZTOOLS_POTIONS_HELP_SMART", "info")

    elseif command == "list" then
        self:PrintAvailablePotions()

    elseif command == "recommend" or command == "rec" then
        self:PrintRecommendedPotions()

    elseif command == "hp" or command == "health" then
        self:UseHealthPotion()

    elseif command == "mana" or command == "mp" then
        self:UseManaPotion()

    elseif command == "stone" or command == "hs" then
        self:UseHealthstone()

    elseif command == "smart" or command == "heal" then
        self:SmartHeal()

    else
        EmzTools:Print("EMZTOOLS_POTIONS_UNKNOWN_COMMAND", "warning")
    end
end

-- ===================================================
-- ENREGISTREMENT DES COMMANDES
-- ===================================================

-- Enregistrement dans le système de commandes principal EmzTools
if not EmzTools.SlashCommands then
    EmzTools.SlashCommands = {}
end

EmzTools.SlashCommands["potions"] = function(msg)
    EmzTools.Potions:SlashCommand(msg)
end

EmzTools.SlashCommands["pot"] = function(msg)
    EmzTools.Potions:SlashCommand(msg)
end
