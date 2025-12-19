-- ===================================================
-- EmzTools - Deutsche Lokalisierung
-- ===================================================

Locale_deDE = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Geladen",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Nicht geladen",
    ["EMZTOOLS_STATE_CONNECTED"] = "Verbunden",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Getrennt",
    ["EMZTOOLS_STATE_ENABLED"] = "Aktiviert",
    ["EMZTOOLS_STATE_DISABLED"] = "Deaktiviert",
    ["EMZTOOLS_STATE_APPLY"] = "Übernehmen",
    ["EMZTOOLS_STATE_RESET"] = "Zurücksetzen",
    ["EMZTOOLS_STATE_YES"] = "Ja",
    ["EMZTOOLS_STATE_NO"] = "Nein",
    ["EMZTOOLS_STATE_STATUS"] = "Status",
    ["EMZTOOLS_STATE_SETTINGS"] = "Einstellungen",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Keine Einstellungen",
    ["EMZTOOLS_STATE_TOTAL"] = "Gesamt",
    ["EMZTOOLS_STATE_LOCKED"] = "Gesperrt",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Entsperrt",
    ["EMZTOOLS_STATE_NONE"] = "Keine",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/V",
    ["EMZTOOLS_STATE_ACTIVE"] = "Aktiv",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inaktiv",
    ["EMZTOOLS_STATE_PAUSED"] = "Pausiert",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Unbekannt",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Nicht erlernt",
    ["EMZTOOLS_STATE_READY"] = "Bereit",
    ["EMZTOOLS_STATE_NOT_READY"] = "Nicht bereit",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (Abklingzeit)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Kann nicht platziert werden",
    ["EMZTOOLS_STATE_REFRESH"] = "Aktualisieren",
    ["EMZTOOLS_STATE_SEARCH"] = "Suchen",
    ["EMZTOOLS_STATE_SHOW"] = "Anzeigen",
    ["EMZTOOLS_STATE_HIDDEN"] = "Versteckt",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Unbekannter Befehl. Geben Sie /emz help für Hilfe ein",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Geben Sie /emz oder /emztools für Hilfe ein.",
    ["EMZTOOLS_INVALID_KEY"] = "[Ungültiger Lokalisierungsschlüssel]",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Datenbank initialisiert.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Überprüfe Datenstrukturen...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Debug-Modus aktiviert.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Debug-Modus deaktiviert.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Framework-Lokalisierung geladen.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Lokalisierung nicht gefunden, verwende Englisch.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Lokalisierung für Plugin '%s' von '%s' geladen.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Verwende englischen Fallback für Plugin '%s' von '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "Keine Lokalisierung für Plugin '%s' gefunden.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Modul '%s' erfolgreich geladen.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Modul '%s' nicht gefunden.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Fehler beim Initialisieren des Moduls '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Modul '%s' entladen.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Fehler beim Beenden des Moduls '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Modulname erforderlich.",
    ["EMZTOOLS_LOADING_MODULE"] = "Lade Modul '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Entlade Modul '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Modul '%s' wird für Klasse '%s' nicht unterstützt.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' registriert.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Plugin-Registrierung fehlgeschlagen: ungültige Parameter.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' wird für Klasse '%s' nicht unterstützt.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin für %s geladen.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' nicht gefunden.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Fehler beim Initialisieren des Plugins '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' ist deaktiviert.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "Plugin-UI für '%s' registriert.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Plugin-Sichtbarkeit umgeschaltet",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Plugin-Anzeige umgeschaltet",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "WARNUNG: Keine Umschaltfunktion für %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "WARNUNG: Kein Plugin für Klasse %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Ungültiger Wert für Plugin-Status",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s aktiviert",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s deaktiviert",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "FEHLER: Plugin-Name fehlt",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: Funktion oder Funktionsname erforderlich",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: ungültige Verzögerung",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Timer #%s abgebrochen",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s Timer bereinigt",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Utils-Modul nicht verfügbar.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Lade automatisch Module für Klasse '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Hilfe: /emz help - Hilfe anzeigen",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Konfig: /emz config - Konfiguration öffnen",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Debug: /emz debug [an/aus] - Debug-Modus umschalten",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Vollständige Hilfe anzeigen",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Konfiguration öffnen",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Das Hilfe-Modul ist nicht geladen.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Konfigurationsschnittstelle nicht verfügbar",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Datenbankmodul nicht verfügbar, verwende Standardeinstellungen.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "UI neu laden",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Klicken, um die Benutzeroberfläche neu zu laden",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Benutzeroberfläche neu laden?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar entsperrt",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Zum Bewegen ziehen\nRechtsklick für Optionen",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Spieluhr",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Rechtsklick, um Zeitformat zu ändern",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Uhrformat",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (basierend auf Lokale)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "24-Stunden-Format",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "12-Stunden-Format",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "InfoBar-Breite auf %s gesetzt.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "InfoBar-Höhe auf %s gesetzt.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: Texturname darf nicht null sein.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Unbekannte Textur '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Verfügbare Texturen: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "InfoBar-Textur '%s' nicht gefunden, verwende Standard.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "Kein Essen in Ihrem Inventar verfügbar.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "Kein Wasser in Ihrem Inventar verfügbar.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Isst oder trinkt bereits.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Isst %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Trinkt %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Gesundheit und Mana sind bereits voll.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Verfügbare Verbrauchsgüter ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Essen: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Wasser: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Verbrauchsgüter-Befehle ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Verfügbare Verbrauchsgüter anzeigen",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Bestes verfügbares Essen essen",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Bestes verfügbares Wasser trinken",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Ausruhen (essen/trinken nach Bedarf)",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB mit Basisstruktur erstellt",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migration: Schwellenwerte von Potions zu Thresholds verschoben",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Datenbankmodul '%s' initialisiert",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Datenbank vollständig zurückgesetzt",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "UI-Neuladen (/reload) erforderlich, damit Änderungen wirksam werden",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Modul '%s' erfolgreich importiert",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Debug-Modus für diesen Befehl erforderlich",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Registrierte Module ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "Keine Module registriert",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Modul-Details: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Datenbank-Dump ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Datenbank nicht initialisiert",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Kerneinstellungen:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Ungültiger Rückruf: Ereignis und Funktion erforderlich",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Fehlende Parameter: Ereignis und Kennung erforderlich",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Ereignisname erforderlich",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Rückruffehler in %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Ereignis '%s' registriert",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Rückruf für Ereignis '%s' hinzugefügt",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Rückruf für Ereignis '%s' entfernt",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Ereignis '%s' deregistriert",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Alle Rückrufe für Ereignis '%s' entfernt",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Benutzerdefiniertes Ereignis ausgelöst: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Kampf begonnen",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Kampf verlassen",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Levelaufstieg! Jetzt Level %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Spieler gestorben",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Welt betreten",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Welt verlassen",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Gemeinsame Ereignisse registriert",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Registrierte Ereignisse ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Ereignis: %s (%d Rückrufe)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "Keine Ereignisse registriert",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Gesamtereignisse: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Rückrufe für Ereignis: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "Keine Rückrufe für dieses Ereignis",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "Rückruf-ID: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Ereignisname erforderlich",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Ereignis-Manager-Statistiken ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Durchschnittliche Rückrufe pro Ereignis: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ EmzTools Befehle ] ==-",
    ["EMZTOOLS_VERSION"] = "Version: %s",
    ["EMZTOOLS_AUTHOR"] = "Autor: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Hauptbefehle):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFACE:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "GAMEPLAY (Farming & Optimierung):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "NÜTZLICHES & DEBUG:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "TIPS:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "SCHWELLENWERTE:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "VERBRAUCHSGÜTER:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "TRÄNKE:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PROFILER (Leistung):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "KARTEN (Kartenoberfläche):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Diese Hilfe anzeigen",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Version anzeigen",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [an|aus] - Debug-Modus aktivieren/deaktivieren",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Plugin-Sichtbarkeit umschalten",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Konfiguration öffnen",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Alias für config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - InfoBar anzeigen",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - InfoBar verbergen",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Anzeige umschalten",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Sperren/entsperren",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Textur ändern",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Konfiguration öffnen",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|zahl> - Breite setzen",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <zahl> - Höhe setzen",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Vollbildmodus",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Benutzerdefinierte Breite 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Benutzerdefinierte Höhe 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Aktuelle Schwellenwerte anzeigen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Farm-Effizienz anzeigen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Aggressivmodus aktivieren/deaktivieren",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <zahl> - Benutzerdefinierten HP-Schwellenwert setzen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <zahl> - Benutzerdefinierten Mana-Schwellenwert setzen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Benutzerdefinierte Schwellenwerte zurücksetzen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [an|aus] - Gruppenstatus setzen",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [an|aus] - PvP-Status setzen",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Verfügbare Verbrauchsgüter auflisten",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Essen verwenden",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Wasser verwenden",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Automatisch ausruhen",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Verfügbare Tränke auflisten",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Tränke für dein Level empfehlen",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Einen Heiltrank verwenden",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Einen Manatrank verwenden",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Einen Gesundheitsstein (Hexenmeister) verwenden",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Intelligent verfügbares verwenden",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Profiler starten",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Profiler stoppen",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Bericht anzeigen",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Statistiken zurücksetzen",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Karteninformationen anzeigen",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Karten neu laden",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Anzeige aktualisieren",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Verwende /emz, um diese Hilfe anzuzeigen",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config öffnet die Konfigurationsschnittstelle",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Debug-Modus (/emz debug) zeigt technische Informationen an",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Schwellenwerte passen sich automatisch an dein Level/Klasse an",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Tipp: Gib /emz <modul> help für spezifische Hilfe ein",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Spezifische Hilfe für Modul: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Modul nicht gefunden. Gib /emz help für vollständige Liste ein",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== EmzTools Befehle ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Hilfesystem nicht geladen.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Addon neu starten oder /reload eingeben",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== DETAILLIERTE HILFE - SCHWELLENWERTE ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Intelligentes Schwellenwertsystem für Farm-Optimierung",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Hauptbefehle:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Konfiguration:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Spezialmodus:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== DETAILLIERTE HILFE - VERBRAUCHSGÜTER ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Automatische Verwaltung von Essen, Wasser und Bandagen",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Verwendung:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Funktionen:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Wählt automatisch den besten Gegenstand für dein Level",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Funktioniert nicht im Kampf",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Verwaltet automatisch Abklingzeiten",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== DETAILLIERTE HILFE - TRÄNKE ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Datenbank und Verwaltung von Heiltrank/Manatrank",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Befehle:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== DETAILLIERTE HILFE - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Anpassbare Informationsleiste am oberen Bildschirmrand",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Anzeige:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Schnelle Konfiguration:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Vollständige Konfiguration:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Wähle angezeigte Elemente (FPS, Ping, Gold, XP, Uhr)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Wähle Textur (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Passe Transparenz an",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== DETAILLIERTE HILFE - PROFILER ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Interner Profiler zur Leistungsanalyse",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Verwendung:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Funktionen:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Misst Funktionsausführungszeit",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifiziert langsamste Funktionen",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Zeigt Echtzeit-Monitoring-Fenster",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Nützlich zum Debuggen von Leistungsproblemen",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Langsamste",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Durchschnitt",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Aufrufe",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Funktionen",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Probleme",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Keine Probleme",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Wickle Funktionen...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Profiler gestartet",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Profiler gestoppt",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Statistiken zurückgesetzt",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== PROFILER-BERICHT ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Funktionen: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Gesamtaufrufe: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Gesamtzeit: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Langsamste: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLEME ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Profiler-Befehle ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Profiler starten",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Profiler stoppen",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Bericht anzeigen",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Statistiken zurücksetzen",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Client)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Englisch",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Französisch",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Deutsch",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Spanisch",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italienisch",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Portugiesisch",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Russisch",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Sprache gesetzt auf",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Linksklick: Konfiguration öffnen",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Rechtsklick: Sprache ändern",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "Keine Heiltränke verfügbar.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "%s verwendet.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "Keine Manatränke verfügbar.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "%s verwendet.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "Keine Gesundheitssteine verfügbar.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "%s verwendet.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "Gesundheit bereits voll.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "Keine Heilgegenstände verfügbar.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Verfügbare Tränke:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Gesundheit: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Gesundheit: Keine",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Mana: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Mana: Keine",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Gesundheitsstein: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Gesundheitsstein: Keine",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Empfohlene Tränke für Level %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Gesundheit: %s (stellt %s wieder her)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Mana: %s (stellt %s wieder her)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Trankbefehle:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Verfügbare Tränke anzeigen",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Empfohlene Tränke für dein Level anzeigen",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Besten Heiltrank verwenden",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Besten Manatrank verwenden",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Besten Gesundheitsstein verwenden",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Intelligente Heilwahl",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Unbekannter Trankbefehl. Gib /emz potions help für Hilfe ein.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ EmzTools Version ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Hilfesystem nicht verfügbar",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Schwellenwerte-Modul nicht verfügbar",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Verbrauchsgüter-Modul nicht verfügbar",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Tränke-Modul nicht verfügbar",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "InfoBar-Modul nicht verfügbar",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Interner Profiler-Modul nicht verfügbar",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Minimap-Modul nicht verfügbar",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Datenbank-Modul nicht verfügbar",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Ereignis-Manager-Modul nicht verfügbar",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Verwendung: /emz thresholds sethp <zahl>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Verwendung: /emz thresholds setmana <zahl>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Verwendung: /emz infobar width <full|zahl>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Verwendung: /emz infobar height <zahl>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Unbekannter Befehl: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Unbekannter Befehl: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Unbekannter Befehl: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Unbekannter Befehl: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Unbekannter Befehl: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Unbekannter Befehl: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Unbekannter Befehl: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Unbekannter Befehl: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Konfiguration nicht verfügbar",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Minimap-Button angezeigt",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Minimap-Button verborgen",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Minimap-Button nicht erstellt",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Utils-Modul nicht geladen.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Benutzerdefinierter HP-Schwellenwert auf %s%% gesetzt.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Benutzerdefinierter HP-Schwellenwert zurückgesetzt.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Benutzerdefinierter Mana-Schwellenwert auf %s%% gesetzt.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Benutzerdefinierter Mana-Schwellenwert zurückgesetzt.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Aggressivmodus aktiviert.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Aggressivmodus deaktiviert.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Gruppenmodus-Anpassungen aktiviert.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Solo-Modus-Anpassungen aktiviert.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "PvP-Modus-Anpassungen aktiviert.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "PvE-Modus-Anpassungen aktiviert.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Niedrige HP und Mana - essen und trinken",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Niedrige HP - essen",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Niedrige Mana - trinken",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Ressourcen sind ausreichend",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Empfohlen, sich jetzt auszuruhen",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Jetzt ausruhen",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Bald ausruhen (%d Gegner übrig)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Gut zum Weiterkämpfen (%d Gegner übrig)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Schwellenwerte für Level %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "HP: %d%% | Mana: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "HP: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Begleiter-Heil-Schwellenwert: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Gegner vor Ausruhen: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Aggressivmodus: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Gruppenanpassungen aktiviert",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "PvP-Anpassungen aktiviert",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Farm-Effizienz ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "HP: %d%% (Schwellenwert: %d%%) | Mana: %d%% (Schwellenwert: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "HP: %d%% (Schwellenwert: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "HP-Puffer: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Geschätzter Schaden/Gegner: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Verbleibende Gegner vor Ausruhen: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Empfehlung: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Verwendung: /emz thresholds sethp <zahl>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Verwendung: /emz thresholds setmana <zahl>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Benutzerdefinierte Schwellenwerte zurückgesetzt",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Verwendung: /emz thresholds group [an|aus]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Verwendung: /emz thresholds pvp [an|aus]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Verfügbare Befehle:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Schwellenwerte anzeigen",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Farm-Effizienz anzeigen",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Aggressivmodus umschalten",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <zahl> - HP-Schwellenwert setzen",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <zahl> - Mana-Schwellenwert setzen",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Schwellenwerte zurücksetzen",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [an|aus] - Gruppenstatus",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [an|aus] - PvP-Status",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "EmzTools Konfiguration",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig initialisiert",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Thema angewendet",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Ladefehler",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Themenauswahl",
    ["EMZTOOLS_UICONFIG_ERROR"] = "UIConfig-Fehler",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Bidirektionale Kompatibilität hergestellt",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Krieger",
    ["CLASS_MAGE"] = "Magier",
    ["CLASS_ROGUE"] = "Schurke",
    ["CLASS_DRUID"] = "Druide",
    ["CLASS_HUNTER"] = "Jäger",
    ["CLASS_SHAMAN"] = "Schamane",
    ["CLASS_PRIEST"] = "Priester",
    ["CLASS_WARLOCK"] = "Hexenmeister",
    ["CLASS_PALADIN"] = "Paladin",
    ["CLASS_UNKNOWN"] = "Unbekannt",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Debug-Meldungen
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Core-Tab geladen",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Core-Tab registriert",

    -- Konfiguration
    ["EMZTOOLS_DEBUG_MODE"] = "Debug-Modus",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Automatisches Laden von Plugins",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Automatisches Laden von Plugins aktiviert",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Automatisches Laden von Plugins deaktiviert",

    -- Thema
    ["EMZTOOLS_THEME_INTERFACE"] = "Interface-Thema",
    ["EMZTOOLS_CURRENT_THEME"] = "Aktuelles Thema:",
    ["EMZTOOLS_THEME_CHANGED"] = "Thema geändert zu: %s",

    -- Datenbank
    ["EMZTOOLS_DATABASE_TITLE"] = "Datenbank",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "DB zurücksetzen",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Sind Sie sicher, dass Sie die Datenbank zurücksetzen möchten?\n\nAlle Ihre Konfigurationen werden gelöscht.",
    ["EMZTOOLS_DATABASE_RESET"] = "Datenbank zurückgesetzt. Lade neu...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Alle Standardwerte wiederherstellen?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Standardwerte wiederhergestellt",
    ["EMZTOOLS_CONFIG_RESET"] = "Konfiguration zurückgesetzt",

    -- Informationen
    ["EMZTOOLS_INFO_TITLE"] = "Information",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugins geladen",

    -- Tab-Beschreibung
    ["EMZTOOLS_CORE_TAB_DESC"] = "Haupt-EmzTools-Framework-Konfiguration",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "EmzTools Konfiguration",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Optionen",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Layout",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Vollbild",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Layout Vollbild",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Benutzerdefiniert",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Layout Benutzerdefiniert",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Benutzerdefinierte Breite",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Höhe",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Höhe 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Höhe 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Transparenz",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Anzeigeelemente",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latenz",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Gold",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "EP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Uhrformat",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Uhrformat Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Uhrformat 24 Stunden",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Uhrformat 12 Stunden",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Test",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar getestet - Anzeige umgeschaltet",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "InfoBar-Modul nicht verfügbar",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "InfoBar-Konfiguration auf Standardwerte zurücksetzen?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "InfoBar-Konfiguration auf Standardwerte zurückgesetzt",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Informationsleisten-Konfiguration",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "InfoBar-Tab registriert",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "InfoBar-Tab geladen",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Trankverwaltung",
    ["EMZTOOLS_POTIONS_DESC"] = "Automatische Konfiguration von Tränken und Verbrauchsgütern",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Heiltränke",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-Heilung",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Verwendet automatisch Heiltränke, wenn deine Gesundheit niedrig ist.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Heilpriorität:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Intelligent",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Stein zuerst",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Trank zuerst",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Gesundheitssteine verwenden",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Verwendet Gesundheitssteine, die von Hexenmeistern erstellt werden.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Manatränke",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-Mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Verwendet automatisch Manatränke, wenn dein Mana niedrig ist.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Alarme und Ankündigungen",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Soundalarm",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Spielt einen Sound ab, wenn ein Trank automatisch verwendet wird.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Im Chat ankündigen",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Kündigt Trankverwendung im Gruppen-/Raid-Kanal an.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Offensive Tränke",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Offensive Priorität:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Entzaubern/Magie",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Schaden",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Geschwindigkeit",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Trank-Konfiguration auf Standardwerte zurücksetzen?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Trank-Konfiguration auf Standardwerte zurückgesetzt",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Setzt alle Optionen auf ihre Standardwerte zurück.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Trank-Tab geladen",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Trank-Tab registriert",
    ["EMZTOOLS_STATE_MODULES"] = "Module",
}
