-- =======================================================================
-- EmzTools - Data/UI.lua - WoW Vanilla 1.12 Compatible
-- Description: Système d'interface utilisateur réutilisable
-- =======================================================================

-- Module principal UI
EmzTools.UI = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.UI:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "UI")
    return true
end

-- Créer le namespace
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.UI = EmzTools.Data.UI or {}

-- ===================================================
-- FONCTION D'AIDE INTERNE
-- ===================================================

-- Fonction sécurisée pour table.getn (compatibilité Lua 5.0)
local function TableSize(t)
    if not t then return 0 end
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

-- ===================================================
-- CONFIGURATION DES TEXTURES NATIVES WOW
-- ===================================================

-- Configuration standard pour tous les backdrops EmzTools
EmzTools.Data.UI.BackdropConfig = {
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
}

-- Configurations alternatives pour différents styles
EmzTools.Data.UI.BackdropConfigs = {
    dialog = {
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    },

    tooltip = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    },

    button = {
        bgFile = "Interface\\Buttons\\UI-Panel-Button-Up",
        edgeFile = "Interface\\Buttons\\UI-Panel-Button-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    },

    chat = {
        bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    }
}

-- Couleurs par défaut pour l'interface EmzTools
EmzTools.Data.UI.Colors = {
    backdrop = { r = 0, g = 0, b = 0, a = 0.8 },
    border = { r = 1, g = 1, b = 1, a = 1 },
    title = { r = 0.831, g = 0.686, b = 0.216, a = 1 },
    text = { r = 1, g = 1, b = 1, a = 1 },
    highlight = { r = 1, g = 0.82, b = 0, a = 1 },
    success = { r = 0, g = 1, b = 0, a = 1 },
    error = { r = 1, g = 0, b = 0, a = 1 },
    warning = { r = 1, g = 1, b = 0, a = 1 },
    info = { r = 0, g = 0.75, b = 1, a = 1 },
}

-- ===================================================
-- CRÉATION DE FRAMES AVEC BACKDROP STANDARD
-- ===================================================

-- Crée une frame avec backdrop standard EmzTools
function EmzTools.Data.UI:CreateFrame(name, parent, width, height, backdropType)
    local frame = CreateFrame("Frame", name, parent or UIParent)
    frame:SetWidth(width or 300)
    frame:SetHeight(height or 200)

    -- Sélectionner le backdrop approprié selon le type
    backdropType = backdropType or "dialog"
    local backdrop = self.BackdropConfigs[backdropType] or self.BackdropConfig

    -- Appliquer le backdrop standard EmzTools
    frame:SetBackdrop(backdrop)
    frame:SetBackdropColor(
        self.Colors.backdrop.r,
        self.Colors.backdrop.g,
        self.Colors.backdrop.b,
        self.Colors.backdrop.a
    )
    frame:SetBackdropBorderColor(
        self.Colors.border.r,
        self.Colors.border.g,
        self.Colors.border.b,
        self.Colors.border.a
    )

    -- Configuration standard pour tous les frames UI
    frame:SetFrameStrata("DIALOG")
    frame:EnableMouse(true)
    frame:SetMovable(true)
    frame:SetClampedToScreen(true)

    return frame
end

-- Crée un bouton avec le style EmzTools standard
function EmzTools.Data.UI:CreateButton(name, parent, text, width, height)
    local button = CreateFrame("Button", name, parent)

    button:SetWidth(width or 100)
    button:SetHeight(height or 24)

    -- Texture normale (utilise textures natives WoW)
    local normalTexture = button:CreateTexture()
    normalTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Up")
    normalTexture:SetAllPoints()
    button:SetNormalTexture(normalTexture)

    -- Texture pressée
    local pushedTexture = button:CreateTexture()
    pushedTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Down")
    pushedTexture:SetAllPoints()
    button:SetPushedTexture(pushedTexture)

    -- Texture de survol
    local highlightTexture = button:CreateTexture()
    highlightTexture:SetTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")
    highlightTexture:SetAllPoints()
    button:SetHighlightTexture(highlightTexture)

    -- Texte du bouton
    local buttonText = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    buttonText:SetPoint("CENTER", 0, 0)
    buttonText:SetText(text or "EMZTOOLS_UI_BUTTON_DEFAULT")
    button:SetFontString(buttonText)

    return button
end

-- Crée un champ de texte éditable avec style EmzTools
function EmzTools.Data.UI:CreateEditBox(name, parent, width, height)
    local editBox = CreateFrame("EditBox", name, parent, "InputBoxTemplate")

    editBox:SetWidth(width or 150)
    editBox:SetHeight(height or 24)
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(255)

    -- Style avec backdrop natif
    editBox:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })

    editBox:SetBackdropColor(0, 0, 0, 0.5)
    editBox:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

    return editBox
end

-- Crée une case à cocher avec template natif
function EmzTools.Data.UI:CreateCheckBox(name, parent, label)
    local checkBox = CreateFrame("CheckButton", name, parent, "OptionsCheckButtonTemplate")

    if label then
        -- Créer le texte du label
        local labelText = checkBox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        labelText:SetPoint("LEFT", checkBox, "RIGHT", 5, 0)
        labelText:SetText(label)
        checkBox.label = labelText
    end

    return checkBox
end

-- Crée un slider avec template natif
function EmzTools.Data.UI:CreateSlider(name, parent, minValue, maxValue, step)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")

    slider:SetMinMaxValues(minValue or 0, maxValue or 100)
    slider:SetValueStep(step or 1)
    slider:SetValue(minValue or 0)

    -- Ajouter les textes min/max
    local minText = slider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    minText:SetPoint("BOTTOMLEFT", slider, "BOTTOMLEFT", 0, -10)
    minText:SetText(tostring(minValue or 0))
    slider.minText = minText

    local maxText = slider:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    maxText:SetPoint("BOTTOMRIGHT", slider, "BOTTOMRIGHT", 0, -10)
    maxText:SetText(tostring(maxValue or 100))
    slider.maxText = maxText

    return slider
end

-- ===================================================
-- CRÉATION DE MENUS ET DROPDOWN
-- ===================================================

-- Crée un menu déroulant avec backdrop natif
function EmzTools.Data.UI:CreateDropDown(name, parent, items, width)
    local dropdown = CreateFrame("Frame", name, parent)
    dropdown:SetWidth(width or 150)
    dropdown:SetHeight(32)

    -- Créer le backdrop avec textures natives
    dropdown:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })

    dropdown:SetBackdropColor(0, 0, 0, 0.7)
    dropdown:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

    -- Texte affiché
    local text = dropdown:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    text:SetPoint("LEFT", dropdown, "LEFT", 8, 0)
    text:SetText(items and items[1] and items[1].text or "EMZTOOLS_UI_SELECT_DEFAULT")
    dropdown.text = text

    -- Bouton de dropdown avec texture native
    local button = CreateFrame("Button", nil, dropdown)
    button:SetWidth(16)
    button:SetHeight(16)
    button:SetPoint("RIGHT", dropdown, "RIGHT", -5, 0)

    -- Texture de flèche native WoW
    local arrow = button:CreateTexture(nil, "OVERLAY")
    arrow:SetAllPoints(button)
    arrow:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")

    -- Variables du dropdown
    dropdown.items = items or {}
    dropdown.selectedIndex = 1
    dropdown.selectedValue = items and items[1] and items[1].value or nil
    dropdown.isOpen = false

    -- Menu popup avec backdrop natif
    local menu = CreateFrame("Frame", name .. "Menu", dropdown)
    menu:SetPoint("TOPLEFT", dropdown, "BOTTOMLEFT", 0, -2)
    menu:SetPoint("TOPRIGHT", dropdown, "BOTTOMRIGHT", 0, -2)
    menu:SetHeight(math.min(200, TableSize(dropdown.items) * 20))
    menu:SetFrameStrata("FULLSCREEN")
    menu:Hide()
    dropdown.menu = menu

    -- Backdrop du menu avec textures natives
    menu:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })

    menu:SetBackdropColor(0, 0, 0, 0.9)
    menu:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

    -- Fonction pour mettre à jour les éléments
    dropdown.UpdateItems = function(self, newItems)
        self.items = newItems or {}
        -- Recréer les boutons du menu
        for i, item in pairs(self.items) do
            local itemButton = CreateFrame("Button", nil, self.menu)
            itemButton:SetWidth(self:GetWidth() - 10)
            itemButton:SetHeight(20)
            itemButton:SetPoint("TOPLEFT", self.menu, "TOPLEFT", 5, -(i-1) * 20 - 5)

            local itemText = itemButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            itemText:SetAllPoints(itemButton)
            itemText:SetJustifyH("LEFT")
            itemText:SetText(item.text)

            itemButton:SetScript("OnClick", function()
                self.selectedIndex = i
                self.selectedValue = item.value
                self.text:SetText(item.text)
                self.menu:Hide()
                self.isOpen = false

                if self.OnSelectionChanged then
                    self:OnSelectionChanged(item.value, item.text, i)
                end
            end)

            itemButton:SetScript("OnEnter", function()
                itemText:SetTextColor(1, 1, 0) -- Jaune au survol
            end)

            itemButton:SetScript("OnLeave", function()
                itemText:SetTextColor(1, 1, 1) -- Blanc normal
            end)
        end
    end

    -- Script pour ouvrir/fermer le menu
    button:SetScript("OnClick", function()
        if dropdown.isOpen then
            dropdown.menu:Hide()
            dropdown.isOpen = false
        else
            dropdown.menu:Show()
            dropdown.isOpen = true
        end
    end)

    -- Initialiser les éléments
    if items then
        dropdown:UpdateItems(items)
    end

    return dropdown
end

-- ===================================================
-- GESTION DES FENÊTRES
-- ===================================================

-- Rend une frame déplaçable par zone de drag
function EmzTools.Data.UI:MakeDraggable(frame, dragArea)
    local dragFrame = dragArea or frame

    dragFrame:EnableMouse(true)
    dragFrame:SetScript("OnMouseDown", function()
        frame:StartMoving()
    end)

    dragFrame:SetScript("OnMouseUp", function()
        frame:StopMovingOrSizing()
    end)
end

-- Ajoute une barre de titre avec texture native
function EmzTools.Data.UI:AddTitleBar(frame, title, height)
    local titleBar = CreateFrame("Frame", nil, frame)
    titleBar:SetHeight(height or 24)
    titleBar:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
    titleBar:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)

    -- Backdrop de la barre de titre avec texture native
    titleBar:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header",
        tile = true,
        tileSize = 32,
    })

    -- Texte du titre avec couleurs EmzTools
    local titleText = titleBar:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    titleText:SetPoint("CENTER", titleBar, "CENTER", 0, 0)
    titleText:SetText(title or "EmzTools")
    titleText:SetTextColor(
        self.Colors.title.r,
        self.Colors.title.g,
        self.Colors.title.b,
        self.Colors.title.a
    )

    titleBar.text = titleText

    -- Rendre la frame déplaçable par la barre de titre
    self:MakeDraggable(frame, titleBar)

    return titleBar
end

-- Ajoute un bouton de fermeture avec template natif
function EmzTools.Data.UI:AddCloseButton(frame, callback)
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    closeButton:SetScript("OnClick", function()
        frame:Hide()
        if callback then
            callback()
        end
    end)

    return closeButton
end

-- ===================================================
-- SYSTÈME D'ONGLETS AVEC BACKDROPS NATIFS
-- ===================================================

-- Crée un système d'onglets avec scroll vertical pour contenu débordant
function EmzTools.Data.UI:CreateTabSystem(name, parent, tabs)
    local tabSystem = CreateFrame("Frame", name, parent)
    tabSystem:SetAllPoints(parent)

    local tabHeight = 24
    local tabButtons = {}
    local tabContents = {}
    local activeTab = 1

    -- Créer les boutons d'onglets avec backdrop natif
    for i, tab in pairs(tabs or {}) do
        local tabButton = CreateFrame("Button", name .. "Tab" .. i, tabSystem)
        tabButton:SetWidth(100)
        tabButton:SetHeight(tabHeight)
        tabButton:SetPoint("TOPLEFT", tabSystem, "TOPLEFT", (i-1) * 100, 0)

        -- Backdrop pour l'onglet avec textures natives
        tabButton:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 3, right = 3, top = 3, bottom = 0 }
        })

        -- Texte de l'onglet
        local tabText = tabButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        tabText:SetAllPoints(tabButton)
        tabText:SetText(tab.title or tab.name or "EMZTOOLS_UI_TAB_DEFAULT")

        tabButton.text = tabText
        tabButton.index = i
        tabButtons[i] = tabButton

        -- Créer le contenu de l'onglet avec ScrollFrame
        local tabContent = CreateFrame("Frame", name .. "Content" .. i, tabSystem)
        tabContent:SetPoint("TOPLEFT", tabSystem, "TOPLEFT", 0, -tabHeight)
        tabContent:SetPoint("BOTTOMRIGHT", tabSystem, "BOTTOMRIGHT", 0, 0)

        -- Backdrop pour le contenu avec textures natives
        tabContent:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 32,
            insets = { left = 11, right = 12, top = 12, bottom = 11 }
        })

        tabContent:SetBackdropColor(0, 0, 0, 0.8)
        tabContent:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

        -- Créer le ScrollFrame pour le contenu défilant
        local scrollFrame = CreateFrame("ScrollFrame", name .. "Scroll" .. i, tabContent)
        scrollFrame:SetPoint("TOPLEFT", tabContent, "TOPLEFT", 12, -12)
        scrollFrame:SetPoint("BOTTOMRIGHT", tabContent, "BOTTOMRIGHT", -30, 12) -- Espace pour scrollbar

        -- Créer le contenu scrollable
        local scrollChild = CreateFrame("Frame", name .. "ScrollChild" .. i, scrollFrame)
        scrollChild:SetWidth(scrollFrame:GetWidth())
        scrollChild:SetHeight(400) -- Hauteur suffisante pour tout le contenu
        scrollFrame:SetScrollChild(scrollChild)

        -- Créer la scrollbar verticale
        local scrollBar = CreateFrame("Slider", name .. "ScrollBar" .. i, tabContent, "UIPanelScrollBarTemplate")
        scrollBar:SetPoint("TOPRIGHT", tabContent, "TOPRIGHT", -8, -16)
        scrollBar:SetPoint("BOTTOMRIGHT", tabContent, "BOTTOMRIGHT", -8, 16)
        scrollBar:SetMinMaxValues(0, 100)
        scrollBar:SetValueStep(1)
        scrollBar:SetValue(0)
        scrollBar:SetWidth(16)

        -- Configuration du scroll
        local function UpdateScrollBar()
            local maxScroll = math.max(0, scrollChild:GetHeight() - scrollFrame:GetHeight())
            if maxScroll > 0 then
                scrollBar:SetMinMaxValues(0, maxScroll)
                scrollBar:Show()
            else
                scrollBar:Hide()
            end
        end

        -- Scripts pour le scrolling
        scrollBar:SetScript("OnValueChanged", function(self, value)
            scrollFrame:SetVerticalScroll(value)
        end)

        -- Scroll avec la molette de souris
        scrollFrame:SetScript("OnMouseWheel", function(self, delta)
            local newValue = scrollBar:GetValue() - (delta * 20)
            newValue = math.max(0, math.min(scrollBar:GetMaxValue(), newValue))
            scrollBar:SetValue(newValue)
        end)
        scrollFrame:EnableMouseWheel(true)

        -- Stocker les références
        tabContent.scrollFrame = scrollFrame
        tabContent.scrollChild = scrollChild
        tabContent.scrollBar = scrollBar
        tabContent.UpdateScrollBar = UpdateScrollBar

        tabContents[i] = tabContent

        -- Script de clic pour l'onglet
        tabButton:SetScript("OnClick", function(self)
            tabSystem:SetActiveTab(self.index)
        end)

        -- Si le tab a du contenu prédéfini, l'ajouter au scrollChild
        if tab.content and type(tab.content) == "function" then
            tab.content(scrollChild) -- Utiliser scrollChild au lieu de tabContent
            -- Mettre à jour la scrollbar après création du contenu
            scrollChild:SetScript("OnShow", function()
                UpdateScrollBar()
            end)
        end
    end

    -- Fonction pour changer d'onglet actif
    tabSystem.SetActiveTab = function(self, index)
        if index < 1 or index > TableSize(tabs) then
            return
        end

        activeTab = index

        -- Mettre à jour l'apparence des onglets
        for i, button in pairs(tabButtons) do
            if i == activeTab then
                button:SetBackdropColor(0.2, 0.2, 0.2, 1)
                button:SetBackdropBorderColor(1, 1, 1, 1)
                button.text:SetTextColor(1, 1, 1)
            else
                button:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
                button:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)
                button.text:SetTextColor(0.8, 0.8, 0.8)
            end
        end

        -- Afficher/masquer le contenu et mettre à jour les scrollbars
        for i, content in pairs(tabContents) do
            if i == activeTab then
                content:Show()
                if content.UpdateScrollBar then
                    content.UpdateScrollBar()
                end
            else
                content:Hide()
            end
        end
    end

    -- Fonction pour obtenir le contenu scrollable d'un onglet
    tabSystem.GetTabContent = function(self, index)
        local tabContent = tabContents[index]
        if tabContent and tabContent.scrollChild then
            return tabContent.scrollChild
        end
        return tabContent
    end

    -- Fonction pour ajouter un onglet dynamiquement
    tabSystem.AddTab = function(self, title, contentFunc)
        local newIndex = TableSize(self.tabs) + 1

        -- Créer un nouveau tableau d'onglets si nécessaire
        if not self.tabs then
            self.tabs = {}
        end

        table.insert(self.tabs, {title = title, content = contentFunc})

        -- Recréer les boutons d'onglets avec le nouvel onglet
        self:RecreateTabButtons()

        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print("Tab added: " .. title, "debug")
        end
    end

    -- Fonction pour recréer les boutons d'onglets
    tabSystem.RecreateTabButtons = function(self)
        -- Supprimer les anciens boutons
        for i, button in pairs(self.tabButtons or {}) do
            button:Hide()
            button:SetParent(nil)
        end

        self.tabButtons = {}
        self.tabContents = {}

        local tabHeight = 24

        -- Recréer tous les boutons d'onglets
        for i, tab in pairs(self.tabs or {}) do
            local tabButton = CreateFrame("Button", self:GetName() .. "Tab" .. i, self)
            tabButton:SetWidth(100)
            tabButton:SetHeight(tabHeight)
            tabButton:SetPoint("TOPLEFT", self, "TOPLEFT", (i-1) * 100, 0)

            -- Backdrop pour l'onglet avec textures natives
            tabButton:SetBackdrop({
                bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                tile = true,
                tileSize = 16,
                edgeSize = 16,
                insets = { left = 3, right = 3, top = 3, bottom = 0 }
            })

            -- Texte de l'onglet
            local tabText = tabButton:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            tabText:SetAllPoints(tabButton)
            tabText:SetText(tab.title or tab.name or "EMZTOOLS_UI_TAB_DEFAULT")

            tabButton.text = tabText
            tabButton.index = i
            self.tabButtons[i] = tabButton

            -- Créer le contenu de l'onglet avec ScrollFrame
            local tabContent = CreateFrame("Frame", self:GetName() .. "Content" .. i, self)
            tabContent:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -tabHeight)
            tabContent:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, 0)

            -- Backdrop pour le contenu avec textures natives
            tabContent:SetBackdrop({
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
                tile = true,
                tileSize = 32,
                edgeSize = 32,
                insets = { left = 11, right = 12, top = 12, bottom = 11 }
            })

            tabContent:SetBackdropColor(0, 0, 0, 0.8)
            tabContent:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

            -- Créer le ScrollFrame pour le contenu défilant
            local scrollFrame = CreateFrame("ScrollFrame", self:GetName() .. "Scroll" .. i, tabContent)
            scrollFrame:SetPoint("TOPLEFT", tabContent, "TOPLEFT", 12, -12)
            scrollFrame:SetPoint("BOTTOMRIGHT", tabContent, "BOTTOMRIGHT", -30, 12)

            -- Créer le contenu scrollable
            local scrollChild = CreateFrame("Frame", self:GetName() .. "ScrollChild" .. i, scrollFrame)
            scrollChild:SetWidth(scrollFrame:GetWidth())
            scrollChild:SetHeight(400)
            scrollFrame:SetScrollChild(scrollChild)

            -- Configuration du scroll
            local function UpdateScrollBar()
                local maxScroll = math.max(0, scrollChild:GetHeight() - scrollFrame:GetHeight())
                -- Implémentation simplifiée du scrollbar
            end

            -- Si le tab a du contenu prédéfini, l'ajouter au scrollChild
            if tab.content and type(tab.content) == "function" then
                tab.content(scrollChild)
            end

            self.tabContents[i] = tabContent

            -- Script de clic pour l'onglet
            tabButton:SetScript("OnClick", function(self)
                self:GetParent():SetActiveTab(self.index)
            end)
        end

        -- Réactiver l'onglet actuel
        if self.activeTab then
            self:SetActiveTab(self.activeTab)
        else
            self:SetActiveTab(1)
        end
    end

-- Fonction pour obtenir le contenu scrollable d'un onglet spécifique
function EmzTools.Data.UI:GetTabContent(tabSystem, tabName)
    if not tabSystem or not tabSystem.tabs then
        return nil
    end

    for i, tab in pairs(tabSystem.tabs) do
        if tab.title == tabName and tabSystem.tabContents[i] then
            local tabContent = tabSystem.tabContents[i]
            if tabContent.scrollChild then
                return tabContent.scrollChild
            end
            return tabContent
        end
    end

    return nil
end

-- ===================================================
-- UTILITAIRES DE POSITIONNEMENT
-- ===================================================

-- Centre une frame sur l'écran
function EmzTools.Data.UI:CenterFrame(frame)
    frame:ClearAllPoints()
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
end

-- Positionne une frame relative à une autre
function EmzTools.Data.UI:AnchorFrame(frame, relativeTo, point, relativePoint, x, y)
    frame:ClearAllPoints()
    frame:SetPoint(point or "CENTER", relativeTo, relativePoint or "CENTER", x or 0, y or 0)
end

-- Redimensionne une frame pour s'adapter à son contenu
function EmzTools.Data.UI:FitToContent(frame, padding)
    padding = padding or 10

    if not frame then
        EmzTools:Print("EMZTOOLS_UI_INVALID_FRAME_FOR_FIT", "debug")
        return
    end

    local minWidth, minHeight = 100, 50
    local maxWidth, maxHeight = 0, 0

    -- Parcourir tous les enfants de la frame pour calculer les dimensions
    local children = {frame:GetChildren()}
    for i, child in ipairs(children) do
        if child:IsVisible() then
            local childWidth = child:GetWidth()
            local childHeight = child:GetHeight()
            local childLeft = child:GetLeft() or 0
            local childTop = child:GetTop() or 0
            local childBottom = child:GetBottom() or 0
            local childRight = child:GetRight() or 0

            -- Calculer les dimensions nécessaires
            local frameLeft = frame:GetLeft() or 0
            local frameTop = frame:GetTop() or 0

            if childRight and frameLeft then
                local rightEdge = childRight - frameLeft
                if rightEdge > maxWidth then
                    maxWidth = rightEdge
                end
            end

            if frameTop and childBottom then
                local bottomEdge = frameTop - childBottom
                if bottomEdge > maxHeight then
                    maxHeight = bottomEdge
                end
            end
        end
    end

    -- Appliquer les nouvelles dimensions avec padding
    local newWidth = math.max(minWidth, maxWidth + padding * 2)
    local newHeight = math.max(minHeight, maxHeight + padding * 2)

    frame:SetWidth(newWidth)
    frame:SetHeight(newHeight)

    EmzTools:Print("EMZTOOLS_UI_FIT_TO_CONTENT_APPLIED", "debug", string.format("%.0fx%.0f", newWidth, newHeight))
end

-- ===================================================
-- GESTION DES COULEURS ET STYLES
-- ===================================================

-- Applique un thème de couleur à une frame
function EmzTools.Data.UI:ApplyTheme(frame, theme)
    theme = theme or "default"

    local themes = {
        default = {
            bg = {r = 0, g = 0, b = 0, a = 0.8},
            border = {r = 1, g = 1, b = 1, a = 1}
        },
        dark = {
            bg = {r = 0.1, g = 0.1, b = 0.1, a = 0.9},
            border = {r = 0.3, g = 0.3, b = 0.3, a = 1}
        },
        light = {
            bg = {r = 0.9, g = 0.9, b = 0.9, a = 0.8},
            border = {r = 0.6, g = 0.6, b = 0.6, a = 1}
        }
    }

    local selectedTheme = themes[theme] or themes.default

    if frame.SetBackdropColor then
        frame:SetBackdropColor(
            selectedTheme.bg.r,
            selectedTheme.bg.g,
            selectedTheme.bg.b,
            selectedTheme.bg.a
        )
    end

    if frame.SetBackdropBorderColor then
        frame:SetBackdropBorderColor(
            selectedTheme.border.r,
            selectedTheme.border.g,
            selectedTheme.border.b,
            selectedTheme.border.a
        )
    end
end

-- Convertit une couleur hexadécimale en RGB
function EmzTools.Data.UI:HexToRGB(hex)
    if not hex or string.len(hex) ~= 6 then
        return 1, 1, 1 -- Blanc par défaut
    end

    local r = tonumber(string.sub(hex, 1, 2), 16) / 255
    local g = tonumber(string.sub(hex, 3, 4), 16) / 255
    local b = tonumber(string.sub(hex, 5, 6), 16) / 255

    return r, g, b
end

-- Convertit RGB en couleur hexadécimale
function EmzTools.Data.UI:RGBToHex(r, g, b)
    r = math.floor((r or 0) * 255)
    g = math.floor((g or 0) * 255)
    b = math.floor((b or 0) * 255)

    return string.format("%02X%02X%02X", r, g, b)
end

-- ===================================================
-- ANIMATIONS ET EFFETS (Vanilla Compatible)
-- ===================================================

-- Fait apparaître une frame avec un effet de fondu
function EmzTools.Data.UI:FadeIn(frame, duration)
    duration = duration or 0.3

    frame:SetAlpha(0)
    frame:Show()

    -- Animation simple pour Vanilla (OnUpdate frame)
    local startTime = GetTime()
    local fadeFrame = CreateFrame("Frame")

    fadeFrame:SetScript("OnUpdate", function()
        local elapsed = GetTime() - startTime
        local progress = elapsed / duration

        if progress >= 1 then
            frame:SetAlpha(1)
            fadeFrame:SetScript("OnUpdate", nil)
            fadeFrame = nil
        else
            frame:SetAlpha(progress)
        end
    end)
end

-- Fait disparaître une frame avec un effet de fondu
function EmzTools.Data.UI:FadeOut(frame, duration, callback)
    duration = duration or 0.3

    local startTime = GetTime()
    local startAlpha = frame:GetAlpha()
    local fadeFrame = CreateFrame("Frame")

    fadeFrame:SetScript("OnUpdate", function()
        local elapsed = GetTime() - startTime
        local progress = elapsed / duration

        if progress >= 1 then
            frame:SetAlpha(0)
            frame:Hide()
            fadeFrame:SetScript("OnUpdate", nil)
            fadeFrame = nil

            if callback then
                callback()
            end
        else
            frame:SetAlpha(startAlpha * (1 - progress))
        end
    end)
end

-- ===================================================
-- TOOLTIPS ET AIDE
-- ===================================================

-- Ajoute un tooltip à un élément UI
function EmzTools.Data.UI:AddTooltip(element, title, text)
    element:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if title then
            GameTooltip:SetText(title, 1, 1, 1)
        end

        if text then
            GameTooltip:AddLine(text, nil, nil, nil, true)
        end

        GameTooltip:Show()
    end)

    element:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
end

-- ===================================================
-- GESTION DES ÉVÉNEMENTS UI
-- ===================================================

-- Ajoute un gestionnaire d'événement à un élément
function EmzTools.Data.UI:AddEventHandler(element, event, handler)
    if event == "click" then
        element:SetScript("OnClick", handler)
    elseif event == "enter" then
        element:SetScript("OnEnter", handler)
    elseif event == "leave" then
        element:SetScript("OnLeave", handler)
    elseif event == "show" then
        element:SetScript("OnShow", handler)
    elseif event == "hide" then
        element:SetScript("OnHide", handler)
    else
        EmzTools:Print("EMZTOOLS_UI_UNKNOWN_EVENT_TYPE", "debug", tostring(event))
    end
end

-- ===================================================
-- UTILITAIRES DE VALIDATION
-- ===================================================

-- Valide qu'un élément UI est bien formé
function EmzTools.Data.UI:ValidateElement(element)
    if not element then
        return false, "EMZTOOLS_UI_ELEMENT_IS_NIL"
    end

    if not element.GetObjectType then
        return false, "EMZTOOLS_UI_NOT_VALID_UI_OBJECT"
    end

    local objectType = element:GetObjectType()
    if not objectType then
        return false, "EMZTOOLS_UI_UNABLE_TO_DETERMINE_OBJECT_TYPE"
    end

    return true, "EMZTOOLS_UI_ELEMENT_IS_VALID"
end

-- ===================================================
-- NETTOYAGE ET MAINTENANCE
-- ===================================================

-- Nettoie les références UI et libère les ressources
function EmzTools.Data.UI:Cleanup()
    EmzTools:Print("EMZTOOLS_UI_CLEANUP_COMPLETED", "debug")
end

-- ===================================================
-- TEMPLATES ET PRESETS
-- ===================================================

-- Crée une fenêtre de configuration standard EmzTools
function EmzTools.Data.UI:CreateConfigWindow(name, title, width, height)
    local window = self:CreateFrame(name, UIParent, width or 400, height or 300)

    -- Barre de titre
    local titleBar = self:AddTitleBar(window, title or "EMZTOOLS_UI_DEFAULT_CONFIG_TITLE")

    -- Bouton de fermeture
    self:AddCloseButton(window)

    -- Centrer la fenêtre
    self:CenterFrame(window)

    -- Masquer par défaut
    window:Hide()

    return window
end

-- ===================================================
-- INTERFACE PRINCIPALE EMZTOOLS - SYSTÈME D'ONGLETS
-- ===================================================

local mainConfigFrame = nil
local isConfigVisible = false

-- Crée l'interface principale de configuration EmzTools
function EmzTools.Data.UI:CreateMainConfigInterface()
    if mainConfigFrame then
        return mainConfigFrame
    end

    EmzTools:Print("EMZTOOLS_UI_CREATING_CONFIG_INTERFACE", "debug")

    -- Frame principale de configuration
    mainConfigFrame = self:CreateConfigWindow("EmzToolsMainConfig", "EMZTOOLS_UI_MAIN_CONFIG_TITLE", 500, 400)

    -- Définir les onglets de configuration de base
    local tabs = {
        {name = "core", title = "EMZTOOLS_UI_TAB_CORE", content = function(parent) self:CreateCoreTab(parent) end},
        {name = "infobar", title = "EMZTOOLS_UI_TAB_INFOBAR", content = function(parent) self:CreateInfoBarTab(parent) end},
        {name = "consumables", title = "EMZTOOLS_UI_TAB_CONSUMABLES", content = function(parent) self:CreateConsumablesTab(parent) end},
        {name = "potions", title = "EMZTOOLS_UI_TAB_POTIONS", content = function(parent) self:CreatePotionsTab(parent) end},
        {name = "thresholds", title = "EMZTOOLS_UI_TAB_THRESHOLDS", content = function(parent) self:CreateThresholdsTab(parent) end},
        {name = "eventmanager", title = "EMZTOOLS_UI_TAB_EVENTMANAGER", content = function(parent) self:CreateEventManagerTab(parent) end},
        {name = "utils", title = "EMZTOOLS_UI_TAB_UTILS", content = function(parent) self:CreateUtilsTab(parent) end},
        {name = "database", title = "EMZTOOLS_UI_TAB_DATABASE", content = function(parent) self:CreateDatabaseTab(parent) end}
    }

    -- Créer le système d'onglets
    local tabSystem = self:CreateTabSystem("EmzToolsConfigTabs", mainConfigFrame, tabs)
    tabSystem:SetPoint("TOPLEFT", mainConfigFrame, "TOPLEFT", 10, -35)
    tabSystem:SetPoint("BOTTOMRIGHT", mainConfigFrame, "BOTTOMRIGHT", -10, 40)

    -- === NOUVEAU : Ajouter les onglets des plugins ===
    self:CreatePluginTabs(tabSystem)

    -- Bouton Apply
    local applyButton = self:CreateButton("EmzToolsConfigApply", mainConfigFrame, "EMZTOOLS_STATE_APPLY", 80, 24)
    applyButton:SetPoint("BOTTOMRIGHT", mainConfigFrame, "BOTTOMRIGHT", -100, 10)
    applyButton:SetScript("OnClick", function(self)
        EmzTools.Data.UI:ApplyConfiguration()
    end)

    -- Bouton Reset
    local resetButton = self:CreateButton("EmzToolsConfigReset", mainConfigFrame, "EMZTOOLS_STATE_RESET", 80, 24)
    resetButton:SetPoint("BOTTOMRIGHT", mainConfigFrame, "BOTTOMRIGHT", -190, 10)
    resetButton:SetScript("OnClick", function(self)
        EmzTools.Data.UI:ResetConfiguration()
    end)

    mainConfigFrame.tabSystem = tabSystem
    mainConfigFrame.applyButton = applyButton
    mainConfigFrame.resetButton = resetButton

    EmzTools:Print("EMZTOOLS_UI_CONFIG_INTERFACE_CREATED", "debug")

    return mainConfigFrame
end

-- Fonction pour créer dynamiquement les onglets des plugins
function EmzTools.Data.UI:CreatePluginTabs(tabSystem)
    if not EmzTools.PluginUIs then
        return
    end

    local pluginCount = 0
    for pluginName, pluginUI in pairs(EmzTools.PluginUIs) do
        if pluginUI and pluginUI.CreateConfigTab then
            -- Créer un onglet pour ce plugin
            local tabContent = function(parent)
                pluginUI:CreateConfigTab(parent)
            end

            -- Ajouter l'onglet au système d'onglets
            tabSystem:AddTab(pluginName, tabContent)
            pluginCount = pluginCount + 1

            if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
                EmzTools:Print("Plugin tab created: " .. pluginName, "debug")
            end
        end
    end

    if pluginCount > 0 and EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
        EmzTools:Print(string.format("Loaded %d plugin tabs", pluginCount), "debug")
    end
end

-- ===================================================
-- ONGLET CORE
-- ===================================================

function EmzTools.Data.UI:CreateCoreTab(parent)
    local yOffset = -20

    -- === SECTION: DEBUG MODE ===
    local debugTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    debugTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    debugTitle:SetText("EMZTOOLS_UI_DEBUG_SECTION")
    debugTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local debugCheckbox = self:CreateCheckBox("EmzToolsDebugMode", parent, "EMZTOOLS_UI_ENABLE_DEBUG")
    debugCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    debugCheckbox:SetChecked(EmzTools.Database:Get("core", "debug", false))
    debugCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("core", "debug", checked)
        EmzTools:SetDebug(checked)
    end)

    yOffset = yOffset - 30

    -- === SECTION: VERSION INFO ===
    local versionTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    versionTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    versionTitle:SetText("EMZTOOLS_UI_VERSION_SECTION")
    versionTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local versionText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    versionText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    versionText:SetText("EmzTools v" .. (EmzTools.version or "1.0") .. " by " .. (EmzTools.author or "Emzime"))
    versionText:SetTextColor(1, 1, 1)

    yOffset = yOffset - 20

    local interfaceText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    interfaceText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    interfaceText:SetText("EMZTOOLS_UI_WOW_VERSION_COMPAT")
    interfaceText:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 30

    -- === SECTION: MODULES STATUS ===
    local modulesTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    modulesTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    modulesTitle:SetText("EMZTOOLS_UI_MODULES_SECTION")
    modulesTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local modules = {"InfoBar", "Potions", "Consumables", "Thresholds", "EventManager", "UI"}
    for i, moduleName in ipairs(modules) do
        local moduleStatus = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        moduleStatus:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

        local isLoaded = EmzTools.Data[moduleName] ~= nil
        local statusColor = isLoaded and "|cFF00FF00" or "|cFFFF0000"
        local statusText = isLoaded and "EMZTOOLS_STATE_LOADED" or "EMZTOOLS_STATE_NOT_LOADED"

        moduleStatus:SetText(moduleName .. ": " .. statusColor .. statusText .. "|r")
        yOffset = yOffset - 18
    end
end

-- ===================================================
-- ONGLET INFOBAR
-- ===================================================

function EmzTools.Data.UI:CreateInfoBarTab(parent)
    local yOffset = -20

    -- === SECTION: ÉTAT GÉNÉRAL ===
    local generalTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    generalTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    generalTitle:SetText("EMZTOOLS_UI_INFOBAR_GENERAL_SECTION")
    generalTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Checkbox Activer l'InfoBar
    local enabledCheckbox = self:CreateCheckBox("InfoBarEnabled", parent, "EMZTOOLS_UI_INFOBAR_ENABLE")
    enabledCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    enabledCheckbox:SetChecked(EmzTools.Database:Get("InfoBar", "enabled", true))
    enabledCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("InfoBar", "enabled", checked)
        if checked then
            EmzTools.Data.InfoBar:Show()
        else
            EmzTools.Data.InfoBar:Hide()
        end
    end)

    -- Checkbox Verrouiller
    local lockCheckbox = self:CreateCheckBox("InfoBarLocked", parent, "EMZTOOLS_UI_INFOBAR_LOCK")
    lockCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 200, yOffset)
    lockCheckbox:SetChecked(EmzTools.Database:Get("InfoBar", "locked", true))
    lockCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("InfoBar", "locked", checked)
        EmzTools.Data.InfoBar:ToggleLock()
    end)

    yOffset = yOffset - 30

    -- === SECTION: DIMENSIONS ===
    local dimensionsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    dimensionsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    dimensionsTitle:SetText("EMZTOOLS_UI_INFOBAR_DIMENSIONS_SECTION")
    dimensionsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Largeur
    local widthLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    widthLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    widthLabel:SetText("EMZTOOLS_UI_INFOBAR_WIDTH")

    local widthEditBox = self:CreateEditBox("InfoBarWidth", parent, 80, 24)
    widthEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 120, yOffset)

    local currentWidth = EmzTools.Database:Get("InfoBar", "width", "full")
    widthEditBox:SetText(tostring(currentWidth))

    widthEditBox:SetScript("OnEnterPressed", function(self)
        local value = self:GetText()
        if value == "full" then
            EmzTools.Database:Set("InfoBar", "width", "full")
            EmzTools.Data.InfoBar:SetWidth("full")
        else
            local numValue = tonumber(value)
            if numValue and numValue >= 400 and numValue <= 2000 then
                EmzTools.Database:Set("InfoBar", "width", numValue)
                EmzTools.Data.InfoBar:SetWidth(numValue)
            else
                self:SetText(tostring(currentWidth))
                EmzTools:Print("EMZTOOLS_UI_INFOBAR_INVALID_WIDTH", "warning")
            end
        end
        self:ClearFocus()
    end)

    -- Hauteur
    local heightLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    heightLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 220, yOffset)
    heightLabel:SetText("EMZTOOLS_UI_INFOBAR_HEIGHT")

    local heightEditBox = self:CreateEditBox("InfoBarHeight", parent, 60, 24)
    heightEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 290, yOffset)
    heightEditBox:SetText(tostring(EmzTools.Database:Get("InfoBar", "height", 24)))
    heightEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 20 and value <= 50 then
            EmzTools.Database:Set("InfoBar", "height", value)
            EmzTools.Data.InfoBar:SetHeight(value)
        else
            self:SetText(tostring(EmzTools.Database:Get("InfoBar", "height", 24)))
            EmzTools:Print("EMZTOOLS_UI_INFOBAR_INVALID_HEIGHT", "warning")
        end
        self:ClearFocus()
    end)

    yOffset = yOffset - 40

    -- === SECTION: TEXTURE ===
    local textureTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    textureTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    textureTitle:SetText("EMZTOOLS_UI_INFOBAR_TEXTURE_SECTION")
    textureTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Dropdown pour sélection de texture
    local textureItems = {
        {text = "X-Perl Style", value = "X-Perl"},
        {text = "Holy Style", value = "Holy"},
        {text = "Tribal Style", value = "Tribal"}
    }

    local textureDropdown = self:CreateDropDown("InfoBarTexture", parent, textureItems, 150)
    textureDropdown:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

    -- Définir la valeur actuelle
    local currentTexture = EmzTools.Database:Get("InfoBar", "texture", "X-Perl")
    for i, item in ipairs(textureItems) do
        if item.value == currentTexture then
            textureDropdown.selectedIndex = i
            textureDropdown.selectedValue = item.value
            textureDropdown.text:SetText(item.text)
            break
        end
    end

    textureDropdown.OnSelectionChanged = function(self, value, text, index)
        EmzTools.Database:Set("InfoBar", "texture", value)
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.SetTexture then
            EmzTools.Data.InfoBar:SetTexture(value)
        end
    end

    yOffset = yOffset - 50

    -- === SECTION: ÉLÉMENTS AFFICHÉS ===
    local elementsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    elementsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    elementsTitle:SetText("EMZTOOLS_UI_INFOBAR_ELEMENTS_SECTION")
    elementsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Checkboxes pour les éléments d'affichage
    local displayOptions = {
        {key = "showFPS", label = "EMZTOOLS_UI_INFOBAR_SHOW_FPS", x = 20, y = yOffset},
        {key = "showLatency", label = "EMZTOOLS_UI_INFOBAR_SHOW_LATENCY", x = 20, y = yOffset - 25},
        {key = "showGold", label = "EMZTOOLS_UI_INFOBAR_SHOW_GOLD", x = 200, y = yOffset},
        {key = "showXP", label = "EMZTOOLS_UI_INFOBAR_SHOW_XP", x = 200, y = yOffset - 25}
    }

    for i, option in ipairs(displayOptions) do
        local checkbox = self:CreateCheckBox("InfoBar" .. option.key, parent, option.label)
        checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", option.x, option.y)
        checkbox:SetChecked(EmzTools.Database:Get("InfoBar", option.key, true))
        checkbox:SetScript("OnClick", function(self)
            local checked = self:GetChecked() == 1
            EmzTools.Database:Set("InfoBar", option.key, checked)
            if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.UpdateVisibility then
                EmzTools.Data.InfoBar:UpdateVisibility()
            end
        end)
    end

    yOffset = yOffset - 60

    -- === SECTION: HORLOGE ===
    local clockTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    clockTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    clockTitle:SetText("EMZTOOLS_UI_INFOBAR_CLOCK_SECTION")
    clockTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons de format horaire
    local clockFormat = EmzTools.Database:Get("InfoBar", "clock24Hour")

    local autoButton = self:CreateButton("ClockAuto", parent, "EMZTOOLS_UI_INFOBAR_CLOCK_AUTO", 80, 24)
    autoButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    autoButton:SetScript("OnClick", function()
        EmzTools.Database:Set("InfoBar", "clock24Hour", nil)
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.UpdateClock then
            EmzTools.Data.InfoBar:UpdateClock()
        end
    end)

    local format24hButton = self:CreateButton("Clock24h", parent, "EMZTOOLS_UI_INFOBAR_CLOCK_24H", 80, 24)
    format24hButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 110, yOffset)
    format24hButton:SetScript("OnClick", function()
        EmzTools.Database:Set("InfoBar", "clock24Hour", true)
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.UpdateClock then
            EmzTools.Data.InfoBar:UpdateClock()
        end
    end)

    local format12hButton = self:CreateButton("Clock12h", parent, "EMZTOOLS_UI_INFOBAR_CLOCK_12H", 80, 24)
    format12hButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 200, yOffset)
    format12hButton:SetScript("OnClick", function()
        EmzTools.Database:Set("InfoBar", "clock24Hour", false)
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.UpdateClock then
            EmzTools.Data.InfoBar:UpdateClock()
        end
    end)

    yOffset = yOffset - 40

    -- === SECTION: ACTIONS RAPIDES ===
    local actionsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    actionsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    actionsTitle:SetText("EMZTOOLS_UI_INFOBAR_ACTIONS_SECTION")
    actionsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Bouton Réinitialiser position
    local resetPosButton = self:CreateButton("InfoBarResetPos", parent, "EMZTOOLS_UI_INFOBAR_RESET_POS", 120, 24)
    resetPosButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    resetPosButton:SetScript("OnClick", function()
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.ResetPosition then
            EmzTools.Data.InfoBar:ResetPosition()
        end
    end)

    -- Bouton Largeur pleine écran
    local fullWidthButton = self:CreateButton("InfoBarFullWidth", parent, "EMZTOOLS_UI_INFOBAR_FULL_WIDTH", 120, 24)
    fullWidthButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    fullWidthButton:SetScript("OnClick", function()
        EmzTools.Database:Set("InfoBar", "width", "full")
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.SetWidth then
            EmzTools.Data.InfoBar:SetWidth("full")
        end
    end)
end

-- ===================================================
-- ONGLET CONSOMMABLES
-- ===================================================

function EmzTools.Data.UI:CreateConsumablesTab(parent)
    local yOffset = -20

    -- === SECTION: AUTO-USE ===
    local autoTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    autoTitle:SetText("EMZTOOLS_UI_AUTO_USE_SECTION")
    autoTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local autoUseCheckbox = self:CreateCheckBox("ConsumablesAutoUse", parent, "EMZTOOLS_UI_ENABLE_AUTO_USE")
    autoUseCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    autoUseCheckbox:SetChecked(EmzTools.Database:Get("Consumables", "autoUse", false))
    autoUseCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("Consumables", "autoUse", checked)
        if checked then
            EmzTools:Print("EMZTOOLS_UI_AUTO_USE_ENABLED", "success")
        else
            EmzTools:Print("EMZTOOLS_UI_AUTO_USE_DISABLED", "warning")
        end
    end)

    -- Tooltip pour auto-use
    self:AddTooltip(autoUseCheckbox,
        "EMZTOOLS_UI_AUTO_USE_TOOLTIP_TITLE",
        "EMZTOOLS_UI_AUTO_USE_TOOLTIP_TEXT"
    )

    yOffset = yOffset - 40

    -- === SECTION: THRESHOLDS ===
    local thresholdTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    thresholdTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    thresholdTitle:SetText("EMZTOOLS_UI_THRESHOLDS_SECTION")
    thresholdTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- EditBox pour seuil de nourriture
    local foodLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    foodLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    foodLabel:SetText("EMZTOOLS_UI_FOOD_THRESHOLD" .. ":")

    local foodEditBox = self:CreateEditBox("ConsumablesFoodThreshold", parent, 60, 24)
    foodEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    foodEditBox:SetText(tostring(EmzTools.Database:Get("Consumables", "foodThreshold", 60)))
    foodEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 10 and value <= 90 then
            EmzTools.Database:Set("Consumables", "foodThreshold", value)
            EmzTools:Print("EMZTOOLS_UI_FOOD_THRESHOLD_UPDATED", "success", value)
            self:ClearFocus()
        else
            self:SetText(tostring(EmzTools.Database:Get("Consumables", "foodThreshold", 60)))
            EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
        end
    end)

    local foodPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    foodPercentLabel:SetPoint("LEFT", foodEditBox, "RIGHT", 5, 0)
    foodPercentLabel:SetText("%")

    -- Tooltip pour seuil nourriture
    self:AddTooltip(foodEditBox,
        "EMZTOOLS_UI_FOOD_THRESHOLD_TOOLTIP_TITLE",
        "EMZTOOLS_UI_FOOD_THRESHOLD_TOOLTIP_TEXT"
    )

    yOffset = yOffset - 40

    -- EditBox pour seuil de boisson
    local drinkLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    drinkLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    drinkLabel:SetText("EMZTOOLS_UI_DRINK_THRESHOLD" .. ":")

    local drinkEditBox = self:CreateEditBox("ConsumablesDrinkThreshold", parent, 60, 24)
    drinkEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    drinkEditBox:SetText(tostring(EmzTools.Database:Get("Consumables", "drinkThreshold", 40)))
    drinkEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 10 and value <= 90 then
            EmzTools.Database:Set("Consumables", "drinkThreshold", value)
            EmzTools:Print("EMZTOOLS_UI_DRINK_THRESHOLD_UPDATED", "success", value)
            self:ClearFocus()
        else
            self:SetText(tostring(EmzTools.Database:Get("Consumables", "drinkThreshold", 40)))
            EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
        end
    end)

    local drinkPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    drinkPercentLabel:SetPoint("LEFT", drinkEditBox, "RIGHT", 5, 0)
    drinkPercentLabel:SetText("%")

    -- Tooltip pour seuil boisson
    self:AddTooltip(drinkEditBox,
        "EMZTOOLS_UI_DRINK_THRESHOLD_TOOLTIP_TITLE",
        "EMZTOOLS_UI_DRINK_THRESHOLD_TOOLTIP_TEXT"
    )

    yOffset = yOffset - 40

    -- EditBox pour seuil de bandage
    local bandageLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bandageLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    bandageLabel:SetText("EMZTOOLS_UI_BANDAGE_THRESHOLD" .. ":")

    local bandageEditBox = self:CreateEditBox("ConsumablesBandageThreshold", parent, 60, 24)
    bandageEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    bandageEditBox:SetText(tostring(EmzTools.Database:Get("Consumables", "bandageThreshold", 50)))
    bandageEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 10 and value <= 90 then
            EmzTools.Database:Set("Consumables", "bandageThreshold", value)
            EmzTools:Print("EMZTOOLS_UI_BANDAGE_THRESHOLD_UPDATED", "success", value)
            self:ClearFocus()
        else
            self:SetText(tostring(EmzTools.Database:Get("Consumables", "bandageThreshold", 50)))
            EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
        end
    end)

    local bandagePercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    bandagePercentLabel:SetPoint("LEFT", bandageEditBox, "RIGHT", 5, 0)
    bandagePercentLabel:SetText("%")

    -- Tooltip pour seuil bandage
    self:AddTooltip(bandageEditBox,
        "EMZTOOLS_UI_BANDAGE_THRESHOLD_TOOLTIP_TITLE",
        "EMZTOOLS_UI_BANDAGE_THRESHOLD_TOOLTIP_TEXT"
    )

    yOffset = yOffset - 50

    -- === SECTION: COMMANDES RAPIDES ===
    local commandsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    commandsTitle:SetText("EMZTOOLS_UI_QUICK_COMMANDS_SECTION")
    commandsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons de commandes rapides
    local eatButton = self:CreateButton("QuickEat", parent, "EMZTOOLS_UI_EAT_NOW", 100, 24)
    eatButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    eatButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Consumables and EmzTools.Data.Consumables.Eat then
            EmzTools.Data.Consumables:Eat()
        end
    end)

    local drinkButton = self:CreateButton("QuickDrink", parent, "EMZTOOLS_UI_DRINK_NOW", 100, 24)
    drinkButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 130, yOffset)
    drinkButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Consumables and EmzTools.Data.Consumables.Drink then
            EmzTools.Data.Consumables:Drink()
        end
    end)

    yOffset = yOffset - 35

    local bandageButton = self:CreateButton("QuickBandage", parent, "EMZTOOLS_UI_BANDAGE_NOW", 100, 24)
    bandageButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    bandageButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Consumables and EmzTools.Data.Consumables.UseBandage then
            EmzTools.Data.Consumables:UseBandage()
        end
    end)

    local restButton = self:CreateButton("QuickRest", parent, "EMZTOOLS_UI_REST_NOW", 100, 24)
    restButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 130, yOffset)
    restButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Consumables and EmzTools.Data.Consumables.Rest then
            EmzTools.Data.Consumables:Rest()
        end
    end)

    yOffset = yOffset - 45

    -- === SECTION: INFORMATIONS ===
    local infoTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    infoTitle:SetText("EMZTOOLS_UI_CONSUMABLES_INFO_SECTION")
    infoTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local listButton = self:CreateButton("ListConsumables", parent, "EMZTOOLS_UI_LIST_CONSUMABLES", 150, 24)
    listButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    listButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Consumables and EmzTools.Data.Consumables.PrintAvailableConsumables then
            EmzTools.Data.Consumables:PrintAvailableConsumables()
        end
    end)

    -- Tooltip pour liste des consommables
    self:AddTooltip(listButton,
        "EMZTOOLS_UI_LIST_CONSUMABLES_TOOLTIP_TITLE",
        "EMZTOOLS_UI_LIST_CONSUMABLES_TOOLTIP_TEXT"
    )
end

-- ===================================================
-- ONGLET POTIONS INTELLIGENTES
-- ===================================================

function EmzTools.Data.UI:CreatePotionsTab(parent)
    local yOffset = -20

    -- === SECTION: AUTO-USE ===
    local autoTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    autoTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    autoTitle:SetText("EMZTOOLS_UI_POTIONS_AUTO_USE_SECTION")
    autoTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local autoUseCheckbox = self:CreateCheckBox("PotionsAutoUse", parent, "EMZTOOLS_UI_POTIONS_ENABLE_AUTO_USE")
    autoUseCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    autoUseCheckbox:SetChecked(EmzTools.Database:Get("Potions", "autoUse", false))
    autoUseCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("Potions", "autoUse", checked)
        if checked then
            EmzTools:Print("EMZTOOLS_UI_POTIONS_AUTO_USE_ENABLED", "success")
        else
            EmzTools:Print("EMZTOOLS_UI_POTIONS_AUTO_USE_DISABLED", "warning")
        end
    end)

    yOffset = yOffset - 40

    -- === SECTION: THRESHOLDS ===
    local thresholdTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    thresholdTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    thresholdTitle:SetText("EMZTOOLS_UI_POTIONS_THRESHOLDS_SECTION")
    thresholdTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- EditBox pour seuil de potion de soin
    local healthLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    healthLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    healthLabel:SetText("EMZTOOLS_UI_POTIONS_HEALTH_THRESHOLD" .. ":")

    local healthEditBox = self:CreateEditBox("PotionsHealthThreshold", parent, 60, 24)
    healthEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 180, yOffset)
    healthEditBox:SetText(tostring(EmzTools.Database:Get("Potions", "healthThreshold", 30)))
    healthEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 10 and value <= 80 then
            EmzTools.Database:Set("Potions", "healthThreshold", value)
            EmzTools:Print("EMZTOOLS_UI_POTIONS_HEALTH_THRESHOLD_UPDATED", "success", value)
            self:ClearFocus()
        else
            self:SetText(tostring(EmzTools.Database:Get("Potions", "healthThreshold", 30)))
            EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
        end
    end)

    local healthPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    healthPercentLabel:SetPoint("LEFT", healthEditBox, "RIGHT", 5, 0)
    healthPercentLabel:SetText("%")

    yOffset = yOffset - 40

    -- EditBox pour seuil de potion de mana (conditionnel)
    local playerClass = EmzTools:GetPlayerClass()
    local hasMana = EmzTools:PlayerHasMana()

    if hasMana then
        local manaLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        manaLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

        local thresholdKey = "EMZTOOLS_UI_POTIONS_MANA_THRESHOLD"
        if playerClass == "ROGUE" then
            thresholdKey = "EMZTOOLS_UI_POTIONS_ENERGY_THRESHOLD"
        end
        manaLabel:SetText(thresholdKey .. ":")

        local manaEditBox = self:CreateEditBox("PotionsManaThreshold", parent, 60, 24)
        manaEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 180, yOffset)
        manaEditBox:SetText(tostring(EmzTools.Database:Get("Potions", "manaThreshold", 25)))
        manaEditBox:SetScript("OnEnterPressed", function(self)
            local value = tonumber(self:GetText())
            if value and value >= 10 and value <= 80 then
                EmzTools.Database:Set("Potions", "manaThreshold", value)
                EmzTools:Print("EMZTOOLS_UI_POTIONS_MANA_THRESHOLD_UPDATED", "success", value)
                self:ClearFocus()
            else
                self:SetText(tostring(EmzTools.Database:Get("Potions", "manaThreshold", 25)))
                EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
            end
        end)

        local manaPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        manaPercentLabel:SetPoint("LEFT", manaEditBox, "RIGHT", 5, 0)
        manaPercentLabel:SetText("%")

        yOffset = yOffset - 40
    end

    -- === SECTION: INFORMATIONS CLASSE ===
    local classTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    classTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    classTitle:SetText("EMZTOOLS_UI_POTIONS_CLASS_INFO_SECTION")
    classTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local classInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    classInfo:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

    local powerType = "mana"
    if playerClass == "ROGUE" then
        powerType = "energy"
    elseif playerClass == "WARRIOR" then
        powerType = "rage"
    end

    local infoKey = "EMZTOOLS_UI_POTIONS_CLASS_INFO_" .. string.upper(powerType)
    classInfo:SetText(infoKey)
    classInfo:SetTextColor(0.8, 0.8, 1)

    yOffset = yOffset - 40

    -- === SECTION: COMMANDES RAPIDES ===
    local commandsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    commandsTitle:SetText("EMZTOOLS_UI_POTIONS_QUICK_COMMANDS_SECTION")
    commandsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons de commandes rapides
    local healthButton = self:CreateButton("QuickHealthPotion", parent, "EMZTOOLS_UI_POTIONS_USE_HEALTH", 120, 24)
    healthButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    healthButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Potions and EmzTools.Data.Potions.UseHealthPotion then
            EmzTools.Data.Potions:UseHealthPotion()
        end
    end)

    if hasMana then
        local manaButton = self:CreateButton("QuickManaPotion", parent, "EMZTOOLS_UI_POTIONS_USE_MANA", 120, 24)
        manaButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
        manaButton:SetScript("OnClick", function(self)
            if EmzTools.Data.Potions and EmzTools.Data.Potions.UseManaPotion then
                EmzTools.Data.Potions:UseManaPotion()
            end
        end)
    end

    yOffset = yOffset - 35

    local stoneButton = self:CreateButton("QuickHealthstone", parent, "EMZTOOLS_UI_POTIONS_USE_STONE", 120, 24)
    stoneButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    stoneButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Potions and EmzTools.Data.Potions.UseHealthstone then
            EmzTools.Data.Potions:UseHealthstone()
        end
    end)

    local smartButton = self:CreateButton("QuickSmartHeal", parent, "EMZTOOLS_UI_POTIONS_SMART_HEAL", 120, 24)
    smartButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    smartButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Potions and EmzTools.Data.Potions.SmartHeal then
            EmzTools.Data.Potions:SmartHeal()
        end
    end)

    yOffset = yOffset - 45

    -- === SECTION: INFORMATIONS ===
    local infoTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    infoTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    infoTitle:SetText("EMZTOOLS_UI_POTIONS_INFO_SECTION")
    infoTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local listButton = self:CreateButton("ListPotions", parent, "EMZTOOLS_UI_POTIONS_LIST_AVAILABLE", 150, 24)
    listButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    listButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Potions and EmzTools.Data.Potions.PrintAvailablePotions then
            EmzTools.Data.Potions:PrintAvailablePotions()
        end
    end)

    local recommendButton = self:CreateButton("RecommendPotions", parent, "EMZTOOLS_UI_POTIONS_RECOMMEND", 150, 24)
    recommendButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 180, yOffset)
    recommendButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Potions and EmzTools.Data.Potions.PrintRecommendedPotions then
            EmzTools.Data.Potions:PrintRecommendedPotions()
        end
    end)
end

-- ===================================================
-- ONGLET SEUILS DYNAMIQUES
-- ===================================================

function EmzTools.Data.UI:CreateThresholdsTab(parent)
    local yOffset = -20

    -- === SECTION: MODE AGRESSIF ===
    local aggressiveTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    aggressiveTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    aggressiveTitle:SetText("EMZTOOLS_UI_DYNAMIC_THRESHOLDS_SECTION")
    aggressiveTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local aggressiveCheckbox = self:CreateCheckBox("ThresholdsAggressiveMode", parent, "EMZTOOLS_UI_ENABLE_DYNAMIC_THRESHOLDS")
    aggressiveCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    aggressiveCheckbox:SetChecked(EmzTools.Database:Get("Thresholds", "aggressiveMode", false))
    aggressiveCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("Thresholds", "aggressiveMode", checked)
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.ToggleAggressiveMode then
            EmzTools.Data.Thresholds:ToggleAggressiveMode()
        end
    end)

    -- Tooltip pour mode agressif
    self:AddTooltip(aggressiveCheckbox,
        "EMZTOOLS_UI_AGGRESSIVE_MODE_TOOLTIP_TITLE",
        "EMZTOOLS_UI_AGGRESSIVE_MODE_TOOLTIP_TEXT"
    )

    yOffset = yOffset - 40

    -- === SECTION: SEUILS PERSONNALISÉS ===
    local customTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    customTitle:SetText("EMZTOOLS_UI_THRESHOLDS_SECTION")
    customTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- EditBox pour seuil HP personnalisé
    local hpLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hpLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    hpLabel:SetText("EMZTOOLS_UI_HEALTH_THRESHOLD" .. ":")

    local hpEditBox = self:CreateEditBox("ThresholdsHPThreshold", parent, 60, 24)
    hpEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    hpEditBox:SetText(tostring(EmzTools.Database:Get("Thresholds", "customHPThreshold", "")))
    hpEditBox:SetScript("OnEnterPressed", function(self)
        local value = tonumber(self:GetText())
        if value and value >= 10 and value <= 90 then
            EmzTools.Database:Set("Thresholds", "customHPThreshold", value)
            if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetCustomHPThreshold then
                EmzTools.Data.Thresholds:SetCustomHPThreshold(value)
            end
            self:ClearFocus()
        else
            self:SetText(tostring(EmzTools.Database:Get("Thresholds", "customHPThreshold", "")))
            EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
        end
    end)

    local hpPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    hpPercentLabel:SetPoint("LEFT", hpEditBox, "RIGHT", 5, 0)
    hpPercentLabel:SetText("%")

    -- Bouton reset HP
    local resetHPButton = self:CreateButton("ResetHPThreshold", parent, "EMZTOOLS_STATE_RESET", 60, 20)
    resetHPButton:SetPoint("LEFT", hpPercentLabel, "RIGHT", 10, 0)
    resetHPButton:SetScript("OnClick", function(self)
        EmzTools.Database:Set("Thresholds", "customHPThreshold", nil)
        hpEditBox:SetText("")
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetCustomHPThreshold then
            EmzTools.Data.Thresholds:SetCustomHPThreshold(nil)
        end
    end)

    yOffset = yOffset - 40

    -- EditBox pour seuil Mana/Énergie personnalisé
    local playerClass = EmzTools:GetPlayerClass()
    local hasMana = EmzTools:PlayerHasMana()

    if hasMana then
        local manaLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        manaLabel:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

        local thresholdKey = "EMZTOOLS_UI_MANA_THRESHOLD"
        if playerClass == "ROGUE" then
            thresholdKey = "EMZTOOLS_UI_ENERGY_THRESHOLD"
        elseif playerClass == "WARRIOR" then
            thresholdKey = "EMZTOOLS_UI_RAGE_THRESHOLD"
        end
        manaLabel:SetText(thresholdKey .. ":")

        local manaEditBox = self:CreateEditBox("ThresholdsManaThreshold", parent, 60, 24)
        manaEditBox:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
        manaEditBox:SetText(tostring(EmzTools.Database:Get("Thresholds", "customManaThreshold", "")))
        manaEditBox:SetScript("OnEnterPressed", function(self)
            local value = tonumber(self:GetText())
            if value and value >= 5 and value <= 80 then
                EmzTools.Database:Set("Thresholds", "customManaThreshold", value)
                if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetCustomManaThreshold then
                    EmzTools.Data.Thresholds:SetCustomManaThreshold(value)
                end
                self:ClearFocus()
            else
                self:SetText(tostring(EmzTools.Database:Get("Thresholds", "customManaThreshold", "")))
                EmzTools:Print("EMZTOOLS_UI_INVALID_THRESHOLD_VALUE", "warning")
            end
        end)

        local manaPercentLabel = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        manaPercentLabel:SetPoint("LEFT", manaEditBox, "RIGHT", 5, 0)
        manaPercentLabel:SetText("%")

        -- Bouton reset Mana
        local resetManaButton = self:CreateButton("ResetManaThreshold", parent, "EMZTOOLS_STATE_RESET", 60, 20)
        resetManaButton:SetPoint("LEFT", manaPercentLabel, "RIGHT", 10, 0)
        resetManaButton:SetScript("OnClick", function(self)
            EmzTools.Database:Set("Thresholds", "customManaThreshold", nil)
            manaEditBox:SetText("")
            if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetCustomManaThreshold then
                EmzTools.Data.Thresholds:SetCustomManaThreshold(nil)
            end
        end)

        yOffset = yOffset - 40
    end

    -- === SECTION: AJUSTEMENTS CONTEXTUELS ===
    local contextTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    contextTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    contextTitle:SetText("EMZTOOLS_UI_CONTEXT_ADJUSTMENTS_SECTION")
    contextTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Checkbox ajustement groupe
    local groupCheckbox = self:CreateCheckBox("ThresholdsGroupAdjust", parent, "EMZTOOLS_UI_GROUP_ADJUSTMENTS")
    groupCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    groupCheckbox:SetChecked(EmzTools.Database:Get("Thresholds", "inGroup", false))
    groupCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("Thresholds", "inGroup", checked)
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetGroupStatus then
            EmzTools.Data.Thresholds:SetGroupStatus(checked)
        end
    end)

    -- Checkbox ajustement PvP
    local pvpCheckbox = self:CreateCheckBox("ThresholdsPvPAdjust", parent, "EMZTOOLS_UI_PVP_ADJUSTMENTS")
    pvpCheckbox:SetPoint("TOPLEFT", parent, "TOPLEFT", 200, yOffset)
    pvpCheckbox:SetChecked(EmzTools.Database:Get("Thresholds", "inPvPZone", false))
    pvpCheckbox:SetScript("OnClick", function(self)
        local checked = self:GetChecked() == 1
        EmzTools.Database:Set("Thresholds", "inPvPZone", checked)
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.SetPvPStatus then
            EmzTools.Data.Thresholds:SetPvPStatus(checked)
        end
    end)

    yOffset = yOffset - 40

    -- === SECTION: INFORMATIONS CLASSE ===
    local classTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    classTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    classTitle:SetText("EMZTOOLS_UI_CLASS_INFO_SECTION")
    classTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local classInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    classInfo:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

    local powerType = "mana"
    if playerClass == "ROGUE" then
        powerType = "energy"
    elseif playerClass == "WARRIOR" then
        powerType = "rage"
    end

    local infoKey = "EMZTOOLS_UI_POTIONS_CLASS_INFO_" .. string.upper(powerType)
    classInfo:SetText(infoKey)
    classInfo:SetTextColor(0.8, 0.8, 1)

    yOffset = yOffset - 40

    -- === SECTION: COMMANDES RAPIDES ===
    local commandsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    commandsTitle:SetText("EMZTOOLS_UI_THRESHOLDS_QUICK_COMMANDS_SECTION")
    commandsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons de commandes rapides
    local showButton = self:CreateButton("ShowThresholds", parent, "EMZTOOLS_UI_SHOW_THRESHOLDS", 120, 24)
    showButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    showButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.PrintThresholds then
            EmzTools.Data.Thresholds:PrintThresholds()
        end
    end)

    local efficiencyButton = self:CreateButton("ShowEfficiency", parent, "EMZTOOLS_UI_SHOW_EFFICIENCY", 120, 24)
    efficiencyButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    efficiencyButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Thresholds and EmzTools.Data.Thresholds.PrintFarmingEfficiency then
            EmzTools.Data.Thresholds:PrintFarmingEfficiency()
        end
    end)

    yOffset = yOffset - 35

    local resetAllButton = self:CreateButton("ResetAllThresholds", parent, "EMZTOOLS_UI_RESET_ALL_THRESHOLDS", 120, 24)
    resetAllButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    resetAllButton:SetScript("OnClick", function(self)
        EmzTools.Database:Set("Thresholds", "customHPThreshold", nil)
        EmzTools.Database:Set("Thresholds", "customManaThreshold", nil)
        EmzTools.Database:Set("Thresholds", "aggressiveMode", false)
        EmzTools.Database:Set("Thresholds", "inGroup", false)
        EmzTools.Database:Set("Thresholds", "inPvPZone", false)

        hpEditBox:SetText("")
        if hasMana then
            manaEditBox:SetText("")
        end
        aggressiveCheckbox:SetChecked(false)
        groupCheckbox:SetChecked(false)
        pvpCheckbox:SetChecked(false)

        if EmzTools.Data.Thresholds then
            if EmzTools.Data.Thresholds.SetCustomHPThreshold then
                EmzTools.Data.Thresholds:SetCustomHPThreshold(nil)
            end
            if EmzTools.Data.Thresholds.SetCustomManaThreshold then
                EmzTools.Data.Thresholds:SetCustomManaThreshold(nil)
            end
            if EmzTools.Data.Thresholds.SetGroupStatus then
                EmzTools.Data.Thresholds:SetGroupStatus(false)
            end
            if EmzTools.Data.Thresholds.SetPvPStatus then
                EmzTools.Data.Thresholds:SetPvPStatus(false)
            end
        end

        EmzTools:Print("EMZTOOLS_THRESHOLDS_RESET_ALL", "success")
    end)

    yOffset = yOffset - 45

    -- === SECTION: STATUT ACTUEL ===
    local statusTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statusTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    statusTitle:SetText("EMZTOOLS_UI_CURRENT_STATUS_SECTION")
    statusTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local statusText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    statusText:SetText("EMZTOOLS_UI_THRESHOLDS_STATUS_INFO")
    statusText:SetTextColor(0.8, 0.8, 0.8)

    -- Mettre à jour le statut périodiquement
    local function UpdateStatusDisplay()
        if EmzTools.Data.Thresholds then
            local hpThreshold = EmzTools.Data.Thresholds:GetEffectiveHPThreshold()
            local manaThreshold = EmzTools.Data.Thresholds:GetEffectiveManaThreshold()
            local mobsLeft = EmzTools.Data.Thresholds:EstimateMobsBeforeRest()

            local statusMessage
            if hasMana then
                statusMessage = string.format("HP: %d%% | %s: %d%% | Mobs: %d",
                    hpThreshold,
                    playerClass == "ROGUE" and "Energy" or playerClass == "WARRIOR" and "Rage" or "Mana",
                    manaThreshold,
                    mobsLeft)
            else
                statusMessage = string.format("HP: %d%% | Mobs: %d", hpThreshold, mobsLeft)
            end

            statusText:SetText(statusMessage)
        end
    end

    -- Mettre à jour le statut toutes les 5 secondes
    local updateFrame = CreateFrame("Frame")
    updateFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = (self.timer or 0) + elapsed
        if self.timer > 5 then
            UpdateStatusDisplay()
            self.timer = 0
        end
    end)

    -- Mise à jour initiale
    UpdateStatusDisplay()
end

-- ===================================================
-- ONGLET BASE DE DONNÉES
-- ===================================================

function EmzTools.Data.UI:CreateDatabaseTab(parent)
    local yOffset = -20

    -- === SECTION: STATUT GÉNÉRAL ===
    local statusTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statusTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    statusTitle:SetText("EMZTOOLS_UI_DATABASE_STATUS_SECTION")
    statusTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Affichage du statut de la base de données
    local statusText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statusText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

    local function UpdateDatabaseStatus()
        if not EmzToolsDB then
            statusText:SetText("EMZTOOLS_DATABASE_NOT_INITIALIZED")
            statusText:SetTextColor(1, 0, 0) -- Rouge
        else
            local moduleCount = 0
            if EmzToolsDB.modules then
                for _ in pairs(EmzToolsDB.modules) do
                    moduleCount = moduleCount + 1
                end
            end

            local statusMessage = string.format("EMZTOOLS_UI_DATABASE_STATUS_FORMAT", moduleCount)
            statusText:SetText(statusMessage)
            statusText:SetTextColor(0, 1, 0) -- Vert
        end
    end

    UpdateDatabaseStatus()

    yOffset = yOffset - 40

    -- === SECTION: MODULES ENREGISTRÉS ===
    local modulesTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    modulesTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    modulesTitle:SetText("EMZTOOLS_UI_REGISTERED_MODULES_SECTION")
    modulesTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Liste des modules avec statut
    local modules = {"Core", "InfoBar", "Consumables", "Potions", "Thresholds", "EventManager", "Utils", "UI"}
    local moduleFrames = {}

    for i, moduleName in ipairs(modules) do
        local moduleFrame = CreateFrame("Frame", "ModuleFrame" .. moduleName, parent)
        moduleFrame:SetWidth(350)
        moduleFrame:SetHeight(20)
        moduleFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)

        -- Nom du module
        local nameText = moduleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        nameText:SetPoint("LEFT", moduleFrame, "LEFT", 0, 0)
        nameText:SetText(moduleName)
        nameText:SetTextColor(1, 1, 1)

        -- Statut du module
        local statusText = moduleFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        statusText:SetPoint("RIGHT", moduleFrame, "RIGHT", -80, 0)

        -- Bouton activation/désactivation
        local toggleButton = self:CreateButton("Toggle" .. moduleName, moduleFrame, "EMZTOOLS_UI_TOGGLE_BUTTON", 70, 18)
        toggleButton:SetPoint("RIGHT", moduleFrame, "RIGHT", 0, 0)

        local function UpdateModuleStatus()
            local isEnabled = EmzTools.Database:IsModuleEnabled(moduleName)
            if isEnabled then
                statusText:SetText("EMZTOOLS_STATE_ENABLED")
                statusText:SetTextColor(0, 1, 0) -- Vert
                toggleButton:SetText("EMZTOOLS_UI_DISABLE_BUTTON")
            else
                statusText:SetText("EMZTOOLS_STATE_DISABLED")
                statusText:SetTextColor(1, 0, 0) -- Rouge
                toggleButton:SetText("EMZTOOLS_UI_ENABLE_BUTTON")
            end
        end

        toggleButton:SetScript("OnClick", function(self)
            local currentState = EmzTools.Database:IsModuleEnabled(moduleName)
            EmzTools.Database:SetModuleEnabled(moduleName, not currentState)
            UpdateModuleStatus()
        end)

        UpdateModuleStatus()
        moduleFrames[moduleName] = moduleFrame

        yOffset = yOffset - 25
    end

    yOffset = yOffset - 20

    -- === SECTION: ACTIONS DE BASE DE DONNÉES ===
    local actionsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    actionsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    actionsTitle:SetText("EMZTOOLS_UI_DATABASE_ACTIONS_SECTION")
    actionsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons d'actions
    local listButton = self:CreateButton("ListModules", parent, "EMZTOOLS_UI_LIST_MODULES_BUTTON", 120, 24)
    listButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    listButton:SetScript("OnClick", function(self)
        if EmzTools.Database and EmzTools.Database.ListModules then
            EmzTools.Database:ListModules()
        end
    end)

    local dumpButton = self:CreateButton("DumpDatabase", parent, "EMZTOOLS_UI_DUMP_DATABASE_BUTTON", 120, 24)
    dumpButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    dumpButton:SetScript("OnClick", function(self)
        if EmzTools.Database and EmzTools.Database.DumpAll then
            EmzTools.Database:DumpAll()
        end
    end)

    yOffset = yOffset - 35

    local resetCoreButton = self:CreateButton("ResetCore", parent, "EMZTOOLS_UI_RESET_CORE_BUTTON", 120, 24)
    resetCoreButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    resetCoreButton:SetScript("OnClick", function(self)
        if EmzTools.Database and EmzTools.Database.ResetModule then
            EmzTools.Database:ResetModule("Core")
            EmzTools:Print("EMZTOOLS_MODULE_RESET", "success", "Core")
            UpdateDatabaseStatus()
        end
    end)

    local resetAllButton = self:CreateButton("ResetAllModules", parent, "EMZTOOLS_UI_RESET_ALL_MODULES_BUTTON", 120, 24)
    resetAllButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    resetAllButton:SetScript("OnClick", function(self)
        for _, moduleName in ipairs(modules) do
            if EmzTools.Database and EmzTools.Database.ResetModule then
                EmzTools.Database:ResetModule(moduleName)
            end
        end
        EmzTools:Print("EMZTOOLS_UI_ALL_MODULES_RESET", "success")
        UpdateDatabaseStatus()
    end)

    yOffset = yOffset - 45

    -- === SECTION: RÉINITIALISATION COMPLÈTE ===
    local resetTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    resetTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    resetTitle:SetText("EMZTOOLS_UI_DATABASE_RESET_SECTION")
    resetTitle:SetTextColor(1, 0.5, 0.5) -- Rouge orangé pour avertissement

    yOffset = yOffset - 30

    local warningText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    warningText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    warningText:SetText("EMZTOOLS_UI_DATABASE_RESET_WARNING")
    warningText:SetTextColor(1, 1, 0) -- Jaune

    yOffset = yOffset - 25

    local fullResetButton = self:CreateButton("FullResetDatabase", parent, "EMZTOOLS_UI_FULL_RESET_BUTTON", 150, 28)
    fullResetButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    fullResetButton:SetScript("OnClick", function(self)
        self:ConfirmDatabaseReset()
    end)

    -- Mettre à jour le statut périodiquement
    local updateFrame = CreateFrame("Frame")
    updateFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = (self.timer or 0) + elapsed
        if self.timer > 2 then -- Mise à jour toutes les 2 secondes
            UpdateDatabaseStatus()
            for _, moduleName in ipairs(modules) do
                if moduleFrames[moduleName] then
                    -- Mettre à jour le statut de chaque module
                    local isEnabled = EmzTools.Database:IsModuleEnabled(moduleName)
                    local statusText = moduleFrames[moduleName].statusText
                    if statusText then
                        if isEnabled then
                            statusText:SetText("EMZTOOLS_STATE_ENABLED")
                            statusText:SetTextColor(0, 1, 0)
                        else
                            statusText:SetText("EMZTOOLS_STATE_DISABLED")
                            statusText:SetTextColor(1, 0, 0)
                        end
                    end
                end
            end
            self.timer = 0
        end
    end)
end

-- ===================================================
-- ONGLET GESTIONNAIRE D'ÉVÉNEMENTS
-- ===================================================

function EmzTools.Data.UI:CreateEventManagerTab(parent)
    local yOffset = -20

    -- === SECTION: ÉVÉNEMENTS ENREGISTRÉS ===
    local eventsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    eventsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    eventsTitle:SetText("EMZTOOLS_UI_EVENTMANAGER_REGISTERED_SECTION")
    eventsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Liste des événements avec compteurs
    local eventsList = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    eventsList:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    eventsList:SetText("EMZTOOLS_UI_EVENTMANAGER_LOADING_EVENTS")
    eventsList:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 40

    -- === SECTION: STATISTIQUES ===
    local statsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    statsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    statsTitle:SetText("EMZTOOLS_UI_EVENTMANAGER_STATS_SECTION")
    statsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local statsText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    statsText:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    statsText:SetText("EMZTOOLS_UI_EVENTMANAGER_NO_STATS")
    statsText:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 40

    -- === SECTION: COMMANDES RAPIDES ===
    local commandsTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    commandsTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    commandsTitle:SetText("EMZTOOLS_UI_EVENTMANAGER_COMMANDS_SECTION")
    commandsTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons de commandes
    local listEventsButton = self:CreateButton("ListEvents", parent, "EMZTOOLS_UI_LIST_EVENTS_BUTTON", 120, 24)
    listEventsButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    listEventsButton:SetScript("OnClick", function(self)
        if EmzTools.Data.EventManager and EmzTools.Data.EventManager.ListRegisteredEvents then
            EmzTools.Data.EventManager:ListRegisteredEvents()
        end
    end)

    local statsButton = self:CreateButton("EventStats", parent, "EMZTOOLS_UI_EVENT_STATS_BUTTON", 120, 24)
    statsButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    statsButton:SetScript("OnClick", function(self)
        if EmzTools.Data.EventManager and EmzTools.Data.EventManager.PrintStats then
            EmzTools.Data.EventManager:PrintStats()
        end
    end)

    yOffset = yOffset - 35

    local registerCommonButton = self:CreateButton("RegisterCommonEvents", parent, "EMZTOOLS_UI_REGISTER_COMMON_EVENTS_BUTTON", 150, 24)
    registerCommonButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    registerCommonButton:SetScript("OnClick", function(self)
        if EmzTools.Data.EventManager and EmzTools.Data.EventManager.RegisterCommonEvents then
            EmzTools.Data.EventManager:RegisterCommonEvents()
            EmzTools:Print("EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED", "success")
        end
    end)

    yOffset = yOffset - 40

    -- === SECTION: ÉVÉNEMENTS PERSONNALISÉS ===
    local customTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    customTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    customTitle:SetText("EMZTOOLS_UI_EVENTMANAGER_CUSTOM_SECTION")
    customTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local customInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    customInfo:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    customInfo:SetText("EMZTOOLS_UI_EVENTMANAGER_CUSTOM_INFO")
    customInfo:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 25

    -- Test d'événement personnalisé
    local testEventButton = self:CreateButton("TestCustomEvent", parent, "EMZTOOLS_UI_TEST_CUSTOM_EVENT_BUTTON", 150, 24)
    testEventButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    testEventButton:SetScript("OnClick", function(self)
        if EmzTools.Data.EventManager and EmzTools.Data.EventManager.FireCustomEvent then
            EmzTools.Data.EventManager:FireCustomEvent("EMZTOOLS_TEST_EVENT", { "Test", 123, true })
            EmzTools:Print("EMZTOOLS_UI_CUSTOM_EVENT_FIRED", "debug")
        end
    end)

    -- Mise à jour en temps réel des événements
    local function UpdateEventManagerDisplay()
        if EmzTools.Data.EventManager then
            -- Mettre à jour la liste des événements
            local eventCount = 0
            local callbackCount = 0
            local eventsText = ""

            -- Simuler un scan des événements (dans la vraie implémentation, on utiliserait les vraies données)
            if EmzTools.Data.EventManager.GetCallbackCount then
                -- Événements communs pour l'affichage
                local commonEvents = {
                    "PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED", "PLAYER_LEVEL_UP",
                    "PLAYER_DEAD", "PLAYER_ENTERING_WORLD", "PLAYER_LEAVING_WORLD"
                }

                for _, event in ipairs(commonEvents) do
                    local count = EmzTools.Data.EventManager:GetCallbackCount(event) or 0
                    if count > 0 then
                        eventCount = eventCount + 1
                        callbackCount = callbackCount + count
                        if eventsText ~= "" then eventsText = eventsText .. "\n" end
                        eventsText = eventsText .. string.format("%s (%d callbacks)", event, count)
                    end
                end
            end

            if eventCount > 0 then
                eventsList:SetText(string.format("EMZTOOLS_UI_EVENTMANAGER_EVENTS_FORMAT", eventCount, callbackCount) .. "\n" .. eventsText)
                eventsList:SetTextColor(0, 1, 0) -- Vert
            else
                eventsList:SetText("EMZTOOLS_UI_EVENTMANAGER_NO_EVENTS_REGISTERED")
                eventsList:SetTextColor(1, 0.5, 0) -- Orange
            end

            -- Mettre à jour les statistiques
            if eventCount > 0 then
                local avgCallbacks = callbackCount / eventCount
                statsText:SetText(string.format("EMZTOOLS_UI_EVENTMANAGER_STATS_FORMAT", eventCount, callbackCount, string.format("%.1f", avgCallbacks)))
                statsText:SetTextColor(0.8, 0.8, 1) -- Bleu clair
            else
                statsText:SetText("EMZTOOLS_UI_EVENTMANAGER_NO_STATS")
                statsText:SetTextColor(0.8, 0.8, 0.8) -- Gris
            end
        end
    end

    -- Mettre à jour périodiquement
    local updateFrame = CreateFrame("Frame")
    updateFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = (self.timer or 0) + elapsed
        if self.timer > 3 then -- Mise à jour toutes les 3 secondes
            UpdateEventManagerDisplay()
            self.timer = 0
        end
    end)

    -- Mise à jour initiale
    UpdateEventManagerDisplay()
end

-- ===================================================
-- ONGLET UTILITAIRES
-- ===================================================

function EmzTools.Data.UI:CreateUtilsTab(parent)
    local yOffset = -20

    -- === SECTION: INFORMATIONS JOUEUR ===
    local playerTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    playerTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    playerTitle:SetText("EMZTOOLS_UI_UTILS_PLAYER_SECTION")
    playerTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    -- Informations joueur en temps réel
    local playerInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    playerInfo:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    playerInfo:SetText("EMZTOOLS_UI_UTILS_LOADING_PLAYER_INFO")
    playerInfo:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 40

    -- === SECTION: ÉTAT DU JOUEUR ===
    local stateTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    stateTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    stateTitle:SetText("EMZTOOLS_UI_UTILS_STATE_SECTION")
    stateTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 25

    local stateInfo = parent:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    stateInfo:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    stateInfo:SetText("EMZTOOLS_UI_UTILS_LOADING_STATE")
    stateInfo:SetTextColor(0.8, 0.8, 0.8)

    yOffset = yOffset - 40

    -- === SECTION: OUTILS DE DÉVELOPPEMENT ===
    local devTitle = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    devTitle:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, yOffset)
    devTitle:SetText("EMZTOOLS_UI_UTILS_DEV_SECTION")
    devTitle:SetTextColor(self.Colors.title.r, self.Colors.title.g, self.Colors.title.b)

    yOffset = yOffset - 30

    -- Boutons d'outils développeur
    local dumpTableButton = self:CreateButton("DumpTable", parent, "EMZTOOLS_UI_DUMP_TABLE_BUTTON", 120, 24)
    dumpTableButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    dumpTableButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Utils and EmzTools.Data.Utils.DumpTable then
            EmzTools:Print("EMZTOOLS_UI_DUMPING_CORE_TABLE", "debug")
            EmzTools.Data.Utils:DumpTable(EmzTools, 0)
        end
    end)

    local testUtilsButton = self:CreateButton("TestUtils", parent, "EMZTOOLS_UI_TEST_UTILS_BUTTON", 120, 24)
    testUtilsButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, yOffset)
    testUtilsButton:SetScript("OnClick", function(self)
        if EmzTools.Data.Utils then
            local class = EmzTools.Data.Utils:GetPlayerClass()
            local hasMana = EmzTools.Data.Utils:PlayerHasMana()
            local canHavePet = EmzTools.Data.Utils:PlayerCanHavePet()
            local inCombat = EmzTools.Data.Utils:IsInCombat()

            EmzTools:Print("EMZTOOLS_UI_UTILS_TEST_RESULTS", "info")
            EmzTools:Print(string.format("EMZTOOLS_UI_UTILS_CLASS_TEST", class), "info")
            EmzTools:Print(string.format("EMZTOOLS_UI_UTILS_MANA_TEST", tostring(hasMana)), "info")
            EmzTools:Print(string.format("EMZTOOLS_UI_UTILS_PET_TEST", tostring(canHavePet)), "info")
            EmzTools:Print(string.format("EMZTOOLS_UI_UTILS_COMBAT_TEST", tostring(inCombat)), "info")
        end
    end)

    yOffset = yOffset - 35

    local reloadUIButton = self:CreateButton("ReloadUI", parent, "EMZTOOLS_UI_RELOAD_UI_BUTTON", 120, 24)
    reloadUIButton:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, yOffset)
    reloadUIButton:SetScript("OnClick", function(self)
        ReloadUI()
    end)

    -- Mise à jour en temps réel des informations
    local function UpdateUtilsDisplay()
        if EmzTools.Data.Utils then
            -- Informations joueur
            local class = EmzTools.Data.Utils:GetPlayerClass()
            local level = EmzTools.Data.Utils:GetPlayerLevel()
            local hpPercent = EmzTools.Data.Utils:GetPlayerHPPercent()
            local manaPercent = EmzTools.Data.Utils:GetPlayerManaPercent()

            local playerText = string.format("EMZTOOLS_UI_UTILS_PLAYER_FORMAT", level, class, math.floor(hpPercent))
            if EmzTools.Data.Utils:PlayerHasMana() then
                playerText = playerText .. string.format(" | Mana: %d%%", math.floor(manaPercent))
            end
            playerInfo:SetText(playerText)
            playerInfo:SetTextColor(0, 1, 0) -- Vert

            -- État du joueur
            local inCombat = EmzTools.Data.Utils:IsInCombat()
            local isDead = EmzTools.Data.Utils:IsDead()
            local isMounted = EmzTools.Data.Utils:IsMounted()
            local isSitting = EmzTools.Data.Utils:IsSitting()

            local stateText = ""
            if inCombat then stateText = stateText .. "EMZTOOLS_UI_UTILS_STATE_COMBAT " end
            if isDead then stateText = stateText .. "EMZTOOLS_UI_UTILS_STATE_DEAD " end
            if isMounted then stateText = stateText .. "EMZTOOLS_UI_UTILS_STATE_MOUNTED " end
            if isSitting then stateText = stateText .. "EMZTOOLS_UI_UTILS_STATE_SITTING " end
            if stateText == "" then stateText = "EMZTOOLS_UI_UTILS_STATE_NORMAL" end

            stateInfo:SetText(stateText)

            -- Couleur selon l'état
            if isDead then
                stateInfo:SetTextColor(1, 0, 0) -- Rouge si mort
            elseif inCombat then
                stateInfo:SetTextColor(1, 0.5, 0) -- Orange si en combat
            else
                stateInfo:SetTextColor(0, 1, 0) -- Vert si normal
            end
        else
            playerInfo:SetText("EMZTOOLS_UI_UTILS_MODULE_NOT_LOADED")
            playerInfo:SetTextColor(1, 0, 0) -- Rouge
            stateInfo:SetText("EMZTOOLS_UI_UTILS_UNAVAILABLE")
            stateInfo:SetTextColor(1, 0, 0) -- Rouge
        end
    end

    -- Mettre à jour périodiquement
    local updateFrame = CreateFrame("Frame")
    updateFrame:SetScript("OnUpdate", function(self, elapsed)
        self.timer = (self.timer or 0) + elapsed
        if self.timer > 1 then -- Mise à jour chaque seconde
            UpdateUtilsDisplay()
            self.timer = 0
        end
    end)

    -- Mise à jour initiale
    UpdateUtilsDisplay()
end

-- ===================================================
-- FONCTIONS DE GESTION DE LA CONFIGURATION
-- ===================================================

-- Applique la configuration (sauvegarde les changements)
function EmzTools.Data.UI:ApplyConfiguration()
    EmzTools:Print("EMZTOOLS_UI_CONFIG_APPLIED", "success")
    EmzTools:Print("EMZTOOLS_UI_CONFIG_APPLIED_DEBUG", "debug")

    -- Sauvegarder la base de données
    if EmzTools.Database and EmzTools.Database.Save then
        EmzTools.Database:Save()
    end
end

-- Remet à zéro la configuration (reset complet)
function EmzTools.Data.UI:ResetConfiguration()
    if EmzTools.Database and EmzTools.Database.Reset then
        EmzTools.Database:Reset()

        EmzTools:Print("EMZTOOLS_UI_CONFIG_RESET", "warning")
        EmzTools:Print("EMZTOOLS_UI_CONFIG_RESET_DEBUG", "debug")

        -- Fermer et rouvrir la fenêtre pour actualiser
        if mainConfigFrame then
            mainConfigFrame:Hide()
        end
        self:ShowMainConfig()
    end
end

-- Confirmation de reset de la base de données avec dialogue
function EmzTools.Data.UI:ConfirmDatabaseReset()
    -- Créer une fenêtre de confirmation simple
    local confirmFrame = self:CreateFrame("EmzToolsConfirmReset", UIParent, 300, 150)
    self:CenterFrame(confirmFrame)

    local title = confirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", confirmFrame, "TOP", 0, -20)
    title:SetText("EMZTOOLS_UI_CONFIRM_RESET_TITLE")
    title:SetTextColor(1, 0, 0)

    local text = confirmFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    text:SetPoint("CENTER", confirmFrame, "CENTER", 0, 10)
    text:SetText("EMZTOOLS_UI_CONFIRM_RESET_MESSAGE")

    local yesButton = self:CreateButton("ConfirmYes", confirmFrame, "EMZTOOLS_STATE_YES", 80, 24)
    yesButton:SetPoint("BOTTOM", confirmFrame, "BOTTOM", -50, 20)
    yesButton:SetScript("OnClick", function(self)
        if EmzTools.Database then
            EmzTools.Database:Reset()

            EmzTools:Print("EMZTOOLS_UI_DATABASE_RESET_SUCCESS", "warning")
        end
        confirmFrame:Hide()
    end)

    local noButton = self:CreateButton("ConfirmNo", confirmFrame, "EMZTOOLS_STATE_NO", 80, 24)
    noButton:SetPoint("BOTTOM", confirmFrame, "BOTTOM", 50, 20)
    noButton:SetScript("OnClick", function(self)
        confirmFrame:Hide()
    end)

    confirmFrame:Show()
end

-- ===================================================
-- FONCTIONS PUBLIQUES D'INTERFACE
-- ===================================================

-- Affiche l'interface principale de configuration
function EmzTools.Data.UI:ShowMainConfig()
    if not mainConfigFrame then
        self:CreateMainConfigInterface()
    end

    mainConfigFrame:Show()
    isConfigVisible = true
    EmzTools:Print("EMZTOOLS_UI_CONFIG_SHOWN", "debug")
end

-- Cache l'interface principale de configuration
function EmzTools.Data.UI:HideMainConfig()
    if mainConfigFrame then
        mainConfigFrame:Hide()
        isConfigVisible = false

        EmzTools:Print("EMZTOOLS_UI_CONFIG_HIDDEN", "debug")
    end
end

-- Toggle l'interface principale de configuration
function EmzTools.Data.UI:ToggleMainConfig()
    if isConfigVisible then
        self:HideMainConfig()
    else
        self:ShowMainConfig()
    end
end

-- Applique le backdrop standard à une frame existante
function EmzTools.Data.UI:SetStandardBackdrop(frame, backdropType)
    if not frame then return end

    backdropType = backdropType or "dialog"
    local backdrop = self.BackdropConfigs[backdropType] or self.BackdropConfig

    frame:SetBackdrop(backdrop)
    frame:SetBackdropColor(
        self.Colors.backdrop.r,
        self.Colors.backdrop.g,
        self.Colors.backdrop.b,
        self.Colors.backdrop.a
    )
    frame:SetBackdropBorderColor(
        self.Colors.border.r,
        self.Colors.border.g,
        self.Colors.border.b,
        self.Colors.border.a
    )
end

-- ===================================================
-- FINALISATION ET CHARGEMENT
-- ===================================================

-- Log de chargement du module UI
EmzTools:Print("EMZTOOLS_UI_MODULE_LOADED", "debug")
