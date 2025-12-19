-- ===================================================
-- EmzTools - Localizzazione italiana
-- ===================================================

Locale_itIT = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Caricato",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Non caricato",
    ["EMZTOOLS_STATE_CONNECTED"] = "Connesso",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Disconnesso",
    ["EMZTOOLS_STATE_ENABLED"] = "Abilitato",
    ["EMZTOOLS_STATE_DISABLED"] = "Disabilitato",
    ["EMZTOOLS_STATE_APPLY"] = "Applica",
    ["EMZTOOLS_STATE_RESET"] = "Ripristina",
    ["EMZTOOLS_STATE_YES"] = "Sì",
    ["EMZTOOLS_STATE_NO"] = "No",
    ["EMZTOOLS_STATE_STATUS"] = "Stato",
    ["EMZTOOLS_STATE_SETTINGS"] = "Impostazioni",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Nessuna impostazione",
    ["EMZTOOLS_STATE_TOTAL"] = "Totale",
    ["EMZTOOLS_STATE_LOCKED"] = "Bloccato",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Sbloccato",
    ["EMZTOOLS_STATE_NONE"] = "Nessuno",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/A",
    ["EMZTOOLS_STATE_ACTIVE"] = "Attivo",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inattivo",
    ["EMZTOOLS_STATE_PAUSED"] = "In pausa",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Sconosciuto",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Non appreso",
    ["EMZTOOLS_STATE_READY"] = "Pronto",
    ["EMZTOOLS_STATE_NOT_READY"] = "Non pronto",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (In recupero)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Impossibile posizionare",
    ["EMZTOOLS_STATE_REFRESH"] = "Aggiorna",
    ["EMZTOOLS_STATE_SEARCH"] = "Cerca",
    ["EMZTOOLS_STATE_SHOW"] = "Mostra",
    ["EMZTOOLS_STATE_HIDDEN"] = "Nascosto",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Comando sconosciuto. Digita /emz help per aiuto",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Digita /emz o /emztools per aiuto.",
    ["EMZTOOLS_INVALID_KEY"] = "[Chiave di localizzazione non valida]",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Database inizializzato.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Verifica strutture dati...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Modalità debug abilitata.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Modalità debug disabilitata.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Localizzazione del framework caricata.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Localizzazione non trovata, uso inglese.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Localizzazione caricata per plugin '%s' da '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Uso fallback inglese per plugin '%s' da '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "Nessuna localizzazione trovata per plugin '%s'.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Modulo '%s' caricato con successo.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Modulo '%s' non trovato.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Errore inizializzazione modulo '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Modulo '%s' scaricato.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Errore chiusura modulo '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Nome modulo richiesto.",
    ["EMZTOOLS_LOADING_MODULE"] = "Caricamento modulo '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Scaricamento modulo '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Modulo '%s' non supportato per classe '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' registrato.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Registrazione plugin fallita: parametri non validi.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' non supportato per classe '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin per %s caricato.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' non trovato.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Errore inizializzazione plugin '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' è disabilitato.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "UI plugin per '%s' registrata.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Visibilità plugin alternata",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Visualizzazione plugin alternata",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "ATTENZIONE: Nessuna funzione di alternanza per %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "ATTENZIONE: Nessun plugin per classe %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Valore non valido per stato plugin",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s abilitato",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s disabilitato",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ERRORE: Nome plugin mancante",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: funzione o nome funzione richiesto",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: ritardo non valido",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Timer #%s cancellato",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s timer eliminati",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Modulo Utils non disponibile.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Caricamento automatico moduli per classe '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Aiuto: /emz help - Mostra aiuto",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Config: /emz config - Apri configurazione",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Debug: /emz debug [on/off] - Alterna modalità debug",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Mostra aiuto completo",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Apri configurazione",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Il modulo Aiuto non è caricato.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Interfaccia configurazione non disponibile",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Modulo database non disponibile, uso impostazioni predefinite.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Ricarica UI",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Clicca per ricaricare l'interfaccia utente",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Ricarica l'interfaccia utente?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Sbloccata",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Trascina per spostare\nTasto destro per opzioni",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Ora di gioco",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Tasto destro per cambiare formato ora",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Formato orologio",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (Basato su localizzazione)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "Formato 24 ore",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "Formato 12 ore",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "Larghezza InfoBar impostata a %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "Altezza InfoBar impostata a %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: Nome texture non può essere nullo.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Texture sconosciuta '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Texture disponibili: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "Texture InfoBar '%s' non trovata, uso predefinita.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "Nessun cibo disponibile nel tuo inventario.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "Nessuna acqua disponibile nel tuo inventario.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Sta già mangiando o bevendo.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Mangiando %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Bevendo %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Salute e mana già pieni.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Consumabili disponibili ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Cibo: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Acqua: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Comandi Consumabili ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Mostra consumabili disponibili",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Mangia il miglior cibo disponibile",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Bevi la miglior acqua disponibile",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Riposa automaticamente",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB creata con struttura base",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migrazione: soglie spostate da Potions a Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Modulo database '%s' inizializzato",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Database completamente ripristinato",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Ricarica UI (/reload) necessaria per effettuare cambiamenti",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Modulo '%s' importato con successo",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Modalità debug necessaria per questo comando",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Moduli registrati ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "Nessun modulo registrato",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Dettagli modulo: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Dump database ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Database non inizializzato",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Impostazioni core:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Callback non valido: evento e funzione richiesti",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Parametri mancanti: evento e identificatore richiesti",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Nome evento richiesto",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Errore callback in %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Evento '%s' registrato",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Callback aggiunto per evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Callback rimosso per evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Evento '%s' deregistrato",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Tutti i callback rimossi per evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Evento personalizzato attivato: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Entrato in combattimento",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Uscito dal combattimento",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Salito di livello! Ora livello %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Giocatore morto",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Entrando nel mondo",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Uscendo dal mondo",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Eventi comuni registrati",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Eventi registrati ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Evento: %s (%d callback)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "Nessun evento registrato",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Eventi totali: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Callback per evento: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "Nessun callback per questo evento",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "ID callback: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Nome evento richiesto",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Statistiche gestore eventi ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Media callback per evento: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ Comandi EmzTools ] ==-",
    ["EMZTOOLS_VERSION"] = "Versione: %s",
    ["EMZTOOLS_AUTHOR"] = "Autore: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Comandi principali):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFACCIA:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "GAMEPLAY (Farming & Ottimizzazione):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "UTILITY & DEBUG:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "CONSIGLI:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "SOGLIE:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "CONSUMABILI:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "POZIONI:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PROFILER (Prestazioni):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "CARTE (Interfaccia carte):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Mostra questo aiuto",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Mostra versione",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [on|off] - Abilita/disabilita modalità debug",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Alterna visibilità plugin",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Apri configurazione",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Alias per config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Mostra InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Nascondi InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Alterna visualizzazione",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Blocca/sblocca",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Cambia texture",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Apri configurazione",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|numero> - Imposta larghezza",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <numero> - Imposta altezza",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Modalità schermo intero",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Larghezza personalizzata 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Altezza personalizzata 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Mostra soglie attuali",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Mostra efficienza farming",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Abilita/disabilita modalità aggressiva",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <numero> - Imposta soglia salute personalizzata",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <numero> - Imposta soglia mana personalizzata",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Ripristina soglie personalizzate",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [on|off] - Imposta stato gruppo",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [on|off] - Imposta stato PvP",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Elenca consumabili disponibili",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Usa cibo",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Usa acqua",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Riposa automaticamente",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Elenca pozioni disponibili",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Consiglia pozioni per il tuo livello",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Usa una pozione di salute",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Usa una pozione di mana",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Usa una pietra della salute (Stregone)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Usa intelligentemente disponibile",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Avvia profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Ferma profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Mostra rapporto",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Ripristina statistiche",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Mostra informazioni carte",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Ricarica carte",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Aggiorna visualizzazione",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Usa /emz per mostrare questo aiuto",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config apre l'interfaccia di configurazione",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Modalità debug (/emz debug) mostra informazioni tecniche",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Le soglie si adattano automaticamente al tuo livello/classe",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Suggerimento: Digita /emz <modulo> help per aiuto specifico",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Aiuto specifico per modulo: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Modulo non trovato. Digita /emz help per lista completa",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== Comandi EmzTools ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Sistema aiuto non caricato.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Riavvia l'addon o digita /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== AIUTO DETTAGLIATO - SOGLIE ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Sistema soglie intelligente per ottimizzazione farming",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Comandi principali:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Configurazione:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Modalità speciale:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== AIUTO DETTAGLIATO - CONSUMABILI ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Gestione automatica cibo, acqua e bende",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Caratteristiche:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Sceglie automaticamente l'oggetto migliore per il tuo livello",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Non funziona in combattimento",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Gestisce automaticamente tempi di recupero",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== AIUTO DETTAGLIATO - POZIONI ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Database e gestione pozioni salute/mana",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Comandi:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== AIUTO DETTAGLIATO - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Barra informazioni personalizzabile in cima allo schermo",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Visualizzazione:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Configurazione rapida:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Configurazione completa:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Scegli elementi visualizzati (FPS, Latenza, Oro, XP, Orologio)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Seleziona texture (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Regola trasparenza",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== AIUTO DETTAGLIATO - PROFILER ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Profiler interno per analisi prestazioni",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Caratteristiche:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Misura tempo esecuzione funzioni",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifica funzioni più lente",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Mostra finestra monitoraggio tempo reale",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Utile per debug problemi prestazioni",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Più lenta",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Media",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Chiamate",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Funzioni",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Problemi",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Nessun problema",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Avvolgimento funzioni...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Profiler avviato",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Profiler fermato",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Statistiche ripristinate",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== RAPPORTO PROFILER ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Funzioni: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Chiamate totali: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Tempo totale: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Più lenta: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLEMI ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Comandi Profiler ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Avvia profiler",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Ferma profiler",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Mostra rapporto",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Ripristina statistiche",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Client)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Inglese",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Francese",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Tedesco",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Spagnolo",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italiano",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Portoghese",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Russo",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Lingua impostata a",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Clic sinistro: Apri configurazione",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Clic destro: Cambia lingua",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "Nessuna pozione di salute disponibile.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Usato %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "Nessuna pozione di mana disponibile.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Usato %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "Nessuna pietra della salute disponibile.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Usato %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "Salute già piena.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "Nessun oggetto di cura disponibile.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Pozioni disponibili:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Salute: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Salute: Nessuna",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Mana: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Mana: Nessuna",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Pietra della salute: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Pietra della salute: Nessuna",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Pozioni consigliate per livello %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Salute: %s (ripristina %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Mana: %s (ripristina %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Comandi pozioni:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Mostra pozioni disponibili",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Mostra pozioni consigliate per il tuo livello",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Usa migliore pozione di salute",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Usa migliore pozione di mana",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Usa migliore pietra della salute",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Scelta intelligente di cura",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando pozioni sconosciuto. Digita /emz potions help per aiuto.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ Versione EmzTools ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Sistema aiuto non disponibile",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Modulo Soglie non disponibile",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Modulo Consumabili non disponibile",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Modulo Pozioni non disponibile",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "Modulo InfoBar non disponibile",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Modulo Profiler interno non disponibile",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Modulo Minimappa non disponibile",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Modulo Database non disponibile",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Modulo Gestore eventi non disponibile",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Uso: /emz thresholds sethp <numero>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Uso: /emz thresholds setmana <numero>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Uso: /emz infobar width <full|numero>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Uso: /emz infobar height <numero>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Comando sconosciuto: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Comando sconosciuto: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando sconosciuto: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Comando sconosciuto: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Comando sconosciuto: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Comando sconosciuto: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Comando sconosciuto: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Comando sconosciuto: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Configurazione non disponibile",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Pulsante minimappa mostrato",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Pulsante minimappa nascosto",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Pulsante minimappa non creato",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Modulo Utils non caricato.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Soglia salute personalizzata impostata a %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Soglia salute personalizzata ripristinata.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Soglia mana personalizzata impostata a %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Soglia mana personalizzata ripristinata.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Modalità aggressiva abilitata.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Modalità aggressiva disabilitata.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Adeguamenti modalità gruppo abilitati.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Adeguamenti modalità singolo abilitati.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "Adeguamenti modalità PvP abilitati.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "Adeguamenti modalità PvE abilitati.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Salute e mana bassi - mangiare e bere",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Salute bassa - mangiare",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Mana basso - bere",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Risorse sufficienti",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Consigliato riposare ora",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Riposa ora",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Riposa presto (%d nemici rimanenti)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Buono per continuare (%d nemici rimanenti)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Soglie per livello %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "Salute: %d%% | Mana: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "Salute: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Soglia cura compagno: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Nemici prima del riposo: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Modalità aggressiva: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Adeguamenti gruppo abilitati",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "Adeguamenti PvP abilitati",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Efficienza Farming ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "Salute: %d%% (Soglia: %d%%) | Mana: %d%% (Soglia: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "Salute: %d%% (Soglia: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "Buffer salute: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Danno stimato/nemico: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Nemici rimanenti prima del riposo: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Raccomandazione: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Uso: /emz thresholds sethp <numero>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Uso: /emz thresholds setmana <numero>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Soglie personalizzate ripristinate",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Uso: /emz thresholds group [on|off]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Uso: /emz thresholds pvp [on|off]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Comandi disponibili:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Mostra soglie",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Mostra efficienza farming",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Alterna modalità aggressiva",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <numero> - Imposta soglia salute",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <numero> - Imposta soglia mana",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Ripristina soglie",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [on|off] - Stato gruppo",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [on|off] - Stato PvP",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "Configurazione EmzTools",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig inizializzato",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Tema applicato",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Errore caricamento",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Selettore tema",
    ["EMZTOOLS_UICONFIG_ERROR"] = "Errore UIConfig",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Compatibilità bidirezionale stabilita",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Guerriero",
    ["CLASS_MAGE"] = "Mago",
    ["CLASS_ROGUE"] = "Ladro",
    ["CLASS_DRUID"] = "Druido",
    ["CLASS_HUNTER"] = "Cacciatore",
    ["CLASS_SHAMAN"] = "Sciamano",
    ["CLASS_PRIEST"] = "Sacerdote",
    ["CLASS_WARLOCK"] = "Stregone",
    ["CLASS_PALADIN"] = "Paladino",
    ["CLASS_UNKNOWN"] = "Sconosciuto",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Messaggi debug
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Scheda Core caricata",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Scheda Core registrata",

    -- Configurazione
    ["EMZTOOLS_DEBUG_MODE"] = "Modalità debug",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Caricamento automatico plugin",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Caricamento automatico plugin abilitato",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Caricamento automatico plugin disabilitato",

    -- Tema
    ["EMZTOOLS_THEME_INTERFACE"] = "Tema interfaccia",
    ["EMZTOOLS_CURRENT_THEME"] = "Tema attuale:",
    ["EMZTOOLS_THEME_CHANGED"] = "Tema cambiato a: %s",

    -- Database
    ["EMZTOOLS_DATABASE_TITLE"] = "Database",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Ripristina DB",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Sei sicuro di voler ripristinare il database?\n\nTutte le tue configurazioni saranno cancellate.",
    ["EMZTOOLS_DATABASE_RESET"] = "Database ripristinato. Ricaricamento...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Ripristinare tutti i valori predefiniti?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Valori predefiniti ripristinati",
    ["EMZTOOLS_CONFIG_RESET"] = "Configurazione ripristinata",

    -- Informazioni
    ["EMZTOOLS_INFO_TITLE"] = "Informazione",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugin caricati",

    -- Descrizione scheda
    ["EMZTOOLS_CORE_TAB_DESC"] = "Configurazione principale framework EmzTools",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "Configurazione EmzTools",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Opzioni",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Layout",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Schermo intero",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Layout Schermo intero",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Personalizzato",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Layout Personalizzato",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Larghezza personalizzata",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Altezza",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Altezza 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Altezza 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Trasparenza",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Elementi visualizzazione",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latenza",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Oro",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "XP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Formato orologio",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Formato orologio Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Formato orologio 24 ore",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Formato orologio 12 ore",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Prova",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar testata - visualizzazione alternata",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "Modulo InfoBar non disponibile",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "Ripristinare configurazione InfoBar ai valori predefiniti?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "Configurazione InfoBar ripristinata ai valori predefiniti",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Configurazione barra informazioni",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "Scheda InfoBar registrata",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "Scheda InfoBar caricata",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Gestione Pozioni",
    ["EMZTOOLS_POTIONS_DESC"] = "Configurazione automatica pozioni e consumabili",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Pozioni Salute",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-cura",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Usa automaticamente pozioni di salute quando la tua salute è bassa.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Priorità cura:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Intelligente",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Pietra prima",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Pozione prima",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Usa pietre della salute",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Usa pietre della salute create da stregoni.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Pozioni Mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Usa automaticamente pozioni di mana quando il tuo mana è basso.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Avvisi e Annunci",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Avviso sonoro",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Riproduce un suono quando una pozione viene usata automaticamente.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Annuncia in chat",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Annuncia l'uso di pozioni nel canale gruppo/raid.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Pozioni Offensive",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Priorità offensiva:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Dissolvi/Magia",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Danno",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Velocità",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Ripristinare configurazione Pozioni ai valori predefiniti?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Configurazione Pozioni ripristinata ai valori predefiniti",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Ripristina tutte le opzioni ai valori predefiniti.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Scheda Pozioni caricata",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Scheda Pozioni registrata",
    ["EMZTOOLS_STATE_MODULES"] = "Moduli",
}
