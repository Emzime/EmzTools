-- ===================================================
-- EmzTools - Database.lua
-- Système de gestion de base de données centralisé
-- ===================================================

-- Module principal Database
EmzTools.Database = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.Database:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Database")
    return true
end

EmzTools.Database = EmzTools.Database or {}

-- ===================================================
-- INITIALIZATION
-- ===================================================

-- Initialise la base de données pour un module spécifique
-- @param moduleName: Nom du module
-- @param defaults: Table contenant les valeurs par défaut
function EmzTools.Database:InitializeModule(moduleName, defaults)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    -- Vérifier que EmzToolsDB existe
    if not EmzToolsDB then
        EmzToolsDB = {}
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    -- Créer l'entrée du module si elle n'existe pas
    if not EmzToolsDB.modules[moduleName] then
        EmzToolsDB.modules[moduleName] = {
            enabled = true,
            settings = {},
        }
    end

    -- Appliquer les valeurs par défaut
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
function EmzTools.Database:Get(moduleName, key, defaultValue)
    if not moduleName or not key then
        return defaultValue
    end

    if not EmzToolsDB.modules then
        return defaultValue
    end

    if not EmzToolsDB.modules[moduleName] then
        return defaultValue
    end

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
function EmzTools.Database:Set(moduleName, key, value)
    if not moduleName or not key then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    if not EmzToolsDB.modules[moduleName] then
        EmzToolsDB.modules[moduleName] = {
            enabled = true,
            settings = {},
        }
    end

    EmzToolsDB.modules[moduleName].settings[key] = value

    return true
end

-- ===================================================
-- MODULE MANAGEMENT
-- ===================================================

-- Vérifie si un module est activé
-- @param moduleName: Nom du module
-- @return: true si le module est activé
function EmzTools.Database:IsModuleEnabled(moduleName)
    if not moduleName then
        return false
    end

    if not EmzToolsDB or not EmzToolsDB.modules then
        return false
    end

    if not EmzToolsDB.modules[moduleName] then
        return true -- Par défaut, un module est considéré comme activé s'il n'existe pas
    end

    return EmzToolsDB.modules[moduleName].enabled
end

-- Active ou désactive un module
-- @param moduleName: Nom du module
-- @param enabled: true pour activer, false pour désactiver
-- @return: true si succès
function EmzTools.Database:SetModuleEnabled(moduleName, enabled)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

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
function EmzTools.Database:ResetModule(moduleName, defaults)
    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

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
function EmzTools.Database:ResetAll()
    EmzToolsDB = {
        core = {
            debug = false,
            firstLoad = true,
            autoLoadPlugins = true,
        },
        modules = {},
    }

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
function EmzTools.Database:ExportModule(moduleName)
    if not moduleName then
        return nil
    end

    if not EmzToolsDB.modules or not EmzToolsDB.modules[moduleName] then
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
function EmzTools.Database:ImportModule(moduleName, data)
    if not moduleName or not data then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

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
function EmzTools.Database:ListModules()
    if not EmzToolsDB or not EmzToolsDB.core or not EmzToolsDB.core.debug then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    EmzTools:Print("EMZTOOLS_REGISTERED_MODULES_HEADER", "debug")

    if not EmzToolsDB.modules then
        EmzTools:Print("  " .. EmzTools:GetText("EMZTOOLS_NO_MODULES_REGISTERED"), "debug")
        return
    end

    local count = 0
    for moduleName, moduleData in pairs(EmzToolsDB.modules) do
        local status = moduleData.enabled and "|cFF00FF00" .. EmzTools:GetText("EMZTOOLS_ENABLED") .. "|r" or "|cFFFF0000" .. EmzTools:GetText("EMZTOOLS_DISABLED") .. "|r"
        EmzTools:Print("  " .. moduleName .. " - " .. status, "debug")
        count = count + 1
    end

    EmzTools:Print(EmzTools:GetText("EMZTOOLS_STATE_TOTAL") .. ": " .. count, "debug")
end

-- Affiche les paramètres d'un module
-- @param moduleName: Nom du module
function EmzTools.Database:PrintModule(moduleName)
    if not EmzToolsDB or not EmzToolsDB.core or not EmzToolsDB.core.debug then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    if not moduleName then
        EmzTools:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "debug")
        return
    end

    if not EmzToolsDB.modules or not EmzToolsDB.modules[moduleName] then
        EmzTools:Print("EMZTOOLS_MODULE_NOT_FOUND", "debug", moduleName)
        return
    end

    EmzTools:Print("EMZTOOLS_MODULE_DETAILS_HEADER", "debug", moduleName)

    local moduleData = EmzToolsDB.modules[moduleName]
    local status = moduleData.enabled and "|cFF00FF00" .. EmzTools:GetText("EMZTOOLS_ENABLED") .. "|r" or "|cFFFF0000" .. EmzTools:GetText("EMZTOOLS_DISABLED") .. "|r"
    EmzTools:Print(EmzTools:GetText("EMZTOOLS_STATE_STATUS") .. ": " .. status, "debug")

    EmzTools:Print(EmzTools:GetText("EMZTOOLS_STATE_SETTINGS") .. ":", "debug")

    local count = 0
    for key, value in pairs(moduleData.settings) do
        EmzTools:Print("  " .. key .. " = " .. tostring(value), "debug")
        count = count + 1
    end

    if count == 0 then
        EmzTools:Print("  " .. EmzTools:GetText("EMZTOOLS_STATE_NO_SETTINGS"), "debug")
    end
end

-- Affiche toutes les données de la base
function EmzTools.Database:DumpAll()
    if not EmzToolsDB or not EmzToolsDB.core or not EmzToolsDB.core.debug then
        EmzTools:Print("EMZTOOLS_DEBUG_MODE_REQUIRED", "warning")
        return
    end

    EmzTools:Print("EMZTOOLS_DATABASE_DUMP_HEADER", "debug")

    if not EmzToolsDB then
        EmzTools:Print(EmzTools:GetText("EMZTOOLS_DATABASE_NOT_INITIALIZED"), "debug")
        return
    end

    EmzTools:Print(EmzTools:GetText("EMZTOOLS_CORE_SETTINGS") .. ":", "debug")
    if EmzToolsDB.core then
        for key, value in pairs(EmzToolsDB.core) do
            EmzTools:Print("  " .. key .. " = " .. tostring(value), "debug")
        end
    end

    EmzTools:Print("", "debug")
    self:ListModules()
end
