-- ===================================================
-- EmzTools - Core.lua
-- Main addon file for EmzTools
-- ===================================================

-- Global namespace
EmzTools = EmzTools or {}

-- ===================================================
-- VERSION / INFO
-- ===================================================

EmzTools.version = "1.0.0"
EmzTools.author = "Emzime"
EmzTools.addonName = "EmzTools"

-- ===================================================
-- LOCALIZATION SIMPLE AVEC SUPPORT PLUGINS
-- ===================================================

function EmzTools:InitializeLocalization()
    local locale = GetLocale()

    -- Supported locales in WoW 1.12
    local localeFiles = {
        ["enUS"] = "Locale_enUS",
        ["frFR"] = "Locale_frFR",
        ["deDE"] = "Locale_deDE",
        ["esES"] = "Locale_esES",
        ["ruRU"] = "Locale_ruRU",
        ["zhCN"] = "Locale_zhCN",
        ["zhTW"] = "Locale_zhTW",
        ["koKR"] = "Locale_koKR",
    }

    -- Load framework localization
    local localeFile = localeFiles[locale]
    if localeFile and _G[localeFile] then
        self.L = _G[localeFile] or {}
        self:Print("EMZTOOLS_FRAMEWORK_LOCALE_LOADED", "debug")
    else
        -- Fallback to enUS
        self.L = Locale_enUS or {}
        if locale ~= "enUS" then
            self:Print("EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND", "warning")
        end
    end

    -- S'assurer que L existe
    if not self.L then
        self.L = {}
    end

    -- Table pour les localisations des plugins
    self.PluginLocales = {}
end

-- Fonction pour qu'un plugin enregistre sa localisation
function EmzTools:RegisterPluginLocale(pluginName, localeTable)
    if not pluginName or not localeTable then
        return false
    end

    self.PluginLocales[pluginName] = localeTable
    return true
end

-- Fonction pour qu'un plugin charge ses fichiers de localisation
function EmzTools:LoadPluginLocalization(pluginName)
    if not pluginName then
        return false
    end

    local locale = GetLocale()
    local pluginLocale = {}

    -- Nouveau chemin avec la structure organisée
    local localePaths = {
        -- Essayer le nouveau chemin avec sous-dossier Localization
        pluginName .. "_Localization/" .. pluginName .. "_Locale_" .. locale,
        -- Fallback à l'ancien chemin (compatibilité)
        pluginName .. "_Locale_" .. locale
    }

    -- Essayer chaque chemin possible
    for _, localePath in ipairs(localePaths) do
        if _G[localePath] then
            pluginLocale = _G[localePath] or {}
            if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
                self:Print("EMZTOOLS_PLUGIN_LOCALE_LOADED", "debug", pluginName, localePath)
            end
            break
        end
    end

    -- Fallback to enUS si aucune locale trouvée
    if not next(pluginLocale) then
        local fallbackPaths = {
            pluginName .. "_Localization/" .. pluginName .. "_Locale_enUS",
            pluginName .. "_Locale_enUS"
        }

        for _, fallbackPath in ipairs(fallbackPaths) do
            if _G[fallbackPath] then
                pluginLocale = _G[fallbackPath] or {}
                if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
                    self:Print("EMZTOOLS_PLUGIN_LOCALE_FALLBACK", "debug", pluginName, fallbackPath)
                end
                break
            end
        end
    end

    -- Enregistrer la localisation du plugin
    if next(pluginLocale) then
        return self:RegisterPluginLocale(pluginName, pluginLocale)
    else
        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            self:Print("EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND", "debug", pluginName)
        end
        return false
    end
end

-- Fonction simple pour obtenir un texte localisé
function EmzTools:GetText(key)
    if not self.L then
        self:InitializeLocalization()
    end

    -- Vérifier que key est valide
    if not key or type(key) ~= "string" then
        return "EMZTOOLS_INVALID_KEY"
    end

    -- D'abord chercher dans le framework
    if self.L[key] then
        return self.L[key]
    end

    -- Ensuite chercher dans les plugins (format: "PLUGIN_KEY")
    local pluginName, pluginKey = key:match("^([^_]+)_(.+)$")
    if pluginName and pluginKey then
        if self.PluginLocales[pluginName] then
            return self.PluginLocales[pluginName][pluginKey] or key
        end
    end

    return key
end

-- ===================================================
-- DEFAULT CONFIGURATION
-- ===================================================

EmzTools.defaults = {
    core = {
        debug = false,
        firstLoad = true,
        autoLoadPlugins = true,
    },
    modules = {},
}

-- ===================================================
-- DATABASE INITIALIZATION
-- ===================================================

function EmzTools:InitializeDatabase()
    if not EmzToolsDB then
        EmzToolsDB = {}
    end

    if not EmzToolsDB.core then
        EmzToolsDB.core = {
            debug = self.defaults.core.debug,
            firstLoad = self.defaults.core.firstLoad,
            autoLoadPlugins = self.defaults.core.autoLoadPlugins
        }
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    self:Print("EMZTOOLS_DATABASE_INITIALIZED", "debug")
end

-- ===================================================
-- BASIC UTILITIES
-- ===================================================

function EmzTools:Print(message, msgType, param1, param2, param3)
    -- Couleurs prédéfinies
    local colors = {
        success = "|cFF00FF00",
        error = "|cFFFF0000",
        warning = "|cFFFFFF00",
        info = "|cFF00BFFF",
        debug = "|cFF888888",
        default = "|cFFFFFFFF"
    }

    -- Vérifier debug (compatible LUA 5.0)
    if msgType == "debug" then
        if not EmzToolsDB or not EmzToolsDB.core or not EmzToolsDB.core.debug then
            return
        end
    end

    local color = colors[msgType] or colors.default
    local prefix = ""
    if msgType ~= "noPrefix" then
        prefix = "|cFFD4AF37[EmzTools]|r"
    end

    -- Récupérer le message localisé
    local formattedMessage = self:GetText(message)

    -- Formatage manuel pour LUA 5.0 si des paramètres sont fournis
    if param1 then
        formattedMessage = string.gsub(formattedMessage, "%%s", param1, 1)
        if param2 then
            formattedMessage = string.gsub(formattedMessage, "%%s", param2, 1)
            if param3 then
                formattedMessage = string.gsub(formattedMessage, "%%s", param3, 1)
            end
        end
    end

    DEFAULT_CHAT_FRAME:AddMessage(prefix .. " " .. color .. formattedMessage .. "|r")
end

function EmzTools:SetDebug(enabled)
    if not EmzToolsDB or not EmzToolsDB.core then
        self:Print("EMZTOOLS_DATABASE_NOT_INITIALIZED", "error")
        return
    end

    EmzToolsDB.core.debug = enabled

    if enabled then
        self:Print("EMZTOOLS_DEBUG_ENABLED", "success")
    else
        self:Print("EMZTOOLS_DEBUG_DISABLED", "success")
    end
end

function EmzTools:GetPlayerClass()
    local _, class = UnitClass("player")
    return class
end

function EmzTools:PlayerHasMana()
    local powerType = UnitPowerType("player")
    return powerType == 0
end

-- ===================================================
-- PLUGIN MANAGEMENT SYSTEM - ARCHITECTURE My<Classe>
-- ===================================================

EmzTools.Plugins = EmzTools.Plugins or {}
EmzTools.PluginUIs = EmzTools.PluginUIs or {}

-- Enregistre un plugin avec son interface UI
function EmzTools:RegisterPlugin(pluginName, pluginTable)
    if not pluginName or not pluginTable then
        self:Print("EMZTOOLS_PLUGIN_REGISTRATION_FAILED", "error")
        return false
    end

    -- Vérifier la compatibilité de classe
    if pluginTable.supportedClasses then
        local playerClass = self:GetPlayerClass()
        local isSupported = false

        for _, class in pairs(pluginTable.supportedClasses) do
            if class == playerClass then
                isSupported = true
                break
            end
        end

        if not isSupported then
            self:Print("EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED", "debug", pluginName, playerClass)
            return false
        end
    end

    self.Plugins[pluginName] = pluginTable
    self:Print("EMZTOOLS_PLUGIN_REGISTERED", "debug", pluginName)
    return true
end

-- Récupère les plugins compatibles avec la classe actuelle
function EmzTools:GetCompatiblePlugins()
    local compatiblePlugins = {}
    local playerClass = self:GetPlayerClass()

    for pluginName, pluginTable in pairs(self.Plugins) do
        local isCompatible = true

        if pluginTable.supportedClasses then
            isCompatible = false
            for _, class in pairs(pluginTable.supportedClasses) do
                if class == playerClass then
                    isCompatible = true
                    break
                end
            end
        end

        if isCompatible then
            compatiblePlugins[pluginName] = pluginTable
        end
    end

    return compatiblePlugins
end

-- Charge automatiquement le plugin correspondant à la classe du personnage
function EmzTools:AutoLoadCompatiblePlugins()
    if not EmzToolsDB.core.autoLoadPlugins then
        return
    end

    local playerClass = self:GetPlayerClass()

    -- Construction du nom du plugin selon l'architecture My<Classe>
    local pluginName = "My" .. playerClass

    -- Vérifier si le plugin principal existe - SILENCIEUSEMENT
    if not _G["EmzTools"] or not _G["EmzTools"][pluginName] then
        -- Pas d'erreur, juste un debug silencieux si activé
        if EmzToolsDB.core.debug then
            self:Print("EMZTOOLS_PLUGIN_NOT_FOUND", "debug", pluginName)
        end
        return
    end

    -- Initialiser le plugin principal - C'EST LUI QUI CHARGE SES PROPRES MODULES
    if _G["EmzTools"][pluginName] and _G["EmzTools"][pluginName].Initialize then
        local success, err = pcall(_G["EmzTools"][pluginName].Initialize, _G["EmzTools"][pluginName])
        if not success then
            -- Seulement afficher l'erreur en mode debug
            if EmzToolsDB.core.debug then
                self:Print("EMZTOOLS_PLUGIN_INIT_ERROR", "error", pluginName, tostring(err))
            end
            return
        end
    end

    self:Print("EMZTOOLS_PLUGIN_LOADED", "success", pluginName)
end

-- Fonction pour intégrer l'UI d'un plugin dans l'interface principale
function EmzTools:RegisterPluginUI(pluginName, uiTable)
    if not uiTable or not uiTable.CreateConfigTab then
        return false
    end

    self.PluginUIs[pluginName] = uiTable

    -- Debug silencieux uniquement
    if EmzToolsDB.core.debug then
        self:Print("EMZTOOLS_PLUGIN_UI_REGISTERED", "debug", pluginName)
    end
    return true
end

-- ===================================================
-- MODULE MANAGEMENT
-- ===================================================

function EmzTools:LoadModule(moduleName)
    if not moduleName then
        self:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if EmzToolsDB.core.debug then
        self:Print("EMZTOOLS_LOADING_MODULE", "debug", moduleName)
    end

    if not self[moduleName] then
        self:Print("EMZTOOLS_MODULE_NOT_FOUND", "error", moduleName)
        return false
    end

    -- Vérifier la classe si spécifiée
    if self[moduleName].supportedClasses then
        local playerClass = self:GetPlayerClass()
        local isSupported = false

        for _, class in pairs(self[moduleName].supportedClasses) do
            if class == playerClass then
                isSupported = true
                break
            end
        end

        if not isSupported then
            self:Print("EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED", "warning", moduleName, playerClass)
            return false
        end
    end

    -- Charger la localisation du module
    self:LoadPluginLocalization(moduleName)

    if self[moduleName].Initialize then
        local success, err = pcall(self[moduleName].Initialize, self[moduleName])
        if not success then
            self:Print("EMZTOOLS_MODULE_INIT_ERROR", "error", moduleName, tostring(err))
            return false
        end
    end

    self:Print("EMZTOOLS_MODULE_LOADED", "success", moduleName)
    return true
end

function EmzTools:UnloadModule(moduleName)
    if not moduleName then
        self:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    if EmzToolsDB.core.debug then
        self:Print("EMZTOOLS_UNLOADING_MODULE", "debug", moduleName)
    end

    if not self[moduleName] then
        self:Print("EMZTOOLS_MODULE_NOT_FOUND", "error", moduleName)
        return false
    end

    if self[moduleName].Shutdown then
        local success, err = pcall(self[moduleName].Shutdown, self[moduleName])
        if not success then
            self:Print("EMZTOOLS_MODULE_SHUTDOWN_ERROR", "error", moduleName, tostring(err))
            return false
        end
    end

    -- Nettoyer la localisation du module
    if self.PluginLocales[moduleName] then
        self.PluginLocales[moduleName] = nil
    end

    self:Print("EMZTOOLS_MODULE_UNLOADED", "success", moduleName)
    return true
end

-- Fonction pour charger automatiquement les modules compatibles
function EmzTools:AutoLoadCompatibleModules()
    if not EmzToolsDB.core.autoLoadPlugins then
        return
    end

    local playerClass = self:GetPlayerClass()

    if EmzToolsDB.core.debug then
        self:Print("EMZTOOLS_AUTO_LOADING_CLASS_MODULES", "debug", playerClass)
    end

    -- Liste des clés à ignorer
    local ignoreKeys = {
        ["defaults"] = true,
        ["L"] = true,
        ["PluginLocales"] = true,
        ["Plugins"] = true,
        ["PluginUIs"] = true,
        ["version"] = true,
        ["author"] = true,
        ["addonName"] = true
    }

    for moduleName, moduleTable in pairs(self) do
        if not ignoreKeys[moduleName] and type(moduleTable) == "table" then
            -- Vérifier si c'est un module avec classes supportées
            if moduleTable.supportedClasses then
                local isSupported = false
                for _, class in pairs(moduleTable.supportedClasses) do
                    if class == playerClass then
                        isSupported = true
                        break
                    end
                end

                if isSupported then
                    self:LoadModule(moduleName)
                end
            end
        end
    end
end

-- ===================================================
-- SLASH COMMANDS
-- ===================================================

function EmzTools:SlashCommandHandler(msg)
    local command, rest = msg:match("^(%S*)%s*(.-)$")

    if command == "" or command == "help" then
        self:Print("EMZTOOLS_COMMANDS_HEADER", "info")
        self:Print("EMZTOOLS_COMMAND_DEBUG", "noPrefix")
        self:Print("EMZTOOLS_COMMAND_VERSION", "noPrefix")
        self:Print("EMZTOOLS_COMMAND_LOAD", "noPrefix")
        self:Print("EMZTOOLS_COMMAND_UNLOAD", "noPrefix")
        self:Print("EMZTOOLS_COMMAND_CONSUMABLES", "noPrefix")

        -- Afficher les commandes des plugins chargés
        self:Print("EMZTOOLS_COMMANDS_PLUGINS_HEADER", "info")
        for pluginName, pluginTable in pairs(self.Plugins) do
            if pluginTable.SlashCommandHandler then
                local displayName = pluginName:gsub("My", "")
                self:Print("EMZTOOLS_COMMAND_PLUGIN", "noPrefix", displayName:lower(), displayName)
            end
        end

    elseif command == "debug" then
        local newState = not EmzToolsDB.core.debug
        self:SetDebug(newState)

    elseif command == "version" then
        self:Print("EMZTOOLS_VERSION_INFO", "info", self.version, self.author)

    elseif command == "load" then
        if rest and rest ~= "" then
            self:LoadModule(rest)
        else
            self:Print("EMZTOOLS_USAGE_LOAD", "error")
        end

    elseif command == "unload" then
        if rest and rest ~= "" then
            self:UnloadModule(rest)
        else
            self:Print("EMZTOOLS_USAGE_UNLOAD", "error")
        end

    -- Commandes pour les modules existants
    elseif command == "consumables" or command == "cons" then
        if self.Consumables and self.Consumables.SlashCommandHandler then
            self.Consumables:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_MODULE_NOT_LOADED", "error", "Consumables")
        end

    -- ===================================================
    -- COMMANDES POUR LES PLUGINS My<CLASSE>
    -- ===================================================

    -- Hunter
    elseif command == "myhunter" or command == "mh" or command == "hunter" then
        if self.MyHunter and self.MyHunter.SlashCommandHandler then
            self.MyHunter:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyHunter")
        end

    -- Mage
    elseif command == "mymage" or command == "mm" or command == "mage" then
        if self.MyMage and self.MyMage.SlashCommandHandler then
            self.MyMage:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyMage")
        end

    -- Warrior
    elseif command == "mywarrior" or command == "mw" or command == "warrior" then
        if self.MyWarrior and self.MyWarrior.SlashCommandHandler then
            self.MyWarrior:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyWarrior")
        end

    -- Rogue
    elseif command == "myrogue" or command == "mr" or command == "rogue" then
        if self.MyRogue and self.MyRogue.SlashCommandHandler then
            self.MyRogue:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyRogue")
        end

    -- Priest
    elseif command == "mypriest" or command == "mp" or command == "priest" then
        if self.MyPriest and self.MyPriest.SlashCommandHandler then
            self.MyPriest:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyPriest")
        end

    -- Warlock
    elseif command == "mywarlock" or command == "ml" or command == "warlock" then
        if self.MyWarlock and self.MyWarlock.SlashCommandHandler then
            self.MyWarlock:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyWarlock")
        end

    -- Paladin
    elseif command == "mypaladin" or command == "mpala" or command == "paladin" then
        if self.MyPaladin and self.MyPaladin.SlashCommandHandler then
            self.MyPaladin:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyPaladin")
        end

    -- Shaman
    elseif command == "myshaman" or command == "ms" or command == "shaman" then
        if self.MyShaman and self.MyShaman.SlashCommandHandler then
            self.MyShaman:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyShaman")
        end

    -- Druid
    elseif command == "mydruid" or command == "md" or command == "druid" then
        if self.MyDruid and self.MyDruid.SlashCommandHandler then
            self.MyDruid:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", "MyDruid")
        end

    -- ===================================================
    -- COMMANDES GÉNÉRIQUES POUR TOUS LES PLUGINS
    -- ===================================================

    -- Commande générique pour n'importe quel plugin My<Classe>
    elseif command:match("^my%a+$") then
        local pluginName = command:gsub("^my", "My"):gsub("^%l", string.upper)
        if self[pluginName] and self[pluginName].SlashCommandHandler then
            self[pluginName]:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", pluginName)
        end

    -- Commande par nom de classe seul
    elseif command == "hunter" or command == "mage" or command == "warrior" or
           command == "rogue" or command == "priest" or command == "warlock" or
           command == "paladin" or command == "shaman" or command == "druid" then
        local pluginName = "My" .. command:gsub("^%l", string.upper)
        if self[pluginName] and self[pluginName].SlashCommandHandler then
            self[pluginName]:SlashCommandHandler(rest)
        else
            self:Print("EMZTOOLS_PLUGIN_NOT_LOADED", "error", pluginName)
        end

    else
        self:Print("EMZTOOLS_UNKNOWN_COMMAND", "warning")
    end
end

SLASH_EMZTOOLS1 = "/emz"
SLASH_EMZTOOLS2 = "/emztools"
SlashCmdList["EMZTOOLS"] = function(msg)
    EmzTools:SlashCommandHandler(msg)
end

-- ===================================================
-- EVENT FRAME
-- ===================================================

local EmzToolsFrame = CreateFrame("Frame", "EmzToolsFrame")
EmzToolsFrame:RegisterEvent("ADDON_LOADED")

-- WoW 1.12 compatible event handler (Lua 5.0: uses parameters directly)
EmzToolsFrame:SetScript("OnEvent", function()
    -- Get event and arguments (compatible with Lua 5.0)
    local event = arg1

    -- ADDON_LOADED
    if event == "ADDON_LOADED" then
        local addonName = arg2
        if addonName == "EmzTools" then
            EmzTools:OnLoad()
            EmzToolsFrame:UnregisterEvent("ADDON_LOADED")
            return
        end
    end

    -- Dispatch to EventManager if it exists
    if EmzTools.EventManager and EmzTools.EventManager.OnEvent then
        -- Pass all arguments safely for Lua 5.0
        EmzTools.EventManager:OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    end
end)

-- ===================================================
-- INITIALIZATION
-- ===================================================

function EmzTools:OnLoad()
    self:InitializeLocalization()
    self:InitializeDatabase()
    self:Print("EMZTOOLS_ADDON_LOADED", "success", self.version)

    if EmzToolsDB.core.firstLoad then
        EmzToolsDB.core.firstLoad = false
        self:Print("EMZTOOLS_TYPE_HELP", "info")
    end

    -- Charger automatiquement les modules compatibles
    self:AutoLoadCompatibleModules()

    -- Charger automatiquement les plugins compatibles (SILENCIEUSEMENT)
    self:AutoLoadCompatiblePlugins()
end

-- ===================================================
-- FINALIZATION
-- ===================================================

-- Initialiser la localisation
if not EmzTools.L then
    EmzTools.L = {}
end

-- Protection contre les clés manquantes (compatible LUA 5.0)
local originalLocale = EmzTools.L
EmzTools.L = {}
setmetatable(EmzTools.L, {
    __index = function(t, k)
        -- Essayer la locale originale
        if originalLocale[k] then
            return originalLocale[k]
        end
        -- Essayer la locale anglaise
        if Locale_enUS and Locale_enUS[k] then
            return Locale_enUS[k]
        end
        -- Sinon retourner la clé
        return k
    end
})
