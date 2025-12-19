-- ===================================================
-- EmzTools - Help.lua
-- Système d'aide centralisé pour toutes les commandes
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Vérifier que EmzTools existe
if not EmzTools then
    return
end

-- Module principal Help
EmzTools.Help = {
    version = "1.0.0"
}

-- ===================================================
-- FONCTIONS PRINCIPALES
-- ===================================================

function EmzTools.Help:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Help")
    return true
end

-- Alias pour organisation Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Help = EmzTools.Help

-- ===================================================
-- AFFICHAGE DE L'AIDE PRINCIPALE
-- ===================================================

function EmzTools.Data.Help:Show()
    EmzTools:Print("EMZTOOLS_HELP_HEADER", "info")
    EmzTools:Print("EMZTOOLS_VERSION", "info", EmzTools.version or "1.0.0")
    EmzTools:Print("EMZTOOLS_AUTHOR", "info", EmzTools.author or "Emzime")
    EmzTools:Print("", "noPrefix")  -- Ligne vide

    self:ShowCoreCommands()
    self:ShowInterfaceCommands()
    self:ShowGameplayCommands()
    self:ShowUtilityCommands()
    self:ShowTips()
end

-- ===================================================
-- SECTIONS DE L'AIDE
-- ===================================================

function EmzTools.Data.Help:ShowCoreCommands()
    EmzTools:Print("EMZTOOLS_HELP_CORE_SECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_HELP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_VERSION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_DEBUG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_TOGGLE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_SECTION_SEPARATOR", "noPrefix")
end

function EmzTools.Data.Help:ShowInterfaceCommands()
    EmzTools:Print("EMZTOOLS_HELP_INTERFACE_SECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_SETTINGS", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_SECTION_SEPARATOR", "noPrefix")
end

function EmzTools.Data.Help:ShowGameplayCommands()
    EmzTools:Print("EMZTOOLS_HELP_GAMEPLAY_SECTION", "noPrefix")

    -- Seuils
    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_SUBSECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP", "noPrefix")
    EmzTools:Print("", "noPrefix")  -- Ligne vide

    -- Consommables
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_SUBSECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST", "noPrefix")
    EmzTools:Print("", "noPrefix")  -- Ligne vide

    -- Potions
    EmzTools:Print("EMZTOOLS_HELP_POTIONS_SUBSECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_LIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_HP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_MANA", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_STONE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_SMART", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_SECTION_SEPARATOR", "noPrefix")
end

function EmzTools.Data.Help:ShowUtilityCommands()
    EmzTools:Print("EMZTOOLS_HELP_UTILITY_SECTION", "noPrefix")

    -- Profiler
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_SUBSECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_START", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_STOP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_REPORT", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_RESET", "noPrefix")
    EmzTools:Print("", "noPrefix")  -- Ligne vide

    -- Cards (si existant)
    if EmzTools.Data and EmzTools.Data.UI_Cards then
        EmzTools:Print("EMZTOOLS_HELP_CARDS_SUBSECTION", "noPrefix")
        EmzTools:Print("EMZTOOLS_HELP_COMMAND_CARD_INFO", "noPrefix")
        EmzTools:Print("EMZTOOLS_HELP_COMMAND_RELOAD_CARDS", "noPrefix")
        EmzTools:Print("EMZTOOLS_HELP_COMMAND_REFRESH_CARDS", "noPrefix")
    end

    EmzTools:Print("EMZTOOLS_HELP_SECTION_SEPARATOR", "noPrefix")
end

function EmzTools.Data.Help:ShowTips()
    EmzTools:Print("EMZTOOLS_HELP_TIPS_SECTION", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_TIP_HELP_COMMAND", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_TIP_CONFIG_COMMAND", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_TIP_DEBUG_COMMAND", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_TIP_THRESHOLDS", "noPrefix")
    EmzTools:Print("", "noPrefix")  -- Ligne vide
    EmzTools:Print("EMZTOOLS_HELP_TIP_MODULE_HELP", "noPrefix")
end

-- ===================================================
-- AIDE SPÉCIFIQUE PAR MODULE
-- ===================================================

function EmzTools.Data.Help:ShowModuleHelp(moduleName)
    moduleName = string.lower(moduleName or "")

    if moduleName == "thresholds" or moduleName == "thresh" then
        self:ShowThresholdsHelp()
    elseif moduleName == "consumables" or moduleName == "cons" then
        self:ShowConsumablesHelp()
    elseif moduleName == "potions" or moduleName == "pot" then
        self:ShowPotionsHelp()
    elseif moduleName == "infobar" or moduleName == "ibar" then
        self:ShowInfoBarHelp()
    elseif moduleName == "profile" or moduleName == "profiler" then
        self:ShowProfilerHelp()
    else
        EmzTools:Print("EMZTOOLS_HELP_MODULE_SPECIFIC", "info", moduleName)
        EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_FOUND", "warning")
    end
end

-- Aide détaillée pour chaque module
function EmzTools.Data.Help:ShowThresholdsHelp()
    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_TITLE", "info")
    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP", "noPrefix")
end

function EmzTools.Data.Help:ShowConsumablesHelp()
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_TITLE", "info")
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_USAGE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_FEATURES", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_FEATURE_1", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_FEATURE_2", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_CONSUMABLES_FEATURE_3", "noPrefix")
end

function EmzTools.Data.Help:ShowPotionsHelp()
    EmzTools:Print("EMZTOOLS_HELP_POTIONS_TITLE", "info")
    EmzTools:Print("EMZTOOLS_HELP_POTIONS_DESCRIPTION", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_POTIONS_COMMANDS", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_LIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_HP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_MANA", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_STONE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_POTIONS_SMART", "noPrefix")
end

function EmzTools.Data.Help:ShowInfoBarHelp()
    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_TITLE", "info")
    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_DESCRIPTION", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_DISPLAY", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_FULL_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_FEATURE_1", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_FEATURE_2", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_INFOBAR_FEATURE_3", "noPrefix")
end

function EmzTools.Data.Help:ShowProfilerHelp()
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_TITLE", "info")
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_DESCRIPTION", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_PROFILER_USAGE", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_START", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_STOP", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_REPORT", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_COMMAND_PROFILE_RESET", "noPrefix")
    EmzTools:Print("", "noPrefix")

    EmzTools:Print("EMZTOOLS_HELP_PROFILER_FEATURES", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_FEATURE_1", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_FEATURE_2", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_FEATURE_3", "noPrefix")
    EmzTools:Print("EMZTOOLS_HELP_PROFILER_FEATURE_4", "noPrefix")
end

-- ===================================================
-- INTÉGRATION AVEC LE SYSTÈME PRINCIPAL
-- ===================================================

-- Remplacer la fonction ShowHelp dans Core
function EmzTools:ShowHelp()
    if EmzTools.Data and EmzTools.Data.Help and EmzTools.Data.Help.Show then
        EmzTools.Data.Help:Show()
    else
        -- Fallback si le module Help n'est pas chargé
        EmzTools:Print("EMZTOOLS_HELP_FALLBACK_TITLE", "info")
        EmzTools:Print("EMZTOOLS_HELP_MODULE_NOT_LOADED", "warning")
        EmzTools:Print("EMZTOOLS_HELP_RELOAD_REQUIRED", "noPrefix")
    end
end

-- ===================================================
-- COMPATIBILITÉ BIDIRECTIONNELLE
-- ===================================================

local function EnsureHelpCompatibility()
    if EmzTools.Help and EmzTools.Data.Help then
        for funcName, func in pairs(EmzTools.Help) do
            if type(func) == "function" then
                EmzTools.Data.Help[funcName] = func
            end
        end
    end
end

EnsureHelpCompatibility()
