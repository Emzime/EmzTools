-- ===================================================
-- EmzTools - Data/Database.lua
-- Système de gestion de base de données centralisé
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Module principal Database DANS Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Database = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

-- ===================================================
-- CONFIGURATION PAR DÉFAUT
-- ===================================================

local DEFAULT_VALUES = {
    debug = false,
    firstLoad = true,
    autoLoadPlugins = true
    -- Note: currentTheme a été déplacé vers UIConfig
}

-- ===================================================
-- Initialise le module Database
-- @return: boolean - true si initialisation réussie
-- ===================================================

function EmzTools.Data.Database:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Database")
    return true
end

-- ===================================================
-- FONCTION POUR GARANTIR QUE EmzToolsDB EXISTE
-- ===================================================

local function EnsureEmzToolsDB()
    if not EmzToolsDB then
        EmzToolsDB = {
            core = {},
            modules = {}
        }
        EmzTools:Print("EMZTOOLS_DATABASE_CREATED", "debug")
    end

    -- Assurer la structure de base
    if not EmzToolsDB.core then
        EmzToolsDB.core = {}
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    -- Appliquer les valeurs par défaut si manquantes (UNIQUEMENT les valeurs système)
    for key, defaultValue in pairs(DEFAULT_VALUES) do
        if EmzToolsDB.core[key] == nil then
            EmzToolsDB.core[key] = defaultValue
        end
    end

    -- Nettoyer l'ancienne structure de thème si elle existe (déplacée vers UIConfig)
    if EmzToolsDB.core.currentTheme then
        EmzTools:Print("EMZTOOLS_MIGRATION_CURRENT_THEME", "debug")

        -- Migrer vers UIConfig si nécessaire
        if not EmzToolsDB.modules.UIConfig then
            EmzToolsDB.modules.UIConfig = {
                enabled = true,
                settings = {}
            }
        end

        EmzToolsDB.modules.UIConfig.settings.currentTheme = EmzToolsDB.core.currentTheme
        EmzToolsDB.core.currentTheme = nil
    end

    -- Nettoyer les doublons et migrer les anciennes structures
    EmzTools.Data.Database:CleanupDuplicates()
end

-- ===================================================
-- FONCTION DE NETTOYAGE DES DOUBLONS
-- ===================================================

function EmzTools.Data.Database:CleanupDuplicates()
    -- Supprimer showMinimapButton du core si présent
    if EmzToolsDB.core.showMinimapButton ~= nil then
        EmzTools:Print("EMZTOOLS_MIGRATION_MINIMAP_BUTTON", "debug")
        -- Le module Minimap gérera cette valeur lors de son initialisation
        EmzToolsDB.core.showMinimapButton = nil
    end

    -- Migration des seuils de Potions vers Thresholds si nécessaire
    if EmzToolsDB.modules and EmzToolsDB.modules.Potions and EmzToolsDB.modules.Potions.settings then
        local potionConfig = EmzToolsDB.modules.Potions.settings

        -- Vérifier si des seuils sont dans Potions
        local thresholdKeys = {
            "aggressiveMode", "customManaThreshold", "customHealthThreshold",
            "aggressiveHealthThreshold", "aggressiveManaThreshold", "useCustomThresholds"
        }

        local hasThresholds = false
        for _, key in ipairs(thresholdKeys) do
            if potionConfig[key] ~= nil then
                hasThresholds = true
                break
            end
        end

        if hasThresholds then
            EmzTools:Print("EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS", "debug")

            -- Créer/initialiser Thresholds
            if not EmzToolsDB.modules.Thresholds then
                EmzToolsDB.modules.Thresholds = {
                    enabled = true,
                    settings = {}
                }
            elseif not EmzToolsDB.modules.Thresholds.settings then
                EmzToolsDB.modules.Thresholds.settings = {}
            end

            -- Migrer les seuils
            local thresholdConfig = EmzToolsDB.modules.Thresholds.settings
            for _, key in ipairs(thresholdKeys) do
                if potionConfig[key] ~= nil then
                    thresholdConfig[key] = potionConfig[key]
                    potionConfig[key] = nil
                end
            end

            -- Supprimer les clés config si elles existent
            if potionConfig.config then
                potionConfig.config = nil
            end
        end
    end

    -- Nettoyer les structures avec config inutiles dans tous les modules
    for moduleName, moduleData in pairs(EmzToolsDB.modules) do
        if moduleData.settings and moduleData.settings.config then
            EmzTools:Print("EMZTOOLS_MIGRATION_REMOVE_CONFIG_LEVEL", "debug", moduleName)

            -- Transférer toutes les clés du niveau config vers settings
            for key, value in pairs(moduleData.settings.config) do
                moduleData.settings[key] = value
            end

            -- Supprimer le niveau config
            moduleData.settings.config = nil
        end
    end

    -- Vérifier que UIConfig a currentTheme
    if EmzToolsDB.modules and EmzToolsDB.modules.UIConfig then
        if not EmzToolsDB.modules.UIConfig.settings then
            EmzToolsDB.modules.UIConfig.settings = {}
        end

        if not EmzToolsDB.modules.UIConfig.settings.currentTheme then
            EmzToolsDB.modules.UIConfig.settings.currentTheme = "BlackWhite"
        end
    end
end

-- ===================================================
-- INITIALIZATION
-- ===================================================

-- Initialise la base de données pour un module spécifique
-- @param moduleName: Nom du module
-- @param defaults: Table contenant les valeurs par défaut
function EmzTools.Data.Database:InitializeModule(moduleName, defaults)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    -- Créer l'entrée du module si elle n'existe pas
    if not EmzToolsDB.modules[moduleName] then
        EmzToolsDB.modules[moduleName] = {
            enabled = true,
            settings = {},
        }
    end

    -- Appliquer les valeurs par défaut directement dans settings
    if defaults and type(defaults) == "table" then
        for key, value in pairs(defaults) do
            if EmzToolsDB.modules[moduleName].settings[key] == nil then
                EmzToolsDB.modules[moduleName].settings[key] = value
            end
        end
    end

    EmzTools:Print("EMZTOOLS_DATABASE_MODULE_INITIALIZED", "debug", moduleName)
    return true
end

-- ===================================================
-- GET/SET OPERATIONS
-- ===================================================

-- Récupère une valeur depuis la base de données
-- @param moduleName: Nom du module
-- @param key: Clé de la valeur
-- @param defaultValue: Valeur par défaut si la clé n'existe pas
-- @return: Valeur stockée ou defaultValue
function EmzTools.Data.Database:Get(moduleName, key, defaultValue)
    if not moduleName or not key then
        return defaultValue
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    -- Pour le module "core", chercher dans EmzToolsDB.core
    if moduleName == "core" then
        local value = EmzToolsDB.core[key]
        return value ~= nil and value or defaultValue
    end

    -- Pour les autres modules
    if not EmzToolsDB.modules[moduleName] then
        return defaultValue
    end

    -- Accès direct aux settings
    local value = EmzToolsDB.modules[moduleName].settings[key]

    if value == nil then
        return defaultValue
    end

    return value
end

-- Définit une valeur dans la base de données
-- @param moduleName: Nom du module
-- @param key: Clé de la valeur
-- @param value: Valeur à stocker
-- @return: true si succès
function EmzTools.Data.Database:Set(moduleName, key, value)
    if not moduleName or not key then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    -- Pour le module "core", stocker dans EmzToolsDB.core
    if moduleName == "core" then
        EmzToolsDB.core[key] = value
        return true
    end

    -- Pour les autres modules
    if not EmzToolsDB.modules[moduleName] then
        EmzToolsDB.modules[moduleName] = {
            enabled = true,
            settings = {},
        }
    end

    -- Stocker directement dans settings
    EmzToolsDB.modules[moduleName].settings[key] = value

    return true
end

-- ===================================================
-- FONCTIONS SPÉCIALISÉES POUR LE CORE
-- ===================================================

-- Récupère une valeur du core
function EmzTools.Data.Database:GetCoreValue(key, defaultValue)
    return self:Get("core", key, defaultValue)
end

-- Définit une valeur du core
function EmzTools.Data.Database:SetCoreValue(key, value)
    return self:Set("core", key, value)
end

-- ===================================================
-- MODULE MANAGEMENT
-- ===================================================

-- Vérifie si un module est activé
-- @param moduleName: Nom du module
-- @return: true si le module est activé
function EmzTools.Data.Database:IsModuleEnabled(moduleName)
    if not moduleName then
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB.modules[moduleName] then
        return true -- Par défaut, un module est considéré comme activé s'il n'existe pas
    end

    return EmzToolsDB.modules[moduleName].enabled
end

-- Active ou désactive un module
-- @param moduleName: Nom du module
-- @param enabled: true pour activer, false pour désactiver
-- @return: true si succès
function EmzTools.Data.Database:SetModuleEnabled(moduleName, enabled)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB.modules[moduleName] then
        EmzToolsDB.modules[moduleName] = {
            enabled = true,
            settings = {},
        }
    end

    EmzToolsDB.modules[moduleName].enabled = enabled

    if enabled then
        EmzTools:Print("EMZTOOLS_MODULE_ENABLED", "success", moduleName)
    else
        EmzTools:Print("EMZTOOLS_MODULE_DISABLED", "warning", moduleName)
    end

    return true
end

-- ===================================================
-- RESET OPERATIONS
-- ===================================================

-- Réinitialise les paramètres d'un module
-- @param moduleName: Nom du module
-- @param defaults: Valeurs par défaut (optionnel)
-- @return: true si succès
function EmzTools.Data.Database:ResetModule(moduleName, defaults)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    -- Réinitialiser le module
    EmzToolsDB.modules[moduleName] = {
        enabled = true,
        settings = {},
    }

    -- Appliquer les valeurs par défaut si fournies
    if defaults and type(defaults) == "table" then
        for key, value in pairs(defaults) do
            EmzToolsDB.modules[moduleName].settings[key] = value
        end
    end

    EmzTools:Print("EMZTOOLS_MODULE_RESET", "success", moduleName)
    return true
end

-- Réinitialise toute la base de données
-- @return: true si succès
function EmzTools.Data.Database:ResetAll()
    -- Réinitialisation complète
    EmzToolsDB = {
        core = {},
        modules = {}
    }

    -- Appliquer les valeurs par défaut
    EnsureEmzToolsDB()

    EmzTools:Print("EMZTOOLS_DATABASE_RESET_COMPLETE", "warning")
    EmzTools:Print("EMZTOOLS_RELOAD_REQUIRED", "info")

    return true
end

-- ===================================================
-- IMPORT/EXPORT
-- ===================================================

-- Exporte les paramètres d'un module
-- @param moduleName: Nom du module
-- @return: Table contenant les paramètres
function EmzTools.Data.Database:ExportModule(moduleName)
    if not moduleName then
        return nil
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB.modules[moduleName] then
        return nil
    end

    -- Créer une copie profonde
    local export = {
        enabled = EmzToolsDB.modules[moduleName].enabled,
        settings = {},
    }

    for key, value in pairs(EmzToolsDB.modules[moduleName].settings) do
        export.settings[key] = value
    end

    return export
end

-- Importe les paramètres d'un module
-- @param moduleName: Nom du module
-- @param data: Table contenant les paramètres
-- @return: true si succès
function EmzTools.Data.Database:ImportModule(moduleName, data)
    if not moduleName or not data then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    -- Créer ou remplacer le module
    EmzToolsDB.modules[moduleName] = {
        enabled = data.enabled or true,
        settings = {},
    }

    -- Importer les paramètres
    if data.settings then
        for key, value in pairs(data.settings) do
            EmzToolsDB.modules[moduleName].settings[key] = value
        end
    end

    EmzTools:Print("EMZTOOLS_MODULE_IMPORT_SUCCESS", "success", moduleName)
    return true
end

-- ===================================================
-- DEBUGGING (uniquement en mode debug)
-- ===================================================

-- Liste tous les modules enregistrés
function EmzTools.Data.Database:ListModules()
    if not EmzToolsDB or not self:GetCoreValue("debug", false) then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    EmzTools:Print("EMZTOOLS_DATABASE_LIST_MODULES", "debug")

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB.modules then
        EmzTools:Print("EMZTOOLS_DATABASE_NO_MODULES", "debug")
        return
    end

    local count = 0
    for moduleName, moduleData in pairs(EmzToolsDB.modules) do
        local status = moduleData.enabled and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED"
        EmzTools:Print("  " .. moduleName .. " - " .. status, "debug")
        count = count + 1
    end

    EmzTools:Print(string.format("%s: %d", "EMZTOOLS_STATE_TOTAL", count), "debug")
end

-- Affiche les paramètres d'un module
-- @param moduleName: Nom du module
function EmzTools.Data.Database:PrintModule(moduleName)
    if not self:GetCoreValue("debug", false) then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "debug")
        return
    end

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB.modules[moduleName] then
        EmzTools:Print("EMZTOOLS_MODULE_NOT_FOUND", "debug", moduleName)
        return
    end

    EmzTools:Print("EMZTOOLS_DATABASE_MODULE_DETAILS", "debug", moduleName)

    local moduleData = EmzToolsDB.modules[moduleName]
    local status = moduleData.enabled and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED"
    EmzTools:Print(string.format("%s: %s", "EMZTOOLS_STATE_STATUS", status), "debug")

    EmzTools:Print("EMZTOOLS_STATE_SETTINGS" .. ":", "debug")

    local count = 0
    for key, value in pairs(moduleData.settings) do
        EmzTools:Print("  " .. key .. " = " .. tostring(value), "debug")
        count = count + 1
    end

    if count == 0 then
        EmzTools:Print("  " .. "EMZTOOLS_STATE_NO_SETTINGS", "debug")
    end
end

-- Affiche toutes les données de la base
function EmzTools.Data.Database:DumpAll()
    if not self:GetCoreValue("debug", false) then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    EmzTools:Print("EMZTOOLS_DATABASE_DUMP_ALL", "debug")

    -- Garantir que EmzToolsDB existe
    EnsureEmzToolsDB()

    if not EmzToolsDB then
        EmzTools:Print("EMZTOOLS_DATABASE_NOT_INITIALIZED", "debug")
        return
    end

    EmzTools:Print("EMZTOOLS_DATABASE_CORE_SETTINGS", "debug")
    if EmzToolsDB.core then
        for key, value in pairs(EmzToolsDB.core) do
            EmzTools:Print("  " .. key .. " = " .. tostring(value), "debug")
        end
    end

    EmzTools:Print("", "debug")
    self:ListModules()
end

-- ===================================================
-- FONCTION PUBLIQUE POUR INITIALISER EmzToolsDB
-- ===================================================

function EmzTools.Data.Database:EnsureDB()
    EnsureEmzToolsDB()
    return EmzToolsDB
end

-- ===================================================
-- COMPATIBILITÉ POUR Core.lua
-- ===================================================

-- Créer aussi une référence dans EmzTools.Database pour compatibilité
EmzTools.Database = EmzTools.Data.Database
