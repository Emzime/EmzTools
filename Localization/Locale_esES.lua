-- ===================================================
-- EmzTools - Localización española
-- ===================================================

Locale_esES = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Cargado",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "No cargado",
    ["EMZTOOLS_STATE_CONNECTED"] = "Conectado",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Desconectado",
    ["EMZTOOLS_STATE_ENABLED"] = "Habilitado",
    ["EMZTOOLS_STATE_DISABLED"] = "Deshabilitado",
    ["EMZTOOLS_STATE_APPLY"] = "Aplicar",
    ["EMZTOOLS_STATE_RESET"] = "Restablecer",
    ["EMZTOOLS_STATE_YES"] = "Sí",
    ["EMZTOOLS_STATE_NO"] = "No",
    ["EMZTOOLS_STATE_STATUS"] = "Estado",
    ["EMZTOOLS_STATE_SETTINGS"] = "Configuración",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Sin configuración",
    ["EMZTOOLS_STATE_TOTAL"] = "Total",
    ["EMZTOOLS_STATE_LOCKED"] = "Bloqueado",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Desbloqueado",
    ["EMZTOOLS_STATE_NONE"] = "Ninguno",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/A",
    ["EMZTOOLS_STATE_ACTIVE"] = "Activo",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inactivo",
    ["EMZTOOLS_STATE_PAUSED"] = "Pausado",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Desconocido",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "No aprendido",
    ["EMZTOOLS_STATE_READY"] = "Listo",
    ["EMZTOOLS_STATE_NOT_READY"] = "No listo",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (En enfriamiento)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "No se puede colocar",
    ["EMZTOOLS_STATE_REFRESH"] = "Actualizar",
    ["EMZTOOLS_STATE_SEARCH"] = "Buscar",
    ["EMZTOOLS_STATE_SHOW"] = "Mostrar",
    ["EMZTOOLS_STATE_HIDDEN"] = "Oculto",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Comando desconocido. Escribe /emz help para ayuda",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Escribe /emz o /emztools para ayuda.",
    ["EMZTOOLS_INVALID_KEY"] = "[Clave de localización inválida]",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Base de datos inicializada.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Verificando estructuras de datos...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Modo depuración habilitado.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Modo depuración deshabilitado.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Localización del framework cargada.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Localización no encontrada, usando inglés.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Localización cargada para plugin '%s' desde '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Usando respaldo inglés para plugin '%s' desde '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "No se encontró localización para plugin '%s'.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Módulo '%s' cargado exitosamente.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Módulo '%s' no encontrado.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Error inicializando módulo '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Módulo '%s' descargado.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Error cerrando módulo '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Nombre de módulo requerido.",
    ["EMZTOOLS_LOADING_MODULE"] = "Cargando módulo '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Descargando módulo '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Módulo '%s' no soportado para clase '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' registrado.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Registro de plugin fallido: parámetros inválidos.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' no soportado para clase '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin para %s cargado.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' no encontrado.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Error inicializando plugin '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' está deshabilitado.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "UI de plugin para '%s' registrada.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Visibilidad de plugin alternada",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Visualización de plugin alternada",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "ADVERTENCIA: Sin función de alternancia para %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "ADVERTENCIA: Sin plugin para clase %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Valor inválido para estado de plugin",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s habilitado",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s deshabilitado",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ERROR: Nombre de plugin faltante",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: función o nombre de función requerido",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: retardo inválido",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Temporizador #%s cancelado",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s temporizadores purgados",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Módulo Utils no disponible.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Cargando automáticamente módulos para clase '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Ayuda: /emz help - Mostrar ayuda",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Config: /emz config - Abrir configuración",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Depuración: /emz debug [on/off] - Alternar modo depuración",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Mostrar ayuda completa",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Abrir configuración",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "El módulo Ayuda no está cargado.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Interfaz de configuración no disponible",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Módulo de base de datos no disponible, usando configuración predeterminada.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Recargar UI",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Clic para recargar la interfaz de usuario",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "¿Recargar la interfaz de usuario?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Desbloqueada",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Arrastrar para mover\nClic derecho para opciones",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Reloj del juego",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Clic derecho para cambiar formato de hora",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Formato de reloj",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (Basado en localidad)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "Formato 24 horas",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "Formato 12 horas",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "Ancho de InfoBar establecido a %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "Altura de InfoBar establecida a %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: El nombre de textura no puede ser nulo.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Textura desconocida '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Texturas disponibles: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "Textura de InfoBar '%s' no encontrada, usando predeterminada.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "No hay comida disponible en tu inventario.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "No hay agua disponible en tu inventario.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Ya está comiendo o bebiendo.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Comiendo %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Bebiendo %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Salud y maná ya están llenos.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Consumibles disponibles ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Comida: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Agua: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Comandos de Consumibles ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Mostrar consumibles disponibles",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Comer la mejor comida disponible",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Beber la mejor agua disponible",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Descansar (comer/beber según necesidad)",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB creada con estructura base",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migración: umbrales movidos de Potions a Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Módulo de base de datos '%s' inicializado",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Base de datos completamente restablecida",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Recarga de UI (/reload) requerida para que los cambios surtan efecto",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Módulo '%s' importado exitosamente",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Modo depuración requerido para este comando",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Módulos registrados ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "No hay módulos registrados",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Detalles del módulo: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Volcado de base de datos ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Base de datos no inicializada",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Configuración del núcleo:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Callback inválido: evento y función requeridos",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Parámetros faltantes: evento e identificador requeridos",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Nombre de evento requerido",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Error de callback en %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Evento '%s' registrado",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Callback añadido para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Callback removido para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Evento '%s' desregistrado",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Todos los callbacks removidos para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Evento personalizado activado: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Entró en combate",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Salió de combate",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "¡Subió de nivel! Ahora nivel %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Jugador murió",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Entrando al mundo",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Saliendo del mundo",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Eventos comunes registrados",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Eventos registrados ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Evento: %s (%d callbacks)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "No hay eventos registrados",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Eventos totales: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Callbacks para evento: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "No hay callbacks para este evento",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "ID de callback: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Nombre de evento requerido",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Estadísticas del gestor de eventos ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Callbacks promedio por evento: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ Comandos de EmzTools ] ==-",
    ["EMZTOOLS_VERSION"] = "Versión: %s",
    ["EMZTOOLS_AUTHOR"] = "Autor: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Comandos principales):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFAZ:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "JUEGO (Farming & Optimización):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "UTILIDADES & DEPURACIÓN:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "CONSEJOS:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "UMBRALES:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "CONSUMIBLES:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "POCIONES:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PERFILADOR (Rendimiento):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "CARTAS (Interfaz de cartas):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Mostrar esta ayuda",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Mostrar versión",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [on|off] - Habilitar/deshabilitar modo depuración",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Alternar visibilidad de plugin",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Abrir configuración",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Alias para config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Mostrar InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Ocultar InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Alternar visualización",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Bloquear/desbloquear",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Cambiar textura",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Abrir configuración",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|número> - Establecer ancho",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <número> - Establecer altura",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Modo pantalla completa",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Ancho personalizado 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Altura personalizada 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Mostrar umbrales actuales",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Mostrar eficiencia de farming",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Habilitar/deshabilitar modo agresivo",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <número> - Establecer umbral de vida personalizado",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <número> - Establecer umbral de maná personalizado",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Restablecer umbrales personalizados",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [on|off] - Establecer estado de grupo",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [on|off] - Establecer estado JcJ",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Listar consumibles disponibles",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Usar comida",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Usar agua",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Descansar automáticamente",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Listar pociones disponibles",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Recomendar pociones para tu nivel",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Usar una poción de salud",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Usar una poción de maná",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Usar una piedra de salud (Brujo)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Usar inteligentemente lo disponible",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Iniciar perfilador",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Detener perfilador",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Mostrar informe",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Restablecer estadísticas",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Mostrar información de cartas",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Recargar cartas",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Actualizar visualización",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Usa /emz para mostrar esta ayuda",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config abre la interfaz de configuración",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• El modo depuración (/emz debug) muestra información técnica",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Los umbrales se adaptan automáticamente a tu nivel/clase",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Consejo: Escribe /emz <módulo> help para ayuda específica",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Ayuda específica para módulo: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Módulo no encontrado. Escribe /emz help para lista completa",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== Comandos de EmzTools ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Sistema de ayuda no cargado.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Reinicia el addon o escribe /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== AYUDA DETALLADA - UMBRALES ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Sistema de umbrales inteligente para optimización de farming",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Comandos principales:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Configuración:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Modo especial:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== AYUDA DETALLADA - CONSUMIBLES ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Gestión automática de comida, agua y vendas",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Características:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Elige automáticamente el mejor ítem para tu nivel",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• No funciona en combate",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Gestiona automáticamente tiempos de reutilización",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== AYUDA DETALLADA - POCIONES ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Base de datos y gestión de pociones de salud/maná",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Comandos:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== AYUDA DETALLADA - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Barra de información personalizable en la parte superior de la pantalla",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Visualización:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Configuración rápida:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Configuración completa:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Elige elementos mostrados (FPS, Latencia, Oro, XP, Reloj)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Selecciona textura (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Ajusta transparencia",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== AYUDA DETALLADA - PERFILADOR ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Perfilador interno para analizar rendimiento",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Características:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Mide tiempo de ejecución de funciones",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifica funciones más lentas",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Muestra ventana de monitoreo en tiempo real",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Útil para depurar problemas de rendimiento",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Más lenta",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Promedio",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Llamadas",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Funciones",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Problemas",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Sin problemas",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Envolviendo funciones...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Perfilador iniciado",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Perfilador detenido",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Estadísticas restablecidas",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== INFORME DEL PERFILADOR ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Funciones: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Llamadas totales: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Tiempo total: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Más lenta: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLEMAS ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Comandos del Perfilador ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Iniciar perfilador",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Detener perfilador",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Mostrar informe",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Restablecer estadísticas",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Cliente)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Inglés",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Francés",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Alemán",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Español",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italiano",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Portugués",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Ruso",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Idioma establecido a",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Clic izquierdo: Abrir configuración",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Clic derecho: Cambiar idioma",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "No hay pociones de salud disponibles.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "No hay pociones de maná disponibles.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "No hay piedras de salud disponibles.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "La salud ya está completa.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "No hay ítems de curación disponibles.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Pociones disponibles:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Salud: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Salud: Ninguna",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Maná: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Maná: Ninguna",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Piedra de salud: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Piedra de salud: Ninguna",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Pociones recomendadas para nivel %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Salud: %s (restaura %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Maná: %s (restaura %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Comandos de pociones:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Mostrar pociones disponibles",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Mostrar pociones recomendadas para tu nivel",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Usar mejor poción de salud",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Usar mejor poción de maná",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Usar mejor piedra de salud",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Elección inteligente de curación",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando de pociones desconocido. Escribe /emz potions help para ayuda.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ Versión de EmzTools ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Sistema de ayuda no disponible",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Módulo Umbrales no disponible",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Módulo Consumibles no disponible",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Módulo Pociones no disponible",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "Módulo InfoBar no disponible",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Módulo Perfilador interno no disponible",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Módulo Minimapa no disponible",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Módulo Base de datos no disponible",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Módulo Gestor de eventos no disponible",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Uso: /emz thresholds sethp <número>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Uso: /emz thresholds setmana <número>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Uso: /emz infobar width <full|número>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Uso: /emz infobar height <número>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Comando desconocido: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Comando desconocido: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando desconocido: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Comando desconocido: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Comando desconocido: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Comando desconocido: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Comando desconocido: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Comando desconocido: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Configuración no disponible",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Botón del minimapa mostrado",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Botón del minimapa oculto",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Botón del minimapa no creado",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Módulo Utils no cargado.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Umbral de vida personalizado establecido a %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Umbral de vida personalizado restablecido.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Umbral de maná personalizado establecido a %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Umbral de maná personalizado restablecido.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Modo agresivo habilitado.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Modo agresivo deshabilitado.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Ajustes de modo grupo habilitados.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Ajustes de modo solo habilitados.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "Ajustes de modo JcJ habilitados.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "Ajustes de modo JcE habilitados.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Vida y maná bajos - comer y beber",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Vida baja - comer",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Maná bajo - beber",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Los recursos son suficientes",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Recomendado descansar ahora",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Descansar ahora",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Descansar pronto (%d enemigos restantes)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Bueno para continuar (%d enemigos restantes)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Umbrales para nivel %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "Vida: %d%% | Maná: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "Vida: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Umbral de curación de mascota: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Enemigos antes de descansar: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Modo agresivo: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Ajustes de grupo habilitados",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "Ajustes JcJ habilitados",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Eficiencia de Farming ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "Vida: %d%% (Umbral: %d%%) | Maná: %d%% (Umbral: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "Vida: %d%% (Umbral: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "Amortiguador de vida: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Daño estimado/enemigo: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Enemigos restantes antes de descansar: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Recomendación: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Uso: /emz thresholds sethp <número>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Uso: /emz thresholds setmana <número>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Umbrales personalizados restablecidos",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Uso: /emz thresholds group [on|off]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Uso: /emz thresholds pvp [on|off]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Comandos disponibles:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Mostrar umbrales",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Mostrar eficiencia de farming",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Alternar modo agresivo",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <número> - Establecer umbral de vida",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <número> - Establecer umbral de maná",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Restablecer umbrales",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [on|off] - Estado de grupo",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [on|off] - Estado JcJ",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "Configuración de EmzTools",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig inicializado",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Tema aplicado",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Error de carga",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Selector de tema",
    ["EMZTOOLS_UICONFIG_ERROR"] = "Error UIConfig",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Compatibilidad bidireccional establecida",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Guerrero",
    ["CLASS_MAGE"] = "Mago",
    ["CLASS_ROGUE"] = "Pícaro",
    ["CLASS_DRUID"] = "Druida",
    ["CLASS_HUNTER"] = "Cazador",
    ["CLASS_SHAMAN"] = "Chamán",
    ["CLASS_PRIEST"] = "Sacerdote",
    ["CLASS_WARLOCK"] = "Brujo",
    ["CLASS_PALADIN"] = "Paladín",
    ["CLASS_UNKNOWN"] = "Desconocido",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Mensajes de depuración
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Pestaña Core cargada",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Pestaña Core registrada",

    -- Configuración
    ["EMZTOOLS_DEBUG_MODE"] = "Modo depuración",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Carga automática de plugins",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Carga automática de plugins habilitada",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Carga automática de plugins deshabilitada",

    -- Tema
    ["EMZTOOLS_THEME_INTERFACE"] = "Tema de interfaz",
    ["EMZTOOLS_CURRENT_THEME"] = "Tema actual:",
    ["EMZTOOLS_THEME_CHANGED"] = "Tema cambiado a: %s",

    -- Base de datos
    ["EMZTOOLS_DATABASE_TITLE"] = "Base de datos",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Restablecer BD",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "¿Estás seguro de que deseas restablecer la base de datos?\n\nTodas tus configuraciones serán borradas.",
    ["EMZTOOLS_DATABASE_RESET"] = "Base de datos restablecida. Recargando...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "¿Restaurar todos los valores predeterminados?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Valores predeterminados restaurados",
    ["EMZTOOLS_CONFIG_RESET"] = "Configuración restablecida",

    -- Información
    ["EMZTOOLS_INFO_TITLE"] = "Información",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugins cargados",

    -- Descripción de la pestaña
    ["EMZTOOLS_CORE_TAB_DESC"] = "Configuración principal del framework EmzTools",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "Configuración de EmzTools",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Opciones",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Diseño",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Pantalla completa",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Diseño Pantalla completa",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Personalizado",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Diseño Personalizado",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Ancho personalizado",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Altura",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Altura 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Altura 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Transparencia",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Elementos de visualización",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latencia",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Oro",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "XP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Formato de reloj",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Formato de reloj Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Formato de reloj 24 horas",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Formato de reloj 12 horas",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Probar",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar probada - visualización alternada",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "Módulo InfoBar no disponible",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "¿Restablecer configuración de InfoBar a valores predeterminados?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "Configuración de InfoBar restablecida a valores predeterminados",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Configuración de barra de información",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "Pestaña InfoBar registrada",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "Pestaña InfoBar cargada",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Gestión de Pociones",
    ["EMZTOOLS_POTIONS_DESC"] = "Configuración automática de pociones y consumibles",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Pociones de Salud",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-curación",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Usa automáticamente pociones de salud cuando tu vida sea baja.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Prioridad de curación:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Inteligente",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Piedra primero",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Poción primero",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Usar piedras de salud",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Usa piedras de salud creadas por brujos.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Pociones de Maná",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-maná",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Usa automáticamente pociones de maná cuando tu maná sea bajo.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Alertas y Anuncios",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Alerta sonora",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Reproduce un sonido cuando se use una poción automáticamente.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Anunciar en chat",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Anuncia el uso de pociones en el canal grupo/banda.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Pociones Ofensivas",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Prioridad ofensiva:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Disipar/Magia",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Daño",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Velocidad",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "¿Restablecer configuración de Pociones a valores predeterminados?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Configuración de Pociones restablecida a valores predeterminados",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Restablece todas las opciones a sus valores predeterminados.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Pestaña Pociones cargada",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Pestaña Pociones registrada",
    ["EMZTOOLS_STATE_MODULES"] = "Módulos",
}
