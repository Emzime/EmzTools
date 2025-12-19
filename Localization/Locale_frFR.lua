-- ===================================================
-- EmzTools - Localisation française
-- ===================================================

Locale_frFR = {
    -- ===================================================
    -- CORE STATES
    -- ===================================================
    ["EMZTOOLS_STATE_LOADED"] = "Chargé",
    ["EMZTOOLS_STATE_NOT_LOADED"] = "Non chargé",
    ["EMZTOOLS_STATE_CONNECTED"] = "Connecté",
    ["EMZTOOLS_STATE_DISCONNECTED"] = "Déconnecté",
    ["EMZTOOLS_STATE_ENABLED"] = "Activé",
    ["EMZTOOLS_STATE_DISABLED"] = "Désactivé",
    ["EMZTOOLS_STATE_APPLY"] = "Appliquer",
    ["EMZTOOLS_STATE_RESET"] = "Réinitialiser",
    ["EMZTOOLS_STATE_YES"] = "Oui",
    ["EMZTOOLS_STATE_NO"] = "Non",
    ["EMZTOOLS_STATE_STATUS"] = "Statut",
    ["EMZTOOLS_STATE_SETTINGS"] = "Paramètres",
    ["EMZTOOLS_STATE_NO_SETTINGS"] = "Aucun paramètre",
    ["EMZTOOLS_STATE_TOTAL"] = "Total",
    ["EMZTOOLS_STATE_LOCKED"] = "Verrouillé",
    ["EMZTOOLS_STATE_UNLOCKED"] = "Déverrouillé",
    ["EMZTOOLS_STATE_NONE"] = "Aucun",
    ["EMZTOOLS_STATE_NOT_APPLICABLE"] = "N/A",
    ["EMZTOOLS_STATE_ACTIVE"] = "Actif",
    ["EMZTOOLS_STATE_INACTIVE"] = "Inactif",
    ["EMZTOOLS_STATE_PAUSED"] = "En pause",
    ["EMZTOOLS_STATE_UNKNOWN"] = "Inconnu",
    ["EMZTOOLS_STATE_NOT_LEARNED"] = "Non appris",
    ["EMZTOOLS_STATE_READY"] = "Prêt",
    ["EMZTOOLS_STATE_NOT_READY"] = "Non prêt",
    ["EMZTOOLS_STATE_ON_COOLDOWN"] = " (En recharge)",
    ["EMZTOOLS_STATE_CANNOT_PLACE"] = "Impossible de placer",
    ["EMZTOOLS_STATE_REFRESH"] = "Actualiser",
    ["EMZTOOLS_STATE_SEARCH"] = "Rechercher",
    ["EMZTOOLS_STATE_SHOW"] = "Afficher",
    ["EMZTOOLS_STATE_HIDDEN"] = "Masqué",
    ["EMZTOOLS_STATE_UNKNOWN_COMMAND"] = "Commande inconnue. Tapez /emz help pour l'aide",

    -- ===================================================
    -- CORE GENERAL MESSAGES
    -- ===================================================
    ["EMZTOOLS_TYPE_HELP"] = "Tapez /emz ou /emztools pour l'aide.",
    ["EMZTOOLS_INVALID_KEY"] = "[Clé de localisation invalide]",
    ["EMZTOOLS_VERSION"] = "Version : %s",

    -- ===================================================
    -- CORE DATABASE
    -- ===================================================
    ["EMZTOOLS_DATABASE_INITIALIZED"] = "Base de données initialisée.",
    ["EMZTOOLS_DEBUG_STRUCTURE_CHECK"] = "Vérification des structures de données...",

    -- ===================================================
    -- CORE DEBUG
    -- ===================================================
    ["EMZTOOLS_DEBUG_ENABLED"] = "Mode debug activé.",
    ["EMZTOOLS_DEBUG_DISABLED"] = "Mode debug désactivé.",

    -- ===================================================
    -- CORE LOCALIZATION
    -- ===================================================
    ["EMZTOOLS_FRAMEWORK_LOCALE_LOADED"] = "Localisation du framework chargée.",
    ["EMZTOOLS_FRAMEWORK_LOCALE_NOT_FOUND"] = "Localisation non trouvée, utilisation de l'anglais.",
    ["EMZTOOLS_PLUGIN_LOCALE_LOADED"] = "Localisation chargée pour le plugin '%s' depuis '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_FALLBACK"] = "Utilisation du repli anglais pour le plugin '%s' depuis '%s'.",
    ["EMZTOOLS_PLUGIN_LOCALE_NOT_FOUND"] = "Aucune localisation trouvée pour le plugin '%s'.",

    -- ===================================================
    -- CORE MODULE SYSTEM
    -- ===================================================
    ["EMZTOOLS_MODULE_LOADED"] = "Module '%s' chargé avec succès.",
    ["EMZTOOLS_MODULE_NOT_FOUND"] = "Module '%s' non trouvé.",
    ["EMZTOOLS_MODULE_INIT_ERROR"] = "Erreur d'initialisation du module '%s' : %s",
    ["EMZTOOLS_MODULE_UNLOADED"] = "Module '%s' déchargé.",
    ["EMZTOOLS_MODULE_SHUTDOWN_ERROR"] = "Erreur lors de l'arrêt du module '%s' : %s",
    ["EMZTOOLS_MODULE_NAME_REQUIRED"] = "Le nom du module est requis.",
    ["EMZTOOLS_LOADING_MODULE"] = "Chargement du module '%s'...",
    ["EMZTOOLS_UNLOADING_MODULE"] = "Déchargement du module '%s'...",
    ["EMZTOOLS_MODULE_CLASS_NOT_SUPPORTED"] = "Module '%s' non pris en charge pour la classe '%s'.",

    -- ===================================================
    -- CORE PLUGIN SYSTEM
    -- ===================================================
    ["EMZTOOLS_PLUGIN_REGISTERED"] = "Plugin '%s' enregistré.",
    ["EMZTOOLS_PLUGIN_REGISTRATION_FAILED"] = "Échec de l'enregistrement du plugin : paramètres invalides.",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_SUPPORTED"] = "Plugin '%s' non pris en charge pour la classe '%s'.",
    ["EMZTOOLS_PLUGIN_LOADED"] = "Plugin pour %s chargé.",
    ["EMZTOOLS_PLUGIN_NOT_FOUND"] = "Plugin '%s' non trouvé.",
    ["EMZTOOLS_PLUGIN_INIT_ERROR"] = "Erreur d'initialisation du plugin '%s' : %s",
    ["EMZTOOLS_PLUGIN_DISABLED"] = "Plugin '%s' est désactivé.",
    ["EMZTOOLS_PLUGIN_UI_REGISTERED"] = "Interface utilisateur du plugin '%s' enregistrée.",
    ["EMZTOOLS_PLUGIN_TOGGLE_SUCCESS"] = "Visibilité du plugin basculée",
    ["EMZTOOLS_PLUGIN_TOGGLE_DISPLAY"] = "Affichage du plugin basculé",
    ["EMZTOOLS_PLUGIN_NO_TOGGLE_FUNCTION"] = "AVERTISSEMENT : Pas de fonction de basculement pour %s",
    ["EMZTOOLS_PLUGIN_CLASS_NOT_FOUND"] = "AVERTISSEMENT : Pas de plugin pour la classe %s",
    ["EMZTOOLS_PLUGIN_INVALID_VALUE"] = "Valeur invalide pour l'état du plugin",
    ["EMZTOOLS_PLUGIN_ENABLED"] = "Plugin %s activé",
    ["EMZTOOLS_PLUGIN_DISABLED_MSG"] = "Plugin %s désactivé",
    ["EMZTOOLS_PLUGIN_NAME_MISSING"] = "ERREUR : Nom du plugin manquant",

    -- ===================================================
    -- CORE TIMER SYSTEM
    -- ===================================================
    ["EMZTOOLS_TIMER_FUNCTION_REQUIRED"] = "ScheduleTimer : fonction ou nom de fonction requis",
    ["EMZTOOLS_TIMER_INVALID_DELAY"] = "ScheduleTimer : délai invalide",
    ["EMZTOOLS_TIMER_CANCELLED"] = "Minuteur #%s annulé",
    ["EMZTOOLS_TIMERS_PURGED"] = "%s minuteurs purgés",

    -- ===================================================
    -- CORE UTILS
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_AVAILABLE"] = "Module Utils non disponible.",

    -- ===================================================
    -- CORE AUTO-LOAD
    -- ===================================================
    ["EMZTOOLS_AUTO_LOADING_CLASS_MODULES"] = "Chargement automatique des modules pour la classe '%s'...",

    -- ===================================================
    -- CORE COMMANDS
    -- ===================================================
    ["EMZTOOLS_COMMAND_HELP"] = "Aide : /emz help - Afficher l'aide",
    ["EMZTOOLS_COMMAND_CONFIG"] = "Config : /emz config - Ouvrir la configuration",
    ["EMZTOOLS_COMMAND_DEBUG"] = "Debug : /emz debug [on/off] - Basculer le mode debug",
    ["EMZTOOLS_HELP_COMMAND"] = "/emz help - Afficher l'aide complète",
    ["EMZTOOLS_CONFIG_COMMAND"] = "/emz config - Ouvrir la configuration",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Le module Aide n'est pas chargé.",
    ["EMZTOOLS_CONFIG_UNAVAILABLE"] = "Interface de configuration non disponible",

    -- ===================================================
    -- INFOBAR MODULE
    -- ===================================================
    ["EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE"] = "InfoBar : Module de base de données non disponible, utilisation des paramètres par défaut.",
    ["EMZTOOLS_INFOBAR_RELOAD_TITLE"] = "Recharger l'interface",
    ["EMZTOOLS_INFOBAR_RELOAD_DESC"] = "Cliquez pour recharger l'interface utilisateur",
    ["EMZTOOLS_INFOBAR_RELOAD_CONFIRM"] = "Recharger l'interface utilisateur ?",
    ["EMZTOOLS_INFOBAR_UNLOCKED_TITLE"] = "InfoBar Déverrouillée",
    ["EMZTOOLS_INFOBAR_UNLOCKED_DESC"] = "Glissez pour déplacer\nClic droit pour les options",
    ["EMZTOOLS_INFOBAR_CLOCK_TITLE"] = "Horloge du jeu",
    ["EMZTOOLS_INFOBAR_CLOCK_DESC"] = "Clic droit pour changer le format d'heure",
    ["EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE"] = "Format de l'horloge",
    ["EMZTOOLS_INFOBAR_CLOCK_AUTO"] = "Auto (basé sur la locale)",
    ["EMZTOOLS_INFOBAR_CLOCK_24H"] = "Format 24 heures",
    ["EMZTOOLS_INFOBAR_CLOCK_12H"] = "Format 12 heures",
    ["EMZTOOLS_INFOBAR_LOCK_STATUS"] = "InfoBar %s.",
    ["EMZTOOLS_INFOBAR_WIDTH_SET"] = "Largeur de l'InfoBar définie à %s.",
    ["EMZTOOLS_INFOBAR_HEIGHT_SET"] = "Hauteur de l'InfoBar définie à %s.",
    ["EMZTOOLS_INFOBAR_TEXTURE_NIL"] = "InfoBar : Le nom de la texture ne peut pas être nul.",
    ["EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN"] = "InfoBar : Texture inconnue '%s'.",
    ["EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE"] = "Textures disponibles : X-Perl, Holy, Tribal",
    ["EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND"] = "Texture d'InfoBar '%s' non trouvée, utilisation par défaut.",

    -- ===================================================
    -- CONSUMABLES MODULE
    -- ===================================================
    ["EMZTOOLS_CONSUMABLES_NO_FOOD"] = "Aucune nourriture disponible dans votre inventaire.",
    ["EMZTOOLS_CONSUMABLES_NO_WATER"] = "Aucune eau disponible dans votre inventaire.",
    ["EMZTOOLS_CONSUMABLES_ALREADY_SITTING"] = "Déjà en train de manger ou de boire.",
    ["EMZTOOLS_CONSUMABLES_EATING"] = "Manger %s",
    ["EMZTOOLS_CONSUMABLES_DRINKING"] = "Boire %s",
    ["EMZTOOLS_CONSUMABLES_FULL"] = "La santé et la mana sont déjà pleines.",
    ["EMZTOOLS_CONSUMABLES_HEADER"] = "=== Consommables disponibles ===",
    ["EMZTOOLS_CONSUMABLES_FOOD_INFO"] = "Nourriture : %s (%d)",
    ["EMZTOOLS_CONSUMABLES_WATER_INFO"] = "Eau : %s (%d)",
    ["EMZTOOLS_CONSUMABLES_COMMANDS_TITLE"] = "=== Commandes Consommables ===",
    ["EMZTOOLS_CONSUMABLES_COMMAND_LIST"] = "/emz consumables list - Afficher les consommables disponibles",
    ["EMZTOOLS_CONSUMABLES_COMMAND_EAT"] = "/emz consumables eat - Manger la meilleure nourriture disponible",
    ["EMZTOOLS_CONSUMABLES_COMMAND_DRINK"] = "/emz consumables drink - Boire la meilleure eau disponible",
    ["EMZTOOLS_CONSUMABLES_COMMAND_REST"] = "/emz consumables rest - Se reposer (manger/boire si nécessaire)",

    -- ===================================================
    -- DATABASE MODULE
    -- ===================================================
    ["EMZTOOLS_DATABASE_CREATED"] = "EmzToolsDB créée avec la structure de base",
    ["EMZTOOLS_MIGRATION_POTIONS_THRESHOLDS"] = "Migration : les seuils déplacés de Potions vers Thresholds",
    ["EMZTOOLS_DATABASE_MODULE_INITIALIZED"] = "Module de base de données '%s' initialisé",
    ["EMZTOOLS_DATABASE_RESET_COMPLETE"] = "Base de données complètement réinitialisée",
    ["EMZTOOLS_RELOAD_REQUIRED"] = "Rechargement de l'interface (/reload) requis pour que les changements prennent effet",
    ["EMZTOOLS_MODULE_IMPORT_SUCCESS"] = "Module '%s' importé avec succès",
    ["EMZTOOLS_DEBUG_MODE_REQUIRED"] = "Mode debug requis pour cette commande",
    ["EMZTOOLS_DATABASE_LIST_MODULES"] = "=== Modules enregistrés ===",
    ["EMZTOOLS_DATABASE_NO_MODULES"] = "Aucun module enregistré",
    ["EMZTOOLS_DATABASE_MODULE_DETAILS"] = "=== Détails du module : %s ===",
    ["EMZTOOLS_DATABASE_DUMP_ALL"] = "=== Dump de la base de données ===",
    ["EMZTOOLS_DATABASE_NOT_INITIALIZED"] = "Base de données non initialisée",
    ["EMZTOOLS_DATABASE_CORE_SETTINGS"] = "Paramètres de base :",

    -- ===================================================
    -- EVENT MANAGER MODULE
    -- ===================================================
    ["EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK"] = "Rappel invalide : événement et fonction requis",
    ["EMZTOOLS_EVENTMANAGER_MISSING_PARAMS"] = "Paramètres manquants : événement et identifiant requis",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED"] = "Nom de l'événement requis",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR"] = "Erreur de rappel dans %s : %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED"] = "Événement '%s' enregistré",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED"] = "Rappel ajouté pour l'événement '%s'",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED"] = "Rappel supprimé pour l'événement '%s'",
    ["EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED"] = "Événement '%s' désenregistré",
    ["EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED"] = "Tous les rappels supprimés pour l'événement '%s'",
    ["EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED"] = "Événement personnalisé déclenché : %s",
    ["EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT"] = "Entrée en combat",
    ["EMZTOOLS_EVENTMANAGER_LEFT_COMBAT"] = "Sortie de combat",
    ["EMZTOOLS_EVENTMANAGER_LEVEL_UP"] = "Niveau supérieur ! Maintenant niveau %s",
    ["EMZTOOLS_EVENTMANAGER_PLAYER_DIED"] = "Le joueur est mort",
    ["EMZTOOLS_EVENTMANAGER_ENTERING_WORLD"] = "Entrée dans le monde",
    ["EMZTOOLS_EVENTMANAGER_LEAVING_WORLD"] = "Sortie du monde",
    ["EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED"] = "Événements communs enregistrés",
    ["EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER"] = "=== Événements enregistrés ===",
    ["EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS"] = "Événement : %s (%d rappels)",
    ["EMZTOOLS_EVENTMANAGER_NO_EVENTS"] = "Aucun événement enregistré",
    ["EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS"] = "Total d'événements : %d",
    ["EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT"] = "=== Rappels pour l'événement : %s ===",
    ["EMZTOOLS_EVENTMANAGER_NO_CALLBACKS"] = "Aucun rappel pour cet événement",
    ["EMZTOOLS_EVENTMANAGER_CALLBACK_ID"] = "ID du rappel : %s",
    ["EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED"] = "Nom de l'événement requis",
    ["EMZTOOLS_EVENTMANAGER_STATS_HEADER"] = "=== Statistiques du gestionnaire d'événements ===",
    ["EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS"] = "Moyenne de rappels par événement : %s",

    -- ===================================================
    -- HELP MODULE
    -- ===================================================
    ["EMZTOOLS_HELP_HEADER"] = "-== [ Commandes EmzTools ] ==-",
    ["EMZTOOLS_AUTHOR"] = "Auteur : %s",
    ["EMZTOOLS_HELP_CORE_SECTION"] = "CORE (Commandes principales) :",
    ["EMZTOOLS_HELP_INTERFACE_SECTION"] = "INTERFACE :",
    ["EMZTOOLS_HELP_GAMEPLAY_SECTION"] = "JEU (Farming & Optimisation) :",
    ["EMZTOOLS_HELP_UTILITY_SECTION"] = "UTILITAIRES & DEBUG :",
    ["EMZTOOLS_HELP_TIPS_SECTION"] = "CONSEILS :",
    ["EMZTOOLS_HELP_SECTION_SEPARATOR"] = "--------------------------------",
    ["EMZTOOLS_HELP_THRESHOLDS_SUBSECTION"] = "SEUILS :",
    ["EMZTOOLS_HELP_CONSUMABLES_SUBSECTION"] = "CONSOMMABLES :",
    ["EMZTOOLS_HELP_POTIONS_SUBSECTION"] = "POTIONS :",
    ["EMZTOOLS_HELP_PROFILER_SUBSECTION"] = "PROFILER (Performance) :",
    ["EMZTOOLS_HELP_CARDS_SUBSECTION"] = "CARTES (Interface de cartes) :",

    -- Core Commands
    ["EMZTOOLS_HELP_COMMAND_HELP"] = "/emz help - Afficher cette aide",
    ["EMZTOOLS_HELP_COMMAND_VERSION"] = "/emz version - Afficher la version",
    ["EMZTOOLS_HELP_COMMAND_DEBUG"] = "/emz debug [on|off] - Activer/désactiver le mode debug",
    ["EMZTOOLS_HELP_COMMAND_TOGGLE"] = "/emz toggle - Basculer la visibilité du plugin",
    ["EMZTOOLS_HELP_COMMAND_CONFIG"] = "/emz config - Ouvrir la configuration",
    ["EMZTOOLS_HELP_COMMAND_SETTINGS"] = "/emz settings - Alias pour config",

    -- Interface Commands
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_SHOW"] = "/emz infobar show - Afficher l'InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HIDE"] = "/emz infobar hide - Masquer l'InfoBar",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TOGGLE"] = "/emz infobar toggle - Basculer l'affichage",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_LOCK"] = "/emz infobar lock - Verrouiller/déverrouiller",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_TEXTURE"] = "/emz infobar texture - Changer la texture",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_CONFIG"] = "/emz infobar config - Ouvrir la configuration",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH"] = "/emz infobar width <full|number> - Définir la largeur",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT"] = "/emz infobar height <number> - Définir la hauteur",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_FULL"] = "/emz infobar width full - Mode plein écran",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_WIDTH_CUSTOM"] = "/emz infobar width 500 - Largeur personnalisée 500px",
    ["EMZTOOLS_HELP_COMMAND_INFOBAR_HEIGHT_CUSTOM"] = "/emz infobar height 30 - Hauteur personnalisée 30px",

    -- Thresholds Commands
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SHOW"] = "/emz thresholds show - Afficher les seuils actuels",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_EFFICIENCY"] = "/emz thresholds efficiency - Afficher l'efficacité du farming",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_AGGRESSIVE"] = "/emz thresholds aggressive - Activer/désactiver le mode agressif",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_HP"] = "/emz thresholds sethp <number> - Définir le seuil de PV personnalisé",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_SET_MANA"] = "/emz thresholds setmana <number> - Définir le seuil de mana personnalisé",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_RESET"] = "/emz thresholds reset - Réinitialiser les seuils personnalisés",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_GROUP"] = "/emz thresholds group [on|off] - Définir le statut de groupe",
    ["EMZTOOLS_HELP_COMMAND_THRESHOLDS_PVP"] = "/emz thresholds pvp [on|off] - Définir le statut JcJ",

    -- Consumables Commands
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_LIST"] = "/emz consumables list - Lister les consommables disponibles",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_EAT"] = "/emz consumables eat - Utiliser de la nourriture",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_DRINK"] = "/emz consumables drink - Utiliser de l'eau",
    ["EMZTOOLS_HELP_COMMAND_CONSUMABLES_REST"] = "/emz consumables rest - Se reposer automatiquement",

    -- Potions Commands
    ["EMZTOOLS_HELP_COMMAND_POTIONS_LIST"] = "/emz potions list - Lister les potions disponibles",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_RECOMMEND"] = "/emz potions recommend - Recommander des potions pour votre niveau",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_HP"] = "/emz potions hp - Utiliser une potion de soins",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_MANA"] = "/emz potions mana - Utiliser une potion de mana",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_STONE"] = "/emz potions stone - Utiliser une pierre de soins (Démoniste)",
    ["EMZTOOLS_HELP_COMMAND_POTIONS_SMART"] = "/emz potions smart - Utiliser intelligemment ce qui est disponible",

    -- Profiler Commands
    ["EMZTOOLS_HELP_COMMAND_PROFILE_START"] = "/emz profile start - Démarrer le profileur",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_STOP"] = "/emz profile stop - Arrêter le profileur",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_REPORT"] = "/emz profile report - Afficher le rapport",
    ["EMZTOOLS_HELP_COMMAND_PROFILE_RESET"] = "/emz profile reset - Réinitialiser les statistiques",

    -- Cards Commands
    ["EMZTOOLS_HELP_COMMAND_CARD_INFO"] = "/emz cardinfo - Afficher les informations de carte",
    ["EMZTOOLS_HELP_COMMAND_RELOAD_CARDS"] = "/emz reloadcards - Recharger les cartes",
    ["EMZTOOLS_HELP_COMMAND_REFRESH_CARDS"] = "/emz refreshcards - Actualiser l'affichage",

    -- Tips
    ["EMZTOOLS_HELP_TIP_HELP_COMMAND"] = "• Utilisez /emz pour afficher cette aide",
    ["EMZTOOLS_HELP_TIP_CONFIG_COMMAND"] = "• /emz config ouvre l'interface de configuration",
    ["EMZTOOLS_HELP_TIP_DEBUG_COMMAND"] = "• Le mode debug (/emz debug) affiche des informations techniques",
    ["EMZTOOLS_HELP_TIP_THRESHOLDS"] = "• Les seuils s'adaptent automatiquement à votre niveau/classe",
    ["EMZTOOLS_HELP_TIP_MODULE_HELP"] = "Astuce : Tapez /emz <module> help pour l'aide spécifique",

    -- Module Specific Help
    ["EMZTOOLS_HELP_MODULE_SPECIFIC"] = "Aide spécifique pour le module : %s",
    ["EMZTOOLS_HELP_MODULE_NOT_FOUND"] = "Module non trouvé. Tapez /emz help pour la liste complète",
    ["EMZTOOLS_HELP_FALLBACK_TITLE"] = "=== Commandes EmzTools ===",
    ["EMZTOOLS_HELP_MODULE_NOT_LOADED"] = "Système d'aide non chargé.",
    ["EMZTOOLS_HELP_RELOAD_REQUIRED"] = "Redémarrez l'addon ou tapez /reload",

    -- Thresholds Help
    ["EMZTOOLS_HELP_THRESHOLDS_TITLE"] = "=== AIDE DÉTAILLÉE - SEUILS ===",
    ["EMZTOOLS_HELP_THRESHOLDS_DESCRIPTION"] = "Système de seuils intelligent pour l'optimisation du farming",
    ["EMZTOOLS_HELP_THRESHOLDS_MAIN_COMMANDS"] = "Commandes principales :",
    ["EMZTOOLS_HELP_THRESHOLDS_CONFIG"] = "Configuration :",
    ["EMZTOOLS_HELP_THRESHOLDS_SPECIAL_MODE"] = "Mode spécial :",

    -- Consumables Help
    ["EMZTOOLS_HELP_CONSUMABLES_TITLE"] = "=== AIDE DÉTAILLÉE - CONSOMMABLES ===",
    ["EMZTOOLS_HELP_CONSUMABLES_DESCRIPTION"] = "Gestion automatique de la nourriture, de l'eau et des bandages",
    ["EMZTOOLS_HELP_CONSUMABLES_USAGE"] = "Utilisation :",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURES"] = "Fonctionnalités :",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_1"] = "• Choisit automatiquement le meilleur item pour votre niveau",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_2"] = "• Ne fonctionne pas en combat",
    ["EMZTOOLS_HELP_CONSUMABLES_FEATURE_3"] = "• Gère automatiquement les temps de recharge",

    -- Potions Help
    ["EMZTOOLS_HELP_POTIONS_TITLE"] = "=== AIDE DÉTAILLÉE - POTIONS ===",
    ["EMZTOOLS_HELP_POTIONS_DESCRIPTION"] = "Base de données et gestion des potions de soins/mana",
    ["EMZTOOLS_HELP_POTIONS_COMMANDS"] = "Commandes :",

    -- InfoBar Help
    ["EMZTOOLS_HELP_INFOBAR_TITLE"] = "=== AIDE DÉTAILLÉE - INFOBAR ===",
    ["EMZTOOLS_HELP_INFOBAR_DESCRIPTION"] = "Barre d'information personnalisable en haut de l'écran",
    ["EMZTOOLS_HELP_INFOBAR_DISPLAY"] = "Affichage :",
    ["EMZTOOLS_HELP_INFOBAR_QUICK_CONFIG"] = "Configuration rapide :",
    ["EMZTOOLS_HELP_INFOBAR_FULL_CONFIG"] = "Configuration complète :",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_1"] = "• Choisissez les éléments affichés (FPS, Latence, Or, XP, Horloge)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_2"] = "• Sélectionnez la texture (X-Perl, Holy, Tribal)",
    ["EMZTOOLS_HELP_INFOBAR_FEATURE_3"] = "• Ajustez la transparence",

    -- Profiler Help
    ["EMZTOOLS_HELP_PROFILER_TITLE"] = "=== AIDE DÉTAILLÉE - PROFILER ===",
    ["EMZTOOLS_HELP_PROFILER_DESCRIPTION"] = "Profileur interne pour analyser les performances",
    ["EMZTOOLS_HELP_PROFILER_USAGE"] = "Utilisation :",
    ["EMZTOOLS_HELP_PROFILER_FEATURES"] = "Fonctionnalités :",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_1"] = "• Mesure le temps d'exécution des fonctions",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_2"] = "• Identifie les fonctions les plus lentes",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_3"] = "• Affiche une fenêtre de monitoring en temps réel",
    ["EMZTOOLS_HELP_PROFILER_FEATURE_4"] = "• Utile pour déboguer les problèmes de performance",

    -- ===================================================
    -- PROFILER MODULE
    -- ===================================================
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION"] = "Plus lent",
    ["EMZTOOLS_PROFILER_AVERAGE_TIME"] = "Moyenne",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS"] = "Appels",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT"] = "Fonctions",
    ["EMZTOOLS_PROFILER_OK"] = "OK",
    ["EMZTOOLS_PROFILER_PROBLEMS"] = "Problèmes",
    ["EMZTOOLS_PROFILER_NO_PROBLEMS"] = "Aucun problème",

    ["EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS"] = "Encapsulation des fonctions...",
    ["EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION"] = "  UI.%s",
    ["EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION"] = "  %s",
    ["EMZTOOLS_PROFILER_STARTED"] = "Profileur démarré",
    ["EMZTOOLS_PROFILER_STOPPED"] = "Profileur arrêté",
    ["EMZTOOLS_PROFILER_STATS_RESET"] = "Statistiques réinitialisées",

    ["EMZTOOLS_PROFILER_REPORT_TITLE"] = "=== RAPPORT DU PROFILER ===",
    ["EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT"] = "Fonctions : %s",
    ["EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT"] = "Total d'appels : %s",
    ["EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT"] = "Temps total : %s",
    ["EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS"] = "Plus lent : %s (%s x %s)",
    ["EMZTOOLS_PROFILER_PROBLEMS_TITLE"] = "=== PROBLÈMES ===",
    ["EMZTOOLS_PROFILER_PROBLEM_FORMAT"] = "• %s",

    ["EMZTOOLS_PROFILER_COMMANDS_TITLE"] = "=== Commandes du Profileur ===",
    ["EMZTOOLS_PROFILER_COMMAND_START"] = "/emz profile start - Démarrer le profileur",
    ["EMZTOOLS_PROFILER_COMMAND_STOP"] = "/emz profile stop - Arrêter le profileur",
    ["EMZTOOLS_PROFILER_COMMAND_REPORT"] = "/emz profile report - Afficher le rapport",
    ["EMZTOOLS_PROFILER_COMMAND_RESET"] = "/emz profile reset - Réinitialiser les statistiques",

    -- ===================================================
    -- MINIMAP MODULE
    -- ===================================================
    ["EMZTOOLS_MINIMAP_LANG_AUTO"] = "Auto (Client)",
    ["EMZTOOLS_MINIMAP_LANG_EN"] = "Anglais",
    ["EMZTOOLS_MINIMAP_LANG_FR"] = "Français",
    ["EMZTOOLS_MINIMAP_LANG_DE"] = "Allemand",
    ["EMZTOOLS_MINIMAP_LANG_ES"] = "Espagnol",
    ["EMZTOOLS_MINIMAP_LANG_IT"] = "Italien",
    ["EMZTOOLS_MINIMAP_LANG_PT"] = "Portugais",
    ["EMZTOOLS_MINIMAP_LANG_RU"] = "Russe",
    ["EMZTOOLS_MINIMAP_LANG_SET"] = "Langue définie sur",
    ["EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"] = "Clic gauche : Ouvrir la configuration",
    ["EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"] = "Clic droit : Changer la langue",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_NO_HEALTH"] = "Aucune potion de soins disponible.",
    ["EMZTOOLS_POTIONS_HEALTH_USED"] = "Utilisé %s.",
    ["EMZTOOLS_POTIONS_NO_MANA"] = "Aucune potion de mana disponible.",
    ["EMZTOOLS_POTIONS_MANA_USED"] = "Utilisé %s.",
    ["EMZTOOLS_POTIONS_NO_HEALTHSTONE"] = "Aucune pierre de soins disponible.",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_USED"] = "Utilisé %s.",
    ["EMZTOOLS_POTIONS_HEALTH_FULL"] = "La santé est déjà pleine.",
    ["EMZTOOLS_POTIONS_NO_HEALING_ITEMS"] = "Aucun objet de soins disponible.",
    ["EMZTOOLS_POTIONS_AVAILABLE_TITLE"] = "Potions disponibles :",
    ["EMZTOOLS_POTIONS_HEALTH_INFO"] = "Santé : %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTH"] = "Santé : Aucune",
    ["EMZTOOLS_POTIONS_MANA_INFO"] = "Mana : %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_MANA"] = "Mana : Aucune",
    ["EMZTOOLS_POTIONS_HEALTHSTONE_INFO"] = "Pierre de soins : %s (%s)",
    ["EMZTOOLS_POTIONS_NONE_HEALTHSTONE"] = "Pierre de soins : Aucune",
    ["EMZTOOLS_POTIONS_RECOMMENDED_TITLE"] = "Potions recommandées pour le niveau %s :",
    ["EMZTOOLS_POTIONS_HEALTH_RECOMMEND"] = "Santé : %s (restaure %s)",
    ["EMZTOOLS_POTIONS_MANA_RECOMMEND"] = "Mana : %s (restaure %s)",
    ["EMZTOOLS_POTIONS_HELP_TITLE"] = "Commandes des potions :",
    ["EMZTOOLS_POTIONS_HELP_LIST"] = "/emz potions list - Afficher les potions disponibles",
    ["EMZTOOLS_POTIONS_HELP_RECOMMEND"] = "/emz potions recommend - Afficher les potions recommandées pour votre niveau",
    ["EMZTOOLS_POTIONS_HELP_HP"] = "/emz potions hp - Utiliser la meilleure potion de soins",
    ["EMZTOOLS_POTIONS_HELP_MANA"] = "/emz potions mana - Utiliser la meilleure potion de mana",
    ["EMZTOOLS_POTIONS_HELP_STONE"] = "/emz potions stone - Utiliser la meilleure pierre de soins",
    ["EMZTOOLS_POTIONS_HELP_SMART"] = "/emz potions smart - Choix intelligent de soins",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Commande de potions inconnue. Tapez /emz potions help pour l'aide.",

    -- ===================================================
    -- SLASH COMMANDS MESSAGES
    -- ===================================================
    ["EMZTOOLS_VERSION_TITLE"] = "-== [ Version d'EmzTools ] ==-",

    -- Module availability messages
    ["EMZTOOLS_HELP_SYSTEM_UNAVAILABLE"] = "Système d'aide non disponible",
    ["EMZTOOLS_THRESHOLDS_MODULE_UNAVAILABLE"] = "Module Seuils non disponible",
    ["EMZTOOLS_CONSUMABLES_MODULE_UNAVAILABLE"] = "Module Consommables non disponible",
    ["EMZTOOLS_POTIONS_MODULE_UNAVAILABLE"] = "Module Potions non disponible",
    ["EMZTOOLS_INFOBAR_MODULE_UNAVAILABLE"] = "Module InfoBar non disponible",
    ["EMZTOOLS_PROFILER_MODULE_UNAVAILABLE"] = "Module Profileur interne non disponible",
    ["EMZTOOLS_MINIMAP_MODULE_UNAVAILABLE"] = "Module Minimap non disponible",
    ["EMZTOOLS_DATABASE_MODULE_UNAVAILABLE"] = "Module Base de données non disponible",
    ["EMZTOOLS_EVENTMANAGER_MODULE_UNAVAILABLE"] = "Module Gestionnaire d'événements non disponible",

    -- Syntax error messages
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETHP"] = "Utilisation : /emz thresholds sethp <nombre>",
    ["EMZTOOLS_THRESHOLDS_SYNTAX_SETMANA"] = "Utilisation : /emz thresholds setmana <nombre>",
    ["EMZTOOLS_INFOBAR_SYNTAX_WIDTH"] = "Utilisation : /emz infobar width <full|nombre>",
    ["EMZTOOLS_INFOBAR_SYNTAX_HEIGHT"] = "Utilisation : /emz infobar height <nombre>",

    -- Unknown command messages
    ["EMZTOOLS_THRESHOLDS_UNKNOWN_COMMAND"] = "Commande inconnue : thresholds %s",
    ["EMZTOOLS_CONSUMABLES_UNKNOWN_COMMAND"] = "Commande inconnue : consumables %s",
    ["EMZTOOLS_POTIONS_UNKNOWN_COMMAND"] = "Commande inconnue : potions %s",
    ["EMZTOOLS_INFOBAR_UNKNOWN_COMMAND"] = "Commande inconnue : infobar %s",
    ["EMZTOOLS_PROFILER_UNKNOWN_COMMAND"] = "Commande inconnue : profile %s",
    ["EMZTOOLS_MINIMAP_UNKNOWN_COMMAND"] = "Commande inconnue : minimap %s",
    ["EMZTOOLS_DATABASE_UNKNOWN_COMMAND"] = "Commande inconnue : database %s",
    ["EMZTOOLS_EVENTMANAGER_UNKNOWN_COMMAND"] = "Commande inconnue : events %s",

    -- Specific messages
    ["EMZTOOLS_INFOBAR_CONFIG_UNAVAILABLE"] = "Configuration non disponible",
    ["EMZTOOLS_MINIMAP_BUTTON_SHOWN"] = "Bouton de la minimap affiché",
    ["EMZTOOLS_MINIMAP_BUTTON_HIDDEN"] = "Bouton de la minimap masqué",
    ["EMZTOOLS_MINIMAP_BUTTON_NOT_CREATED"] = "Bouton de la minimap non créé",

    -- ===================================================
    -- THRESHOLDS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_NOT_LOADED"] = "Module Utils non chargé.",
    ["EMZTOOLS_THRESHOLDS_HP_SET"] = "Seuil de PV personnalisé défini à %s%%.",
    ["EMZTOOLS_THRESHOLDS_HP_RESET"] = "Seuil de PV personnalisé réinitialisé.",
    ["EMZTOOLS_THRESHOLDS_MANA_SET"] = "Seuil de mana personnalisé défini à %s%%.",
    ["EMZTOOLS_THRESHOLDS_MANA_RESET"] = "Seuil de mana personnalisé réinitialisé.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_ON"] = "Mode agressif activé.",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_OFF"] = "Mode agressif désactivé.",
    ["EMZTOOLS_THRESHOLDS_GROUP_MODE"] = "Ajustements en mode groupe activés.",
    ["EMZTOOLS_THRESHOLDS_SOLO_MODE"] = "Ajustements en mode solo activés.",
    ["EMZTOOLS_THRESHOLDS_PVP_MODE"] = "Ajustements en mode JcJ activés.",
    ["EMZTOOLS_THRESHOLDS_PVE_MODE"] = "Ajustements en mode JcE activés.",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP_MANA"] = "PV et mana bas - manger et boire",
    ["EMZTOOLS_CONSUME_REASON_LOW_HP"] = "PV bas - manger",
    ["EMZTOOLS_CONSUME_REASON_LOW_MANA"] = "Mana bas - boire",
    ["EMZTOOLS_CONSUME_REASON_OK"] = "Les ressources sont suffisantes",
    ["EMZTOOLS_FARMING_RECOMMEND_REST"] = "Recommandé de se reposer maintenant",
    ["EMZTOOLS_THRESHOLDS_REST_NOW"] = "Se reposer maintenant",
    ["EMZTOOLS_THRESHOLDS_REST_SOON"] = "Se reposer bientôt (%d mobs restants)",
    ["EMZTOOLS_THRESHOLDS_GOOD_CONTINUE"] = "Bon pour continuer (%d mobs restants)",
    ["EMZTOOLS_THRESHOLDS_HEADER"] = "Seuils pour le niveau %d %s :",
    ["EMZTOOLS_THRESHOLDS_HP_MANA"] = "PV : %d%% | Mana : %d%%",
    ["EMZTOOLS_THRESHOLDS_HP_ONLY"] = "PV : %d%%",
    ["EMZTOOLS_THRESHOLDS_PET_HEAL"] = "Seuil de soin du familier : %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT"] = "Mobs avant repos : %d",
    ["EMZTOOLS_THRESHOLDS_AGGRESSIVE_STATUS"] = "Mode agressif : %s",
    ["EMZTOOLS_THRESHOLDS_GROUP_ADJUSTMENTS"] = "Ajustements de groupe activés",
    ["EMZTOOLS_THRESHOLDS_PVP_ADJUSTMENTS"] = "Ajustements JcJ activés",
    ["EMZTOOLS_THRESHOLDS_EFFICIENCY_HEADER"] = "=== Efficacité du Farming ===",
    ["EMZTOOLS_THRESHOLDS_HP_MANA_STATS"] = "PV : %d%% (Seuil : %d%%) | Mana : %d%% (Seuil : %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_STATS"] = "PV : %d%% (Seuil : %d%%)",
    ["EMZTOOLS_THRESHOLDS_HP_BUFFER"] = "Tampon de PV : %d%%",
    ["EMZTOOLS_THRESHOLDS_DAMAGE_PER_MOB"] = "Dégâts estimés/mob : %d%%",
    ["EMZTOOLS_THRESHOLDS_MOBS_LEFT_EFFICIENCY"] = "Mobs restants avant repos : %d",
    ["EMZTOOLS_THRESHOLDS_RECOMMENDATION"] = "Recommandation : %s",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETHIP"] = "Utilisation : /emz thresholds sethp <nombre>",
    ["EMZTOOLS_THRESHOLDS_USAGE_SETMANA"] = "Utilisation : /emz thresholds setmana <nombre>",
    ["EMZTOOLS_THRESHOLDS_RESET_SUCCESS"] = "Seuils personnalisés réinitialisés",
    ["EMZTOOLS_THRESHOLDS_USAGE_GROUP"] = "Utilisation : /emz thresholds group [on|off]",
    ["EMZTOOLS_THRESHOLDS_USAGE_PVP"] = "Utilisation : /emz thresholds pvp [on|off]",
    ["EMZTOOLS_THRESHOLDS_COMMANDS_HEADER"] = "Commandes disponibles :",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SHOW"] = "/emz thresholds show - Afficher les seuils",
    ["EMZTOOLS_THRESHOLDS_COMMAND_EFFICIENCY"] = "/emz thresholds efficiency - Afficher l'efficacité du farming",
    ["EMZTOOLS_THRESHOLDS_COMMAND_AGGRESSIVE"] = "/emz thresholds aggressive - Basculer le mode agressif",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETHIP"] = "/emz thresholds sethp <nombre> - Définir le seuil de PV",
    ["EMZTOOLS_THRESHOLDS_COMMAND_SETMANA"] = "/emz thresholds setmana <nombre> - Définir le seuil de mana",
    ["EMZTOOLS_THRESHOLDS_COMMAND_RESET"] = "/emz thresholds reset - Réinitialiser les seuils",
    ["EMZTOOLS_THRESHOLDS_COMMAND_GROUP"] = "/emz thresholds group [on|off] - Statut de groupe",
    ["EMZTOOLS_THRESHOLDS_COMMAND_PVP"] = "/emz thresholds pvp [on|off] - Statut JcJ",

    -- ===================================================
    -- UICONFIG MODULE
    -- ===================================================
    ["EMZTOOLS_UICONFIG_TITLE"] = "Configuration d'EmzTools",
    ["EMZTOOLS_UICONFIG_INITIALIZED"] = "UIConfig initialisé",
    ["EMZTOOLS_UICONFIG_THEME_APPLIED"] = "Thème appliqué",
    ["EMZTOOLS_UICONFIG_LOAD_ERROR"] = "Erreur de chargement",
    ["EMZTOOLS_UICONFIG_THEME_SELECTOR"] = "Sélecteur de thème",
    ["EMZTOOLS_UICONFIG_ERROR"] = "Erreur UIConfig",

    -- ===================================================
    -- UTILS MODULE
    -- ===================================================
    ["EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED"] = "Utils : Compatibilité bidirectionnelle établie",

    -- ===================================================
    -- CLASS NAMES
    -- ===================================================
    ["CLASS_WARRIOR"] = "Guerrier",
    ["CLASS_MAGE"] = "Mage",
    ["CLASS_ROGUE"] = "Voleur",
    ["CLASS_DRUID"] = "Druide",
    ["CLASS_HUNTER"] = "Chasseur",
    ["CLASS_SHAMAN"] = "Chaman",
    ["CLASS_PRIEST"] = "Prêtre",
    ["CLASS_WARLOCK"] = "Démoniste",
    ["CLASS_PALADIN"] = "Paladin",
    ["CLASS_UNKNOWN"] = "Inconnu",

    -- ===================================================
    -- UICONFIG_CORE TAB
    -- ===================================================

    -- Messages de debug
    ["EMZTOOLS_CORE_TAB_LOADED"] = "Onglet Core chargé",
    ["EMZTOOLS_CORE_TAB_REGISTERED"] = "Onglet Core enregistré",

    -- Configuration
    ["EMZTOOLS_DEBUG_MODE"] = "Mode debug",
    ["EMZTOOLS_AUTO_LOAD_PLUGINS"] = "Chargement automatique des plugins",
    ["EMZTOOLS_AUTO_LOAD_ENABLED"] = "Chargement automatique des plugins activé",
    ["EMZTOOLS_AUTO_LOAD_DISABLED"] = "Chargement automatique des plugins désactivé",

    -- Thème
    ["EMZTOOLS_THEME_INTERFACE"] = "Thème de l'interface",
    ["EMZTOOLS_CURRENT_THEME"] = "Thème actuel :",
    ["EMZTOOLS_THEME_CHANGED"] = "Thème changé pour : %s",

    -- Base de données
    ["EMZTOOLS_DATABASE_TITLE"] = "Base de données",
    ["EMZTOOLS_RESET_DATABASE_BUTTON"] = "Réinitialiser la BD",
    ["EMZTOOLS_RESET_DATABASE_CONFIRM"] = "Êtes-vous sûr de vouloir réinitialiser la base de données ?\n\nToutes vos configurations seront effacées.",
    ["EMZTOOLS_DATABASE_RESET"] = "Base de données réinitialisée. Rechargement...",
    ["EMZTOOLS_RESET_DEFAULTS_CONFIRM"] = "Restaurer toutes les valeurs par défaut ?",
    ["EMZTOOLS_DEFAULTS_RESTORED"] = "Valeurs par défaut restaurées",
    ["EMZTOOLS_CONFIG_RESET"] = "Configuration réinitialisée",

    -- Informations
    ["EMZTOOLS_INFO_TITLE"] = "Information",
    ["EMZTOOLS_PLUGINS_LOADED"] = "Plugins chargés",

    -- Description de l'onglet
    ["EMZTOOLS_CORE_TAB_DESC"] = "Configuration principale du framework EmzTools",

    -- ===================================================
    -- UICONFIG - INFOBAR
    -- ===================================================
    ["EMZTOOLS_UCCONFIG_INFOBAR_TITLE"] = "Configuration d'EmzTools",
    ["EMZTOOLS_UCCONFIG_OPTIONS"] = "Options",
    ["EMZTOOLS_UCCONFIG_INFOBAR"] = "InfoBar",
    ["EMZTOOLS_UCCONFIG_LAYOUT"] = "Disposition",
    ["EMZTOOLS_UCCONFIG_FULLSCREEN"] = "Plein écran",
    ["EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"] = "Disposition Plein écran",
    ["EMZTOOLS_UCCONFIG_CUSTOM"] = "Personnalisé",
    ["EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"] = "Disposition Personnalisée",
    ["EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"] = "Largeur personnalisée",
    ["EMZTOOLS_UCCONFIG_HEIGHT"] = "Hauteur",
    ["EMZTOOLS_UCCONFIG_HEIGHT_20PX"] = "Hauteur 20px",
    ["EMZTOOLS_UCCONFIG_HEIGHT_16PX"] = "Hauteur 16px",
    ["EMZTOOLS_UCCONFIG_TRANSPARENCY"] = "Transparence",
    ["EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS"] = "Éléments d'affichage",
    ["EMZTOOLS_INFOBAR_FPS_SHORT"] = "FPS",
    ["EMZTOOLS_INFOBAR_LATENCY_SHORT"] = "Latence",
    ["EMZTOOLS_INFOBAR_GOLD_SHORT"] = "Or",
    ["EMZTOOLS_INFOBAR_XP_SHORT"] = "XP",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT"] = "Format de l'horloge",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"] = "Format d'horloge Auto",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"] = "Format d'horloge 24 heures",
    ["EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"] = "Format d'horloge 12 heures",
    ["EMZTOOLS_UCCONFIG_TEST"] = "Test",
    ["EMZTOOLS_UCCONFIG_INFOBAR_TESTED"] = "InfoBar testée - affichage basculé",
    ["EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE"] = "Module InfoBar non disponible",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"] = "Réinitialiser la configuration de l'InfoBar aux valeurs par défaut ?",
    ["EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS"] = "Configuration de l'InfoBar réinitialisée aux valeurs par défaut",
    ["EMZTOOLS_UCCONFIG_INFOBAR_DESC"] = "Configuration de la barre d'information",
    ["EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED"] = "Onglet InfoBar enregistré",
    ["EMZTOOLS_UCCONFIG_INFOBAR_LOADED"] = "Onglet InfoBar chargé",

    -- ===================================================
    -- POTIONS MODULE
    -- ===================================================
    ["EMZTOOLS_POTIONS_TITLE"] = "Gestion des Potions",
    ["EMZTOOLS_POTIONS_DESC"] = "Configuration automatique des potions et consommables",
    ["EMZTOOLS_POTIONS_HEAL_TITLE"] = "Potions de Soins",
    ["EMZTOOLS_POTIONS_AUTO_HEAL"] = "Auto-soins",
    ["EMZTOOLS_POTIONS_AUTO_HEAL_HELP"] = "Utilise automatiquement les potions de soins quand votre santé est basse.",
    ["EMZTOOLS_POTIONS_HEAL_PRIORITY"] = "Priorité de soins :",
    ["EMZTOOLS_POTIONS_PRIORITY_SMART"] = "Intelligent",
    ["EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"] = "Pierre d'abord",
    ["EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"] = "Potion d'abord",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE"] = "Utiliser les pierres de soins",
    ["EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"] = "Utilise les pierres de soins créées par les démonistes.",
    ["EMZTOOLS_POTIONS_MANA_TITLE"] = "Potions de Mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA"] = "Auto-mana",
    ["EMZTOOLS_POTIONS_AUTO_MANA_HELP"] = "Utilise automatiquement les potions de mana quand votre mana est bas.",
    ["EMZTOOLS_POTIONS_ALERTS_TITLE"] = "Alertes et Annonces",
    ["EMZTOOLS_POTIONS_SOUND_ALERT"] = "Alerte sonore",
    ["EMZTOOLS_POTIONS_SOUND_ALERT_HELP"] = "Joue un son quand une potion est automatiquement utilisée.",
    ["EMZTOOLS_POTIONS_ANNOUNCE"] = "Annoncer dans le chat",
    ["EMZTOOLS_POTIONS_ANNOUNCE_HELP"] = "Annonce l'utilisation de potions dans le canal groupe/raid.",
    ["EMZTOOLS_POTIONS_OFFENSIVE_TITLE"] = "Potions Offensives",
    ["EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"] = "Priorité offensive :",
    ["EMZTOOLS_POTIONS_PRIORITY_DISPEL"] = "Dissipation/Magie",
    ["EMZTOOLS_POTIONS_PRIORITY_DAMAGE"] = "Dégâts",
    ["EMZTOOLS_POTIONS_PRIORITY_SPEED"] = "Vitesse",
    ["EMZTOOLS_POTIONS_RESET_CONFIRM"] = "Réinitialiser la configuration des Potions aux valeurs par défaut ?",
    ["EMZTOOLS_POTIONS_RESET_SUCCESS"] = "Configuration des Potions réinitialisée aux valeurs par défaut",
    ["EMZTOOLS_POTIONS_RESET_HELP"] = "Réinitialise toutes les options à leurs valeurs par défaut.",
    ["EMZTOOLS_POTIONS_TAB_LOADED"] = "Onglet Potions chargé",
    ["EMZTOOLS_POTIONS_TAB_REGISTERED"] = "Onglet Potions enregistré",
    ["EMZTOOLS_STATE_MODULES"] = "Modules",
}
