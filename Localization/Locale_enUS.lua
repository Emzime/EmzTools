-- ===================================================
-- EmzTools - English Localization
-- ===================================================

Locale_enUS = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Loaded",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Not Loaded",
    ["EMZTOOLS_STATE_CONNECTED"] = "Connected",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Disconnected",
    ["EMZTOOLS_STATE_ENABLED"] = "Enabled",
    ["EMZTOOLS_STATE_DISABLED"] = "Disabled",
    ["EMZTOOLS_STATE_APPLY"] = "Apply",
    ["EMZTOOLS_STATE_RESET"] = "Reset",
    ["EMZTOOLS_STATE_YES"] = "Yes",
    ["EMZTOOLS_STATE_NO"] = "No",
    ["EMZTOOLS_STATE_STATUS"] = "Status",
    ["EMZTOOLS_STATE_SETTINGS"] = "Settings",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "No settings",
    ["EMZTOOLS_STATE_TOTAL"] = "Total",
    ["EMZTOOLS_STATE_LOCKED"] = "Locked",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Unlocked",
    ["EMZTOOLS_STATE_NONE"] = "None",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/A",
    ["EMZTOOLS_STATE_ACTIVE"] = "Active",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inactive",
    ["EMZTOOLS_STATE_PAUSED"] = "Paused",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Unknown",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Not Learned",
    ["EMZTOOLS_STATE_READY"] = "Ready",
    ["EMZTOOLS_STATE_NOT_READY"] = "Not Ready",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (On Cooldown)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Cannot Place",
    ["EMZTOOLS_STATE_REFRESH"] = "Refresh",
    ["EMZTOOLS_STATE_SEARCH"] = "Search",
    ["EMZTOOLS_STATE_SHOW"] = "Show",
    ["EMZTOOLS_STATE_HIDDEN"] = "Hidden",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Unknown command. Type /emz help for help",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Type /emz or /emztools for help.",
    ["EMZTOOLS_INVALID_KEY"] = "[Invalid Localization Key]",
    ["EMZTOOLS_VERSION"] = "Version: %s",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Database initialized.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Checking data structures...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Debug mode enabled.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Debug mode disabled.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Framework localization loaded.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Localization not found, using English.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Localization loaded for plugin '%s' from '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Using English fallback for plugin '%s' from '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "No localization found for plugin '%s'.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Module '%s' loaded successfully.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Module '%s' not found.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Error initializing module '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Module '%s' unloaded.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Error shutting down module '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Module name is required.",
    ["EMZTOOLS_LOADING_MODULE"] = "Loading module '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Unloading module '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Module '%s' is not supported for class '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' registered.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Plugin registration failed: invalid parameters.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' not supported for class '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin for %s loaded.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' not found.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Error initializing plugin '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' is disabled.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "Plugin UI for '%s' registered.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Plugin visibility toggled",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Plugin display toggled",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "WARNING: No toggle function for %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "WARNING: No plugin for class %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Invalid value for plugin state",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s enabled",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s disabled",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ERROR: Plugin name missing",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: function or function name required",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: invalid delay",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Timer #%s cancelled",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s timers purged",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Utils module not available.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Auto-loading modules for class '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Help: /emz help - Show help",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Config: /emz config - Open configuration",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Debug: /emz debug [on/off] - Toggle debug mode",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Show complete help",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Open configuration",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "The Help module is not loaded.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Configuration interface not available",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Database module not available, using default settings.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Reload UI",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Click to reload the user interface",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Reload the user interface?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Unlocked",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Drag to move\nRight-click for options",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Game Clock",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Right-click to change time format",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Clock Format",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (Based on Locale)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "24-Hour Format",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "12-Hour Format",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "InfoBar width set to %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "InfoBar height set to %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: Texture name cannot be nil.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Unknown texture '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Available textures: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "InfoBar texture '%s' not found, using default.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "No food available in your inventory.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "No water available in your inventory.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Already eating or drinking.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Eating %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Drinking %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Health and mana are already full.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Available Consumables ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Food: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Water: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Consumables Commands ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Show available consumables",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Eat the best available food",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Drink the best available water",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Rest (eat/drink as needed)",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB created with base structure",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migration: thresholds moved from Potions to Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Database module '%s' initialized",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Database completely reset",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Reload UI (/reload) required for changes to take effect",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Module '%s' imported successfully",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Debug mode required for this command",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Registered Modules ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "No modules registered",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Module Details: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Database Dump ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Database not initialized",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Core Settings:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Invalid callback: event and function required",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Missing parameters: event and identifier required",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Event name required",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Callback error in %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Event '%s' registered",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Callback added for event '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Callback removed for event '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Event '%s' unregistered",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "All callbacks removed for event '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Custom event fired: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Entered combat",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Left combat",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Level up! Now level %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Player died",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Entering world",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Leaving world",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Common events registered",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Registered Events ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Event: %s (%d callbacks)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "No events registered",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Total events: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Callbacks for event: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "No callbacks for this event",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "Callback ID: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Event name required",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Event Manager Statistics ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Average callbacks per event: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ EmzTools Commands ] ==-",
    ["EMZTOOLS_AUTHOR"] = "Author: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Main commands):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFACE:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "GAMEPLAY (Farming & Optimization):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "UTILITIES & DEBUG:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "TIPS:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "THRESHOLDS:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "CONSUMABLES:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "POTIONS:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PROFILER (Performance):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "CARDS (Card interface):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Display this help",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Display version",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [on|off] - Enable/disable debug mode",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Toggle plugin visibility",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Open configuration",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Alias for config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Show InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Hide InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Toggle display",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Lock/unlock",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Change texture",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Open configuration",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|number> - Set width",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <number> - Set height",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Full screen mode",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Custom width 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Custom height 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Show current thresholds",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Show farming efficiency",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Enable/disable aggressive mode",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <number> - Set custom HP threshold",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <number> - Set custom mana threshold",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Reset custom thresholds",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [on|off] - Set group status",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [on|off] - Set PvP status",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - List available consumables",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Use food",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Use water",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Rest automatically",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - List available potions",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Recommend potions for your level",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Use a healing potion",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Use a mana potion",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Use a health stone (Warlock)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Use intelligently what's available",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Start profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Stop profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Display report",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Reset stats",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Display card information",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Reload cards",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Refresh display",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Use /emz to display this help",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config opens the configuration interface",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Debug mode (/emz debug) displays technical info",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Thresholds automatically adapt to your level/class",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Tip: Type /emz <module> help for specific help",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Specific help for module: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Module not found. Type /emz help for complete list",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== EmzTools Commands ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Help system not loaded.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Restart addon or type /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== DETAILED HELP - THRESHOLDS ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Intelligent threshold system for farming optimization",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Main commands:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Configuration:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Special mode:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== DETAILED HELP - CONSUMABLES ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Automatic management of food, water, and bandages",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Usage:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Features:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Automatically chooses the best item for your level",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Doesn't work in combat",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Automatically manages cooldowns",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== DETAILED HELP - POTIONS ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Database and management of healing/mana potions",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Commands:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== DETAILED HELP - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Customizable information bar at top of screen",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Display:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Quick configuration:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Full configuration:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Choose displayed elements (FPS, Ping, Gold, XP, Clock)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Select texture (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Adjust transparency",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== DETAILED HELP - PROFILER ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Internal profiler to analyze performance",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Usage:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Features:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Measures function execution time",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifies slowest functions",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Displays real-time monitoring window",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Useful for debugging performance issues",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Slowest",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Average",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Calls",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Functions",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Problems",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "No problems",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Wrapping functions...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Profiler started",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Profiler stopped",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Stats reset",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== PROFILER REPORT ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Functions: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Total calls: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Total time: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Slowest: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLEMS ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Profiler Commands ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Start profiler",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Stop profiler",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Show report",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Reset stats",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Client)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "English",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Français",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Deutsch",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Español",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italiano",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Português",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Russian",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Language set to",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Left click: Open configuration",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Right click: Change language",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "No health potions available.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Used %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "No mana potions available.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Used %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "No healthstone available.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Used %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "Health is already full.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "No healing items available.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Available potions:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Health: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Health: None",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Mana: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Mana: None",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Healthstone: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Healthstone: None",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Recommended potions for level %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Health: %s (restores %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Mana: %s (restores %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Potions commands:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Show available potions",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Show recommended potions for your level",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Use best health potion",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Use best mana potion",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Use best healthstone",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Smart heal choice",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Unknown potions command. Type /emz potions help for help.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ EmzTools Version ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Help system not available",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Thresholds module not available",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Consumables module not available",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Potions module not available",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "InfoBar module not available",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "InternalProfiler module not available",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Minimap module not available",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Database module not available",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "EventManager module not available",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Usage: /emz thresholds sethp <number>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Usage: /emz thresholds setmana <number>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Usage: /emz infobar width <full|number>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Usage: /emz infobar height <number>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Unknown command: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Unknown command: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Unknown command: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Unknown command: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Unknown command: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Unknown command: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Unknown command: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Unknown command: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Configuration not available",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Minimap button shown",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Minimap button hidden",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Minimap button not created",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Utils module not loaded.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Custom HP threshold set to %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Custom HP threshold reset.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Custom mana threshold set to %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Custom mana threshold reset.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Aggressive mode enabled.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Aggressive mode disabled.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Group mode adjustments enabled.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Solo mode adjustments enabled.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "PvP mode adjustments enabled.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "PvE mode adjustments enabled.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Low HP and mana - eat and drink",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Low HP - eat",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Low mana - drink",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Resources are sufficient",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Recommended to rest now",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Rest now",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Rest soon (%d mobs left)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Good to continue (%d mobs left)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Thresholds for level %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "HP: %d%% | Mana: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "HP: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Pet heal threshold: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Mobs before rest: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Aggressive mode: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Group adjustments enabled",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "PvP adjustments enabled",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Farming Efficiency ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "HP: %d%% (Threshold: %d%%) | Mana: %d%% (Threshold: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "HP: %d%% (Threshold: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "HP buffer: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Estimated damage/mob: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Mobs left before rest: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Recommendation: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Usage: /emz thresholds sethp <number>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Usage: /emz thresholds setmana <number>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Custom thresholds reset",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Usage: /emz thresholds group [on|off]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Usage: /emz thresholds pvp [on|off]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Available commands:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Show thresholds",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Show farming efficiency",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Toggle aggressive mode",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <number> - Set HP threshold",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <number> - Set mana threshold",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Reset thresholds",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [on|off] - Group status",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [on|off] - PvP status",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "EmzTools Configuration",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig initialized",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Theme applied",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Loading error",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Theme selector",
    ["EMZTOOLS_UICONFIG_ERROR"] = "UIConfig error",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Bidirectional compatibility established",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Warrior",
    ["CLASS_MAGE"] = "Mage",
    ["CLASS_ROGUE"] = "Rogue",
    ["CLASS_DRUID"] = "Druid",
    ["CLASS_HUNTER"] = "Hunter",
    ["CLASS_SHAMAN"] = "Shaman",
    ["CLASS_PRIEST"] = "Priest",
    ["CLASS_WARLOCK"] = "Warlock",
    ["CLASS_PALADIN"] = "Paladin",
    ["CLASS_UNKNOWN"] = "Unknown",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Debug messages
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Core tab loaded",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Core tab registered",

    -- Configuration
    ["EMZTOOLS_DEBUG_MODE"] = "Debug mode",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Auto-load plugins",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Auto-load plugins enabled",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Auto-load plugins disabled",

    -- Theme
    ["EMZTOOLS_THEME_INTERFACE"] = "Interface Theme",
    ["EMZTOOLS_CURRENT_THEME"] = "Current theme:",
    ["EMZTOOLS_THEME_CHANGED"] = "Theme changed to: %s",

    -- Database
    ["EMZTOOLS_DATABASE_TITLE"] = "Database",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Reset DB",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Are you sure you want to reset the database?\n\nAll your configurations will be erased.",
    ["EMZTOOLS_DATABASE_RESET"] = "Database reset. Reloading...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Restore all default values?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Default values restored",
    ["EMZTOOLS_CONFIG_RESET"] = "Configuration reset",

    -- Information
    ["EMZTOOLS_INFO_TITLE"] = "Information",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugins loaded",

    -- Tab description
    ["EMZTOOLS_CORE_TAB_DESC"] = "Main EmzTools framework configuration",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "EmzTools Configuration",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Options",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Layout",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Full screen",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Layout Full screen",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Custom",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Layout Custom",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Custom width",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Height",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Height 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Height 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Transparency",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Display elements",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latency",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Gold",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "XP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Clock format",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Clock format Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Clock format 24 hours",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Clock format 12 hours",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Test",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar tested - display toggled",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "InfoBar module not available",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "Reset InfoBar configuration to default values ?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "InfoBar configuration reset to default values",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Information bar configuration",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "InfoBar tab registered",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "InfoBar tab loaded",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Potion Management",
    ["EMZTOOLS_POTIONS_DESC"] = "Automatic configuration of potions and consumables",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Healing Potions",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-heal",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Automatically uses healing potions when your health is low.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Heal priority:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Smart",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Stone first",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Potion first",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Use healthstones",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Use healthstones created by warlocks.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Mana Potions",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Automatically uses mana potions when your mana is low.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Alerts and Announcements",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Sound alert",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Plays a sound when a potion is automatically used.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Announce in chat",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Announces potion usage in group/raid channel.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Offensive Potions",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Offensive priority:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Dispel/Magic",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Damage",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Speed",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Reset Potions configuration to default values?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Potions configuration reset to default values",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Resets all options to their default values.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Potions tab loaded",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Potions tab registered",
    ["EMZTOOLS_STATE_MODULES"] = "Modules",
}
