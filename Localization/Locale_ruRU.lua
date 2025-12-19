-- ===================================================
-- EmzTools - Русская локализация
-- ===================================================

Locale_ruRU = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Загружен",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Не загружен",
    ["EMZTOOLS_STATE_CONNECTED"] = "Подключен",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Отключен",
    ["EMZTOOLS_STATE_ENABLED"] = "Включен",
    ["EMZTOOLS_STATE_DISABLED"] = "Выключен",
    ["EMZTOOLS_STATE_APPLY"] = "Применить",
    ["EMZTOOLS_STATE_RESET"] = "Сбросить",
    ["EMZTOOLS_STATE_YES"] = "Да",
    ["EMZTOOLS_STATE_NO"] = "Нет",
    ["EMZTOOLS_STATE_STATUS"] = "Статус",
    ["EMZTOOLS_STATE_SETTINGS"] = "Настройки",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Нет настроек",
    ["EMZTOOLS_STATE_TOTAL"] = "Всего",
    ["EMZTOOLS_STATE_LOCKED"] = "Заблокирован",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Разблокирован",
    ["EMZTOOLS_STATE_NONE"] = "Нет",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "Н/П",
    ["EMZTOOLS_STATE_ACTIVE"] = "Активен",
    ["EMZTOOLS_STATE_INACTIVE"] = "Неактивен",
    ["EMZTOOLS_STATE_PAUSED"] = "Приостановлен",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Неизвестно",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Не изучено",
    ["EMZTOOLS_STATE_READY"] = "Готов",
    ["EMZTOOLS_STATE_NOT_READY"] = "Не готов",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (Перезарядка)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Нельзя разместить",
    ["EMZTOOLS_STATE_REFRESH"] = "Обновить",
    ["EMZTOOLS_STATE_SEARCH"] = "Поиск",
    ["EMZTOOLS_STATE_SHOW"] = "Показать",
    ["EMZTOOLS_STATE_HIDDEN"] = "Скрыт",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Неизвестная команда. Введите /emz help для справки",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Введите /emz или /emztools для справки.",
    ["EMZTOOLS_INVALID_KEY"] = "[Неверный ключ локализации]",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "База данных инициализирована.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Проверка структур данных...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Режим отладки включен.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Режим отладки выключен.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Локализация фреймворка загружена.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Локализация не найдена, используется английский.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Локализация загружена для плагина '%s' из '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Используется английский запасной вариант для плагина '%s' из '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "Локализация для плагина '%s' не найдена.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Модуль '%s' успешно загружен.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Модуль '%s' не найден.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Ошибка инициализации модуля '%s': %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Модуль '%s' выгружен.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Ошибка завершения модуля '%s': %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Имя модуля обязательно.",
    ["EMZTOOLS_LOADING_MODULE"] = "Загрузка модуля '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Выгрузка модуля '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Модуль '%s' не поддерживается для класса '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Плагин '%s' зарегистрирован.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Ошибка регистрации плагина: неверные параметры.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Плагин '%s' не поддерживается для класса '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Плагин для %s загружен.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Плагин '%s' не найден.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Ошибка инициализации плагина '%s': %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Плагин '%s' отключен.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "UI плагина для '%s' зарегистрирована.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Видимость плагина переключена",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Отображение плагина переключено",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "ВНИМАНИЕ: Нет функции переключения для %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "ВНИМАНИЕ: Нет плагина для класса %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Неверное значение состояния плагина",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Плагин %s включен",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Плагин %s выключен",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ОШИБКА: Имя плагина отсутствует",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer: требуется функция или имя функции",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer: неверная задержка",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Таймер #%s отменен",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s таймеров очищено",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Модуль Utils недоступен.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Автозагрузка модулей для класса '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Помощь: /emz help - Показать справку",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Конфиг: /emz config - Открыть настройки",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Отладка: /emz debug [вкл/выкл] - Переключить режим отладки",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Показать полную справку",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Открыть настройки",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Модуль помощи не загружен.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Интерфейс настроек недоступен",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar: Модуль базы данных недоступен, используются стандартные настройки.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Перезагрузить UI",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Нажмите для перезагрузки пользовательского интерфейса",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Перезагрузить пользовательский интерфейс?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Разблокирована",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Перетащите для перемещения\nПравый клик для опций",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Игровые часы",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Правый клик для изменения формата времени",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Формат часов",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Авто (на основе локали)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "24-часовой формат",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "12-часовой формат",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "Ширина InfoBar установлена на %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "Высота InfoBar установлена на %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar: Имя текстуры не может быть пустым.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar: Неизвестная текстура '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Доступные текстуры: X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "Текстура InfoBar '%s' не найдена, используется стандартная.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "Нет доступной еды в вашем инвентаре.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "Нет доступной воды в вашем инвентаре.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Уже ест или пьет.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Ест %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Пьет %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "Здоровье и мана уже полные.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Доступные расходники ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Еда: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Вода: %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Команды расходников ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Показать доступные расходники",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Съесть лучшую доступную еду",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Выпить лучшую доступную воду",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Отдохнуть (поесть/попить по необходимости)",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB создана с базовой структурой",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Миграция: пороги перемещены из Potions в Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Модуль базы данных '%s' инициализирован",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "База данных полностью сброшена",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Требуется перезагрузка UI (/reload) для применения изменений",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Модуль '%s' успешно импортирован",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Требуется режим отладки для этой команды",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Зарегистрированные модули ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "Нет зарегистрированных модулей",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Детали модуля: %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Дамп базы данных ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "База данных не инициализирована",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Основные настройки:",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Неверный обратный вызов: требуется событие и функция",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Отсутствуют параметры: требуется событие и идентификатор",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Требуется имя события",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Ошибка обратного вызова в %s: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Событие '%s' зарегистрировано",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Обратный вызов добавлен для события '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Обратный вызов удален для события '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Событие '%s' разрегистрировано",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Все обратные вызовы удалены для события '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Пользовательское событие вызвано: %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Вступил в бой",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Вышел из боя",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Повышение уровня! Теперь уровень %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Игрок умер",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Вход в мир",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Выход из мира",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Общие события зарегистрированы",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Зарегистрированные события ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Событие: %s (%d обратных вызовов)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "Нет зарегистрированных событий",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Всего событий: %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Обратные вызовы для события: %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "Нет обратных вызовов для этого события",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "ID обратного вызова: %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Требуется имя события",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Статистика менеджера событий ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Среднее количество обратных вызовов на событие: %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ Команды EmzTools ] ==-",
    ["EMZTOOLS_VERSION"] = "Версия: %s",
    ["EMZTOOLS_AUTHOR"] = "Автор: %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Основные команды):",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "ИНТЕРФЕЙС:",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "ИГРОВОЙ ПРОЦЕСС (Фарминг & Оптимизация):",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "УТИЛИТЫ & ОТЛАДКА:",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "СОВЕТЫ:",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "ПОРОГИ:",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "РАСХОДНИКИ:",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "ЗЕЛЬЯ:",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "ПРОФАЙЛЕР (Производительность):",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "КАРТЫ (Интерфейс карт):",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Показать эту справку",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Показать версию",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [вкл|выкл] - Включить/выключить режим отладки",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Переключить видимость плагина",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Открыть настройки",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Псевдоним для config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Показать InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Скрыть InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Переключить отображение",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Заблокировать/разблокировать",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Изменить текстуру",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Открыть настройки",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|число> - Установить ширину",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <число> - Установить высоту",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Полноэкранный режим",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Пользовательская ширина 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Пользовательская высота 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Показать текущие пороги",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Показать эффективность фарминга",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Включить/выключить агрессивный режим",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <число> - Установить пользовательский порог здоровья",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <число> - Установить пользовательский порог маны",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Сбросить пользовательские пороги",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [вкл|выкл] - Установить статус группы",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [вкл|выкл] - Установить статус PvP",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Перечислить доступные расходники",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Использовать еду",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Использовать воду",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Отдохнуть автоматически",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Перечислить доступные зелья",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Рекомендовать зелья для вашего уровня",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Использовать зелье лечения",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Использовать зелье маны",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Использовать камень здоровья (Чернокнижник)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Использовать доступное с умом",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Запустить профайлер",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Остановить профайлер",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Показать отчет",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Сбросить статистику",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Показать информацию о картах",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Перезагрузить карты",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Обновить отображение",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Используйте /emz для показа этой справки",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config открывает интерфейс настроек",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Режим отладки (/emz debug) показывает техническую информацию",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Пороги автоматически адаптируются к вашему уровню/классу",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Совет: Введите /emz <модуль> help для конкретной справки",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Конкретная справка для модуля: %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Модуль не найден. Введите /emz help для полного списка",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== Команды EmzTools ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Система помощи не загружена.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Перезапустите аддон или введите /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== ПОДРОБНАЯ СПРАВКА - ПОРОГИ ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Интеллектуальная система порогов для оптимизации фарминга",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Основные команды:",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Настройки:",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Особый режим:",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== ПОДРОБНАЯ СПРАВКА - РАСХОДНИКИ ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Автоматическое управление едой, водой и бинтами",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Использование:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Особенности:",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Автоматически выбирает лучший предмет для вашего уровня",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Не работает в бою",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Автоматически управляет восстановлением",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== ПОДРОБНАЯ СПРАВКА - ЗЕЛЬЯ ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "База данных и управление зельями лечения/маны",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Команды:",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== ПОДРОБНАЯ СПРАВКА - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Настраиваемая информационная панель в верхней части экрана",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Отображение:",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Быстрая настройка:",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Полная настройка:",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Выберите отображаемые элементы (FPS, Задержка, Золото, Опыт, Часы)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Выберите текстуру (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Настройте прозрачность",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== ПОДРОБНАЯ СПРАВКА - ПРОФАЙЛЕР ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Внутренний профайлер для анализа производительности",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Использование:",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Особенности:",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Измеряет время выполнения функций",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Определяет самые медленные функции",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Показывает окно мониторинга в реальном времени",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Полезно для отладки проблем производительности",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Самая медленная",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Среднее",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Вызовы",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Функции",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Проблемы",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Нет проблем",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Обертывание функций...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Профайлер запущен",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Профайлер остановлен",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Статистика сброшена",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== ОТЧЕТ ПРОФАЙЛЕРА ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Функции: %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Всего вызовов: %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Общее время: %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Самая медленная: %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== ПРОБЛЕМЫ ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Команды профайлера ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Запустить профайлер",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Остановить профайлер",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Показать отчет",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Сбросить статистику",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Авто (Клиент)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Английский",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Французский",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Немецкий",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Испанский",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Итальянский",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Португальский",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Русский",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Язык установлен на",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Левый клик: Открыть настройки",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Правый клик: Изменить язык",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "Нет доступных зелий лечения.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Использовано %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "Нет доступных зелий маны.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Использовано %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "Нет доступных камней здоровья.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Использовано %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "Здоровье уже полное.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "Нет доступных предметов лечения.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Доступные зелья:",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Здоровье: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Здоровье: Нет",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Мана: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Мана: Нет",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Камень здоровья: %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Камень здоровья: Нет",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Рекомендуемые зелья для уровня %s:",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Здоровье: %s (восстанавливает %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Мана: %s (восстанавливает %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Команды зелий:",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Показать доступные зелья",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Показать рекомендуемые зелья для вашего уровня",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Использовать лучшее зелье лечения",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Использовать лучшее зелье маны",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Использовать лучший камень здоровья",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Умный выбор лечения",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Неизвестная команда зелий. Введите /emz potions help для справки.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ Версия EmzTools ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Система помощи недоступна",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Модуль Порогов недоступен",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Модуль Расходников недоступен",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Модуль Зелий недоступен",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "Модуль InfoBar недоступен",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Модуль Внутреннего профайлера недоступен",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Модуль Миникарты недоступен",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Модуль Базы данных недоступен",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Модуль Менеджера событий недоступен",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Использование: /emz thresholds sethp <число>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Использование: /emz thresholds setmana <число>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Использование: /emz infobar width <full|число>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Использование: /emz infobar height <число>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Неизвестная команда: thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Неизвестная команда: consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Неизвестная команда: potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Неизвестная команда: infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Неизвестная команда: profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Неизвестная команда: minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Неизвестная команда: database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Неизвестная команда: events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Настройки недоступны",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Кнопка миникарты показана",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Кнопка миникарты скрыта",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Кнопка миникарты не создана",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Модуль Utils не загружен.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Пользовательский порог здоровья установлен на %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Пользовательский порог здоровья сброшен.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Пользовательский порог маны установлен на %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Пользовательский порог маны сброшен.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Агрессивный режим включен.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Агрессивный режим выключен.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Корректировки группового режима включены.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Корректировки одиночного режима включены.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "Корректировки режима PvP включены.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "Корректировки режима PvE включены.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "Низкое здоровье и мана - есть и пить",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "Низкое здоровье - есть",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Низкая мана - пить",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Ресурсы достаточны",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Рекомендуется отдохнуть сейчас",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Отдохнуть сейчас",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Отдохнуть скоро (%d существ осталось)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Хорошо продолжать (%d существ осталось)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Пороги для уровня %d %s:",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "Здоровье: %d%% | Мана: %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "Здоровье: %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Порог лечения питомца: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Существ до отдыха: %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Агрессивный режим: %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Групповые корректировки включены",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "PvP корректировки включены",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Эффективность фарминга ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "Здоровье: %d%% (Порог: %d%%) | Мана: %d%% (Порог: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "Здоровье: %d%% (Порог: %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "Буфер здоровья: %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Оценочный урон/существо: %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Оставшихся существ до отдыха: %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Рекомендация: %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Использование: /emz thresholds sethp <число>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Использование: /emz thresholds setmana <число>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Пользовательские пороги сброшены",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Использование: /emz thresholds group [вкл|выкл]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Использование: /emz thresholds pvp [вкл|выкл]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Доступные команды:",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Показать пороги",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Показать эффективность фарминга",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Переключить агрессивный режим",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <число> - Установить порог здоровья",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <число> - Установить порог маны",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Сбросить пороги",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [вкл|выкл] - Статус группы",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [вкл|выкл] - Статус PvP",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "Настройки EmzTools",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig инициализирован",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Тема применена",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Ошибка загрузки",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Выбор темы",
    ["EMZTOOLS_UICONFIG_ERROR"] = "Ошибка UIConfig",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils: Установлена двунаправленная совместимость",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Воин",
    ["CLASS_MAGE"] = "Маг",
    ["CLASS_ROGUE"] = "Разбойник",
    ["CLASS_DRUID"] = "Друид",
    ["CLASS_HUNTER"] = "Охотник",
    ["CLASS_SHAMAN"] = "Шаман",
    ["CLASS_PRIEST"] = "Жрец",
    ["CLASS_WARLOCK"] = "Чернокнижник",
    ["CLASS_PALADIN"] = "Паладин",
    ["CLASS_UNKNOWN"] = "Неизвестно",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Сообщения отладки
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Вкладка Core загружена",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Вкладка Core зарегистрирована",

    -- Конфигурация
    ["EMZTOOLS_DEBUG_MODE"] = "Режим отладки",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Автозагрузка плагинов",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Автозагрузка плагинов включена",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Автозагрузка плагинов выключена",

    -- Тема
    ["EMZTOOLS_THEME_INTERFACE"] = "Тема интерфейса",
    ["EMZTOOLS_CURRENT_THEME"] = "Текущая тема:",
    ["EMZTOOLS_THEME_CHANGED"] = "Тема изменена на: %s",

    -- База данных
    ["EMZTOOLS_DATABASE_TITLE"] = "База данных",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Сбросить БД",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Вы уверены, что хотите сбросить базу данных?\n\nВсе ваши настройки будут удалены.",
    ["EMZTOOLS_DATABASE_RESET"] = "База данных сброшена. Перезагрузка...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Восстановить все значения по умолчанию?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Значения по умолчанию восстановлены",
    ["EMZTOOLS_CONFIG_RESET"] = "Настройки сброшены",

    -- Информация
    ["EMZTOOLS_INFO_TITLE"] = "Информация",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Плагины загружены",

    -- Описание вкладки
    ["EMZTOOLS_CORE_TAB_DESC"] = "Основная конфигурация фреймворка EmzTools",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "Настройки EmzTools",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Опции",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Макет",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Полный экран",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Макет Полный экран",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Пользовательский",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Макет Пользовательский",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Пользовательская ширина",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Высота",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Высота 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Высота 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Прозрачность",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Отображаемые элементы",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Задержка",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Золото",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "Опыт",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Формат часов",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Формат часов Авто",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Формат часов 24 часа",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Формат часов 12 часов",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Тест",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar протестирована - отображение переключено",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "Модуль InfoBar недоступен",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "Сбросить настройки InfoBar к значениям по умолчанию?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "Настройки InfoBar сброшены к значениям по умолчанию",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Настройка информационной панели",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "Вкладка InfoBar зарегистрирована",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "Вкладка InfoBar загружена",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Управление зельями",
    ["EMZTOOLS_POTIONS_DESC"] = "Автоматическая настройка зелий и расходников",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Зелья лечения",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Авто-лечение",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Автоматически использует зелья лечения, когда ваше здоровье низкое.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Приоритет лечения:",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Умный",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Камень сначала",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Зелье сначала",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Использовать камни здоровья",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Использует камни здоровья, созданные чернокнижниками.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Зелья маны",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Авто-мана",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Автоматически использует зелья маны, когда ваша мана низкая.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Оповещения и объявления",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Звуковое оповещение",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Воспроизводит звук, когда зелье автоматически используется.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Объявлять в чат",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Объявляет использование зелий в канале группы/рейда.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Наступательные зелья",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Наступательный приоритет:",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Рассеивание/Магия",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Урон",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Скорость",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Сбросить настройки Зелий к значениям по умолчанию?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Настройки Зелий сброшены к значениям по умолчанию",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Сбрасывает все опции к их значениям по умолчанию.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Вкладка Зелья загружена",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Вкладка Зелья зарегистрирована",
    ["EMZTOOLS_STATE_MODULES"] = "Модули",
}
