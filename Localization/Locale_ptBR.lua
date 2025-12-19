-- ===================================================
-- EmzTools - Localização Português Brasileiro
-- ===================================================

Locale_ptBR = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Carregado",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Não Carregado",
    ["EMZTOOLS_STATE_CONNECTED"] = "Conectado",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Desconectado",
    ["EMZTOOLS_STATE_ENABLED"] = "Habilitado",
    ["EMZTOOLS_STATE_DISABLED"] = "Desabilitado",
    ["EMZTOOLS_STATE_APPLY"] = "Aplicar",
    ["EMZTOOLS_STATE_RESET"] = "Redefinir",
    ["EMZTOOLS_STATE_YES"] = "Sim",
    ["EMZTOOLS_STATE_NO"] = "Não",
    ["EMZTOOLS_STATE_STATUS"] = "Status",
    ["EMZTOOLS_STATE_SETTINGS"] = "Configurações",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Sem configurações",
    ["EMZTOOLS_STATE_TOTAL"] = "Total",
    ["EMZTOOLS_STATE_LOCKED"] = "Bloqueado",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Desbloqueado",
    ["EMZTOOLS_STATE_NONE"] = "Nenhum",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/A",
    ["EMZTOOLS_STATE_ACTIVE"] = "Ativo",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inativo",
    ["EMZTOOLS_STATE_PAUSED"] = "Pausado",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Desconhecido",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Não Aprendido",
    ["EMZTOOLS_STATE_READY"] = "Pronto",
    ["EMZTOOLS_STATE_NOT_READY"] = "Não Pronto",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (Em Recarga)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Não Pode Colocar",
    ["EMZTOOLS_STATE_REFRESH"] = "Atualizar",
    ["EMZTOOLS_STATE_SEARCH"] = "Buscar",
    ["EMZTOOLS_STATE_SHOW"] = "Mostrar",
    ["EMZTOOLS_STATE_HIDDEN"] = "Oculto",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Comando desconhecido. Digite /emz help para ajuda",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Digite /emz ou /emztools para ajuda.",
    ["EMZTOOLS_INVALID_KEY"] = "[Chave de Localização Inválida]",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Banco de dados inicializado.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Verificando estruturas de dados...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Modo depuração habilitado.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Modo depuração desabilitado.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Localização do framework carregada.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Localização não encontrada, usando inglês.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Localização carregada para plugin '%s' de '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Usando fallback inglês para plugin '%s' de '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "Nenhuma localização encontrada para plugin '%s'.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Módulo '%s' carregado com sucesso.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Módulo '%s' não encontrado.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Erro inicializando módulo '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Módulo '%s' descarregado.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Erro encerrando módulo '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Nome do módulo é obrigatório.",
    ["EMZTOOLS_LOADING_MODULE"] = "Carregando módulo '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Descarregando módulo '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Módulo '%s' não suportado para classe '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' registrado.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Falha no registro do plugin: parâmetros inválidos.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' não suportado para classe '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin para %s carregado.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' não encontrado.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Erro inicializando plugin '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' está desabilitado.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "UI do plugin para '%s' registrada.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Visibilidade do plugin alternada",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Exibição do plugin alternada",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "AVISO: Nenhuma função de alternância para %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "AVISO: Nenhum plugin para classe %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Valor inválido para estado do plugin",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s habilitado",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s desabilitado",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ERRO: Nome do plugin faltando",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: função ou nome de função necessário",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: atraso inválido",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Timer #%s cancelado",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s timers purgados",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Módulo Utils não disponível.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Carregando automaticamente módulos para classe '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Ajuda: /emz help - Mostrar ajuda",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Config: /emz config - Abrir configuração",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Depuração: /emz debug [on/off] - Alternar modo depuração",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Mostrar ajuda completa",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Abrir configuração",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "O módulo Ajuda não está carregado.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Interface de configuração não disponível",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Módulo de banco de dados não disponível, usando configuração padrão.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Recarregar UI",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Clique para recarregar a interface do usuário",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Recarregar a interface do usuário?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Desbloqueada",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Arraste para mover\nBotão direito para opções",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Relógio do Jogo",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Botão direito para mudar formato de hora",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Formato do Relógio",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (Baseado na Localidade)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "Formato 24 Horas",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "Formato 12 Horas",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "Largura da InfoBar definida para %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "Altura da InfoBar definida para %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: Nome da textura não pode ser nulo.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Textura desconhecida '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Texturas disponíveis: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "Textura da InfoBar '%s' não encontrada, usando padrão.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "Nenhuma comida disponível no seu inventário.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "Nenhuma água disponível no seu inventário.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Já está comendo ou bebendo.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Comendo %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Bebendo %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Vida e mana já estão cheios.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Consumíveis Disponíveis ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Comida: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Água: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Comandos de Consumíveis ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Mostrar consumíveis disponíveis",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Comer a melhor comida disponível",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Beber a melhor água disponível",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Descansar automaticamente",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB criada com estrutura base",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migração: limiares movidos de Potions para Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Módulo de banco de dados '%s' inicializado",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Banco de dados completamente redefinido",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Recarregar UI (/reload) necessário para mudanças fazerem efeito",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Módulo '%s' importado com sucesso",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Modo depuração necessário para este comando",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Módulos Registrados ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "Nenhum módulo registrado",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Detalhes do Módulo: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Despejo do Banco de Dados ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Banco de dados não inicializado",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Configurações principais:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Callback inválido: evento e função necessários",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Parâmetros faltando: evento e identificador necessários",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Nome do evento necessário",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Erro de callback em %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Evento '%s' registrado",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Callback adicionado para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Callback removido para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Evento '%s' desregistrado",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Todos callbacks removidos para evento '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Evento personalizado disparado: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Entrou em combate",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Saiu de combate",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Subiu de nível! Agora nível %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Jogador morreu",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Entrando no mundo",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Saindo do mundo",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Eventos comuns registrados",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Eventos Registrados ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Evento: %s (%d callbacks)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "Nenhum evento registrado",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Eventos totais: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Callbacks para evento: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "Nenhum callback para este evento",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "ID do callback: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Nome do evento necessário",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Estatísticas do Gerenciador de Eventos ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Média de callbacks por evento: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ Comandos EmzTools ] ==-",
    ["EMZTOOLS_VERSION"] = "Versão: %s",
    ["EMZTOOLS_AUTHOR"] = "Autor: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Comandos principais):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFACE:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "JOGABILIDADE (Farming & Otimização):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "UTILIDADES & DEPURAÇÃO:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "DICAS:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "LIMIARES:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "CONSUMÍVEIS:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "POÇÕES:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PROFILER (Desempenho):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "CARTAS (Interface de cartas):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Mostrar esta ajuda",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Mostrar versão",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [on|off] - Habilitar/desabilitar modo depuração",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Alternar visibilidade do plugin",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Abrir configuração",
    ["EMZTOOLS_HELP_COMMAND_SETTings"] = "/emz settings - Alias para config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Mostrar InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Ocultar InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Alternar exibição",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Bloquear/desbloquear",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Mudar textura",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Abrir configuração",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|número> - Definir largura",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <número> - Definir altura",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Modo tela cheia",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Largura personalizada 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Altura personalizada 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Mostrar limiares atuais",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Mostrar eficiência de farming",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Habilitar/desabilitar modo agressivo",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <número> - Definir limiar de vida personalizado",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <número> - Definir limiar de mana personalizado",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Redefinir limiares personalizados",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [on|off] - Definir status de grupo",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [on|off] - Definir status JxJ",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Listar consumíveis disponíveis",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Usar comida",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Usar água",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Descansar automaticamente",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Listar poções disponíveis",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Recomendar poções para seu nível",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Usar uma poção de vida",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Usar uma poção de mana",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Usar uma pedra da saúde (Bruxo)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Usar inteligentemente o disponível",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Iniciar profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Parar profiler",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Mostrar relatório",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Redefinir estatísticas",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Mostrar informações de cartas",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Recarregar cartas",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Atualizar exibição",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Use /emz para mostrar esta ajuda",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config abre a interface de configuração",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Modo depuração (/emz debug) mostra informações técnicas",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Limiares adaptam-se automaticamente ao seu nível/classe",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Dica: Digite /emz <módulo> help para ajuda específica",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Ajuda específica para módulo: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Módulo não encontrado. Digite /emz help para lista completa",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== Comandos EmzTools ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Sistema de ajuda não carregado.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Reinicie o addon ou digite /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== AJUDA DETALHADA - LIMIARES ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Sistema de limiares inteligente para otimização de farming",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Comandos principais:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Configuração:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Modo especial:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== AJUDA DETALHADA - CONSUMÍVEIS ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Gerenciamento automático de comida, água e bandagens",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Características:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Escolhe automaticamente o melhor item para seu nível",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Não funciona em combate",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Gerencia automaticamente recargas",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== AJUDA DETALHADA - POÇÕES ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Banco de dados e gerenciamento de poções de vida/mana",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Comandos:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== AJUDA DETALHADA - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Barra de informação personalizável no topo da tela",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Exibição:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Configuração rápida:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Configuração completa:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Escolha elementos exibidos (FPS, Latência, Ouro, XP, Relógio)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Selecione textura (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Ajuste transparência",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== AJUDA DETALHADA - PROFILER ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Profiler interno para análise de desempenho",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Uso:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Características:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Mede tempo de execução de funções",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifica funções mais lentas",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Mostra janela de monitoramento em tempo real",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Útil para depurar problemas de desempenho",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Mais lenta",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Média",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Chamadas",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Funções",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Problemas",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Sem problemas",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Envolvendo funções...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Profiler iniciado",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Profiler parado",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Estatísticas redefinidas",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== RELATÓRIO DO PROFILER ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Funções: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Chamadas totais: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Tempo total: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Mais lenta: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLEMAS ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Comandos do Profiler ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Iniciar profiler",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Parar profiler",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Mostrar relatório",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Redefinir estatísticas",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Cliente)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Inglês",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Francês",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Alemão",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Espanhol",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italiano",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Português",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Russo",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Idioma definido para",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Botão esquerdo: Abrir configuração",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Botão direito: Mudar idioma",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "Nenhuma poção de vida disponível.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "Nenhuma poção de mana disponível.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "Nenhuma pedra da saúde disponível.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Usado %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "Vida já está cheia.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "Nenhum item de cura disponível.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Poções disponíveis:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Vida: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Vida: Nenhuma",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Mana: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Mana: Nenhuma",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Pedra da saúde: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Pedra da saúde: Nenhuma",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Poções recomendadas para nível %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Vida: %s (restaura %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Mana: %s (restaura %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Comandos de poções:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Mostrar poções disponíveis",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Mostrar poções recomendadas para seu nível",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Usar melhor poção de vida",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Usar melhor poção de mana",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Usar melhor pedra da saúde",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Escolha inteligente de cura",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando de poções desconhecido. Digite /emz potions help para ajuda.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ Versão EmzTools ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Sistema de ajuda não disponível",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Módulo Limiares não disponível",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Módulo Consumíveis não disponível",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Módulo Poções não disponível",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "Módulo InfoBar não disponível",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Módulo Profiler interno não disponível",
    ["EMZTOOLS_MINIMap_MODULE_UNAVAILABLE"] = "Módulo Minimapa não disponível",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Módulo Banco de Dados não disponível",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Módulo Gerenciador de Eventos não disponível",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Uso: /emz thresholds sethp <número>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Uso: /emz thresholds setmana <número>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Uso: /emz infobar width <full|número>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Uso: /emz infobar height <número>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Comando desconhecido: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Comando desconhecido: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Comando desconhecido: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Comando desconhecido: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Comando desconhecido: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Comando desconhecido: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Comando desconhecido: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Comando desconhecido: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Configuração não disponível",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Botão do minimapa mostrado",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Botão do minimapa oculto",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Botão do minimapa não criado",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Módulo Utils não carregado.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Limiar de vida personalizado definido para %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Limiar de vida personalizado redefinido.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Limiar de mana personalizado definido para %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Limiar de mana personalizado redefinido.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Modo agressivo habilitado.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Modo agressivo desabilitado.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Ajustes de modo grupo habilitados.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Ajustes de modo solo habilitados.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "Ajustes de modo JxJ habilitados.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "Ajustes de modo JxA habilitados.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Vida e mana baixos - comer e beber",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Vida baixa - comer",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Mana baixo - beber",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Recursos são suficientes",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Recomendado descansar agora",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Descansar agora",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Descansar em breve (%d inimigos restantes)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Bom para continuar (%d inimigos restantes)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Limiares para nível %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "Vida: %d%% | Mana: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "Vida: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Limiar de cura do ajudante: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Inimigos antes de descansar: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Modo agressivo: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Ajustes de grupo habilitados",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "Ajustes JxJ habilitados",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Eficiência de Farming ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "Vida: %d%% (Limiar: %d%%) | Mana: %d%% (Limiar: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "Vida: %d%% (Limiar: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "Buffer de vida: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Dano estimado/inimigo: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Inimigos restantes antes de descansar: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Recomendação: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Uso: /emz thresholds sethp <número>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Uso: /emz thresholds setmana <número>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Limiares personalizados redefinidos",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Uso: /emz thresholds group [on|off]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Uso: /emz thresholds pvp [on|off]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Comandos disponíveis:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Mostrar limiares",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Mostrar eficiência de farming",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Alternar modo agressivo",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <número> - Definir limiar de vida",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <número> - Definir limiar de mana",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Redefinir limiares",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [on|off] - Status de grupo",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [on|off] - Status JxJ",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "Configuração EmzTools",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig inicializado",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Tema aplicado",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Erro de carregamento",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Seletor de tema",
    ["EMZTOOLS_UICONFIG_ERROR"] = "Erro UIConfig",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Compatibilidade bidirecional estabelecida",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Guerreiro",
    ["CLASS_MAGE"] = "Mago",
    ["CLASS_ROGUE"] = "Ladino",
    ["CLASS_DRUID"] = "Druida",
    ["CLASS_HUNTER"] = "Caçador",
    ["CLASS_SHAMAN"] = "Xamã",
    ["CLASS_PRIEST"] = "Sacerdote",
    ["CLASS_WARLOCK"] = "Bruxo",
    ["CLASS_PALADIN"] = "Paladino",
    ["CLASS_UNKNOWN"] = "Desconhecido",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Mensagens de depuração
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Aba Core carregada",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Aba Core registrada",

    -- Configuração
    ["EMZTOOLS_DEBUG_MODE"] = "Modo depuração",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Carregamento automático de plugins",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Carregamento automático de plugins habilitado",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Carregamento automático de plugins desabilitado",

    -- Tema
    ["EMZTOOLS_THEME_INTERFACE"] = "Tema da Interface",
    ["EMZTOOLS_CURRENT_THEME"] = "Tema atual:",
    ["EMZTOOLS_THEME_CHANGED"] = "Tema alterado para: %s",

    -- Banco de dados
    ["EMZTOOLS_DATABASE_TITLE"] = "Banco de Dados",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Redefinir BD",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Tem certeza de que deseja redefinir o banco de dados?\n\nTodas suas configurações serão apagadas.",
    ["EMZTOOLS_DATABASE_RESET"] = "Banco de dados redefinido. Recarregando...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Restaurar todos os valores padrão?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Valores padrão restaurados",
    ["EMZTOOLS_CONFIG_RESET"] = "Configuração redefinida",

    -- Informações
    ["EMZTOOLS_INFO_TITLE"] = "Informação",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugins carregados",

    -- Descrição da aba
    ["EMZTOOLS_CORE_TAB_DESC"] = "Configuração principal do framework EmzTools",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "Configuração EmzTools",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Opções",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Layout",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Tela cheia",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Layout Tela cheia",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Personalizado",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Layout Personalizado",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Largura personalizada",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Altura",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Altura 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Altura 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Transparência",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Elementos de exibição",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latência",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Ouro",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "XP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Formato do relógio",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Formato do relógio Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Formato do relógio 24 horas",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Formato do relógio 12 horas",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Teste",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar testada - exibição alternada",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "Módulo InfoBar não disponível",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "Redefinir configuração da InfoBar para valores padrão?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "Configuração da InfoBar redefinida para valores padrão",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Configuração da barra de informação",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "Aba InfoBar registrada",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "Aba InfoBar carregada",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Gerenciamento de Poções",
    ["EMZTOOLS_POTIONS_DESC"] = "Configuração automática de poções e consumíveis",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Poções de Vida",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-cura",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Usa automaticamente poções de vida quando sua saúde está baixa.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Prioridade de cura:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Inteligente",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Pedra primeiro",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Poção primeiro",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Usar pedras da saúde",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Usa pedras da saúde criadas por bruxos.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Poções de Mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Usa automaticamente poções de mana quando seu mana está baixo.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Alertas e Anúncios",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Alerta sonoro",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Reproduz um som quando uma poção é usada automaticamente.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Anunciar no chat",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Anuncia uso de poções no canal grupo/raide.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Poções Ofensivas",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Prioridade ofensiva:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Dissipar/Magia",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Dano",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Velocidade",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Redefinir configuração de Poções para valores padrão?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Configuração de Poções redefinida para valores padrão",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Redefine todas as opções para seus valores padrão.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Aba Poções carregada",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Aba Poções registrada",
    ["EMZTOOLS_STATE_MODULES"] = "Módulos",
}
