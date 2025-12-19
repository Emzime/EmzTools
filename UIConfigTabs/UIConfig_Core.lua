-- ===================================================
-- EmzTools - UIConfigTabs/UIConfig_InfoBar.lua
-- Onglet de configuration du module InfoBar
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- Vérifier que le système UIConfig est disponible
if not EmzTools or not EmzTools.Data or not EmzTools.Data.UIConfig then
    return
end

-- ===================================================
-- CRÉATION DU MODULE INFOBAR TAB
-- ===================================================

-- Créer la table du module
local InfoBarTab = {}

-- Variables locales pour les contrôles
local controls = {}
local config = {}
local radioButtonGroups = {}  -- Pour gérer les groupes de boutons radio

-- ===================================================
-- FONCTIONS UTILITAIRES COMPATIBLES LUA 5.0
-- ===================================================

-- Compatibilité table.getn pour les tables indexées
local function tableSize(tbl)
    if not tbl then return 0 end
    return table.getn(tbl) or 0
end

-- Fonction pour appliquer une couleur de texte
local function ApplyTextColor(textObject, color)
    if not textObject or not color then return end
    textObject:SetTextColor(color[1], color[2], color[3], color[4] or 1)
end

-- Fonction pour styliser un bouton avec le thème
local function StyleButton(button, themeData)
    if not button or not themeData then return end

    local buttonColors = themeData.button or {
        normalColor = {0.4, 0.4, 0.5, 1},
        highlightColor = {0.5, 0.5, 0.6, 1},
        pressedColor = {0.3, 0.3, 0.4, 1},
        textColor = {1, 1, 1, 1}
    }

    -- Appliquer les textures avec les couleurs du thème
    button:SetNormalTexture("Interface\\Buttons\\UI-Panel-Button-Up")
    button:SetPushedTexture("Interface\\Buttons\\UI-Panel-Button-Down")
    button:SetHighlightTexture("Interface\\Buttons\\UI-Panel-Button-Highlight")

    -- Teinter les textures avec les couleurs du thème
    local normalTexture = button:GetNormalTexture()
    if normalTexture then
        normalTexture:SetVertexColor(
            buttonColors.normalColor[1],
            buttonColors.normalColor[2],
            buttonColors.normalColor[3],
            buttonColors.normalColor[4] or 1
        )
    end

    local pushedTexture = button:GetPushedTexture()
    if pushedTexture then
        pushedTexture:SetVertexColor(
            buttonColors.pressedColor[1],
            buttonColors.pressedColor[2],
            buttonColors.pressedColor[3],
            buttonColors.pressedColor[4] or 1
        )
    end

    local highlightTexture = button:GetHighlightTexture()
    if highlightTexture then
        highlightTexture:SetVertexColor(
            buttonColors.highlightColor[1],
            buttonColors.highlightColor[2],
            buttonColors.highlightColor[3],
            buttonColors.highlightColor[4] or 1
        )
    end

    -- Appliquer la couleur du texte
    local fontString = button:GetFontString()
    if fontString then
        ApplyTextColor(fontString, buttonColors.textColor)
    end
end

-- Fonction pour créer un bouton stylisé
local function CreateStyledButton(parent, text, x, y, width, height, onClick)
    local button = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    button:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    button:SetWidth(width)
    button:SetHeight(height)
    button:SetText(text)

    -- Styliser le bouton avec le thème actuel
    local themeData = EmzTools.Data.UIConfig:GetThemeData()
    StyleButton(button, themeData)

    if onClick then
        button:SetScript("OnClick", onClick)
    end

    return button
end

-- Fonction pour créer un checkbox compatible
local function CreateCheckbox(parent, text, x, y, isChecked, onClick)
    local checkbox = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    checkbox:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    checkbox:SetWidth(24)
    checkbox:SetHeight(24)

    local checkboxText = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    checkboxText:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
    checkboxText:SetText(text)

    checkbox:SetChecked(isChecked and 1 or 0)

    if onClick then
        checkbox:SetScript("OnClick", onClick)
    end

    return checkbox, checkboxText
end

-- Fonction pour créer un bouton radio (utilise l'apparence des checkbox mais avec logique de groupe)
local function CreateRadioButton(parent, text, x, y, value, isChecked, groupName, onClick)
    local radioButton = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    radioButton:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    radioButton:SetWidth(24)
    radioButton:SetHeight(24)
    radioButton.value = value
    radioButton.groupName = groupName or "default"

    local radioText = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    radioText:SetPoint("LEFT", radioButton, "RIGHT", 5, 0)
    radioText:SetText(text)

    radioButton:SetChecked(isChecked and 1 or 0)

    radioButton:SetScript("OnClick", function()
        -- Si on clique sur un bouton déjà coché, on ne fait rien
        if this:GetChecked() == 1 then
            return
        end

        -- Cocher ce bouton
        this:SetChecked(1)

        -- Décocher tous les autres boutons du même groupe
        if not radioButtonGroups[groupName] then
            radioButtonGroups[groupName] = {}
        end

        for _, otherButton in pairs(radioButtonGroups[groupName]) do
            if otherButton ~= this then
                otherButton:SetChecked(0)
            end
        end

        -- Appeler la fonction onClick
        if onClick then
            onClick()
        end
    end)

    -- Stocker dans le groupe
    if not radioButtonGroups[groupName] then
        radioButtonGroups[groupName] = {}
    end
    table.insert(radioButtonGroups[groupName], radioButton)

    return radioButton, radioText
end

-- Fonction pour créer une ligne de séparation avec la couleur du thème
local function CreateSeparator(parent, yPosition, widthPercent)
    local themeData = EmzTools.Data.UIConfig:GetThemeData()
    local borderColor = themeData.frame and themeData.frame.borderColor or {0.2, 0.2, 0.25, 0.8}

    local separator = parent:CreateTexture(nil, "BACKGROUND")
    separator:SetPoint("TOP", parent, "TOP", 0, yPosition)
    separator:SetWidth(parent:GetWidth() * (widthPercent or 0.9))
    separator:SetHeight(1)
    separator:SetTexture(borderColor[1], borderColor[2], borderColor[3], borderColor[4] or 0.3)
    return separator
end

-- Charger la configuration de l'InfoBar
local function LoadConfig()
    config = {
        enabled = true,
        showXP = true,
        showGold = true,
        showFPS = true,
        showLatency = true,
        -- showTime = true, -- L'horloge est toujours visible, pas d'option pour la masquer
        locked = true,
        width = "full",
        height = 20,
        clock24Hour = true,
        transparency = 1.0
    }

    -- Charger depuis la base de données si disponible
    if EmzTools.Data and EmzTools.Data.Database then
        config.enabled = EmzTools.Data.Database:Get("InfoBar", "enabled", true)
        config.showXP = EmzTools.Data.Database:Get("InfoBar", "showXP", true)
        config.showGold = EmzTools.Data.Database:Get("InfoBar", "showGold", true)
        config.showFPS = EmzTools.Data.Database:Get("InfoBar", "showFPS", true)
        config.showLatency = EmzTools.Data.Database:Get("InfoBar", "showLatency", true)
        -- showTime n'est pas chargé car l'horloge est toujours visible
        config.locked = EmzTools.Data.Database:Get("InfoBar", "locked", true)
        config.width = EmzTools.Data.Database:Get("InfoBar", "width", "full")
        config.height = EmzTools.Data.Database:Get("InfoBar", "height", 20)
        config.clock24Hour = EmzTools.Data.Database:Get("InfoBar", "clock24Hour", true)
        config.transparency = EmzTools.Data.Database:Get("InfoBar", "transparency", 1.0)
    end
end

-- Sauvegarder la configuration de l'InfoBar
local function SaveConfig()
    if EmzTools.Data and EmzTools.Data.Database then
        EmzTools.Data.Database:Set("InfoBar", "enabled", config.enabled)
        EmzTools.Data.Database:Set("InfoBar", "showXP", config.showXP)
        EmzTools.Data.Database:Set("InfoBar", "showGold", config.showGold)
        EmzTools.Data.Database:Set("InfoBar", "showFPS", config.showFPS)
        EmzTools.Data.Database:Set("InfoBar", "showLatency", config.showLatency)
        -- showTime n'est pas sauvegardé car l'horloge est toujours visible
        EmzTools.Data.Database:Set("InfoBar", "locked", config.locked)
        EmzTools.Data.Database:Set("InfoBar", "width", config.width)
        EmzTools.Data.Database:Set("InfoBar", "height", config.height)
        EmzTools.Data.Database:Set("InfoBar", "clock24Hour", config.clock24Hour)
        EmzTools.Data.Database:Set("InfoBar", "transparency", config.transparency)

        -- Appliquer les changements à l'InfoBar si elle existe
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.SetConfigValue then
            for key, value in pairs(config) do
                EmzTools.Data.InfoBar:SetConfigValue(key, value)
            end
        end

        return true
    end
    return false
end

-- Fonction pour afficher un message de feedback
local function ShowOptionFeedback(optionName, enabled)
    local message = optionName
    if enabled then
        message = message .. " " .. EmzTools:GetText("EMZTOOLS_STATE_ENABLED")
        EmzTools:Print(message, "success")
    else
        message = message .. " " .. EmzTools:GetText("EMZTOOLS_STATE_DISABLED")
        EmzTools:Print(message, "info")
    end
end

-- ===================================================
-- Crée le contenu de l'onglet InfoBar
-- ===================================================

function InfoBarTab:CreateContent(parentFrame, yOffset)
    -- Charger la configuration
    LoadConfig()

    -- Obtenir le thème actuel
    local themeData = EmzTools.Data.UIConfig:GetThemeData()
    local titleColor = themeData.header and themeData.header.titleColor or {1, 0.82, 0, 1}
    local textColor = themeData.card and themeData.card.labelColor or {0.9, 0.9, 0.9, 1}

    -- ===================================================
    -- CRÉATION DU CONTENU COMPACT
    -- ===================================================

    local currentY = yOffset - 10

    -- Titre principal
    controls.title = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    controls.title:SetPoint("TOP", parentFrame, "TOP", 0, currentY)
    controls.title:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_INFOBAR_TITLE"))
    ApplyTextColor(controls.title, titleColor)

    currentY = currentY - 40

    -- Options (SEULEMENT InfoBar comme checkbox simple)
    controls.optionLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.optionLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.optionLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_OPTIONS"))
    ApplyTextColor(controls.optionLabel, textColor)

    -- InfoBar checkbox (simple checkbox, pas un bouton radio)
    controls.infoBarCheckbox, controls.infoBarText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_UCCONFIG_INFOBAR"), 100, currentY, config.enabled, function()
        config.enabled = this:GetChecked() == 1
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_INFOBAR"), config.enabled)
    end)
    ApplyTextColor(controls.infoBarText, textColor)

    currentY = currentY - 40

    -- Séparateur
    CreateSeparator(parentFrame, currentY, 0.95)
    currentY = currentY - 20

    -- Layout section - BOUTONS RADIO EXCLUSIFS
    controls.layoutLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.layoutLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.layoutLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_LAYOUT") .. ":")
    ApplyTextColor(controls.layoutLabel, textColor)

    -- Plein écran radio
    controls.fullScreenRadio, controls.fullScreenText = CreateRadioButton(
        parentFrame,
        EmzTools:GetText("EMZTOOLS_UCCONFIG_FULLSCREEN"),
        100,
        currentY,
        "full",
        config.width == "full",
        "layoutGroup",
        function()
            config.width = "full"
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_LAYOUT_FULLSCREEN"), true)
        end
    )
    ApplyTextColor(controls.fullScreenText, textColor)

    -- Personnalisée radio
    controls.customRadio, controls.customText = CreateRadioButton(
        parentFrame,
        EmzTools:GetText("EMZTOOLS_UCCONFIG_CUSTOM") .. ":",
        250,
        currentY,
        "custom",
        config.width ~= "full",
        "layoutGroup",
        function()
            config.width = 400  -- Valeur par défaut pour personnalisée
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_LAYOUT_CUSTOM"), true)
        end
    )
    ApplyTextColor(controls.customText, textColor)

    -- Personnalisée checkbox (simple checkbox lié au bouton radio)
    controls.customWidthCheckbox, controls.customWidthText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_UCCONFIG_FULLSCREEN"), 400, currentY, config.width ~= "full", function()
        local isChecked = this:GetChecked() == 1
        if isChecked then
            -- Passer en mode personnalisé
            config.width = 400
            controls.fullScreenRadio:SetChecked(0)
            controls.customRadio:SetChecked(1)
        else
            -- Passer en mode plein écran
            config.width = "full"
            controls.fullScreenRadio:SetChecked(1)
            controls.customRadio:SetChecked(0)
        end
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_CUSTOM_WIDTH"), isChecked)
    end)
    ApplyTextColor(controls.customWidthText, textColor)

    currentY = currentY - 40

    -- Séparateur
    CreateSeparator(parentFrame, currentY, 0.95)
    currentY = currentY - 20

    -- Hauteur section - BOUTONS RADIO EXCLUSIFS
    controls.heightLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.heightLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.heightLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_HEIGHT") .. ":")
    ApplyTextColor(controls.heightLabel, textColor)

    -- 20px radio
    controls.height20Radio, controls.height20Text = CreateRadioButton(
        parentFrame,
        "20px",
        100,
        currentY,
        20,
        config.height == 20,
        "heightGroup",
        function()
            config.height = 20
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_HEIGHT_20PX"), true)
        end
    )
    ApplyTextColor(controls.height20Text, textColor)

    -- 16px radio
    controls.height16Radio, controls.height16Text = CreateRadioButton(
        parentFrame,
        "16px",
        200,
        currentY,
        16,
        config.height == 16,
        "heightGroup",
        function()
            config.height = 16
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_HEIGHT_16PX"), true)
        end
    )
    ApplyTextColor(controls.height16Text, textColor)

    currentY = currentY - 30

    -- Transparence label
    controls.transparencyLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.transparencyLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.transparencyLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_TRANSPARENCY") .. ":")
    ApplyTextColor(controls.transparencyLabel, textColor)

    -- Valeurs de transparence (affichage seulement)
    controls.transparency100Text = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.transparency100Text:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 150, currentY)
    controls.transparency100Text:SetText("100%")
    ApplyTextColor(controls.transparency100Text, textColor)

    controls.transparency10Text = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.transparency10Text:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 250, currentY)
    controls.transparency10Text:SetText("10%")
    ApplyTextColor(controls.transparency10Text, textColor)

    -- Slider pour la transparence (invisible mais fonctionnel)
    controls.transparencySlider = CreateFrame("Slider", nil, parentFrame, "OptionsSliderTemplate")
    controls.transparencySlider:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 150, currentY - 25)
    controls.transparencySlider:SetWidth(150)
    controls.transparencySlider:SetHeight(17)
    controls.transparencySlider:SetMinMaxValues(1, 10)  -- 1-10 pour simuler 10%-100%
    controls.transparencySlider:SetValueStep(1)
    controls.transparencySlider:SetValue(config.transparency * 10)  -- Convertir 0.1-1.0 en 1-10

    -- Texte de valeur actuelle
    controls.transparencyValueText = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    controls.transparencyValueText:SetPoint("TOP", controls.transparencySlider, "BOTTOM", 0, -5)
    controls.transparencyValueText:SetText(string.format("%d%%", config.transparency * 100))

    controls.transparencySlider:SetScript("OnValueChanged", function()
        local value = this:GetValue()
        config.transparency = value / 10  -- Convertir 1-10 en 0.1-1.0
        if controls.transparencyValueText then
            controls.transparencyValueText:SetText(string.format("%d%%", config.transparency * 100))
        end
        SaveConfig()
    end)

    currentY = currentY - 60

    -- Séparateur
    CreateSeparator(parentFrame, currentY, 0.95)
    currentY = currentY - 20

    -- Éléments affichés section - CHECKBOXES SIMPLES
    controls.elementsLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.elementsLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.elementsLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_DISPLAY_ELEMENTS") .. ":")
    ApplyTextColor(controls.elementsLabel, textColor)

    -- Tous les éléments sur la même ligne - CHECKBOXES SIMPLES
    local elementStartX = 150
    local elementSpacing = 80

    -- FPS (checkbox simple)
    controls.fpsCheckbox, controls.fpsText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_INFOBAR_FPS_SHORT"), elementStartX, currentY, config.showFPS, function()
        config.showFPS = this:GetChecked() == 1
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_INFOBAR_FPS_SHORT"), config.showFPS)
    end)
    ApplyTextColor(controls.fpsText, textColor)

    -- Latence (checkbox simple)
    controls.latencyCheckbox, controls.latencyText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_INFOBAR_LATENCY_SHORT"), elementStartX + elementSpacing, currentY, config.showLatency, function()
        config.showLatency = this:GetChecked() == 1
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_INFOBAR_LATENCY_SHORT"), config.showLatency)
    end)
    ApplyTextColor(controls.latencyText, textColor)

    -- Or (checkbox simple)
    controls.goldCheckbox, controls.goldText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_INFOBAR_GOLD_SHORT"), elementStartX + (elementSpacing * 2), currentY, config.showGold, function()
        config.showGold = this:GetChecked() == 1
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_INFOBAR_GOLD_SHORT"), config.showGold)
    end)
    ApplyTextColor(controls.goldText, textColor)

    -- XP (checkbox simple)
    controls.xpCheckbox, controls.xpText = CreateCheckbox(parentFrame, EmzTools:GetText("EMZTOOLS_INFOBAR_XP_SHORT"), elementStartX + (elementSpacing * 3), currentY, config.showXP, function()
        config.showXP = this:GetChecked() == 1
        SaveConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_INFOBAR_XP_SHORT"), config.showXP)
    end)
    ApplyTextColor(controls.xpText, textColor)

    currentY = currentY - 40

    -- Séparateur
    CreateSeparator(parentFrame, currentY, 0.95)
    currentY = currentY - 20

    -- Format horloge section - BOUTONS RADIO EXCLUSIFS
    controls.clockLabel = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.clockLabel:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 20, currentY)
    controls.clockLabel:SetText(EmzTools:GetText("EMZTOOLS_UCCONFIG_CLOCK_FORMAT") .. ":")
    ApplyTextColor(controls.clockLabel, textColor)

    -- Déterminer quelle option est cochée
    local isAutoChecked = config.clock24Hour == nil
    local is24Checked = config.clock24Hour == true
    local is12Checked = config.clock24Hour == false

    -- Auto radio
    controls.clockAutoRadio, controls.clockAutoText = CreateRadioButton(
        parentFrame,
        EmzTools:GetText("EMZTOOLS_INFOBAR_CLOCK_AUTO"),
        150,
        currentY,
        nil,
        isAutoChecked,
        "clockGroup",
        function()
            config.clock24Hour = nil
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_CLOCK_FORMAT_AUTO"), true)
        end
    )
    ApplyTextColor(controls.clockAutoText, textColor)

    -- 24 heures radio
    controls.clock24Radio, controls.clock24Text = CreateRadioButton(
        parentFrame,
        EmzTools:GetText("EMZTOOLS_INFOBAR_CLOCK_24H"),
        320,
        currentY,
        true,
        is24Checked,
        "clockGroup",
        function()
            config.clock24Hour = true
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_CLOCK_FORMAT_24H"), true)
        end
    )
    ApplyTextColor(controls.clock24Text, textColor)

    -- 12 heures radio
    controls.clock12Radio, controls.clock12Text = CreateRadioButton(
        parentFrame,
        EmzTools:GetText("EMZTOOLS_INFOBAR_CLOCK_12H"),
        450,
        currentY,
        false,
        is12Checked,
        "clockGroup",
        function()
            config.clock24Hour = false
            SaveConfig()
            ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_UCCONFIG_CLOCK_FORMAT_12H"), true)
        end
    )
    ApplyTextColor(controls.clock12Text, textColor)

    currentY = currentY - 40

    -- Séparateur
    CreateSeparator(parentFrame, currentY, 0.95)
    currentY = currentY - 30

    -- Boutons en bas
    local buttonY = currentY - 20

    -- Bouton Tester
    controls.testButton = CreateStyledButton(parentFrame, EmzTools:GetText("EMZTOOLS_UCCONFIG_TEST"), 150, buttonY, 100, 25, function()
        if EmzTools.Data.InfoBar and EmzTools.Data.InfoBar.Toggle then
            EmzTools.Data.InfoBar:Toggle()
            EmzTools:Print("EMZTOOLS_UCCONFIG_INFOBAR_TESTED", "info")
        else
            EmzTools:Print("EMZTOOLS_UCCONFIG_INFOBAR_UNAVAILABLE", "warning")
        end
    end)

    -- Bouton Réinitialiser
    controls.resetButton = CreateStyledButton(parentFrame, EmzTools:GetText("EMZTOOLS_STATE_RESET"), 300, buttonY, 100, 25, function()
        -- Créer la popup de confirmation
        if not StaticPopupDialogs["EMZTOOLS_RESET_INFOBAR"] then
            StaticPopupDialogs["EMZTOOLS_RESET_INFOBAR"] = {
                text = EmzTools:GetText("EMZTOOLS_UCCONFIG_RESET_INFOBAR_CONFIRM"),
                button1 = EmzTools:GetText("EMZTOOLS_STATE_YES"),
                button2 = EmzTools:GetText("EMZTOOLS_STATE_NO"),
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                OnAccept = function()
                    -- Valeurs par défaut
                    local defaults = {
                        enabled = true,
                        showXP = true,
                        showGold = true,
                        showFPS = true,
                        showLatency = true,
                        locked = true,
                        width = "full",
                        height = 20,
                        clock24Hour = true,
                        transparency = 1.0
                    }

                    -- Mettre à jour la configuration
                    config = defaults

                    -- Mettre à jour les contrôles
                    if controls.infoBarCheckbox then
                        controls.infoBarCheckbox:SetChecked(defaults.enabled and 1 or 0)
                    end

                    -- Layout
                    if controls.fullScreenRadio then
                        controls.fullScreenRadio:SetChecked(1)
                        controls.customRadio:SetChecked(0)
                    end
                    if controls.customWidthCheckbox then
                        controls.customWidthCheckbox:SetChecked(0)
                    end

                    -- Hauteur
                    if controls.height20Radio then
                        controls.height20Radio:SetChecked(1)
                    end
                    if controls.height16Radio then
                        controls.height16Radio:SetChecked(0)
                    end

                    -- Transparence
                    if controls.transparencySlider then
                        controls.transparencySlider:SetValue(defaults.transparency * 10)
                    end
                    if controls.transparencyValueText then
                        controls.transparencyValueText:SetText(string.format("%d%%", defaults.transparency * 100))
                    end

                    -- Éléments affichés
                    if controls.fpsCheckbox then
                        controls.fpsCheckbox:SetChecked(1)
                    end
                    if controls.latencyCheckbox then
                        controls.latencyCheckbox:SetChecked(1)
                    end
                    if controls.goldCheckbox then
                        controls.goldCheckbox:SetChecked(1)
                    end
                    if controls.xpCheckbox then
                        controls.xpCheckbox:SetChecked(1)
                    end

                    -- Format horloge
                    if controls.clock24Radio then
                        controls.clock24Radio:SetChecked(1)
                    end
                    if controls.clockAutoRadio then
                        controls.clockAutoRadio:SetChecked(0)
                    end
                    if controls.clock12Radio then
                        controls.clock12Radio:SetChecked(0)
                    end

                    -- Sauvegarder
                    SaveConfig()

                    EmzTools:Print("EMZTOOLS_UCCONFIG_RESET_INFOBAR_SUCCESS", "success")
                end
            }
        end
        StaticPopup_Show("EMZTOOLS_RESET_INFOBAR")
    end)

    -- Stocker les références
    self.controls = controls

    EmzTools:Print("EMZTOOLS_UCCONFIG_INFOBAR_LOADED", "debug")
end

-- ===================================================
-- FONCTIONS DU MODULE
-- ===================================================

function InfoBarTab:ResetToDefaults()
    if controls then
        -- Valeurs par défaut
        local defaults = {
            enabled = true,
            showXP = true,
            showGold = true,
            showFPS = true,
            showLatency = true,
            locked = true,
            width = "full",
            height = 20,
            clock24Hour = true,
            transparency = 1.0
        }

        if controls.infoBarCheckbox then
            controls.infoBarCheckbox:SetChecked(defaults.enabled and 1 or 0)
        end

        -- Layout
        if controls.fullScreenRadio then
            controls.fullScreenRadio:SetChecked(1)
            if controls.customRadio then controls.customRadio:SetChecked(0) end
        end
        if controls.customWidthCheckbox then
            controls.customWidthCheckbox:SetChecked(0)
        end

        -- Hauteur
        if controls.height20Radio then
            controls.height20Radio:SetChecked(1)
            if controls.height16Radio then controls.height16Radio:SetChecked(0) end
        end

        -- Transparence
        if controls.transparencySlider then
            controls.transparencySlider:SetValue(defaults.transparency * 10)
        end
        if controls.transparencyValueText then
            controls.transparencyValueText:SetText(string.format("%d%%", defaults.transparency * 100))
        end

        -- Éléments affichés
        if controls.fpsCheckbox then
            controls.fpsCheckbox:SetChecked(1)
        end
        if controls.latencyCheckbox then
            controls.latencyCheckbox:SetChecked(1)
        end
        if controls.goldCheckbox then
            controls.goldCheckbox:SetChecked(1)
        end
        if controls.xpCheckbox then
            controls.xpCheckbox:SetChecked(1)
        end

        -- Format horloge
        if controls.clock24Radio then
            controls.clock24Radio:SetChecked(1)
            if controls.clockAutoRadio then controls.clockAutoRadio:SetChecked(0) end
            if controls.clock12Radio then controls.clock12Radio:SetChecked(0) end
        end

        -- Sauvegarder
        config = defaults
        SaveConfig()
    end
end

function InfoBarTab:UpdateControls()
    if not controls then return end

    LoadConfig()

    if controls.infoBarCheckbox then
        controls.infoBarCheckbox:SetChecked(config.enabled and 1 or 0)
    end

    -- Layout
    if controls.fullScreenRadio then
        controls.fullScreenRadio:SetChecked(config.width == "full" and 1 or 0)
    end
    if controls.customRadio then
        controls.customRadio:SetChecked(config.width ~= "full" and 1 or 0)
    end
    if controls.customWidthCheckbox then
        controls.customWidthCheckbox:SetChecked(config.width ~= "full" and 1 or 0)
    end

    -- Hauteur
    if controls.height20Radio then
        controls.height20Radio:SetChecked(config.height == 20 and 1 or 0)
    end
    if controls.height16Radio then
        controls.height16Radio:SetChecked(config.height == 16 and 1 or 0)
    end

    -- Transparence
    if controls.transparencySlider then
        controls.transparencySlider:SetValue(config.transparency * 10)
    end
    if controls.transparencyValueText then
        controls.transparencyValueText:SetText(string.format("%d%%", config.transparency * 100))
    end

    -- Éléments affichés
    if controls.fpsCheckbox then
        controls.fpsCheckbox:SetChecked(config.showFPS and 1 or 0)
    end
    if controls.latencyCheckbox then
        controls.latencyCheckbox:SetChecked(config.showLatency and 1 or 0)
    end
    if controls.goldCheckbox then
        controls.goldCheckbox:SetChecked(config.showGold and 1 or 0)
    end
    if controls.xpCheckbox then
        controls.xpCheckbox:SetChecked(config.showXP and 1 or 0)
    end

    -- Format horloge
    if controls.clock24Radio then
        controls.clock24Radio:SetChecked(config.clock24Hour == true and 1 or 0)
    end
    if controls.clockAutoRadio then
        controls.clockAutoRadio:SetChecked(config.clock24Hour == nil and 1 or 0)
    end
    if controls.clock12Radio then
        controls.clock12Radio:SetChecked(config.clock24Hour == false and 1 or 0)
    end
end

-- ===================================================
-- ENREGISTREMENT DU MODULE
-- ===================================================

EmzTools.Data.UIConfig["InfoBar"] = InfoBarTab
EmzTools.Data.UIConfig.InfoBar = InfoBarTab

-- Fonction pour enregistrer l'onglet
local function RegisterInfoBarTab()
    if not EmzTools.Data.UIConfig then
        return false
    end

    if EmzTools.Data.UIConfig.RegisterModuleTab then
        local success = EmzTools.Data.UIConfig:RegisterModuleTab({
            name = "InfoBar",
            displayName = EmzTools:GetText("EMZTOOLS_UCCONFIG_INFOBAR"),
            description = EmzTools:GetText("EMZTOOLS_UCCONFIG_INFOBAR_DESC"),
            file = "UIConfig_InfoBar",
            icon = "Interface\\Icons\\INV_Misc_Note_01",
            iconColor = {1, 0.82, 0},
            group = "Interface"
        })

        if success then
            EmzTools:Print("EMZTOOLS_UCCONFIG_INFOBAR_REGISTERED", "debug")
        end

        return success
    end

    return false
end

-- Initialisation différée
if EmzTools and EmzTools.ScheduleTimer then
    EmzTools:ScheduleTimer(RegisterInfoBarTab, 1)
else
    local waitFrame = CreateFrame("Frame")
    waitFrame.timeElapsed = 0
    waitFrame:SetScript("OnUpdate", function()
        this.timeElapsed = this.timeElapsed + arg1
        if this.timeElapsed > 1 then
            RegisterInfoBarTab()
            this:SetScript("OnUpdate", nil)
        end
    end)
end
