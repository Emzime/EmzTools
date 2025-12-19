-- ===================================================
-- EmzTools - Data/SlashCommands.lua
-- Commandes slash centralisées
-- ===================================================

EmzTools = EmzTools or {}
EmzTools.SlashCommands = EmzTools.SlashCommands or {}

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

local function extractArgs(msg)
    if not msg or msg == "" then
        return "", ""
    end

    local command, rest = "", ""
    local firstSpace = string.find(msg, " ")

    if not firstSpace then
        command = msg
    else
        command = string.sub(msg, 1, firstSpace - 1)
        rest = string.sub(msg, firstSpace + 1)
    end

    return command, rest
end

local function toLower(str)
    if type(str) ~= "string" then return "" end
    return string.lower(str)
end

-- ===================================================
-- GESTIONNAIRE PRINCIPAL DES COMMANDES SLASH
-- ===================================================

function EmzTools.SlashCommands:Handle(msg)
    if not msg or type(msg) ~= "string" then
        msg = ""
    end

    local command, rest = extractArgs(msg)
    command = toLower(command)

    -- ===================================================
    -- COMMANDES CORE
    -- ===================================================
    if command == "" or command == "help" then
        if rest == "" then
            EmzTools:ShowHelp()
        else
            -- Aide spécifique pour un module
            if EmzTools.Data and EmzTools.Data.Help and EmzTools.Data.Help.ShowModuleHelp then
                EmzTools.Data.Help:ShowModuleHelp(rest)
            else
                EmzTools:Print("EMZTOOLS_HELP_SYSTEM_UNAVAILABLE", "error")
            end
        end

    elseif command == "version" then
        EmzTools:Print("EMZTOOLS_VERSION_TITLE", "info")
        EmzTools:Print("EMZTOOLS_VERSION", "noPrefix", EmzTools.version or "1.0.0")
        EmzTools:Print("EMZTOOLS_AUTHOR", "noPrefix", EmzTools.author or "Emzime")

    elseif command == "debug" then
        EmzTools:SetDebug(rest)

    elseif command == "toggle" then
        EmzTools:TogglePluginVisibility()

    -- ===================================================
    -- COMMANDES THRESHOLDS
    -- ===================================================
    elseif command == "thresholds" or command == "thresh" then
        local subCommand, arg1 = extractArgs(rest)
        subCommand = toLower(subCommand or "")

        if not EmzTools.Data or not EmzTools.Data.Thresholds then
            EmzTools:Print("EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowThresholdsHelp then
                EmzTools.Data.Help:ShowThresholdsHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "show" then
            EmzTools.Data.Thresholds:PrintThresholds()
        elseif subCommand == "efficiency" or subCommand == "eff" then
            EmzTools.Data.Thresholds:PrintFarmingEfficiency()
        elseif subCommand == "aggressive" or subCommand == "aggro" then
            EmzTools.Data.Thresholds:ToggleAggressiveMode()
        elseif subCommand == "sethp" then
            local value = tonumber(arg1)
            if value then
                EmzTools.Data.Thresholds:SetCustomHPThreshold(value)
            else
                EmzTools:Print("EMZTOOLS_THRESHOLDS_SYNTAX_SETHP", "error")
            end
        elseif subCommand == "setmana" then
            local value = tonumber(arg1)
            if value then
                EmzTools.Data.Thresholds:SetCustomManaThreshold(value)
            else
                EmzTools:Print("EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA", "error")
            end
        elseif subCommand == "reset" then
            EmzTools.Data.Thresholds:SetCustomHPThreshold(nil)
            EmzTools.Data.Thresholds:SetCustomManaThreshold(nil)
        elseif subCommand == "group" then
            local inGroup = (arg1 == "on" or arg1 == "1" or arg1 == "true")
            EmzTools.Data.Thresholds:SetGroupStatus(inGroup)
        elseif subCommand == "pvp" then
            local inPvP = (arg1 == "on" or arg1 == "1" or arg1 == "true")
            EmzTools.Data.Thresholds:SetPvPStatus(inPvP)
        else
            EmzTools:Print("EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES CONSUMABLES
    -- ===================================================
    elseif command == "consumables" or command == "cons" or command == "food" or command == "water" then
        local subCommand

        if command == "food" then
            subCommand = "eat"
        elseif command == "water" then
            subCommand = "drink"
        else
            subCommand = toLower(rest or "")
        end

        if not EmzTools.Data or not EmzTools.Data.Consumables then
            EmzTools:Print("EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowConsumablesHelp then
                EmzTools.Data.Help:ShowConsumablesHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "list" then
            EmzTools.Data.Consumables:PrintAvailableConsumables()
        elseif subCommand == "eat" then
            EmzTools.Data.Consumables:Eat()
        elseif subCommand == "drink" then
            EmzTools.Data.Consumables:Drink()
        elseif subCommand == "bandage" or subCommand == "band" then
            EmzTools.Data.Consumables:UseBandage()
        elseif subCommand == "rest" then
            EmzTools.Data.Consumables:Rest()
        else
            EmzTools:Print("EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES POTIONS
    -- ===================================================
    elseif command == "potions" or command == "pot" then
        local subCommand = toLower(rest or "")

        if not EmzTools.Data or not EmzTools.Data.Potions then
            EmzTools:Print("EMZTOOLS_POTIONS_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowPotionsHelp then
                EmzTools.Data.Help:ShowPotionsHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "list" then
            EmzTools.Data.Potions:PrintAvailablePotions()
        elseif subCommand == "recommend" or subCommand == "rec" then
            EmzTools.Data.Potions:PrintRecommendedPotions()
        elseif subCommand == "hp" or subCommand == "health" then
            EmzTools.Data.Potions:UseHealthPotion()
        elseif subCommand == "mana" or subCommand == "mp" then
            EmzTools.Data.Potions:UseManaPotion()
        elseif subCommand == "stone" or subCommand == "hs" then
            EmzTools.Data.Potions:UseHealthstone()
        elseif subCommand == "smart" or subCommand == "heal" then
            EmzTools.Data.Potions:SmartHeal()
        else
            EmzTools:Print("EMZTOOLS_POTIONS_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES INFOBAR
    -- ===================================================
    elseif command == "infobar" or command == "ibar" then
        local subCommand, arg1 = extractArgs(rest)
        subCommand = toLower(subCommand or "")

        if not EmzTools.Data or not EmzTools.Data.InfoBar then
            EmzTools:Print("EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowInfoBarHelp then
                EmzTools.Data.Help:ShowInfoBarHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "show" then
            EmzTools.Data.InfoBar:Show()
        elseif subCommand == "hide" then
            EmzTools.Data.InfoBar:Hide()
        elseif subCommand == "toggle" then
            EmzTools.Data.InfoBar:Toggle()
        elseif subCommand == "lock" then
            EmzTools.Data.InfoBar:ToggleLock()
        elseif subCommand == "texture" then
            EmzTools.Data.InfoBar:CycleTexture()
        elseif subCommand == "width" then
            if arg1 then
                EmzTools.Data.InfoBar:SetWidth(arg1)
            else
                EmzTools:Print("EMZTOOLS_INFOBAR_SYNTAX_WIDTH", "error")
            end
        elseif subCommand == "height" then
            if arg1 then
                EmzTools.Data.InfoBar:SetHeight(arg1)
            else
                EmzTools:Print("EMZTOOLS_INFOBAR_SYNTAX_HEIGHT", "error")
            end
        elseif subCommand == "config" then
            if EmzTools.Data.InfoBar.OpenConfig then
                EmzTools.Data.InfoBar:OpenConfig()
            else
                EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE", "error")
            end
        else
            EmzTools:Print("EMZTOOLS_INFOBAR_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES INTERNALPROFILER
    -- ===================================================
    elseif command == "profile" or command == "profiler" then
        local subCommand = toLower(rest or "")

        if not EmzTools.Data or not EmzTools.Data.InternalProfiler then
            EmzTools:Print("EMZTOOLS_PROFILER_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowProfilerHelp then
                EmzTools.Data.Help:ShowProfilerHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "start" then
            EmzTools.Data.InternalProfiler:Start()
        elseif subCommand == "stop" then
            EmzTools.Data.InternalProfiler:Stop()
        elseif subCommand == "report" then
            EmzTools.Data.InternalProfiler:GenerateDetailedReport()
        elseif subCommand == "reset" then
            EmzTools.Data.InternalProfiler:ResetStats()
        else
            EmzTools:Print("EMZTOOLS_PROFILER_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES MINIMAP
    -- ===================================================
    elseif command == "minimap" then
        local subCommand = toLower(rest or "")

        if not EmzTools.Data or not EmzTools.Data.Minimap then
            EmzTools:Print("EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowMinimapHelp then
                EmzTools.Data.Help:ShowMinimapHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "show" then
            if EmzTools.Data.Minimap.minimapButton then
                EmzTools.Data.Minimap.minimapButton:ShowButton()
                EmzTools:Print("EMZTOOLS_MINIMAP_BUTTON_SHOWN", "success")
            else
                EmzTools:Print("EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED", "warning")
            end
        elseif subCommand == "hide" then
            if EmzTools.Data.Minimap.minimapButton then
                EmzTools.Data.Minimap.minimapButton:HideButton()
                EmzTools:Print("EMZTOOLS_MINIMAP_BUTTON_HIDDEN", "success")
            else
                EmzTools:Print("EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED", "warning")
            end
        elseif subCommand == "toggle" then
            if EmzTools.Data.Minimap.minimapButton then
                EmzTools.Data.Minimap.minimapButton:Toggle()
            else
                EmzTools:Print("EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED", "warning")
            end
        else
            EmzTools:Print("EMZTOOLS_MINIMAP_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES DATABASE
    -- ===================================================
    elseif command == "database" or command == "db" then
        local subCommand = toLower(rest or "")

        if not EmzTools.Data or not EmzTools.Data.Database then
            EmzTools:Print("EMZTOOLS_DATABASE_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowDatabaseHelp then
                EmzTools.Data.Help:ShowDatabaseHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "list" then
            EmzTools.Data.Database:ListModules()
        elseif subCommand == "dump" then
            EmzTools.Data.Database:DumpAll()
        elseif subCommand == "reset" then
            EmzTools.Data.Database:ResetAll()
        else
            EmzTools:Print("EMZTOOLS_DATABASE_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES EVENTMANAGER
    -- ===================================================
    elseif command == "events" or command == "event" then
        local subCommand = toLower(rest or "")

        if not EmzTools.Data or not EmzTools.Data.EventManager then
            EmzTools:Print("EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE", "error")
            return
        end

        if subCommand == "" or subCommand == "help" then
            if EmzTools.Data.Help and EmzTools.Data.Help.ShowEventManagerHelp then
                EmzTools.Data.Help:ShowEventManagerHelp()
            else
                EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
            end
        elseif subCommand == "list" then
            EmzTools.Data.EventManager:ListRegisteredEvents()
        elseif subCommand == "stats" then
            EmzTools.Data.EventManager:PrintStats()
        else
            EmzTools:Print("EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND", "warning", subCommand)
        end

    -- ===================================================
    -- COMMANDES CONFIG
    -- ===================================================
    elseif command == "config" or command == "settings" then
        if EmzTools.Data and EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Toggle then
            EmzTools.Data.UIConfig:Toggle()
        elseif EmzTools.Data and EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Show then
            EmzTools.Data.UIConfig:Show()
        else
            EmzTools:Print("EMZTOOLS_CONFIG_UNAVAILABLE", "error")
        end

    -- ===================================================
    -- COMMANDE INCONNUE
    -- ===================================================
    else
        EmzTools:Print("EMZTOOLS_STATE_UNKNOWN_COMMAND", "warning")
    end
end

-- ===================================================
-- ENREGISTREMENT DES COMMANDES SLASH
-- ===================================================

if not SlashCmdList["EMZTOOLS"] then
    SLASH_EMZTOOLS1 = "/emz"
    SLASH_EMZTOOLS2 = "/emztools"
    SlashCmdList["EMZTOOLS"] = function(msg)
        if EmzTools.SlashCommands and EmzTools.SlashCommands.Handle then
            EmzTools.SlashCommands:Handle(msg)
        else
            DEFAULT_CHAT_FRAME:AddMessage("|cFFFF0000Erreur: Commandes slash non initialisées|r")
        end
    end
end
