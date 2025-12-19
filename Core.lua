-- ===================================================
-- EmzTools - Core.lua
-- Fichier principal du framework EmzTools
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Espace de noms global
EmzTools = EmzTools or {}

-- ===================================================
-- VERSION ET INFORMATIONS
-- ===================================================

EmzTools.version = "1.0.0"
EmzTools.author = "Emzime"
EmzTools.addonName = "EmzTools"

-- ===================================================
-- SYSTÈME DE LOCALISATION
-- ===================================================

-- Initialise le système de localisation du framework
function EmzTools:InitializeLocalization()
    local locale = GetLocale()

    -- Locales supportées
    local localeFiles = {
        ["enUS"] = "Locale_enUS",
        ["frFR"] = "Locale_frFR",
        ["deDE"] = "Locale_deDE",
        ["esES"] = "Locale_esES",
        ["itIT"] = "Locale_itIT",
        ["ptBR"] = "Locale_ptBR",
        ["ruRU"] = "Locale_ruRU",
    }

    -- Charger la localisation du framework
    local localeFile = localeFiles[locale]
    if localeFile and _G[localeFile] then
        self.L = _G[localeFile] or {}
        self:Print("EMZTOOLS_FRAMEWORK_LOCALE_LOADED", "debug")
    else
        -- Fallback vers l'anglais (enUS)
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

-- ===================================================
-- Enregistre la localisation d'un plugin
-- @param pluginName: Nom du plugin
-- @param localeTable: Table de localisation
-- @return: true si réussi, false sinon
-- ===================================================

function EmzTools:RegisterPluginLocale(pluginName, localeTable)
    if not pluginName or not localeTable then
        return false
    end

    self.PluginLocales[pluginName] = localeTable
    return true
end

-- ===================================================
-- Charge la localisation d'un plugin
-- @param pluginName: Nom du plugin
-- @return: true si réussi, false sinon
-- ===================================================

function EmzTools:LoadPluginLocalization(pluginName)
    if not pluginName then
        return false
    end

    local locale = GetLocale()
    local pluginLocale = {}

    -- Chemins possibles pour les fichiers de localisation
    local localePaths = {
        -- Nouveau chemin avec sous-dossier Localization
        pluginName .. "_Localization/" .. pluginName .. "_Locale_" .. locale,
        -- Ancien chemin (compatibilité)
        pluginName .. "_Locale_" .. locale
    }

    -- Essayer chaque chemin possible
    for _, localePath in ipairs(localePaths) do
        if _G[localePath] then
            pluginLocale = _G[localePath] or {}
            self:Print("EMZTOOLS_PLUGIN_LOCALE_LOADED", "debug", pluginName, localePath)
            break
        end
    end

    -- Fallback vers enUS si aucune locale trouvée
    if not next(pluginLocale) then
        local fallbackPaths = {
            pluginName .. "_Localization/" .. pluginName .. "_Locale_enUS",
            pluginName .. "_Locale_enUS"
        }

        for _, fallbackPath in ipairs(fallbackPaths) do
            if _G[fallbackPath] then
                pluginLocale = _G[fallbackPath] or {}
                self:Print("EMZTOOLS_PLUGIN_LOCALE_FALLBACK", "debug", pluginName, fallbackPath)
                break
            end
        end
    end

    -- Enregistrer la localisation du plugin
    if next(pluginLocale) then
        return self:RegisterPluginLocale(pluginName, pluginLocale)
    else
        self:Print("EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND", "debug", pluginName)
        return false
    end
end

-- ===================================================
-- Obtient un texte localisé
-- @param key: Clé de localisation
-- @return: Texte localisé ou la clé si non trouvé
-- ===================================================

function EmzTools:GetText(key)
    if not self.L then
        self:InitializeLocalization()
    end

    -- Vérifier que la clé est valide
    if not key or type(key) ~= "string" then
        return "EMZTOOLS_INVALID_KEY"
    end

    -- Chercher d'abord dans le framework
    if self.L[key] then
        return self.L[key]
    end

    -- Chercher ensuite dans les plugins (format: "PLUGIN_KEY")
    local pluginName, pluginKey = key:match("^([^_]+)_(.+)$")
    if pluginName and pluginKey then
        if self.PluginLocales[pluginName] then
            return self.PluginLocales[pluginName][pluginKey] or key
        end
    end

    return key
end

-- ===================================================
-- CONFIGURATION PAR DÉFAUT
-- ===================================================

EmzTools.defaults = {
    core = {
        debug = false,
        firstLoad = true,
        autoLoadPlugins = true
        -- Note: currentTheme a été déplacé vers UIConfig
    },
    modules = {},
    plugins = {}
}

-- ===================================================
-- INITIALISATION DE LA BASE DE DONNÉES
-- ===================================================

function EmzTools:InitializeDatabase()
    if not EmzToolsDB then
        EmzToolsDB = {}
    end

    -- Toujours initialiser core avec les valeurs par défaut, mais conserver les valeurs existantes
    if not EmzToolsDB.core then
        EmzToolsDB.core = {}
    end

    -- Appliquer les valeurs par défaut seulement si elles n'existent pas
    local defaults = self.defaults.core
    for key, defaultValue in pairs(defaults) do
        if EmzToolsDB.core[key] == nil then
            EmzToolsDB.core[key] = defaultValue
        end
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    -- Initialiser la section plugins si elle n'existe pas
    if not EmzToolsDB.plugins then
        EmzToolsDB.plugins = {}
    end

    self:Print("EMZTOOLS_DATABASE_INITIALIZED", "debug")
end

-- ===================================================
-- FONCTIONS UTILITAIRES DE BASE
-- ===================================================

-- ===================================================
-- Affiche un message dans la fenêtre de chat
-- @param message: Message ou clé de localisation
-- @param msgType: Type de message (success, error, warning, info, debug)
-- @param param1-3: Paramètres optionnels pour le formatage
-- ===================================================

function EmzTools:Print(message, msgType, param1, param2, param3)
    -- Couleurs prédéfinies selon le type de message
    local colors = {
        success = "|cFF00FF00",
        error = "|cFFFF0000",
        warning = "|cFFFFFF00",
        info = "|cFF00BFFF",
        debug = "|cFF888888",
        default = "|cFFFFFFFF"
    }

    -- Pour les messages debug, vérifier s'il faut les afficher
    if msgType == "debug" then
        -- Si la carte debug existe, lui envoyer le message
        if EmzTools_Card_Debug and EmzTools_Card_Debug.AddLog then
            -- Formatage des paramètres
            local formattedMessage = self:GetText(message)
            if param1 then
                formattedMessage = string.gsub(formattedMessage, "%%s", param1, 1)
                if param2 then
                    formattedMessage = string.gsub(formattedMessage, "%%s", param2, 1)
                    if param3 then
                        formattedMessage = string.gsub(formattedMessage, "%%s", param3, 1)
                    end
                end
            end
            EmzTools_Card_Debug:AddLog(formattedMessage)
        end

        -- Ne PAS afficher dans le chat si debug désactivé
        if not EmzToolsDB or not EmzToolsDB.core or not EmzToolsDB.core.debug then
            return
        end
    end

    -- Le reste du code pour afficher dans le chat (pour tous les types sauf debug)
    local color = colors[msgType] or colors.default
    local prefix = ""
    if msgType ~= "noPrefix" then
        prefix = "|cFFD4AF37[EmzTools]|r"
    end

    -- Récupérer le message localisé
    local formattedMessage = self:GetText(message)

    -- Formatage manuel si des paramètres sont fournis
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

-- ===================================================
-- Active ou désactive le mode debug
-- @param enabled: true/false, "on"/"off", "1"/"0"
-- @return: Nouvel état du mode debug
-- ===================================================

function EmzTools:SetDebug(enabled)
    -- Convertir différentes formes en booléen
    if type(enabled) ~= "boolean" then
        if enabled == "true"  or enabled == "on" then
            enabled = true
        elseif enabled == "false" or enabled == "off" then
            enabled = false
        else
            return EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug or false
        end
    end

    -- Initialiser la base de données si nécessaire
    if not EmzToolsDB then
        self:InitializeDatabase()
    end

    -- Créer la section core si elle n'existe pas
    if not EmzToolsDB.core then
        EmzToolsDB.core = {}
    end

    -- Sauvegarder l'ancienne valeur
    local oldValue = EmzToolsDB.core.debug or false

    -- Mettre à jour la valeur
    EmzToolsDB.core.debug = enabled

    -- Afficher un message seulement si la valeur a changé
    if oldValue ~= enabled then
        if enabled then
            self:Print("EMZTOOLS_DEBUG_ENABLED", "success")
        else
            self:Print("EMZTOOLS_DEBUG_DISABLED", "success")
        end
    else
        self:Print(string.format("Debug est déjà %s", enabled and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED"), "info")
    end

    return enabled
end

-- ===================================================
-- Bascule la visibilité des plugins UI
-- ===================================================

function EmzTools:TogglePluginVisibility()
    if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
        self:Print("EMZTOOLS_UTILS_NOT_AVAILABLE", "error")
        return
    end

    local playerClass = EmzTools.Data.Utils:GetPlayerClass()
    local pluginName = "My" .. playerClass

    if self[pluginName] then
        if self[pluginName].Toggle then
            self[pluginName]:Toggle()
            self:Print("EMZTOOLS_PLUGIN_TOGGLE_SUCCESS", "success")
        elseif self[pluginName].ToggleDisplay then
            self[pluginName]:ToggleDisplay()
            self:Print("EMZTOOLS_PLUGIN_TOGGLE_DISPLAY", "success")
        else
            self:Print("EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION", "warning", pluginName)
        end
    else
        self:Print("EMZTOOLS_PLUGIN_CLASS_NOT_FOUND", "warning", playerClass)
    end
end

-- ===================================================
-- SYSTÈME DE GESTION DES PLUGINS
-- ===================================================

EmzTools.Plugins = EmzTools.Plugins or {}
EmzTools.PluginUIs = EmzTools.PluginUIs or {}

-- =============================================================
-- Enregistre un plugin dans le système
-- @param pluginName: Nom du plugin
-- @param pluginTable: Table contenant les fonctions du plugin
-- @return: true si réussi, false sinon
-- ============================================================

function EmzTools:RegisterPlugin(pluginName, pluginTable)
    if not pluginName or not pluginTable then
        self:Print("EMZTOOLS_PLUGIN_REGISTRATION_FAILED", "error")
        return false
    end

    -- Vérifier la compatibilité de classe
    if pluginTable.supportedClasses then
        if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
            self:Print("EMZTOOLS_UTILS_NOT_AVAILABLE", "error")
            return false
        end

        local playerClass = EmzTools.Data.Utils:GetPlayerClass()
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

-- ========================================================
-- Obtient les plugins compatibles avec la classe actuelle
-- @return: Table des plugins compatibles
-- ========================================================

function EmzTools:GetCompatiblePlugins()
    local compatiblePlugins = {}
    if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
        return compatiblePlugins
    end

    local playerClass = EmzTools.Data.Utils:GetPlayerClass()

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

-- =========================================================================
-- Charge automatiquement le plugin correspondant à la classe du personnage
-- =========================================================================

function EmzTools:AutoLoadCompatiblePlugins()
    if not EmzToolsDB.core.autoLoadPlugins then
        return
    end

    if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
        self:Print("EMZTOOLS_UTILS_NOT_AVAILABLE", "warning")
        return
    end

    local playerClass = EmzTools.Data.Utils:GetPlayerClass()
    local pluginName = "My" .. playerClass

    -- Vérifier si le plugin est désactivé dans les options
    if not self:IsPluginEnabled(pluginName) then
        self:Print("EMZTOOLS_PLUGIN_DISABLED", "debug", pluginName)
        return
    end

    -- Vérifier si le plugin existe
    if not _G["EmzTools"] or not _G["EmzTools"][pluginName] then
        self:Print("EMZTOOLS_PLUGIN_NOT_FOUND", "debug", pluginName)
        return
    end

    -- Initialiser le plugin
    if _G["EmzTools"][pluginName] and _G["EmzTools"][pluginName].Initialize then
        local success, err = pcall(_G["EmzTools"][pluginName].Initialize, _G["EmzTools"][pluginName])
        if not success then
            self:Print("EMZTOOLS_PLUGIN_INIT_ERROR", "error", pluginName, tostring(err))
            return
        end
    end

    self:Print("EMZTOOLS_PLUGIN_LOADED", "success", EmzTools.Data.Utils:GetLocalizedClassName(playerClass))
end

-- =========================================================
-- Active ou désactive un plugin
-- @param pluginName: Nom du plugin (ex: "MyWarrior")
-- @param enabled: true pour activer, false pour désactiver
-- @return: Nouvel état du plugin
-- =========================================================

function EmzTools:SetPluginEnabled(pluginName, enabled)
    if not pluginName then
        return false
    end

    -- Initialiser la base de données si nécessaire
    if not EmzToolsDB then
        self:InitializeDatabase()
    end

    -- S'assurer que la section plugins existe
    if not EmzToolsDB.plugins then
        EmzToolsDB.plugins = {}
    end

    -- Convertir en booléen si nécessaire
    if type(enabled) ~= "boolean" then
        if enabled == "true" or enabled == "1" or enabled == "on" then
            enabled = true
        elseif enabled == "false" or enabled == "0" or enabled == "off" then
            enabled = false
        else
            self:Print("EMZTOOLS_PLUGIN_INVALID_VALUE", "error")
            return EmzToolsDB.plugins[pluginName] or true  -- Par défaut activé
        end
    end

    -- Sauvegarder l'ancien état
    local oldState = EmzToolsDB.plugins[pluginName]

    -- Mettre à jour l'état
    EmzToolsDB.plugins[pluginName] = enabled

    -- Afficher un message si l'état a changé
    if oldState ~= enabled then
        local pluginDisplayName = EmzTools.Data.Utils:GetLocalizedClassName(pluginName:gsub("My", ""))
        if enabled then
            self:Print("EMZTOOLS_PLUGIN_ENABLED", "success", pluginDisplayName)
        else
            self:Print("EMZTOOLS_PLUGIN_DISABLED_MSG", "success", pluginDisplayName)
        end
    end

    return enabled
end

-- ==========================================================
-- Vérifie si un plugin est activé
-- @param pluginName: Nom du plugin
-- @return: true si activé, false si désactivé ou non défini
-- ==========================================================

function EmzTools:IsPluginEnabled(pluginName)
    if not pluginName or not EmzToolsDB or not EmzToolsDB.plugins then
        return true  -- Par défaut activé si non défini
    end

    -- Si le plugin n'est pas dans la DB, il est activé par défaut
    if EmzToolsDB.plugins[pluginName] == nil then
        return true
    end

    return EmzToolsDB.plugins[pluginName]
end

-- ===================================================
-- Bascule l'état d'un plugin
-- @param pluginName: Nom du plugin
-- @return: Nouvel état du plugin
-- ===================================================

function EmzTools:TogglePlugin(pluginName)
    if not pluginName then
        self:Print("EMZTOOLS_PLUGIN_NAME_MISSING", "error")
        return false
    end

    local currentState = self:IsPluginEnabled(pluginName)
    local result = self:SetPluginEnabled(pluginName, not currentState)

    -- SetPluginEnabled affiche déjà le message
    return result
end

-- ===========================================================
-- Enregistre l'interface UI d'un plugin
-- @param pluginName: Nom du plugin
-- @param uiTable: Table contenant les fonctions UI du plugin
-- @return: true si réussi, false sinon
-- ===========================================================

function EmzTools:RegisterPluginUI(pluginName, uiTable)
    if not uiTable or not uiTable.CreateConfigTab then
        return false
    end

    self.PluginUIs[pluginName] = uiTable

    self:Print("EMZTOOLS_PLUGIN_UI_REGISTERED", "debug", pluginName)
    return true
end

-- ===================================================
-- GESTION DES MODULES
-- ===================================================

-- ===================================================
-- Charge un module
-- @param moduleName: Nom du module à charger
-- @return: true si réussi, false sinon
-- ===================================================

function EmzTools:LoadModule(moduleName)
    if not moduleName then
        self:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    self:Print("EMZTOOLS_LOADING_MODULE", "debug", moduleName)

    -- Gestion spéciale pour le module UI
    local moduleTable
    if moduleName == "UI" then
        if not self.Data then
            self.Data = {}
        end
        moduleTable = self.Data.UI
    else
        moduleTable = self[moduleName]
    end

    if not moduleTable then
        self:Print("EMZTOOLS_MODULE_NOT_FOUND", "error", moduleName)
        return false
    end

    -- Vérifier la compatibilité de classe
    if moduleTable.supportedClasses then
        if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
            self:Print("EMZTOOLS_UTILS_NOT_AVAILABLE", "warning")
            return false
        end

        local playerClass = EmzTools.Data.Utils:GetPlayerClass()
        local isSupported = false

        for _, class in pairs(moduleTable.supportedClasses) do
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

    if moduleTable.Initialize then
        local success, err = pcall(moduleTable.Initialize, moduleTable)
        if not success then
            self:Print("EMZTOOLS_MODULE_INIT_ERROR", "error", moduleName, tostring(err))
            return false
        end
    end

    self:Print("EMZTOOLS_MODULE_LOADED", "success", moduleName)
    return true
end

-- ===================================================
-- Décharge un module
-- @param moduleName: Nom du module à décharger
-- @return: true si réussi, false sinon
-- ===================================================

function EmzTools:UnloadModule(moduleName)
    if not moduleName then
        self:Print("EMZTOOLS_MODULE_NAME_REQUIRED", "error")
        return false
    end

    self:Print("EMZTOOLS_UNLOADING_MODULE", "debug", moduleName)

    -- Gestion spéciale pour le module UI
    local moduleTable
    if moduleName == "UI" then
        moduleTable = self.Data and self.Data.UI
    else
        moduleTable = self[moduleName]
    end

    if not moduleTable then
        self:Print("EMZTOOLS_MODULE_NOT_FOUND", "error", moduleName)
        return false
    end

    if moduleTable.Shutdown then
        local success, err = pcall(moduleTable.Shutdown, moduleTable)
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

-- ===================================================
-- Charge automatiquement les modules compatibles
-- ===================================================

function EmzTools:AutoLoadCompatibleModules()
    if not EmzToolsDB.core.autoLoadPlugins then
        return
    end

    if not EmzTools.Data.Utils or not EmzTools.Data.Utils.GetPlayerClass then
        self:Print("EMZTOOLS_UTILS_NOT_AVAILABLE", "warning")
        return
    end

    local playerClass = EmzTools.Data.Utils:GetPlayerClass()

    self:Print("EMZTOOLS_AUTO_LOADING_CLASS_MODULES", "debug", playerClass)

    -- Clés à ignorer
    local ignoreKeys = {
        ["defaults"] = true,
        ["L"] = true,
        ["PluginLocales"] = true,
        ["Plugins"] = true,
        ["PluginUIs"] = true,
        ["version"] = true,
        ["author"] = true,
        ["addonName"] = true,
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

-- =======================================================
-- SYSTÈME DE TIMER
-- Compatible avec les fonctions et les noms de fonctions
-- =======================================================

function EmzTools:ScheduleTimer(funcOrName, delay)
    -- Vérification des paramètres
    if not funcOrName then
        self:Print("EMZTOOLS_TIMER_FUNCTION_REQUIRED", "error")
        return false
    end

    if type(delay) ~= "number" or delay < 0 then
        self:Print("EMZTOOLS_TIMER_INVALID_DELAY", "error")
        return false
    end

    -- Initialiser le frame de timer si nécessaire
    if not EmzTools.timerFrame then
        EmzTools.timerFrame = CreateFrame("Frame", "EmzToolsTimerFrame")
        EmzTools.timerFrame.timers = {}
        EmzTools.timerFrame.timerID = 0
    end

    -- Générer un ID unique pour le timer
    EmzTools.timerFrame.timerID = EmzTools.timerFrame.timerID + 1
    local timerID = EmzTools.timerFrame.timerID

    -- Récupérer les arguments
    local args = {}
    if arg and arg.n then
        for i = 1, arg.n do
            args[i] = arg[i]
        end
    end

    -- Créer le timer
    local timerEntry = {
        id = timerID,
        func = funcOrName,
        endTime = GetTime() + delay,
        args = args
    }

    table.insert(EmzTools.timerFrame.timers, timerEntry)

    -- Activer OnUpdate si pas déjà actif
    if not EmzTools.timerFrame:GetScript("OnUpdate") then
        EmzTools.timerFrame:SetScript("OnUpdate", function()
            local currentTime = GetTime()
            local frame = this

            for i = table.getn(frame.timers), 1, -1 do
                local timer = frame.timers[i]
                if timer and currentTime >= timer.endTime then
                    -- Exécuter le timer
                    if type(timer.func) == "string" then
                        local func = _G[timer.func] or EmzTools[timer.func]
                        if func then
                            pcall(func)
                        end
                    elseif type(timer.func) == "function" then
                        pcall(timer.func)
                    end

                    -- Supprimer le timer
                    table.remove(frame.timers, i)
                end
            end

            -- Désactiver OnUpdate si plus de timers
            if table.getn(frame.timers) == 0 then
                frame:SetScript("OnUpdate", nil)
            end
        end)
    end

    return timerID
end

-- ===================================================
-- FONCTIONS UTILITAIRES POUR LES TIMERS
-- ===================================================

-- Version compatibilité avec arguments
function EmzTools:ScheduleTimerWithArgs(funcOrName, delay, arg1, arg2, arg3, arg4, arg5)
    local args = {}
    local argCount = 0

    -- Collecter les arguments manuellement
    if arg1 ~= nil then
        table.insert(args, arg1)
        argCount = argCount + 1
    end
    if arg2 ~= nil then
        table.insert(args, arg2)
        argCount = argCount + 1
    end
    if arg3 ~= nil then
        table.insert(args, arg3)
        argCount = argCount + 1
    end
    if arg4 ~= nil then
        table.insert(args, arg4)
        argCount = argCount + 1
    end
    if arg5 ~= nil then
        table.insert(args, arg5)
        argCount = argCount + 1
    end

    return self:ScheduleTimer(funcOrName, delay, unpack(args))
end

-- Fonction de déballage manuel
function EmzTools:UnpackTable(tbl)
    if not tbl or table.getn(tbl) == 0 then
        return nil
    end

    local result = ""
    for i = 1, table.getn(tbl) do
        result = result .. tostring(tbl[i])
        if i < table.getn(tbl) then
            result = result .. ", "
        end
    end
    return result
end

-- Version améliorée de ScheduleTimer qui gère mieux les arguments
function EmzTools:ScheduleTimerEx(funcOrName, delay)
    -- Cette fonction utilise le système arg de Lua 5.0
    local args = {}

    -- arg.n contient le nombre d'arguments, arg[1], arg[2], etc. contiennent les valeurs
    if arg and arg.n and arg.n > 0 then
        for i = 1, arg.n do
            args[i] = arg[i]
        end
    end

    -- Continuer avec la logique existante
    return self:ScheduleTimer(funcOrName, delay, unpack(args))
end

-- ===================================================
-- FONCTIONS UTILITAIRES POUR LES TIMERS
-- ===================================================

-- Annule un timer par son ID
function EmzTools:CancelTimer(timerID)
    if not EmzTools.timerFrame or not EmzTools.timerFrame.timers then
        return false
    end

    for i = table.getn(EmzTools.timerFrame.timers), 1, -1 do
        local timer = EmzTools.timerFrame.timers[i]
        if timer and timer.id == timerID then
            table.remove(EmzTools.timerFrame.timers, i)

            self:Print("EMZTOOLS_TIMER_CANCELLED", "debug", timerID)

            return true
        end
    end

    return false
end

-- Vérifie si un timer est actif
function EmzTools:IsTimerActive(timerID)
    if not EmzTools.timerFrame or not EmzTools.timerFrame.timers then
        return false
    end

    for _, timer in ipairs(EmzTools.timerFrame.timers) do
        if timer and timer.id == timerID then
            return true
        end
    end

    return false
end

-- Récupère le temps restant d'un timer
function EmzTools:GetTimerRemaining(timerID)
    if not EmzTools.timerFrame or not EmzTools.timerFrame.timers then
        return nil
    end

    local currentTime = GetTime()

    for _, timer in ipairs(EmzTools.timerFrame.timers) do
        if timer and timer.id == timerID then
            local remaining = timer.endTime - currentTime
            return remaining > 0 and remaining or 0
        end
    end

    return nil
end

-- Purge tous les timers
function EmzTools:PurgeAllTimers()
    if EmzTools.timerFrame and EmzTools.timerFrame.timers then
        local count = table.getn(EmzTools.timerFrame.timers)
        EmzTools.timerFrame.timers = {}

        self:Print("EMZTOOLS_TIMERS_PURGED", "debug", count)

        return count
    end
    return 0
end

-- ===================================================
-- ALIAS POUR LA COMPATIBILITÉ
-- ===================================================

-- Alias pour fonctions anonymes (version simplifiée)
function EmzTools:ScheduleFunction(func, delay, a1, a2, a3, a4, a5)
    return self:ScheduleTimerWithArgs(func, delay, a1, a2, a3, a4, a5)
end

-- Alias pour fonctions nommées (version simplifiée)
function EmzTools:ScheduleNamedFunction(funcName, delay, a1, a2, a3, a4, a5)
    return self:ScheduleTimerWithArgs(funcName, delay, a1, a2, a3, a4, a5)
end

-- ===================================================
-- FONCTION D'AIDE SIMPLIFIÉE
-- ===================================================

function EmzTools:ShowHelp()
    -- Délégation au module Help s'il est chargé
    if EmzTools.Data and EmzTools.Data.Help and EmzTools.Data.Help.Show then
        EmzTools.Data.Help:Show()
    else
        -- Fallback ultra-minimal
        self:Print("=== EmzTools ===", "info")
        self:Print(string.format("EMZTOOLS_VERSION", self.version or "1.0.0"), "noPrefix")
        self:Print("EMZTOOLS_HELP_COMMAND", "noPrefix")
        self:Print("EMZTOOLS_CONFIG_COMMAND", "noPrefix")
        self:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
    end
end

-- ===================================================
-- FONCTION POUR OUVRIRE LA CONFIGURATION CORE
-- ===================================================

-- Alias pour la commande /emz config
function EmzTools:OpenMainConfig()
    if EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Show then
        EmzTools.Data.UIConfig:Show()
    else
        EmzTools:Print("EMZTOOLS_CONFIG_UNAVAILABLE", "error")
    end
end

-- ===================================================
-- GESTION DES ÉVÉNEMENTS
-- ===================================================

local EmzToolsFrame = CreateFrame("Frame", "EmzToolsFrame")
EmzToolsFrame:RegisterEvent("ADDON_LOADED")

EmzToolsFrame:SetScript("OnEvent", function()
    -- En Lua 5.0, 'arg1', 'arg2' contiennent les paramètres d'événement
    local event = arg1
    local addonName = arg2

    -- ADDON_LOADED
    if event == "ADDON_LOADED" and addonName == "EmzTools" then
        EmzTools:OnLoad()
        EmzToolsFrame:UnregisterEvent("ADDON_LOADED")
        return
    end

    -- Délégation à EventManager si existant
    if EmzTools.EventManager and EmzTools.EventManager.OnEvent then
        EmzTools.EventManager:OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    end
end)

-- ===================================================
-- INITIALISATION PRINCIPALE
-- ===================================================

function EmzTools:OnLoad()
    -- Initialisations critiques
    self:InitializeLocalization()
    self:InitializeDatabase()

    if EmzToolsDB.core.firstLoad then
        EmzToolsDB.core.firstLoad = false
        self:Print("EMZTOOLS_TYPE_HELP", "info")
    end

    -- Initialisation différée pour s'assurer que tout est chargé
    self:ScheduleTimer(function()
        -- Charger les modules compatibles
        self:AutoLoadCompatibleModules()
        self:AutoLoadCompatiblePlugins()
    end, 2)
end

-- ===================================================
-- GESTIONNAIRE DES COMMANDES SLASH PRINCIPAL
-- ===================================================

function EmzTools.HandleSlashCommand(msg)
    if EmzTools.SlashCommands and EmzTools.SlashCommands.Handle then
        EmzTools.SlashCommands:Handle(msg)
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000Error: Uninitialized slash commands|r")
    end
end

-- ===================================================
-- ENREGISTREMENT DES COMMANDES SLASH
-- ===================================================

SLASH_EMZTOOLS1 = "/emz"
SLASH_EMZTOOLS2 = "/emztools"
SlashCmdList["EMZTOOLS"] = EmzTools.HandleSlashCommand

-- ===================================================
-- INITIALISATION FINALE
-- ===================================================

-- Initialiser la localisation
if not EmzTools.L then
    EmzTools.L = {}
end

-- Protection contre les clés manquantes
local originalLocale = EmzTools.L
EmzTools.L = {}
setmetatable(EmzTools.L, {
    __index = function(t, k)
        if originalLocale[k] then
            return originalLocale[k]
        end
        if Locale_enUS and Locale_enUS[k] then
            return Locale_enUS[k]
        end
        return k
    end
})
