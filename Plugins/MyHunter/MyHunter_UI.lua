-- ===================================================
-- MyHunter - MyHunter_UI.lua
-- Interface utilisateur pour le plugin MyHunter
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

MyHunter.UI = {}

-- ===================================================
-- CONFIGURATION DE L'INTERFACE
-- ===================================================

MyHunter.UI.Tabs = {
    "General",
    "Rotation",
    "Aspects",
    "Pet",
    "Stings",
    "Blacklist"
}

MyHunter.UI.TabTitles = {
    General = "EMZTOOLS_MYHUNTER_UI_TAB_GENERAL",
    Rotation = "EMZTOOLS_MYHUNTER_UI_TAB_ROTATION",
    Aspects = "EMZTOOLS_MYHUNTER_UI_TAB_ASPECTS",
    Pet = "EMZTOOLS_MYHUNTER_UI_TAB_PET",
    Stings = "EMZTOOLS_MYHUNTER_UI_TAB_STINGS",
    Blacklist = "EMZTOOLS_MYHUNTER_UI_TAB_BLACKLIST"
}

-- ===================================================
-- INITIALISATION DE L'INTERFACE
-- ===================================================

function MyHunter.UI:Initialize()
    if not EmzTools or not EmzTools.Data or not EmzTools.Data.UI then
        return false
    end

    -- Enregistrer l'interface avec le framework
    EmzTools:RegisterPluginUI("MyHunter", self)

    EmzTools:Print("EMZTOOLS_MYHUNTER_UI_INITIALIZED", "debug")
    return true
end

-- ===================================================
-- CRÉATION DE L'INTERFACE PRINCIPALE
-- ===================================================

function MyHunter.UI:CreateConfigTab(container)
    if not container then return end

    -- Créer les onglets
    self.tabs = EmzTools.Data.UI:CreateTabSystem(container, self.UI.Tabs, self.UI.TabTitles)

    -- Créer le contenu de chaque onglet
    self:CreateGeneralTab(self.tabs.General.content)
    self:CreateRotationTab(self.tabs.Rotation.content)
    self:CreateAspectsTab(self.tabs.Aspects.content)
    self:CreatePetTab(self.tabs.Pet.content)
    self:CreateStingsTab(self.tabs.Stings.content)
    self:CreateBlacklistTab(self.tabs.Blacklist.content)

    return container
end

-- ===================================================
-- ONGLET GÉNÉRAL
-- ===================================================

function MyHunter.UI:CreateGeneralTab(container)
    -- Section Activation
    local activationSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ACTIVATION_SECTION")

    self.enablePluginCheckbox = EmzTools.Data.UI:CreateCheckbox(
        activationSection,
        "EMZTOOLS_MYHUNTER_UI_ENABLE_PLUGIN",
        "EMZTOOLS_MYHUNTER_UI_ENABLE_PLUGIN_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_ENABLE_PLUGIN_TOOLTIP_TEXT",
        MyHunter:GetOption("enabled", true),
        function(checked)
            MyHunter:SetOption("enabled", checked)
        end
    )

    -- Section Spécialisation
    local specSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_SPEC_SECTION")

    self.specDropdown = EmzTools.Data.UI:CreateDropdown(
        specSection,
        "EMZTOOLS_MYHUNTER_UI_SPEC_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_SPEC_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPEC_BEASTMASTERY", value = "BeastMastery"},
            {text = "EMZTOOLS_MYHUNTER_SPEC_MARKSMANSHIP", value = "Marksmanship"},
            {text = "EMZTOOLS_MYHUNTER_SPEC_SURVIVAL", value = "Survival"}
        },
        MyHunter:GetOption("selectedSpec", "BeastMastery"),
        function(value)
            MyHunter:SetOption("selectedSpec", value)
            if MyHunter.SetCurrentSpec then
                MyHunter:SetCurrentSpec(value)
            end
        end
    )

    -- Section Comportement
    local behaviorSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_BEHAVIOR_SECTION")

    self.autoImmunityCheckbox = EmzTools.Data.UI:CreateCheckbox(
        behaviorSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_IMMUNITY",
        "EMZTOOLS_MYHUNTER_UI_AUTO_IMMUNITY_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_IMMUNITY_TOOLTIP_TEXT",
        MyHunter:GetOption("autoImmunity", true),
        function(checked)
            MyHunter:SetOption("autoImmunity", checked)
        end
    )

    -- Section Affichage
    local displaySection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_DISPLAY_SECTION")

    self.showRotationDisplayCheckbox = EmzTools.Data.UI:CreateCheckbox(
        displaySection,
        "EMZTOOLS_MYHUNTER_UI_SHOW_ROTATION_DISPLAY",
        "EMZTOOLS_MYHUNTER_UI_SHOW_ROTATION_DISPLAY_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_SHOW_ROTATION_DISPLAY_TOOLTIP_TEXT",
        MyHunter:GetOption("showRotationDisplay", true),
        function(checked)
            MyHunter:SetOption("showRotationDisplay", checked)
        end
    )
end

-- ===================================================
-- ONGLET ROTATION
-- ===================================================

function MyHunter.UI:CreateRotationTab(container)
    -- Section Rotation Automatique
    local rotationSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ROTATION_SECTION")

    self.autoRotationCheckbox = EmzTools.Data.UI:CreateCheckbox(
        rotationSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_ROTATION",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ROTATION_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ROTATION_TOOLTIP_TEXT",
        MyHunter:GetOption("autoRotation", false),
        function(checked)
            MyHunter:SetOption("autoRotation", checked)
        end
    )

    -- Délai de rotation
    self.rotationDelaySlider = EmzTools.Data.UI:CreateSlider(
        rotationSection,
        "EMZTOOLS_MYHUNTER_UI_ROTATION_DELAY",
        "EMZTOOLS_MYHUNTER_UI_ROTATION_DELAY_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_ROTATION_DELAY_TOOLTIP_TEXT",
        0.1, 2.0, 0.1,
        MyHunter:GetOption("rotationDelay", 0.5),
        function(value)
            MyHunter:SetOption("rotationDelay", value)
        end
    )

    -- Section Comportement Rotation
    local behaviorSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ROTATION_BEHAVIOR_SECTION")

    self.combatOnlyCheckbox = EmzTools.Data.UI:CreateCheckbox(
        behaviorSection,
        "EMZTOOLS_MYHUNTER_UI_COMBAT_ONLY",
        "EMZTOOLS_MYHUNTER_UI_COMBAT_ONLY_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_COMBAT_ONLY_TOOLTIP_TEXT",
        MyHunter:GetOption("enableCombatOnly", true),
        function(checked)
            MyHunter:SetOption("enableCombatOnly", checked)
        end
    )

    self.targetChecksCheckbox = EmzTools.Data.UI:CreateCheckbox(
        behaviorSection,
        "EMZTOOLS_MYHUNTER_UI_TARGET_CHECKS",
        "EMZTOOLS_MYHUNTER_UI_TARGET_CHECKS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_TARGET_CHECKS_TOOLTIP_TEXT",
        MyHunter:GetOption("enableTargetChecks", true),
        function(checked)
            MyHunter:SetOption("enableTargetChecks", checked)
        end
    )

    -- Section Fonctionnalités Automatiques
    local autoFeaturesSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_AUTO_FEATURES_SECTION")

    self.autoAspectsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        autoFeaturesSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS_TOOLTIP_TEXT",
        MyHunter:GetOption("enableAutoAspects", true),
        function(checked)
            MyHunter:SetOption("enableAutoAspects", checked)
        end
    )

    self.autoPetCheckbox = EmzTools.Data.UI:CreateCheckbox(
        autoFeaturesSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET",
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET_TOOLTIP_TEXT",
        MyHunter:GetOption("enableAutoPet", true),
        function(checked)
            MyHunter:SetOption("enableAutoPet", checked)
        end
    )

    self.autoStingsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        autoFeaturesSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS",
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS_TOOLTIP_TEXT",
        MyHunter:GetOption("enableAutoStings", true),
        function(checked)
            MyHunter:SetOption("enableAutoStings", checked)
        end
    )

    -- Boutons de contrôle
    local controlSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ROTATION_CONTROL_SECTION")

    self.startRotationButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_START_ROTATION",
        function()
            if MyHunter.Rotation and MyHunter.Rotation.Start then
                MyHunter.Rotation:Start()
            end
        end
    )

    self.stopRotationButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_STOP_ROTATION",
        function()
            if MyHunter.Rotation and MyHunter.Rotation.Stop then
                MyHunter.Rotation:Stop()
            end
        end
    )

    self.executeOnceButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_EXECUTE_ONCE",
        function()
            if MyHunter.Rotation and MyHunter.Rotation.ExecuteOnce then
                MyHunter.Rotation:ExecuteOnce()
            end
        end
    )
end

-- ===================================================
-- ONGLET ASPECTS
-- ===================================================

function MyHunter.UI:CreateAspectsTab(container)
    -- Section Activation
    local activationSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ASPECTS_ACTIVATION_SECTION")

    self.autoAspectsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        activationSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_ASPECTS_TOOLTIP_TEXT",
        MyHunter:GetOption("autoAspect", true),
        function(checked)
            MyHunter:SetOption("autoAspect", checked)
        end
    )

    self.smartAspectsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        activationSection,
        "EMZTOOLS_MYHUNTER_UI_SMART_ASPECTS",
        "EMZTOOLS_MYHUNTER_UI_SMART_ASPECTS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_SMART_ASPECTS_TOOLTIP_TEXT",
        MyHunter:GetOption("enableSmartAspects", true),
        function(checked)
            MyHunter:SetOption("enableSmartAspects", checked)
        end
    )

    -- Section Configuration des Aspects
    local configSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ASPECTS_CONFIG_SECTION")

    -- Aspect de combat
    self.combatAspectDropdown = EmzTools.Data.UI:CreateDropdown(
        configSection,
        "EMZTOOLS_MYHUNTER_UI_COMBAT_ASPECT",
        "EMZTOOLS_MYHUNTER_UI_COMBAT_ASPECT_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPELL_ASPECT_HAWK", value = "Aspect of the Hawk"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_ASPECT_MONKEY", value = "Aspect of the Monkey"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_ASPECT_WILD", value = "Aspect of the Wild"}
        },
        MyHunter:GetOption("combatAspect", "Aspect of the Hawk"),
        function(value)
            MyHunter:SetOption("combatAspect", value)
        end
    )

    -- Aspect de voyage
    self.travelAspectDropdown = EmzTools.Data.UI:CreateDropdown(
        configSection,
        "EMZTOOLS_MYHUNTER_UI_TRAVEL_ASPECT",
        "EMZTOOLS_MYHUNTER_UI_TRAVEL_ASPECT_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPELL_ASPECT_CHEETAH", value = "Aspect of the Cheetah"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_ASPECT_PACK", value = "Aspect of the Pack"}
        },
        MyHunter:GetOption("travelAspect", "Aspect of the Cheetah"),
        function(value)
            MyHunter:SetOption("travelAspect", value)
        end
    )

    -- Section Verrouillage
    local lockSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ASPECTS_LOCK_SECTION")

    self.aspectLockCheckbox = EmzTools.Data.UI:CreateCheckbox(
        lockSection,
        "EMZTOOLS_MYHUNTER_UI_ASPECT_LOCK",
        "EMZTOOLS_MYHUNTER_UI_ASPECT_LOCK_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_ASPECT_LOCK_TOOLTIP_TEXT",
        MyHunter:GetOption("aspectLocked", false),
        function(checked)
            MyHunter:SetOption("aspectLocked", checked)
            if MyHunter.Aspects and MyHunter.Aspects.SetAspectLock then
                MyHunter.Aspects:SetAspectLock(checked)
            end
        end
    )

    -- Boutons de contrôle
    local controlSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_ASPECTS_CONTROL_SECTION")

    self.applyCombatAspectButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_APPLY_COMBAT_ASPECT",
        function()
            if MyHunter.Aspects and MyHunter.Aspects.SwitchToCombatAspect then
                MyHunter.Aspects:SwitchToCombatAspect()
            end
        end
    )

    self.applyTravelAspectButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_APPLY_TRAVEL_ASPECT",
        function()
            if MyHunter.Aspects and MyHunter.Aspects.SwitchToTravelAspect then
                MyHunter.Aspects:SwitchToTravelAspect()
            end
        end
    )

    self.smartAspectButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_SMART_ASPECT",
        function()
            if MyHunter.Aspects and MyHunter.Aspects.SmartAspect then
                MyHunter.Aspects:SmartAspect()
            end
        end
    )
end

-- ===================================================
-- ONGLET FAMILIER
-- ===================================================

function MyHunter.UI:CreatePetTab(container)
    -- Section Gestion Automatique
    local managementSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_PET_MANAGEMENT_SECTION")

    self.autoPetManagementCheckbox = EmzTools.Data.UI:CreateCheckbox(
        managementSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET_MANAGEMENT",
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET_MANAGEMENT_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_PET_MANAGEMENT_TOOLTIP_TEXT",
        MyHunter:GetOption("autoPetManagement", true),
        function(checked)
            MyHunter:SetOption("autoPetManagement", checked)
        end
    )

    self.autoHealPetCheckbox = EmzTools.Data.UI:CreateCheckbox(
        managementSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_HEAL_PET",
        "EMZTOOLS_MYHUNTER_UI_AUTO_HEAL_PET_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_HEAL_PET_TOOLTIP_TEXT",
        MyHunter:GetOption("autoHealPet", true),
        function(checked)
            MyHunter:SetOption("autoHealPet", checked)
        end
    )

    self.autoRevivePetCheckbox = EmzTools.Data.UI:CreateCheckbox(
        managementSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_REVIVE_PET",
        "EMZTOOLS_MYHUNTER_UI_AUTO_REVIVE_PET_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_REVIVE_PET_TOOLTIP_TEXT",
        MyHunter:GetOption("autoRevivePet", true),
        function(checked)
            MyHunter:SetOption("autoRevivePet", checked)
        end
    )

    self.autoCallPetCheckbox = EmzTools.Data.UI:CreateCheckbox(
        managementSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_CALL_PET",
        "EMZTOOLS_MYHUNTER_UI_AUTO_CALL_PET_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_CALL_PET_TOOLTIP_TEXT",
        MyHunter:GetOption("autoCallPet", true),
        function(checked)
            MyHunter:SetOption("autoCallPet", checked)
        end
    )

    -- Section Soins
    local healingSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_PET_HEALING_SECTION")

    self.petHealThresholdSlider = EmzTools.Data.UI:CreateSlider(
        healingSection,
        "EMZTOOLS_MYHUNTER_UI_PET_HEAL_THRESHOLD",
        "EMZTOOLS_MYHUNTER_UI_PET_HEAL_THRESHOLD_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_PET_HEAL_THRESHOLD_TOOLTIP_TEXT",
        10, 90, 5,
        MyHunter:GetOption("petHealThreshold", 50),
        function(value)
            MyHunter:SetOption("petHealThreshold", value)
        end
    )

    -- Section Nourriture
    local feedingSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_PET_FEEDING_SECTION")

    self.petFeedingCheckbox = EmzTools.Data.UI:CreateCheckbox(
        feedingSection,
        "EMZTOOLS_MYHUNTER_UI_PET_FEEDING",
        "EMZTOOLS_MYHUNTER_UI_PET_FEEDING_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_PET_FEEDING_TOOLTIP_TEXT",
        MyHunter:GetOption("petFeedingEnabled", true),
        function(checked)
            MyHunter:SetOption("petFeedingEnabled", checked)
        end
    )

    self.happinessThresholdSlider = EmzTools.Data.UI:CreateSlider(
        feedingSection,
        "EMZTOOLS_MYHUNTER_UI_HAPPINESS_THRESHOLD",
        "EMZTOOLS_MYHUNTER_UI_HAPPINESS_THRESHOLD_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_HAPPINESS_THRESHOLD_TOOLTIP_TEXT",
        1, 3, 1,
        MyHunter:GetOption("happinessThreshold", 2),
        function(value)
            MyHunter:SetOption("happinessThreshold", value)
        end
    )

    -- Boutons de contrôle
    local controlSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_PET_CONTROL_SECTION")

    self.healPetButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_HEAL_PET",
        function()
            if MyHunter.Pet and MyHunter.Pet.HealPet then
                MyHunter.Pet:HealPet()
            end
        end
    )

    self.feedPetButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_FEED_PET",
        function()
            if MyHunter.Pet and MyHunter.Pet.FeedPet then
                MyHunter.Pet:FeedPet()
            end
        end
    )

    self.callPetButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_CALL_PET",
        function()
            if MyHunter.Pet and MyHunter.Pet.CallPet then
                MyHunter.Pet:CallPet()
            end
        end
    )

    self.revivePetButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_REVIVE_PET",
        function()
            if MyHunter.Pet and MyHunter.Pet.RevivePet then
                MyHunter.Pet:RevivePet()
            end
        end
    )
end

-- ===================================================
-- ONGLET PIQÛRES
-- ===================================================

function MyHunter.UI:CreateStingsTab(container)
    -- Section Configuration
    local configSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_STINGS_CONFIG_SECTION")

    self.autoStingsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        configSection,
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS",
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_AUTO_STINGS_TOOLTIP_TEXT",
        MyHunter:GetOption("autoStings", true),
        function(checked)
            MyHunter:SetOption("autoStings", checked)
        end
    )

    self.smartStingsCheckbox = EmzTools.Data.UI:CreateCheckbox(
        configSection,
        "EMZTOOLS_MYHUNTER_UI_SMART_STINGS",
        "EMZTOOLS_MYHUNTER_UI_SMART_STINGS_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_SMART_STINGS_TOOLTIP_TEXT",
        MyHunter:GetOption("enableSmartStings", true),
        function(checked)
            MyHunter:SetOption("enableSmartStings", checked)
        end
    )

    self.stingRotationCheckbox = EmzTools.Data.UI:CreateCheckbox(
        configSection,
        "EMZTOOLS_MYHUNTER_UI_STING_ROTATION",
        "EMZTOOLS_MYHUNTER_UI_STING_ROTATION_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_STING_ROTATION_TOOLTIP_TEXT",
        MyHunter:GetOption("stingRotation", true),
        function(checked)
            MyHunter:SetOption("stingRotation", checked)
        end
    )

    -- Section Sélection par Contexte
    local contextSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_STINGS_CONTEXT_SECTION")

    -- Piqûre PvE
    self.pveStingDropdown = EmzTools.Data.UI:CreateDropdown(
        contextSection,
        "EMZTOOLS_MYHUNTER_UI_PVE_STING",
        "EMZTOOLS_MYHUNTER_UI_PVE_STING_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPELL_SERPENT_STING", value = "Serpent Sting"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_SCORPID_STING", value = "Scorpid Sting"}
        },
        MyHunter:GetOption("pveSting", "Serpent Sting"),
        function(value)
            MyHunter:SetOption("pveSting", value)
        end
    )

    -- Piqûre PvP
    self.pvpStingDropdown = EmzTools.Data.UI:CreateDropdown(
        contextSection,
        "EMZTOOLS_MYHUNTER_UI_PVP_STING",
        "EMZTOOLS_MYHUNTER_UI_PVP_STING_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPELL_VIPER_STING", value = "Viper Sting"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_SERPENT_STING", value = "Serpent Sting"}
        },
        MyHunter:GetOption("pvpSting", "Viper Sting"),
        function(value)
            MyHunter:SetOption("pvpSting", value)
        end
    )

    -- Piqûre Boss
    self.bossStingDropdown = EmzTools.Data.UI:CreateDropdown(
        contextSection,
        "EMZTOOLS_MYHUNTER_UI_BOSS_STING",
        "EMZTOOLS_MYHUNTER_UI_BOSS_STING_TOOLTIP_TEXT",
        {
            {text = "EMZTOOLS_MYHUNTER_SPELL_SCORPID_STING", value = "Scorpid Sting"},
            {text = "EMZTOOLS_MYHUNTER_SPELL_SERPENT_STING", value = "Serpent Sting"}
        },
        MyHunter:GetOption("bossSting", "Scorpid Sting"),
        function(value)
            MyHunter:SetOption("bossSting", value)
        end
    )

    -- Boutons de contrôle
    local controlSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_STINGS_CONTROL_SECTION")

    self.applySerpentStingButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_APPLY_SERPENT_STING",
        function()
            if MyHunter.Stings and MyHunter.Stings.ActivateSerpent then
                MyHunter.Stings:ActivateSerpent()
            end
        end
    )

    self.applyScorpidStingButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_APPLY_SCORPID_STING",
        function()
            if MyHunter.Stings and MyHunter.Stings.ActivateScorpid then
                MyHunter.Stings:ActivateScorpid()
            end
        end
    )

    self.applyViperStingButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_APPLY_VIPER_STING",
        function()
            if MyHunter.Stings and MyHunter.Stings.ActivateViper then
                MyHunter.Stings:ActivateViper()
            end
        end
    )

    self.smartStingButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_SMART_STING",
        function()
            if MyHunter.Stings and MyHunter.Stings.SmartSting then
                MyHunter.Stings:SmartSting()
            end
        end
    )
end

-- ===================================================
-- ONGLET BLACKLIST
-- ===================================================

function MyHunter.UI:CreateBlacklistTab(container)
    -- Section Information
    local infoSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_BLACKLIST_INFO_SECTION")

    EmzTools.Data.UI:CreateText(
        infoSection,
        "EMZTOOLS_MYHUNTER_UI_BLACKLIST_PERMANENT_INFO",
        "EMZTOOLS_MYHUNTER_UI_BLACKLIST_INFO_TOOLTIP_TITLE",
        "EMZTOOLS_MYHUNTER_UI_BLACKLIST_INFO_TOOLTIP_TEXT"
    )

    -- Section Liste
    local listSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_BLACKLIST_LIST_SECTION")

    -- Créer une zone de texte pour afficher la blacklist
    self.blacklistText = EmzTools.Data.UI:CreateScrollableText(
        listSection,
        "",
        300,
        200
    )

    -- Section Contrôles
    local controlSection = EmzTools.Data.UI:CreateSection(container, "EMZTOOLS_MYHUNTER_UI_BLACKLIST_CONTROL_SECTION")

    self.refreshBlacklistButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_REFRESH_BLACKLIST",
        function()
            self:UpdateBlacklistDisplay()
        end
    )

    self.clearBlacklistButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_CLEAR_BLACKLIST",
        function()
            if MyHunter.Utils and MyHunter.Utils.ClearBlacklist then
                MyHunter.Utils:ClearBlacklist()
                self:UpdateBlacklistDisplay()
            end
        end
    )

    self.addCurrentTargetButton = EmzTools.Data.UI:CreateButton(
        controlSection,
        "EMZTOOLS_MYHUNTER_UI_ADD_CURRENT_TARGET",
        function()
            if MyHunter.Utils and MyHunter.Utils.AddCurrentTargetToBlacklist then
                MyHunter.Utils:AddCurrentTargetToBlacklist()
                self:UpdateBlacklistDisplay()
            end
        end
    )

    -- Mettre à jour l'affichage initial
    self:UpdateBlacklistDisplay()
end

-- ===================================================
-- FONCTIONS UTILITAIRES UI
-- ===================================================

function MyHunter.UI:UpdateBlacklistDisplay()
    if not self.blacklistText then return end

    local text = ""

    if MyHunter.Utils and MyHunter.Utils.Blacklist then
        local blacklist = MyHunter.Utils.Blacklist.poisonImmuneTargets or {}

        if next(blacklist) then
            for targetName, entry in pairs(blacklist) do
                local timeAdded = entry.timestamp
                local daysAgo = math.floor((GetTime() - timeAdded) / 86400) -- 86400 secondes dans une journée

                if daysAgo == 0 then
                    text = text .. string.format("• %s (" .. MYHUNTER_UI_BLACKLIST_ADDED_TODAY .. ")\n", targetName)
                elseif daysAgo == 1 then
                    text = text .. string.format("• %s (" .. MYHUNTER_UI_BLACKLIST_ADDED_YESTERDAY .. ")\n", targetName)
                else
                    text = text .. string.format("• %s (" .. MYHUNTER_UI_BLACKLIST_ADDED_DAYS_AGO .. ")\n", targetName, daysAgo)
                end
            end
        else
            text = MYHUNTER_UI_BLACKLIST_EMPTY
        end
    else
        text = MYHUNTER_UI_BLACKLIST_UNAVAILABLE
    end

    self.blacklistText:SetText(text)
end

function MyHunter.UI:RefreshAllSettings()
    -- Mettre à jour tous les contrôles UI avec les valeurs actuelles
    if self.enablePluginCheckbox then
        self.enablePluginCheckbox:SetChecked(MyHunter:GetOption("enabled", true))
    end

    if self.autoRotationCheckbox then
        self.autoRotationCheckbox:SetChecked(MyHunter:GetOption("autoRotation", false))
    end

    if self.rotationDelaySlider then
        self.rotationDelaySlider:SetValue(MyHunter:GetOption("rotationDelay", 0.5))
    end

    -- Mettre à jour l'affichage de la blacklist
    self:UpdateBlacklistDisplay()
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

-- Fonction requise par le framework EmzTools
function MyHunter.UI:CreateConfigPanel()
    local panel = EmzTools.Data.UI:CreateConfigPanel("MyHunter")

    if panel then
        self:CreateConfigTab(panel)
        self:RefreshAllSettings()
    end

    return panel
end

-- Enregistrement avec le framework
if EmzTools and EmzTools.Data and EmzTools.Data.UI then
    EmzTools.Data.UI:RegisterPluginConfig("MyHunter", MyHunter.UI)
end

return MyHunter.UI
