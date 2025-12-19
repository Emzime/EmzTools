-- ===================================================
-- EmzTools - Data/UIConfig.lua
-- Interface de configuration simplifiée - WoW 1.12 (Lua 5.0)
-- ===================================================

EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.UIConfig = {}

-- ===================================================
-- VARIABLES LOCALES
-- ===================================================

local mainFrame = nil
local tabButtons = {}
local tabContentFrames = {}
local currentTab = nil
local tabs = {}

-- ===================================================
-- CONSTANTES
-- ===================================================

local WINDOW_WIDTH = 750
local WINDOW_HEIGHT = 550
local TAB_AREA_WIDTH = 180

-- Thème par défaut (utilisé uniquement si pas de thème chargé)
local DEFAULT_THEME = {
    name = "Default",
    frame = {
        bgColor = {0.08, 0.08, 0.1, 0.95},
        borderColor = {0.15, 0.15, 0.2, 1}
    },
    card = {
        bgColor = {0.12, 0.12, 0.15, 0.95},
        borderColor = {0.2, 0.2, 0.25, 1},
        titleColor = {0.9, 0.9, 0.9, 1},
        descColor = {0.7, 0.7, 0.7, 1},
        labelColor = {0.9, 0.9, 0.9, 1}
    },
    header = {
        titleColor = {0.9, 0.9, 0.9, 1},
        subtitleColor = {0.7, 0.7, 0.7, 1}
    },
    button = {
        normalColor = {0.4, 0.4, 0.5, 1},
        highlightColor = {0.5, 0.5, 0.6, 1},
        pressedColor = {0.3, 0.3, 0.4, 1},
        disabledColor = {0.2, 0.2, 0.3, 1},
        textColor = {1, 1, 1, 1}
    }
}

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

local function tableSize(tbl)
    if not tbl then return 0 end
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

local function pairsCompat(tbl)
    local key = nil
    return function()
        local value
        key, value = next(tbl, key)
        return key, value
    end
end

local function CreateSolidTexture(parent, r, g, b, a)
    local tex = parent:CreateTexture(nil, "BACKGROUND")
    tex:SetAllPoints()
    tex:SetTexture(r, g, b, a or 1)
    return tex
end

-- Fonction pour appliquer une couleur à un texte
local function ApplyTextColor(textObject, color)
    if not textObject or not color then return end
    textObject:SetTextColor(color[1], color[2], color[3], color[4] or 1)
end

-- Fonction pour styliser un bouton avec le thème
local function StyleButton(button, themeData)
    if not button or not themeData then return end

    local buttonColors = themeData.button or DEFAULT_THEME.button

    -- Appliquer les textures avec les couleurs du thème
    button:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
    button:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
    button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")

    -- Teinter les textures avec les couleurs du thème
    local normalTex = button:GetNormalTexture()
    if normalTex then
        normalTex:SetVertexColor(
            buttonColors.normalColor[1],
            buttonColors.normalColor[2],
            buttonColors.normalColor[3],
            buttonColors.normalColor[4] or 1
        )
    end

    local pushedTex = button:GetPushedTexture()
    if pushedTex then
        pushedTex:SetVertexColor(
            buttonColors.pressedColor[1],
            buttonColors.pressedColor[2],
            buttonColors.pressedColor[3],
            buttonColors.pressedColor[4] or 1
        )
    end

    local highlightTex = button:GetHighlightTexture()
    if highlightTex then
        highlightTex:SetVertexColor(
            buttonColors.highlightColor[1],
            buttonColors.highlightColor[2],
            buttonColors.highlightColor[3],
            buttonColors.highlightColor[4] or 1
        )
    end

    -- Appliquer la couleur du texte
    local fontString = button:GetFontString()
    if fontString then
        ApplyTextColor(fontString, buttonColors.textColor or DEFAULT_THEME.button.textColor)
    end
end

-- ===================================================
-- FONCTIONS DE THÈME - CORRIGÉES
-- ===================================================

function EmzTools.Data.UIConfig:GetCurrentTheme()
    -- Récupérer le thème depuis la base de données - CORRIGÉ
    if EmzToolsDB and EmzToolsDB.modules and EmzToolsDB.modules.UIConfig then
        local settings = EmzToolsDB.modules.UIConfig.settings
        if settings and settings.currentTheme then
            return settings.currentTheme
        end
    end
    return "BlackWhite"  -- Thème par défaut
end

function EmzTools.Data.UIConfig:SetCurrentTheme(themeName)
    if not themeName then
        themeName = "BlackWhite"
    end

    -- Sauvegarder dans la base de données
    if not EmzToolsDB then
        EmzToolsDB = {
            core = {},
            modules = {}
        }
    end

    if not EmzToolsDB.modules then
        EmzToolsDB.modules = {}
    end

    if not EmzToolsDB.modules.UIConfig then
        EmzToolsDB.modules.UIConfig = {
            enabled = true,
            settings = {}
        }
    end

    -- Stocker directement dans settings
    EmzToolsDB.modules.UIConfig.settings.currentTheme = themeName

    -- Appliquer le thème immédiatement
    self:ApplyTheme(themeName)

    return themeName
end

function EmzTools.Data.UIConfig:GetThemeData(themeName)
    themeName = themeName or self:GetCurrentTheme()

    -- Vérifier si le module de thèmes est chargé
    if EmzTools.Data and EmzTools.Data.UI_Themes_Colors then
        local theme = EmzTools.Data.UI_Themes_Colors[themeName]
        if theme then
            return theme
        end
    end

    -- Fallback : thème par défaut simple
    return DEFAULT_THEME
end

function EmzTools.Data.UIConfig:GetAvailableThemes()
    local themes = {}

    if EmzTools.Data and EmzTools.Data.UI_Themes_Colors then
        for themeName, themeData in pairs(EmzTools.Data.UI_Themes_Colors) do
            if type(themeData) == "table" and themeData.name then
                table.insert(themes, themeName)
            end
        end
    else
        -- Fallback aux thèmes de base
        themes = {"BlackWhite", "Amber", "Sapphire", "Desert", "Emerald", "CrimsonGold"}
    end

    -- Trier par ordre alphabétique
    table.sort(themes)
    return themes
end

function EmzTools.Data.UIConfig:ApplyTheme(themeName)
    if not themeName then
        themeName = self:GetCurrentTheme()
    end

    local themeData = self:GetThemeData(themeName)

    -- Stocker le thème actuel
    self.currentThemeData = themeData

    -- Appliquer aux éléments UI
    self:ApplyThemeToWindow(themeData)
    self:ApplyThemeToTabs(themeData)
    self:ApplyThemeToButtons(themeData)
    self:ApplyThemeToLoadedTabs(themeData)
    self:UpdateTitleBarColor(themeData)

    EmzTools:Print("EMZTOOLS_UICONFIG_THEME_APPLIED" .. ": " .. themeName, "debug")
    return themeData
end

-- Applique le thème aux onglets déjà chargés
function EmzTools.Data.UIConfig:ApplyThemeToLoadedTabs(themeData)
    if not themeData then return end

    -- Appliquer aux onglets existants dans UIConfig
    for tabName, tabModule in pairsCompat(self) do
        if type(tabModule) == "table" and tabModule.controls then
            self:ApplyThemeToTabControls(tabModule.controls, themeData, tabName)
        end
    end

    -- Appliquer aux onglets spécifiques comme Potions, InfoBar
    if self.Potions and self.Potions.controls then
        self:ApplyThemeToTabControls(self.Potions.controls, themeData, "Potions")
    end

    if self.InfoBar and self.InfoBar.controls then
        self:ApplyThemeToTabControls(self.InfoBar.controls, themeData, "InfoBar")
    end
end

-- Applique le thème aux contrôles d'un onglet
function EmzTools.Data.UIConfig:ApplyTheme(themeName)
    if not themeName then
        themeName = self:GetCurrentTheme()
    end

    local themeData = self:GetThemeData(themeName)

    -- Stocker le thème actuel
    self.currentThemeData = themeData

    -- Appliquer aux éléments UI
    self:ApplyThemeToWindow(themeData)
    self:ApplyThemeToTabs(themeData)
    self:ApplyThemeToButtons(themeData)

    -- SIMPLE : Recréer l'interface si elle est ouverte
    if mainFrame and mainFrame:IsShown() and currentTab then
        local wasVisible = mainFrame:IsShown()
        local current = currentTab

        -- Recréer l'interface
        self:ReloadInterface()

        -- Réafficher
        if wasVisible then
            self:Show()
            self:ShowTab(current)  -- Rechargera l'onglet avec le nouveau thème
        end
    end

    EmzTools:Print("EMZTOOLS_UICONFIG_THEME_APPLIED" .. ": " .. themeName, "debug")
    return themeData
end

-- Fonction pour mettre à jour la couleur de la barre de titre
function EmzTools.Data.UIConfig:UpdateTitleBarColor(themeData)
    if not mainFrame then return end

    local titleBar = getglobal("EmzToolsUIConfig_TitleBar")
    if not titleBar then return end

    -- Calculer la couleur de la barre de titre
    local headerColor
    if themeData.header and themeData.header.bgColor then
        headerColor = themeData.header.bgColor
    else
        local bgColor = themeData.frame.bgColor or DEFAULT_THEME.frame.bgColor
        headerColor = {
            math.max(bgColor[1] - 0.05, 0),
            math.max(bgColor[2] - 0.05, 0),
            math.max(bgColor[3] - 0.05, 0),
            bgColor[4] or 1
        }
    end

    -- Mettre à jour la texture
    if titleBar.bgTexture then
        titleBar.bgTexture:SetTexture(
            headerColor[1],
            headerColor[2],
            headerColor[3],
            headerColor[4]
        )
    end

    -- Mettre à jour le texte du titre
    if titleBar.titleText then
        local titleColor = themeData.header.titleColor or DEFAULT_THEME.header.titleColor
        titleBar.titleText:SetTextColor(
            titleColor[1],
            titleColor[2],
            titleColor[3],
            titleColor[4] or 1
        )
    end
end

function EmzTools.Data.UIConfig:ApplyThemeToWindow(themeData)
    if not themeData then return end

    -- Appliquer à la fenêtre principale si elle existe
    if mainFrame then
        -- Couleur de fond principale
        local bgColor = themeData.frame.bgColor or DEFAULT_THEME.frame.bgColor

        -- CORRECTION SIMPLIFIÉE : Recréer simplement les textures
        local bgTex = mainFrame:GetRegions()
        if bgTex and bgTex:GetObjectType() == "Texture" then
            bgTex:SetTexture(bgColor[1], bgColor[2], bgColor[3], bgColor[4] or 1)
        end

        -- CORRECTION SIMPLIFIÉE : Mettre à jour la barre de titre
        local children = {mainFrame:GetChildren()}
        for i = 1, getn(children) do
            local child = children[i]
            if child and child:GetHeight() == 32 then -- Barre de titre
                local regions = {child:GetRegions()}
                for j = 1, getn(regions) do
                    local region = regions[j]
                    if region and region:GetObjectType() == "Texture" then
                        local titleBarColor = {
                            bgColor[1] - 0.05,
                            bgColor[2] - 0.05,
                            bgColor[3] - 0.05,
                            bgColor[4] or 1
                        }
                        if titleBarColor[1] < 0 then titleBarColor[1] = 0 end
                        if titleBarColor[2] < 0 then titleBarColor[2] = 0 end
                        if titleBarColor[3] < 0 then titleBarColor[3] = 0 end

                        region:SetTexture(
                            titleBarColor[1],
                            titleBarColor[2],
                            titleBarColor[3],
                            titleBarColor[4]
                        )
                    end
                end
            end
        end

        -- CORRECTION SIMPLIFIÉE : Mettre à jour les zones principales
        self:UpdateWindowColors(mainFrame, themeData)
    end
end

-- CORRECTION SIMPLIFIÉE : Version ultra simple pour Lua 5.0
function EmzTools.Data.UIConfig:UpdateWindowColors(frame, themeData)
    if not frame or not themeData then return end

    local cardColor = themeData.card.bgColor or DEFAULT_THEME.card.bgColor
    local frameColor = themeData.frame.bgColor or DEFAULT_THEME.frame.bgColor

    -- CORRECTION : Traitement simplifié sans tableaux complexes
    local i = 1
    local child = getglobal(frame:GetName() .. "Child" .. i)
    while child do
        if child:GetObjectType() == "Frame" then
            -- Zone d'onglets (gauche) - utiliser cardColor
            if child:GetWidth() == TAB_AREA_WIDTH then
                local j = 1
                local region = getglobal(child:GetName() .. "Region" .. j)
                while region do
                    if region:GetObjectType() == "Texture" then
                        region:SetTexture(cardColor[1], cardColor[2], cardColor[3], cardColor[4] or 1)
                    end
                    j = j + 1
                    region = getglobal(child:GetName() .. "Region" .. j)
                end
            -- Zone de contenu (droite) - utiliser frameColor
            else
                local j = 1
                local region = getglobal(child:GetName() .. "Region" .. j)
                while region do
                    if region:GetObjectType() == "Texture" then
                        region:SetTexture(frameColor[1], frameColor[2], frameColor[3], frameColor[4] or 1)
                    end
                    j = j + 1
                    region = getglobal(child:GetName() .. "Region" .. j)
                end
            end

            -- Récurrence sur les enfants
            self:UpdateWindowColors(child, themeData)
        end

        i = i + 1
        child = getglobal(frame:GetName() .. "Child" .. i)
    end
end

function EmzTools.Data.UIConfig:ApplyThemeToTabs(themeData)
    if not themeData then return end

    local activeColor = themeData.header.titleColor or DEFAULT_THEME.header.titleColor
    local inactiveColor = themeData.card.descColor or DEFAULT_THEME.card.descColor

    -- Mettre à jour tous les boutons d'onglets
    for tabName, button in pairsCompat(tabButtons) do
        if button and button.text then
            -- Détecter si c'est l'onglet actif
            local isActive = (currentTab == tabName)

            -- Mettre à jour la barre de sélection
            if button.selectionBar then
                if isActive then
                    button.selectionBar:Show()
                    local i = 1
                    local region = getglobal(button.selectionBar:GetName() .. "Region" .. i)
                    while region do
                        if region:GetObjectType() == "Texture" then
                            region:SetTexture(activeColor[1], activeColor[2], activeColor[3], 1)
                        end
                        i = i + 1
                        region = getglobal(button.selectionBar:GetName() .. "Region" .. i)
                    end
                else
                    button.selectionBar:Hide()
                end
            end

            -- Mettre à jour la couleur du texte
            if isActive then
                ApplyTextColor(button.text, activeColor)
            else
                ApplyTextColor(button.text, inactiveColor)
            end
        end
    end
end

function EmzTools.Data.UIConfig:ApplyThemeToButtons(themeData)
    if not themeData then return end

    -- Styliser tous les boutons dans l'interface
    self:StyleAllButtons(mainFrame, themeData)
end

function EmzTools.Data.UIConfig:StyleAllButtons(frame, themeData)
    if not frame then return end

    -- CORRECTION : Traitement simplifié sans tableaux
    local i = 1
    local child = getglobal(frame:GetName() .. "Child" .. i)
    while child do
        if child:GetObjectType() == "Button" then
            -- Éviter les boutons d'onglets (ils ont un traitement spécial)
            if not tabButtons[child] then
                StyleButton(child, themeData)
            end
        end

        -- Récurrence sur les enfants
        self:StyleAllButtons(child, themeData)

        i = i + 1
        child = getglobal(frame:GetName() .. "Child" .. i)
    end
end

-- ===================================================
-- INITIALISATION
-- ===================================================

function EmzTools.Data.UIConfig:Initialize()
    self:LoadAllTabs()

    -- Appliquer le thème actuel
    self:ApplyTheme()

    EmzTools:Print("EMZTOOLS_UICONFIG_INITIALIZED", "debug")
    return true
end

-- ===================================================
-- GESTION DES ONGLETS
-- ===================================================

EmzTools.Data.UIConfig.registeredTabs = {}

function EmzTools.Data.UIConfig:RegisterModuleTab(tabInfo)
    if not tabInfo or not tabInfo.name then
        return false
    end

    tabInfo.displayName = tabInfo.displayName or tabInfo.name
    tabInfo.description = tabInfo.description or EmzTools:GetText("EMZTOOLS_STATE_SETTINGS")
    tabInfo.icon = tabInfo.icon or "Interface\\Icons\\INV_Misc_QuestionMark"

    table.insert(self.registeredTabs, tabInfo)
    return true
end

function EmzTools.Data.UIConfig:LoadAllTabs()
    tabs = {}

    -- Ajouter les onglets enregistrés
    for i = 1, table.getn(self.registeredTabs) do
        local tabInfo = self.registeredTabs[i]
        if tabInfo then
            table.insert(tabs, tabInfo)
        end
    end
end

-- ===================================================
-- CRÉATION DE L'INTERFACE
-- ===================================================

function EmzTools.Data.UIConfig:CreateModernWindow()
    if mainFrame then return mainFrame end

    -- Obtenir le thème actuel
    local themeData = self:GetThemeData()
    local frameColor = themeData.frame.bgColor or DEFAULT_THEME.frame.bgColor
    local cardColor = themeData.card.bgColor or DEFAULT_THEME.card.bgColor
    local titleColor = themeData.header.titleColor or DEFAULT_THEME.header.titleColor
    local buttonColors = themeData.button or DEFAULT_THEME.button

    -- Calculer la couleur pour la barre de titre
    local titleBarColor
    if themeData.header and themeData.header.bgColor then
        titleBarColor = themeData.header.bgColor
    else
        -- Calcul automatique : un peu plus sombre que le fond
        titleBarColor = {
            math.max(frameColor[1] - 0.05, 0),
            math.max(frameColor[2] - 0.05, 0),
            math.max(frameColor[3] - 0.05, 0),
            frameColor[4] or 1
        }
    end

    -- Fenêtre principale
    mainFrame = CreateFrame("Frame", "EmzToolsUIConfig", UIParent)
    mainFrame:SetWidth(WINDOW_WIDTH)
    mainFrame:SetHeight(WINDOW_HEIGHT)
    mainFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    mainFrame:SetFrameStrata("DIALOG")
    mainFrame:SetToplevel(true)
    mainFrame:SetMovable(true)
    mainFrame:EnableMouse(true)
    mainFrame:RegisterForDrag("LeftButton")

    -- Fond principal avec thème
    mainFrame.bgTexture = CreateSolidTexture(mainFrame, frameColor[1], frameColor[2], frameColor[3], frameColor[4])

    -- Barre de titre
    local titleBar = CreateFrame("Frame", "EmzToolsUIConfig_TitleBar", mainFrame)
    titleBar:SetHeight(32)
    titleBar:SetPoint("TOPLEFT", mainFrame, "TOPLEFT", 2, -2)
    titleBar:SetPoint("TOPRIGHT", mainFrame, "TOPRIGHT", -2, -2)

    -- Stocker la texture de la barre de titre AVEC LA COULEUR DU THÈME
    local titleBarTex = CreateSolidTexture(titleBar, titleBarColor[1], titleBarColor[2], titleBarColor[3], titleBarColor[4])
    titleBar.bgTexture = titleBarTex  -- Stocker la référence

    -- Titre
    local title = titleBar:CreateFontString("EmzToolsUIConfig_Title", "OVERLAY", "GameFontNormal")
    title:SetPoint("LEFT", titleBar, "LEFT", 12, 0)
    title:SetText(EmzTools:GetText("EMZTOOLS_UICONFIG_TITLE"))
    ApplyTextColor(title, titleColor)

    -- Bouton fermer
    local closeBtn = CreateFrame("Button", "EmzToolsUIConfig_CloseBtn", titleBar)
    closeBtn:SetWidth(24)
    closeBtn:SetHeight(24)
    closeBtn:SetPoint("RIGHT", titleBar, "RIGHT", -8, 0)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    closeBtn:SetScript("OnClick", function() mainFrame:Hide() end)

    -- Teinter le bouton fermer
    local closeNormalTex = closeBtn:GetNormalTexture()
    if closeNormalTex then
        closeNormalTex:SetVertexColor(
            buttonColors.normalColor[1],
            buttonColors.normalColor[2],
            buttonColors.normalColor[3]
        )
    end

    -- Zone principale
    local mainArea = CreateFrame("Frame", "EmzToolsUIConfig_MainArea", mainFrame)
    mainArea:SetPoint("TOPLEFT", titleBar, "BOTTOMLEFT", 0, 0)
    mainArea:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", 0, 0)

    -- Zone des onglets (gauche)
    local tabArea = CreateFrame("Frame", "EmzToolsUIConfig_TabArea", mainArea)
    tabArea:SetWidth(TAB_AREA_WIDTH)
    tabArea:SetPoint("TOPLEFT", mainArea, "TOPLEFT", 0, 0)
    tabArea:SetPoint("BOTTOMLEFT", mainArea, "BOTTOMLEFT", 0, 0)
    local tabAreaTex = CreateSolidTexture(tabArea, cardColor[1], cardColor[2], cardColor[3], cardColor[4])

    -- Séparateur vertical
    local separator = tabArea:CreateTexture("EmzToolsUIConfig_Separator", "BORDER")
    separator:SetWidth(1)
    separator:SetPoint("TOPRIGHT", tabArea, "TOPRIGHT", 0, 0)
    separator:SetPoint("BOTTOMRIGHT", tabArea, "BOTTOMRIGHT", 0, 0)
    local borderColor = themeData.frame.borderColor or DEFAULT_THEME.frame.borderColor
    separator:SetTexture(borderColor[1], borderColor[2], borderColor[3], 0.8)

    -- Zone de contenu (droite)
    local contentArea = CreateFrame("Frame", "EmzToolsUIConfig_ContentArea", mainArea)
    contentArea:SetPoint("TOPLEFT", tabArea, "TOPRIGHT", 0, 0)
    contentArea:SetPoint("BOTTOMRIGHT", mainArea, "BOTTOMRIGHT", 0, 0)
    local contentAreaTex = CreateSolidTexture(contentArea, frameColor[1], frameColor[2], frameColor[3], frameColor[4])

    -- Stocker les textures pour les mettre à jour plus tard
    mainFrame.bgTexture = mainFrame:GetRegions()
    titleBar.bgTexture = titleBarTex
    tabArea.bgTexture = tabAreaTex
    contentArea.bgTexture = contentAreaTex

    -- Initialiser les onglets
    self:InitializeTabs(tabArea, contentArea)

    -- Drag & drop
    titleBar:EnableMouse(true)
    titleBar:RegisterForDrag("LeftButton")
    titleBar:SetScript("OnDragStart", function()
        mainFrame:StartMoving()
    end)
    titleBar:SetScript("OnDragStop", function()
        mainFrame:StopMovingOrSizing()
    end)

    mainFrame:Hide()
    return mainFrame
end

-- ===================================================
-- INITIALISATION DES ONGLETS
-- ===================================================

function EmzTools.Data.UIConfig:InitializeTabs(tabArea, contentArea)
    local yOffset = -15

    for i = 1, table.getn(tabs) do
        local tab = tabs[i]
        if tab then
            local button = self:CreateTabButton(tabArea, tab, yOffset, contentArea)
            yOffset = yOffset - 35
        end
    end
end

function EmzTools.Data.UIConfig:CreateTabButton(parent, tab, yPos, contentArea)
    local themeData = self:GetThemeData()
    local inactiveColor = themeData.card.descColor or DEFAULT_THEME.card.descColor
    local highlightColor = themeData.header.titleColor or DEFAULT_THEME.header.titleColor

    local buttonName = "EmzToolsUIConfig_Tab_" .. tab.name
    local button = CreateFrame("Button", buttonName, parent)
    button:SetWidth(170)
    button:SetHeight(30)
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", 5, yPos)

    -- Texte
    button.text = button:CreateFontString(buttonName .. "_Text", "OVERLAY", "GameFontNormal")
    button.text:SetPoint("LEFT", button, "LEFT", 10, 0)
    button.text:SetText(tab.displayName)
    ApplyTextColor(button.text, inactiveColor)

    -- Indicateur de sélection (barre à gauche)
    button.selectionBar = CreateFrame("Frame", buttonName .. "_SelectionBar", button)
    button.selectionBar:SetWidth(3)
    button.selectionBar:SetHeight(24)
    button.selectionBar:SetPoint("LEFT", button, "LEFT", 2, 0)
    button.selectionBar:Hide()

    local selectionTex = button.selectionBar:CreateTexture(buttonName .. "_SelectionTex", "OVERLAY")
    selectionTex:SetAllPoints()
    selectionTex:SetTexture(highlightColor[1], highlightColor[2], highlightColor[3], 1)

    -- Effet au survol
    button:SetScript("OnEnter", function()
        ApplyTextColor(button.text, highlightColor)
    end)

    button:SetScript("OnLeave", function()
        if not button.selectionBar:IsVisible() then
            ApplyTextColor(button.text, inactiveColor)
        end
    end)

    -- Créer le contenu
    local contentFrameName = "EmzToolsUIConfig_Content_" .. tab.name
    local contentFrame = CreateFrame("Frame", contentFrameName, contentArea)
    contentFrame:SetAllPoints(contentArea)
    contentFrame:Hide()

    -- Enregistrer
    tabButtons[tab.name] = button
    tabContentFrames[tab.name] = contentFrame

    -- Chargement différé
    contentFrame.loaded = false
    button:SetScript("OnClick", function()
        self:ShowTab(tab.name)
    end)

    contentFrame:SetScript("OnShow", function()
        if not this.loaded then
            self:LoadTabContent(tab.name, contentFrame)
            this.loaded = true
        end
    end)

    return button
end

-- ===================================================
-- GESTION DES ONGLETS ACTIFS
-- ===================================================

function EmzTools.Data.UIConfig:ShowTab(tabName)
    -- Cacher le contenu précédent
    if currentTab and tabContentFrames[currentTab] then
        tabContentFrames[currentTab]:Hide()
    end

    local themeData = self:GetThemeData()
    local activeColor = themeData.header.titleColor or DEFAULT_THEME.header.titleColor
    local inactiveColor = themeData.card.descColor or DEFAULT_THEME.card.descColor

    -- Désélectionner tous les onglets
    for name, button in pairsCompat(tabButtons) do
        if button then
            button.selectionBar:Hide()
            ApplyTextColor(button.text, inactiveColor)
        end
    end

    -- Sélectionner l'onglet actif
    if tabButtons[tabName] then
        local button = tabButtons[tabName]
        button.selectionBar:Show()
        ApplyTextColor(button.text, activeColor)
    end

    -- Afficher le nouveau contenu
    if tabContentFrames[tabName] then
        tabContentFrames[tabName]:Show()
    end

    currentTab = tabName
end

-- ===================================================
-- CHARGEMENT DU CONTENU
-- ===================================================

function EmzTools.Data.UIConfig:LoadTabContent(tabName, parentFrame)
    local module = EmzTools.Data.UIConfig[tabName]

    if module and module.CreateContent then
        module:CreateContent(parentFrame, -20)
    else
        self:CreateErrorContent(parentFrame, tabName)
    end
end

function EmzTools.Data.UIConfig:CreateErrorContent(parentFrame, tabName)
    local title = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", parentFrame, "TOP", 0, -50)
    title:SetText(tabName)
    title:SetTextColor(1, 0.5, 0.5)

    local errorText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    errorText:SetPoint("TOP", title, "BOTTOM", 0, -20)
    errorText:SetText(EmzTools:GetText("EMZTOOLS_UICONFIG_LOAD_ERROR"))
    errorText:SetTextColor(1, 0.3, 0.3)
end

-- ===================================================
-- FONCTIONS UTILITAIRES POUR LES ONGLETS
-- ===================================================

function EmzTools.Data.UIConfig:CreateCheckbox(parent, text, x, y, checked)
    local themeData = self:GetThemeData()
    local textColor = themeData.card.labelColor or DEFAULT_THEME.card.labelColor

    local checkButton = CreateFrame("CheckButton", nil, parent)
    checkButton:SetWidth(24)
    checkButton:SetHeight(24)
    checkButton:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    checkButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
    checkButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
    checkButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
    checkButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

    if checked then
        checkButton:SetChecked(1)
    else
        checkButton:SetChecked(nil)
    end

    local checkText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    checkText:SetPoint("LEFT", checkButton, "RIGHT", 6, 0)
    checkText:SetText(text)
    ApplyTextColor(checkText, textColor)

    return checkButton
end

function EmzTools.Data.UIConfig:CreateButton(parent, text, x, y, width, height)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetWidth(width)
    button:SetHeight(height)
    button:SetText(text)

    -- Styliser le bouton avec le thème actuel
    StyleButton(button, self:GetThemeData())

    return button
end

function EmzTools.Data.UIConfig:CreateStyledButton(parent, text, x, y, width, height, onClick)
    local button = self:CreateButton(parent, text, x, y, width, height)

    if onClick then
        button:SetScript("OnClick", onClick)
    end

    return button
end

-- ===================================================
-- FONCTIONS PRINCIPALES
-- ===================================================

function EmzTools.Data.UIConfig:Show()
    if not mainFrame then
        self:CreateModernWindow()
    end

    mainFrame:Show()

    if not currentTab then
        self:ShowTab("Core")
    end
end

function EmzTools.Data.UIConfig:Hide()
    if mainFrame then
        mainFrame:Hide()
    end
end

function EmzTools.Data.UIConfig:Toggle()
    if mainFrame and mainFrame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

-- ===================================================
-- FONCTIONS DE THÈME (compatibilité)
-- ===================================================

function EmzTools.Data.UIConfig:GetThemeDataCompat()
    return self:GetThemeData()
end

function EmzTools.Data.UIConfig:SetTheme(themeName)
    -- Alias pour compatibilité
    return self:SetCurrentTheme(themeName)
end

function EmzTools.Data.UIConfig:ShowThemeSelector()
    -- Fonction vide pour compatibilité
    EmzTools:Print("EMZTOOLS_UICONFIG_THEME_SELECTOR", "debug")
end

-- ===================================================
-- FONCTION DE RECHARGEMENT
-- ===================================================

function EmzTools.Data.UIConfig:ReloadInterface()
    if mainFrame then
        local wasVisible = mainFrame:IsShown()
        self:Hide()

        mainFrame = nil
        tabButtons = {}
        tabContentFrames = {}
        currentTab = nil

        if wasVisible then
            self:Show()
        end
    end
end

-- ===================================================
-- INITIALISATION DIFFÉRÉE
-- ===================================================

local function InitializeUIConfig()
    if EmzTools.Data.UIConfig and EmzTools.Data.UIConfig.Initialize then
        local success, err = pcall(function()
            EmzTools.Data.UIConfig:Initialize()
        end)
        if not success then
            EmzTools:Print("EMZTOOLS_UICONFIG_ERROR" .. ": " .. tostring(err), "error")
        end
    end
end

-- Initialiser après un délai
local waitFrame = CreateFrame("Frame")
waitFrame.timeElapsed = 0
waitFrame:SetScript("OnUpdate", function()
    this.timeElapsed = this.timeElapsed + arg1
    if this.timeElapsed > 2 then
        InitializeUIConfig()
        this:SetScript("OnUpdate", nil)
    end
end)

-- ===================================================
-- COMPATIBILITÉ
-- ===================================================

EmzTools.UIConfig = EmzTools.Data.UIConfig
