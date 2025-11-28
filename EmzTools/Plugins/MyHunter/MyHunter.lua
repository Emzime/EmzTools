-- ===================================================
-- MyHunter - MyHunter.lua
-- Plugin Hunter pour EmzTools Framework
-- Architecture: My<Classe>
-- Version: 1.0.0
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

-- Namespace principal selon l'architecture My<Classe>
MyHunter = MyHunter or {}
MyHunter.version = "1.0.0"
MyHunter.author = "Emzime"
MyHunter.supportedClasses = { "HUNTER" }

-- ===================================================
-- CONFIGURATION PAR DÉFAUT
-- ===================================================
MyHunter.defaultSettings = {
    enabled = true,
    autoAspect = true,
    autoPet = true,
    showRotationDisplay = true,
    selectedSpec = "BeastMastery",
    petHealThreshold = 70,
    useHunterConsumables = true,
    useHunterPotions = true,
    minimapPosition = 200,
    displaySize = 64,
    displayOpacity = 100,
    displayShowGlow = true,
    displayShowName = true,
    displayLocked = false,

	-- Consommables (nourriture/eaue)
    autoEatDrink = true,
    autoEatDrinkHPThreshold = 70,
    autoEatDrinkMPThreshold = 50,
    autoSitToRest = true,
    restOutOfCombatOnly = true,

    -- Potions (soins/mana)
    autoUsePotions = true,
    autoHealthPotionThreshold = 30,
    autoManaPotionThreshold = 20,
    usePotionsInCombat = true,
    useHealthstones = true,
}

-- ===================================================
-- ÉTAT DU MODULE
-- ===================================================
MyHunter.state = {
    lastKillTime = 0,
    lastCombatTime = 0,
    lastSpellCastTime = 0,
    currentTarget = nil,
    immuneTargets = {},
    combatLog = {},
    activeAspect = nil,
    petStatus = "healthy",
}

-- ===================================================
-- INITIALIZATION - COMPATIBLE EMZTOOLS
-- ===================================================

function MyHunter:Initialize()
    if EmzTools and EmzTools.Database then
        EmzTools.Database:InitializeModule("MyHunter", self.defaultSettings)
    end

    self:LoadLocalization()

    self:RegisterEvents()

    self:InitializeSubModules()

    self:InitializeUI()

    EmzTools:Print("EMZTOOLS_MYHUNTER_MODULE_LOADED", "success", self.version)
    return true
end

-- ===================================================
-- CHARGEMENT DE LA LOCALISATION
-- ===================================================
function MyHunter:LoadLocalization()
    EmzTools:LoadPluginLocalization("MyHunter")
end

-- ===================================================
-- SYSTÈME DE FALLBACK ROBUSTE
-- ===================================================
function MyHunter:GetModuleSafe(moduleName)
    return self[moduleName] or EmzTools["MyHunter_" .. moduleName] or {}
end

function MyHunter:IsModuleReady(moduleName)
    local module = self:GetModuleSafe(moduleName)
    return module and module.Initialize and true or false
end

-- ===================================================
-- INITIALISATION DES SOUS-MODULES
-- ===================================================
function MyHunter:InitializeSubModules()
    self.SpellBook = self:GetModuleSafe("SpellBook")
    self.Rotation = self:GetModuleSafe("Rotation")
    self.RotationDisplay = self:GetModuleSafe("RotationDisplay")
    self.Aspects = self:GetModuleSafe("Aspects")
    self.Pet = self:GetModuleSafe("Pet")
    self.Stings = self:GetModuleSafe("Stings")

    self.Specs = {
        BeastMastery = self:GetModuleSafe("BeastMastery"),
        Marksmanship = self:GetModuleSafe("Marksman"),
        Survival = self:GetModuleSafe("Survival")
    }
end

-- ===================================================
-- INITIALISATION DE L'INTERFACE
-- ===================================================
function MyHunter:InitializeUI()
    if self.CreateConfigTab then
        EmzTools:RegisterPluginUI("MyHunter", self)
    end
end

-- ===================================================
-- ENREGISTREMENT DES ÉVÉNEMENTS
-- ===================================================
function MyHunter:RegisterEvents()
    if not EmzTools or not EmzTools.EventManager then
        return
    end

    EmzTools.EventManager:RegisterEvent("PLAYER_REGEN_DISABLED", function()
        self.state.lastCombatTime = GetTime()
    end, "MyHunter_EnterCombat")

    EmzTools.EventManager:RegisterEvent("PLAYER_REGEN_ENABLED", function()
        self.state.lastCombatTime = GetTime()
    end, "MyHunter_LeaveCombat")

    EmzTools.EventManager:RegisterEvent("PLAYER_DEAD", function()
        self.state.immuneTargets = {}
    end, "MyHunter_PlayerDead")

    EmzTools.EventManager:RegisterEvent("PLAYER_TARGET_CHANGED", function()
        if self.Rotation and self.Rotation.Reset then
            self.Rotation:Reset("EMZTOOLS_MYHUNTER_TARGET_CHANGED")
        end
    end, "MyHunter_TargetChanged")

    EmzTools.EventManager:RegisterEvent("UNIT_PET", function()
        if self.Pet and self.Pet.OnPetChanged then
            self.Pet:OnPetChanged()
        end
    end, "MyHunter_PetChanged")
end

-- ===================================================
-- FONCTIONS UTILITAIRES - SPÉCIFIQUES HUNTER
-- ===================================================

function MyHunter:IsHunter()
    local _, class = UnitClass("player")
    return class == "HUNTER"
end

function MyHunter:IsReady()
    return self:IsHunter() and self:GetOption("enabled", true)
end

function MyHunter:GetOption(key, defaultValue)
    if EmzTools and EmzTools.Database then
        return EmzTools.Database:Get("MyHunter", key, defaultValue)
    end
    return defaultValue
end

function MyHunter:SetOption(key, value)
    if EmzTools and EmzTools.Database then
        return EmzTools.Database:Set("MyHunter", key, value)
    end
    return false
end

function MyHunter:InCombat()
    return UnitAffectingCombat("player")
end

function MyHunter:HasPet()
    return UnitExists("pet") and not UnitIsDead("pet")
end

function MyHunter:GetPetHealth()
    if not self:HasPet() then
        return 0
    end
    local currentHP = UnitHealth("pet")
    local maxHP = UnitHealthMax("pet")
    if maxHP > 0 then
        return (currentHP / maxHP) * 100
    end
    return 0
end

function MyHunter:HasAspect(aspectName)
    for i=1,40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if name then
            if aspectName and string.find(name, aspectName) then
                return true, name
            elseif not aspectName and string.find(name, "Aspect") then
                return true, name
            end
        else
            break
        end
    end
    return false, nil
end

function MyHunter:GetCurrentSpecModule()
    local selectedSpec = self:GetOption("selectedSpec", "BeastMastery")

    if selectedSpec == "BeastMastery" and self:IsModuleReady("BeastMastery") then
        return self:GetModuleSafe("BeastMastery")
    elseif selectedSpec == "Marksmanship" and self:IsModuleReady("Marksman") then
        return self:GetModuleSafe("Marksman")
    elseif selectedSpec == "Survival" and self:IsModuleReady("Survival") then
        return self:GetModuleSafe("Survival")
    end

    if self:IsModuleReady("BeastMastery") then
        return self:GetModuleSafe("BeastMastery")
    elseif self:IsModuleReady("Marksman") then
        return self:GetModuleSafe("Marksman")
    elseif self:IsModuleReady("Survival") then
        return self:GetModuleSafe("Survival")
    end

    return nil
end

function MyHunter:GetCurrentSpecName()
    local specModule = self:GetCurrentSpecModule()
    if specModule and specModule.specName then
        return specModule.specName
    end

    local selectedSpec = self:GetOption("selectedSpec", "BeastMastery")
    return selectedSpec
end

-- ===================================================
-- FONCTIONS SPÉCIFIQUES HUNTER
-- ===================================================

function MyHunter:UseFrameworkConsumables()
    if not self:GetOption("useHunterConsumables", true) then
        return false
    end

    if EmzTools and EmzTools.Data and EmzTools.Data.Consumables then
        local hpPercent = UnitHealth("player") / UnitHealthMax("player") * 100
        if hpPercent < 50 then
            return EmzTools.Data.Consumables:Rest()
        end
    end
    return false
end

function MyHunter:UseFrameworkPotions()
    if not self:GetOption("useHunterPotions", true) then
        return false
    end

    if EmzTools and EmzTools.Data and EmzTools.Data.Potions then
        local hpPercent = UnitHealth("player") / UnitHealthMax("player") * 100
        if hpPercent < 30 then
            return EmzTools.Data.Potions:SmartHeal()
        end
    end
    return false
end

-- ===================================================
-- GESTION AUTOMATIQUE NOURRITURE/EAUE
-- ===================================================

function MyHunter:AutoEatDrink()
    if not self:GetOption("autoEatDrink", true) then
        return false
    end

    if not EmzTools or not EmzTools.Data or not EmzTools.Data.Consumables then
        return false
    end

    local inCombat = UnitAffectingCombat("player")
    local isSitting = UnitIsSitting("player")
    local hpPercent = (UnitHealth("player") / UnitHealthMax("player")) * 100
    local manaPercent = (UnitMana("player") / UnitManaMax("player")) * 100
    local hasMana = UnitManaMax("player") > 0

    if self:GetOption("restOutOfCombatOnly", true) and inCombat then
        return false
    end

    local needHP = hpPercent < self:GetOption("autoEatDrinkHPThreshold", 70)
    local needMana = hasMana and manaPercent < self:GetOption("autoEatDrinkMPThreshold", 50)

    if not needHP and not needMana then
        return false
    end

    if self:GetOption("autoSitToRest", true) and not isSitting and not inCombat then
        SitOrStand()
        return true
    end

    if isSitting or not self:GetOption("autoSitToRest", true) then
        return EmzTools.Data.Consumables:Rest()
    end

    return false
end

-- ===================================================
-- GESTION AUTOMATIQUE DES POTIONS
-- ===================================================

function MyHunter:AutoUsePotions()
    if not self:GetOption("autoUsePotions", true) then
        return false
    end

    if not EmzTools or not EmzTools.Data or not EmzTools.Data.Potions then
        return false
    end

    local inCombat = UnitAffectingCombat("player")
    local hpPercent = (UnitHealth("player") / UnitHealthMax("player")) * 100
    local manaPercent = (UnitMana("player") / UnitManaMax("player")) * 100
    local hasMana = UnitManaMax("player") > 0

    if not self:GetOption("usePotionsInCombat", true) and inCombat then
        return false
    end

    local needEmergencyHP = hpPercent < self:GetOption("autoHealthPotionThreshold", 30)
    local needEmergencyMana = hasMana and manaPercent < self:GetOption("autoManaPotionThreshold", 20)

    if not needEmergencyHP and not needEmergencyMana then
        return false
    end

    if needEmergencyHP then
        if self:GetOption("useHealthstones", true) then
            if EmzTools.Data.Potions:UseHealthstone() then
                return true
            end
        end

        if EmzTools.Data.Potions:UseHealthPotion() then
            return true
        end
    end

    if needEmergencyMana then
        if EmzTools.Data.Potions:UseManaPotion() then
            return true
        end
    end

    return false
end

function MyHunter:AutoAspect()
    if not self:GetOption("autoAspect", true) then
        return
    end

    local inCombat = self:InCombat()
    local hasAspect, currentAspect = self:HasAspect()

    if inCombat and (not hasAspect or currentAspect == "Aspect of the Cheetah" or currentAspect == "Aspect of the Pack") then
        if not string.find(currentAspect or "", "Hawk") then
            self:CastAspect("Hawk")
        end
    elseif not inCombat and (not hasAspect or currentAspect == "Aspect of the Hawk") then
        if not string.find(currentAspect or "", "Cheetah") then
            self:CastAspect("Cheetah")
        end
    end
end

function MyHunter:AutoStings()
    local stingsModule = self:GetModuleSafe("Stings")
    if stingsModule and stingsModule.AutoStingRotation then
        stingsModule:AutoStingRotation()
    end
end

function MyHunter:CastAspect(aspectType)
    local aspectSpells = {
        Hawk = "Aspect of the Hawk",
        Cheetah = "Aspect of the Cheetah",
        Monkey = "Aspect of the Monkey",
        Beast = "Aspect of the Beast",
        Pack = "Aspect of the Pack",
        Wild = "Aspect of the Wild"
    }

    local spellName = aspectSpells[aspectType]
    if spellName then
        CastSpellByName(spellName)
        self.state.activeAspect = spellName
    end
end

function MyHunter:AutoPetHeal()
    if not self:GetOption("autoPet", true) or not self:HasPet() then
        return
    end

    local petHealth = self:GetPetHealth()
    local healThreshold = self:GetOption("petHealThreshold", 70)

    if petHealth < healThreshold then
        CastSpellByName("Mend Pet")
    end
end

-- ===================================================
-- BOUCLE PRINCIPALE DE MISE À JOUR
-- ===================================================
function MyHunter:OnUpdate(elapsed)
    if not self:IsReady() then
        return
    end

    self:AutoAspect()
    self:AutoPetHeal()
    self:AutoStings()
    self:AutoEatDrink()
    self:AutoUsePotions()

    if self.Combat and self.Combat.Logic then
        self.Combat:Logic()
    end

    if self.RotationDisplay and self.RotationDisplay.Update then
        self.RotationDisplay:Update()
    end
end

-- ===================================================
-- SYSTÈME DE PLUGINS
-- ===================================================
MyHunter.plugins = {
    {
        name = "EMZTOOLS_MYHUNTER_PLUGIN_ASPECTS",
        key = "aspects",
        description = "EMZTOOLS_MYHUNTER_PLUGIN_ASPECTS_DESC",
        enabled = true,
        module = "Aspects"
    },
    {
        name = "EMZTOOLS_MYHUNTER_PLUGIN_PET",
        key = "pet",
        description = "EMZTOOLS_MYHUNTER_PLUGIN_PET_DESC",
        enabled = true,
        module = "Pet"
    },
    {
        name = "EMZTOOLS_MYHUNTER_PLUGIN_STINGS",
        key = "stings",
        description = "EMZTOOLS_MYHUNTER_PLUGIN_STINGS_DESC",
        enabled = true,
        module = "Stings"
    },
    {
        name = "EMZTOOLS_MYHUNTER_PLUGIN_ROTATION",
        key = "rotation",
        description = "EMZTOOLS_MYHUNTER_PLUGIN_ROTATION_DESC",
        enabled = true,
        module = "Rotation"
    },
}

function MyHunter:IsPluginEnabled(pluginKey)
    return self:GetOption(pluginKey .. "_enabled", true)
end

function MyHunter:SetPluginEnabled(pluginKey, enabled)
    return self:SetOption(pluginKey .. "_enabled", enabled)
end

-- ===================================================
-- GESTIONNAIRE DE COMMANDES SLASH
-- ===================================================
function MyHunter:SlashCommandHandler(msg)
    local command = string.lower(strtrim(msg))

    if command == "" or command == "config" or command == "ui" then
        self:ToggleConfig()

    elseif command == "toggle" then
        local newState = not self:GetOption("enabled", true)
        self:SetOption("enabled", newState)
        local statusKey = newState and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED"
        EmzTools:Print(statusKey, newState and "success" or "warning", "MyHunter")

    elseif command == "status" then
        self:PrintStatus()

    elseif command == "display" then
        self:ToggleRotationDisplay()

    elseif command == "aspect" then
        self:AspectCommands(command)

    elseif command == "pet" then
        self:PetCommands(command)

    elseif command == "spec" then
        self:SpecCommands(command)

    elseif command == "stings" then
        self:StingsCommands(command)

    elseif command == "rotation" then
        self:RotationCommands(command)

    elseif command == "help" then
        self:PrintHelp()

    else
        EmzTools:Print("EMZTOOLS_STATE_UNKNOW_COMMAND", "warning")
        self:PrintHelp()
    end
end

-- ===================================================
-- FONCTIONS DE COMMANDES
-- ===================================================

function MyHunter:ToggleConfig()
    if EmzTools and EmzTools.Data and EmzTools.Data.UI then
        EmzTools.Data.UI:ShowMainConfig()
    else
        self:PrintStatus()
    end
end

function MyHunter:ToggleRotationDisplay()
    local current = self:GetOption("showRotationDisplay", true)
    self:SetOption("showRotationDisplay", not current)
    local status = not current and "EMZTOOLS_STATE_SHOW" or "EMZTOOLS_STATE_HIDDEN"
    EmzTools:Print(status, "info")
end

function MyHunter:AspectCommands(cmd)
    if cmd == "hawk" then
        self:CastAspect("Hawk")
    elseif cmd == "cheetah" then
        self:CastAspect("Cheetah")
    elseif cmd == "monkey" then
        self:CastAspect("Monkey")
    else
        local hasAspect, currentAspect = self:HasAspect()
        if hasAspect then
            EmzTools:Print("EMZTOOLS_MYHUNTER_CURRENT_ASPECT", "info", currentAspect)
        else
            EmzTools:Print("EMZTOOLS_MYHUNTER_NO_ASPECT", "info")
        end
    end
end

function MyHunter:PetCommands(cmd)
    if cmd == "heal" then
        self:AutoPetHeal()
    elseif cmd == "call" then
        CastSpellByName("Call Pet")
    elseif cmd == "dismiss" then
        CastSpellByName("Dismiss Pet")
    else
        if self:HasPet() then
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_STATUS", "info", math.floor(self:GetPetHealth()))
        else
            EmzTools:Print("EMZTOOLS_MYHUNTER_NO_PET", "info")
        end
    end
end

function MyHunter:SpecCommands(cmd)
    if cmd == "beast" or cmd == "bm" then
        self:SetOption("selectedSpec", "BeastMastery")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_BEAST", "success")
    elseif cmd == "marks" or cmd == "mm" then
        self:SetOption("selectedSpec", "Marksmanship")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_MARKSMAN", "success")
    elseif cmd == "surv" or cmd == "sv" then
        self:SetOption("selectedSpec", "Survival")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPEC_SURVIVAL", "success")
    else
        local currentSpec = self:GetOption("selectedSpec", "BeastMastery")
        EmzTools:Print("EMZTOOLS_MYHUNTER_CURRENT_SPEC", "info", currentSpec)
    end
end

function MyHunter:StingsCommands(cmd)
    local stingsModule = self:GetModuleSafe("Stings")
    if stingsModule and stingsModule.SlashCommandHandler then
        stingsModule:SlashCommandHandler(cmd)
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_NOT_LOADED", "warning")
    end
end

function MyHunter:RotationCommands(cmd)
    if cmd == "start" then
        EmzTools:Print("EMZTOOLS_MYHUNTER_ROTATION_STARTED", "success")
    elseif cmd == "stop" then
        EmzTools:Print("EMZTOOLS_MYHUNTER_ROTATION_STOPPED", "warning")
    elseif cmd == "pause" then
        EmzTools:Print("EMZTOOLS_MYHUNTER_ROTATION_PAUSED", "info")
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_ROTATION_STATUS", "info")
    end
end

function MyHunter:PrintStatus()
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_HEADER", "info")

    local enabledStatus = self:GetOption("enabled", true) and
        "|cFF00FF00" .. "EMZTOOLS_STATE_ENABLED" .. "|r" or
        "|cFFFF0000" .. "EMZTOOLS_STATE_DISABLED" .. "|r"

    local combatStatus = self:InCombat() and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO"
    local petStatus = self:HasPet() and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO"
    local aspectStatus = self.state.activeAspect or "EMZTOOLS_STATE_NONE"

    EmzTools:Print("EMZTOOLS_STATE_STATUS: " .. enabledStatus, "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_CLASS: " .. (self:IsHunter() and "Hunter" or "NOT Hunter"), "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_COMBAT: " .. combatStatus, "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_PET: " .. petStatus .. (self:HasPet() and " (" .. math.floor(self:GetPetHealth()) .. "%)" or ""), "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_ASPECT: " .. aspectStatus, "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STATUS_SPEC: " .. self:GetOption("selectedSpec", "BeastMastery"), "noPrefix")
end

function MyHunter:PrintHelp()
    EmzTools:Print("EMZTOOLS_MYHUNTER_HELP_HEADER", "info")
    EmzTools:Print("/emz myhunter - EMZTOOLS_MYHUNTER_HELP_OPEN_UI", "noPrefix")
    EmzTools:Print("/emz myhunter toggle - EMZTOOLS_MYHUNTER_HELP_TOGGLE", "noPrefix")
    EmzTools:Print("/emz myhunter status - EMZTOOLS_MYHUNTER_HELP_STATUS", "noPrefix")
    EmzTools:Print("/emz myhunter display - EMZTOOLS_MYHUNTER_HELP_DISPLAY", "noPrefix")
    EmzTools:Print("/emz myhunter aspect - EMZTOOLS_MYHUNTER_HELP_ASPECT", "noPrefix")
    EmzTools:Print("/emz myhunter pet - EMZTOOLS_MYHUNTER_HELP_PET", "noPrefix")
    EmzTools:Print("/emz myhunter spec - EMZTOOLS_MYHUNTER_HELP_SPEC", "noPrefix")
    EmzTools:Print("/emz myhunter stings - EMZTOOLS_MYHUNTER_HELP_STINGS", "noPrefix")
    EmzTools:Print("/emz myhunter rotation - EMZTOOLS_MYHUNTER_HELP_ROTATION", "noPrefix")
    EmzTools:Print("/emz myhunter help - EMZTOOLS_MYHUNTER_HELP_HELP", "noPrefix")
end

-- ===================================================
-- CONFIGURATION DE LA FRAME
-- ===================================================
if not MyHunterFrame then
    MyHunterFrame = CreateFrame("Frame")
end

MyHunterFrame:SetScript("OnUpdate", function(self, elapsed)
    MyHunter:OnUpdate(elapsed)
end)

-- ===================================================
-- ENREGISTREMENT DU PLUGIN EMZTOOLS
-- ===================================================
if EmzTools and EmzTools.RegisterPlugin then
    EmzTools:RegisterPlugin("MyHunter", MyHunter)
end

EmzTools:Print("EMZTOOLS_MYHUNTER_CORE_INITIALIZED", "debug")
