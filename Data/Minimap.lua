-- ===================================================
-- EmzTools - Data/Minimap.lua
-- Bouton de minimap pour EmzTools
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Module principal Minimap DANS Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Minimap = {}

-- ===================================================
-- Initialise le module Minimap
-- @return: boolean - true si initialisation réussie
-- ===================================================

function EmzTools.Data.Minimap:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Minimap")
    return true
end

-------------------------------------------------
-- Fonction pour charger les locales externes
-------------------------------------------------

function EmzTools.Data.Minimap:LoadExternalLocales()
    -- Vérifier si la table globale existe
    if not EmzTools.Locales then
        return
    end

    -- Copier toutes les locales depuis la table globale
    for lang, localeTable in pairs(EmzTools.Locales) do
        if type(localeTable) == "table" then
            EmzTools.Data.Minimap.Locales[lang] = localeTable
        end
    end
end

-------------------------------------------------
-- Fonction pour définir la langue
-------------------------------------------------

function EmzTools.Data.Minimap:SetLanguage(lang)
    -- Charger toutes les locales d'abord
    EmzTools.Data.Minimap:LoadExternalLocales()

    -- Vérifier si la langue cible existe
    if not EmzTools.Data.Minimap.Locales[targetLang] then
        targetLang = "enUS"
    end

    -- Créer une nouvelle table pour EmzTools.L
    local newLocale = {}
    for key, value in pairs(EmzTools.Data.Minimap.Locales[targetLang]) do
        newLocale[key] = value
    end

    -- S'assurer d'avoir toutes les clés
    for key, value in pairs(EmzTools.Data.Minimap.Locales["enUS"]) do
        if not newLocale[key] then
            newLocale[key] = value
        end
    end

    -- Remplacer EmzTools.L
    EmzTools.Data.Minimap.L = newLocale

    -- Sauvegarder la configuration
    EmzTools.Data.Minimap.language = lang
    EmzTools.Data.Minimap_Config.language = lang

    -- Message de confirmation
    local langNames = {
        ["AUTO"] = "|cFF00CCFF" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_AUTO") .. "|r",
        ["enUS"] = "|cFFFF9900" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_EN") .. "|r",
        ["frFR"] = "|cFF00FF00" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_FR") .. "|r",
        ["deDE"] = "|cFFFF0000" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_DE") .. "|r",
        ["esES"] = "|cFFFFFF00" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_ES") .. "|r",
        ["itIT"] = "|cFF00FFFF" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_IT") .. "|r",
        ["ptBR"] = "|cFFFF00FF" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_PT") .. "|r",
        ["ruRU"] = "|cFFCC0000" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_RU") .. "|r"
    }

    DEFAULT_CHAT_FRAME:AddMessage("|cFF00CCFF" .. EmzTools.addonName .. ":|r " ..
        EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_SET") .. " " ..
        (langNames[lang] or lang))
end

-------------------------------------------------
-- Menu déroulant des langues
-------------------------------------------------

local function ShowLanguageMenu()
    -- Vérifier si le menu existe déjà, sinon le créer
    if not _G["EmzToolsLanguageMenu"] then
        CreateFrame("Frame", "EmzToolsLanguageMenu", UIParent, "UIDropDownMenuTemplate")
    end

    -- Fermer tout menu existant
    CloseDropDownMenus()

    -- Liste des langues
    local languageList = {
        {text = "|cFFFF9900" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_EN") .. "|r", value = "enUS"},
        {text = "|cFF00FF00" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_FR") .. "|r", value = "frFR"},
        {text = "|cFFFF0000" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_DE") .. "|r", value = "deDE"},
        {text = "|cFFFFFF00" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_ES") .. "|r", value = "esES"},
        {text = "|cFF00FFFF" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_IT") .. "|r", value = "itIT"},
        {text = "|cFFFF00FF" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_PT") .. "|r", value = "ptBR"},
        {text = "|cFFCC0000" .. EmzTools:GetText("EMZTOOLS_MINIMAP_LANG_RU") .. "|r", value = "ruRU"}
    }

    -- Initialiser le menu
    UIDropDownMenu_Initialize(_G["EmzToolsLanguageMenu"], function()
        for i = 1, 8 do
            local lang = languageList[i]
            local info = UIDropDownMenu_CreateInfo()
            info.text = lang.text
            info.value = lang.value
            info.func = function()
                EmzTools.Data.Minimap:SetLanguage(lang.value)
            end
            info.checked = (EmzTools.Data.Minimap.language == lang.value)
            info.notCheckable = false
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Afficher le menu
    ToggleDropDownMenu(1, nil, _G["EmzToolsLanguageMenu"], "cursor", 0, 0)
end

-- ===================================================
-- CRÉATION DU BOUTON MINIMAP
-- ===================================================

function EmzTools.Data.Minimap:CreateButton()
    -- D'abord détruire l'ancien bouton s'il existe
    if EmzToolsMinimapButton then
        EmzToolsMinimapButton:Hide()
        EmzToolsMinimapButton = nil
    end

    if self.minimapButton then return end

    -- Création de la frame
    local button = CreateFrame("Button", "EmzToolsMinimapButton", Minimap)
    button:SetWidth(40)
    button:SetHeight(40)
    button:SetFrameStrata("MEDIUM")

    -- IMPORTANT: Ne pas utiliser SetPoint fixe, laisser pfUI gérer la position
    -- Si pfUI n'est pas présent, utiliser une position par défaut
    if not (pfUI and pfUI.minimap) then
        button:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 10, -75)
    end

    -- Cercle doré autour de l'image
    button.goldCircle = button:CreateTexture(nil, "ARTWORK")
    button.goldCircle:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    button.goldCircle:SetWidth(32)
    button.goldCircle:SetHeight(32)
    button.goldCircle:SetPoint("CENTER", 0, -3)
    button.goldCircle:SetTexCoord(0, 0.6, 0, 0.6)

    -- Icône personnalisée
    button.icon = button:CreateTexture(nil, "BACKGROUND")
    button.icon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\Icon\\EmzTools")
    button.icon:SetWidth(20)
    button.icon:SetHeight(20)
    button.icon:SetPoint("CENTER", 0, -4)
    button.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

    -- Highlight au survol
    button.highlight = button:CreateTexture(nil, "HIGHLIGHT")
    button.highlight:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
    button.highlight:SetWidth(32)
    button.highlight:SetHeight(32)
    button.highlight:SetPoint("CENTER", 0, -3)
    button.highlight:SetTexCoord(0, 0.6, 0, 0.6)
    button.highlight:SetBlendMode("ADD")

    -- Gestion du drag (pfUI ou normal)
    button:SetScript("OnDragStart", function()
        this:StartMoving()
        this.isMoving = true
    end)

    button:SetScript("OnDragStop", function()
        this:StopMovingOrSizing()
        this.isMoving = false
    end)

    -- Tooltip
    button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(this, "ANCHOR_LEFT")
        GameTooltip:SetText(EmzTools.addonName, 1, 1, 1)
        GameTooltip:AddLine(EmzTools:GetText("EMZTOOLS_MINIMAP_TOOLTIP_LEFT_CLICK"), 0.8, 0.8, 0.8)
        GameTooltip:AddLine(EmzTools:GetText("EMZTOOLS_MINIMAP_TOOLTIP_RIGHT_CLICK"), 0.8, 0.8, 0.8)
        GameTooltip:Show()
    end)

    button:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- Clic
    button:SetScript("OnClick", function()
        if arg1 == "RightButton" then
            ShowLanguageMenu()
        elseif arg1 == "LeftButton" then
            if EmzTools.Data and EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Toggle then
                EmzTools.Data.UIConfig:Toggle()
            elseif EmzTools.Data and EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Show then
                EmzTools.Data.UIConfig:Show()
            elseif EmzTools.OpenMainConfig then
                EmzTools:OpenMainConfig()
            elseif EmzTools.OpenConfig then
                EmzTools:OpenConfig()
            elseif SlashCmdList["EMZTOOLS"] then
                SlashCmdList["EMZTOOLS"]("config")
            end
        end
    end)

    -- ===================================================
    -- RESTAURATION DE LA POSITION
    -- ===================================================

    local savedPosition = nil

    if EmzTools.Data and EmzTools.Data.Database then
        savedPosition = EmzTools.Data.Database:Get("Minimap", "position")
    elseif EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.minimapButton
       and EmzToolsDB.core.minimapButton.position then
        savedPosition = EmzToolsDB.core.minimapButton.position
    end

    if savedPosition then
        button:ClearAllPoints()
        button:SetPoint("CENTER", Minimap, "CENTER", savedPosition.x, savedPosition.y)
    else
        button:ClearAllPoints()
        button:SetPoint("CENTER", Minimap, "CENTER", 75, 75)
    end

    -- ===================================================
    -- VISIBILITÉ
    -- ===================================================

    function button:HideButton()
        self:Hide()
        if EmzTools.Data and EmzTools.Data.Database then
            EmzTools.Data.Database:Set("Minimap", "showMinimapButton", false)
        end
    end

    function button:ShowButton()
        self:Show()
        if EmzTools.Data and EmzTools.Data.Database then
            EmzTools.Data.Database:Set("Minimap", "showMinimapButton", true)
        end
    end

    function button:Toggle()
        if self:IsVisible() then
            self:HideButton()
        else
            self:ShowButton()
        end
    end

    -- ===================================================
    -- AFFICHAGE INITIAL
    -- ===================================================

    local shouldShow = true

    if EmzTools.Data and EmzTools.Data.Database then
        shouldShow = EmzTools.Data.Database:Get("Minimap", "showMinimapButton", true)
    end

    if shouldShow then
        button:Show()
    else
        button:Hide()
    end
end

-- ===================================================
-- INITIALISATION DU BOUTON
-- ===================================================

function EmzTools.Data.Minimap:InitializeButton()
    if not Minimap then return false end

    if self.minimapButton then
        self.minimapButton:Show()
        return true
    end

    self:CreateButton()
    return true
end

-- ===================================================
-- Réessaie d'initialiser le bouton minimap
-- ===================================================

function EmzTools.Data.Minimap:Retry()
    if not self.minimapButton or not self.minimapButton:IsShown() then
        self:InitializeButton()
    end
end

-- ===================================================
-- Force la création du bouton minimap
-- ===================================================

function EmzTools.Data.Minimap:ForceCreate()
    if not self.minimapButton then
        self:CreateButton()
        self.minimapButton:Show()
    end
end

-- ===================================================
-- DÉTECTION DE LA DISPONIBILITÉ DU JEU
-- ===================================================

EmzTools.readyFrame = CreateFrame("Frame")
EmzTools.readyFrame:RegisterEvent("PLAYER_LOGIN")

EmzTools.readyFrame:SetScript("OnEvent", function()
    -- 'this' est la frame dans Lua 5.0
    this:UnregisterEvent("PLAYER_LOGIN")

    if event == "PLAYER_LOGIN" then
        EmzTools.Minimap:InitializeButton()
    end
end)

-- ===================================================
-- COMPATIBILITÉ BIDIRECTIONNELLE
-- ===================================================

EmzTools.Minimap = EmzTools.Data.Minimap
