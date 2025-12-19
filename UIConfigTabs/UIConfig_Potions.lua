-- ===================================================
-- EmzTools - UIConfigTabs/UIConfig_Potions.lua
-- Onglet de configuration du module Potions
-- Compatible WoW 1.12 (Lua 5.0)
-- ===================================================

-- Vérifier que le système UIConfig est disponible
if not EmzTools or not EmzTools.Data or not EmzTools.Data.UIConfig then
    return
end

-- ===================================================
-- CRÉATION DU MODULE POTIONS TAB
-- ===================================================

-- Créer la table du module
local PotionsTab = {}

-- Variables locales pour les contrôles
local controls = {}
local potionConfig = {}

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

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
    if button:GetNormalTexture() then
        button:GetNormalTexture():SetVertexColor(
            buttonColors.normalColor[1],
            buttonColors.normalColor[2],
            buttonColors.normalColor[3],
            buttonColors.normalColor[4] or 1
        )
    end

    if button:GetPushedTexture() then
        button:GetPushedTexture():SetVertexColor(
            buttonColors.pressedColor[1],
            buttonColors.pressedColor[2],
            buttonColors.pressedColor[3],
            buttonColors.pressedColor[4] or 1
        )
    end

    if button:GetHighlightTexture() then
        button:GetHighlightTexture():SetVertexColor(
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

-- Fonction pour créer des icônes d'aide avec l'icône personnalisée
local function CreateHelpIcon(parentFrame, anchorTo, tooltipText, xOffset, yOffset)
    local helpButton = CreateFrame("Button", nil, parentFrame)
    helpButton:SetWidth(16)
    helpButton:SetHeight(16)
    helpButton:SetPoint("LEFT", anchorTo, "RIGHT", xOffset or 5, yOffset or 0)

    local icon = helpButton:CreateTexture(nil, "OVERLAY")
    icon:SetAllPoints()
    icon:SetTexture("Interface\\Addons\\EmzTools\\Textures\\Icon\\Question")
    icon:SetVertexColor(1, 1, 1)

    helpButton:SetScript("OnEnter", function()
        GameTooltip:SetOwner(this, "ANCHOR_RIGHT")
        GameTooltip:ClearLines()
        GameTooltip:SetText(tooltipText, 1, 1, 1, 1, true)
        GameTooltip:Show()
    end)

    helpButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    helpButton:SetHighlightTexture("Interface\\Addons\\EmzTools\\Textures\\Icon\\Question_Highlight")

    return helpButton
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

-- Fonction pour créer un bouton radio qui ressemble à une checkbox
local function CreateCheckboxStyleRadioButton(parent, text, x, y, groupName, value, optionText)
    local radioButton = CreateFrame("CheckButton", nil, parent, "UICheckButtonTemplate")
    radioButton:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)
    radioButton:SetWidth(24)
    radioButton:SetHeight(24)
    radioButton.groupName = groupName
    radioButton.value = value
    radioButton.optionText = optionText

    local radioText = radioButton:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    radioText:SetPoint("LEFT", radioButton, "RIGHT", 5, 0)
    radioText:SetText(text)

    -- Appliquer la couleur du texte depuis le thème
    local themeData = EmzTools.Data.UIConfig:GetThemeData()
    local textColor = themeData.card and themeData.card.labelColor or {0.9, 0.9, 0.9, 1}
    ApplyTextColor(radioText, textColor)

    return radioButton, radioText
end

-- Charger la configuration des potions
local function LoadPotionConfig()
    potionConfig = {
        autoHeal = true,
        autoMana = true,
        healPriority = "smart",
        soundAlert = true,
        announce = false,
        useHealthstone = true,
        offensivePriority = "dispel"
    }

    -- Charger depuis la base de données si disponible
    if EmzTools.Data and EmzTools.Data.Database then
        potionConfig.autoHeal = EmzTools.Data.Database:Get("Potions", "autoHeal", true)
        potionConfig.autoMana = EmzTools.Data.Database:Get("Potions", "autoMana", true)
        potionConfig.healPriority = EmzTools.Data.Database:Get("Potions", "healPriority", "smart")
        potionConfig.soundAlert = EmzTools.Data.Database:Get("Potions", "soundAlert", true)
        potionConfig.announce = EmzTools.Data.Database:Get("Potions", "announce", false)
        potionConfig.useHealthstone = EmzTools.Data.Database:Get("Potions", "useHealthstone", true)
        potionConfig.offensivePriority = EmzTools.Data.Database:Get("Potions", "offensivePriority", "dispel")
    end
end

-- Sauvegarder la configuration des potions
local function SavePotionConfig()
    if EmzTools.Data and EmzTools.Data.Database then
        EmzTools.Data.Database:Set("Potions", "autoHeal", potionConfig.autoHeal)
        EmzTools.Data.Database:Set("Potions", "autoMana", potionConfig.autoMana)
        EmzTools.Data.Database:Set("Potions", "healPriority", potionConfig.healPriority)
        EmzTools.Data.Database:Set("Potions", "soundAlert", potionConfig.soundAlert)
        EmzTools.Data.Database:Set("Potions", "announce", potionConfig.announce)
        EmzTools.Data.Database:Set("Potions", "useHealthstone", potionConfig.useHealthstone)
        EmzTools.Data.Database:Set("Potions", "offensivePriority", potionConfig.offensivePriority)
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
-- Crée le contenu de l'onglet Potions
-- ===================================================

function PotionsTab:CreateContent(parentFrame, yOffset)
    -- Charger la configuration
    LoadPotionConfig()

    -- Obtenir le thème actuel
    local themeData = EmzTools.Data.UIConfig:GetThemeData()
    local titleColor = themeData.header and themeData.header.titleColor or {1, 0.82, 0, 1}
    local textColor = themeData.card and themeData.card.labelColor or {0.9, 0.9, 0.9, 1}
    local descColor = themeData.card and themeData.card.descColor or {0.8, 0.8, 0.8, 1}

    -- Créer un ScrollFrame pour contenir tout le contenu
    local scrollFrame = CreateFrame("ScrollFrame", "EmzToolsPotionsScrollFrame", parentFrame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", 10, yOffset - 10)
    scrollFrame:SetPoint("BOTTOMRIGHT", parentFrame, "BOTTOMRIGHT", -30, 10)

    -- Créer un cadre pour contenir les éléments défilables
    local scrollChild = CreateFrame("Frame", nil, scrollFrame)
    scrollChild:SetWidth(scrollFrame:GetWidth() - 20)
    scrollChild:SetHeight(550)

    scrollFrame:SetScrollChild(scrollChild)

    local currentY = -10

    -- Titre
    controls.title = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.title:SetPoint("TOP", scrollChild, "TOP", 0, currentY)
    controls.title:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_TITLE"))
    ApplyTextColor(controls.title, titleColor)

    currentY = currentY - 35

    -- Description
    controls.desc = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    controls.desc:SetPoint("TOP", controls.title, "BOTTOM", 0, -5)
    controls.desc:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_DESC"))
    ApplyTextColor(controls.desc, descColor)

    currentY = currentY - 40

    -- Ligne de séparation après le titre
    CreateSeparator(scrollChild, currentY, 0.8)
    currentY = currentY - 20

    -- ===================================================
    -- SECTION 1 : POTIONS DE SOIN
    -- ===================================================

    controls.healTitle = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.healTitle:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.healTitle:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_HEAL_TITLE"))
    ApplyTextColor(controls.healTitle, titleColor)

    currentY = currentY - 30

    -- Auto-soin
    controls.autoHealCheckbox = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
    controls.autoHealCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.autoHealCheckbox:SetWidth(24)
    controls.autoHealCheckbox:SetHeight(24)
    controls.autoHealText = controls.autoHealCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.autoHealText:SetPoint("LEFT", controls.autoHealCheckbox, "RIGHT", 5, 0)
    controls.autoHealText:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_HEAL"))
    ApplyTextColor(controls.autoHealText, textColor)
    controls.autoHealCheckbox:SetChecked(potionConfig.autoHeal and 1 or 0)
    controls.autoHealCheckbox:SetScript("OnClick", function()
        local button = this
        potionConfig.autoHeal = button:GetChecked() == 1
        SavePotionConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_HEAL"), potionConfig.autoHeal)
    end)

    -- Icône d'aide pour Auto-soin
    controls.autoHealHelpIcon = CreateHelpIcon(scrollChild, controls.autoHealText,
        EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_HEAL_HELP"), 10, 0)

    currentY = currentY - 40

    -- Priorité de soin
    controls.healPriorityLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.healPriorityLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.healPriorityLabel:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_HEAL_PRIORITY"))
    ApplyTextColor(controls.healPriorityLabel, textColor)

    currentY = currentY - 25

    -- Boutons radio style checkbox pour la priorité de soin (sur la même ligne)
    local healPriorityOptions = {
        {value = "smart", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_SMART"), x = 40},
        {value = "stone_first", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_STONE_FIRST"), x = 180},
        {value = "potion_first", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_POTION_FIRST"), x = 320}
    }

    for i, option in ipairs(healPriorityOptions) do
        local radioButton, radioText = CreateCheckboxStyleRadioButton(
            scrollChild,
            option.text,
            option.x,
            currentY,
            "healPriority",
            option.value,
            option.text
        )

        radioButton:SetChecked(potionConfig.healPriority == option.value and 1 or 0)

        radioButton:SetScript("OnClick", function()
            local button = this
            local isChecked = button:GetChecked() == 1
            if isChecked then
                potionConfig.healPriority = button.value
                SavePotionConfig()

                -- Décocher les autres boutons du même groupe
                for j, opt in ipairs(healPriorityOptions) do
                    if opt.value ~= button.value then
                        local otherButton = controls["healPriorityRadio" .. j]
                        if otherButton then
                            otherButton:SetChecked(nil)
                        end
                    end
                end

                ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_HEAL_PRIORITY") .. ": " .. button.optionText, true)
            else
                -- On ne permet pas de décocher complètement
                button:SetChecked(1)
            end
        end)

        controls["healPriorityRadio" .. i] = radioButton
    end

    currentY = currentY - 40

    -- Utiliser les pierres de soins
    controls.useHealthstoneCheckbox = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
    controls.useHealthstoneCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.useHealthstoneCheckbox:SetWidth(24)
    controls.useHealthstoneCheckbox:SetHeight(24)
    controls.useHealthstoneText = controls.useHealthstoneCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.useHealthstoneText:SetPoint("LEFT", controls.useHealthstoneCheckbox, "RIGHT", 5, 0)
    controls.useHealthstoneText:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_USE_HEALTHSTONE"))
    ApplyTextColor(controls.useHealthstoneText, textColor)
    controls.useHealthstoneCheckbox:SetChecked(potionConfig.useHealthstone and 1 or 0)
    controls.useHealthstoneCheckbox:SetScript("OnClick", function()
        local button = this
        potionConfig.useHealthstone = button:GetChecked() == 1
        SavePotionConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_USE_HEALTHSTONE"), potionConfig.useHealthstone)
    end)

    -- Icône d'aide pour Utiliser les pierres de soins
    controls.useHealthstoneHelpIcon = CreateHelpIcon(scrollChild, controls.useHealthstoneText,
        EmzTools:GetText("EMZTOOLS_POTIONS_USE_HEALTHSTONE_HELP"), 10, 0)

    currentY = currentY - 40

    -- Ligne de séparation après Potions de soin
    CreateSeparator(scrollChild, currentY, 0.8)
    currentY = currentY - 20

    -- ===================================================
    -- SECTION 2 : POTIONS DE MANA
    -- ===================================================

    controls.manaTitle = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.manaTitle:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.manaTitle:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_MANA_TITLE"))
    ApplyTextColor(controls.manaTitle, titleColor)

    currentY = currentY - 30

    -- Auto-mana
    controls.autoManaCheckbox = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
    controls.autoManaCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.autoManaCheckbox:SetWidth(24)
    controls.autoManaCheckbox:SetHeight(24)
    controls.autoManaText = controls.autoManaCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.autoManaText:SetPoint("LEFT", controls.autoManaCheckbox, "RIGHT", 5, 0)
    controls.autoManaText:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_MANA"))
    ApplyTextColor(controls.autoManaText, textColor)
    controls.autoManaCheckbox:SetChecked(potionConfig.autoMana and 1 or 0)
    controls.autoManaCheckbox:SetScript("OnClick", function()
        local button = this
        potionConfig.autoMana = button:GetChecked() == 1
        SavePotionConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_MANA"), potionConfig.autoMana)
    end)

    -- Icône d'aide pour Auto-mana
    controls.autoManaHelpIcon = CreateHelpIcon(scrollChild, controls.autoManaText,
        EmzTools:GetText("EMZTOOLS_POTIONS_AUTO_MANA_HELP"), 10, 0)

    currentY = currentY - 40

    -- Ligne de séparation après Potions de mana
    CreateSeparator(scrollChild, currentY, 0.8)
    currentY = currentY - 20

    -- ===================================================
    -- SECTION 3 : ALERTES ET ANNONCES
    -- ===================================================

    controls.alertsTitle = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.alertsTitle:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.alertsTitle:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_ALERTS_TITLE"))
    ApplyTextColor(controls.alertsTitle, titleColor)

    currentY = currentY - 30

    -- Alerte sonore
    controls.soundAlertCheckbox = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
    controls.soundAlertCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.soundAlertCheckbox:SetWidth(24)
    controls.soundAlertCheckbox:SetHeight(24)
    controls.soundAlertText = controls.soundAlertCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.soundAlertText:SetPoint("LEFT", controls.soundAlertCheckbox, "RIGHT", 5, 0)
    controls.soundAlertText:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_SOUND_ALERT"))
    ApplyTextColor(controls.soundAlertText, textColor)
    controls.soundAlertCheckbox:SetChecked(potionConfig.soundAlert and 1 or 0)
    controls.soundAlertCheckbox:SetScript("OnClick", function()
        local button = this
        potionConfig.soundAlert = button:GetChecked() == 1
        SavePotionConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_SOUND_ALERT"), potionConfig.soundAlert)
    end)

    -- Icône d'aide pour Alerte sonore
    controls.soundAlertHelpIcon = CreateHelpIcon(scrollChild, controls.soundAlertText,
        EmzTools:GetText("EMZTOOLS_POTIONS_SOUND_ALERT_HELP"), 10, 0)

    currentY = currentY - 40

    -- Annoncer dans le chat
    controls.announceCheckbox = CreateFrame("CheckButton", nil, scrollChild, "UICheckButtonTemplate")
    controls.announceCheckbox:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.announceCheckbox:SetWidth(24)
    controls.announceCheckbox:SetHeight(24)
    controls.announceText = controls.announceCheckbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.announceText:SetPoint("LEFT", controls.announceCheckbox, "RIGHT", 5, 0)
    controls.announceText:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_ANNOUNCE"))
    ApplyTextColor(controls.announceText, textColor)
    controls.announceCheckbox:SetChecked(potionConfig.announce and 1 or 0)
    controls.announceCheckbox:SetScript("OnClick", function()
        local button = this
        potionConfig.announce = button:GetChecked() == 1
        SavePotionConfig()
        ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_ANNOUNCE"), potionConfig.announce)
    end)

    -- Icône d'aide pour Annoncer dans le chat
    controls.announceHelpIcon = CreateHelpIcon(scrollChild, controls.announceText,
        EmzTools:GetText("EMZTOOLS_POTIONS_ANNOUNCE_HELP"), 10, 0)

    currentY = currentY - 40

    -- Ligne de séparation après Alertes et annonces
    CreateSeparator(scrollChild, currentY, 0.8)
    currentY = currentY - 20

    -- ===================================================
    -- SECTION 4 : POTIONS OFFENSIVES
    -- ===================================================

    controls.offensiveTitle = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.offensiveTitle:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.offensiveTitle:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_OFFENSIVE_TITLE"))
    ApplyTextColor(controls.offensiveTitle, titleColor)

    currentY = currentY - 30

    -- Priorité offensive
    controls.offensivePriorityLabel = scrollChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    controls.offensivePriorityLabel:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 20, currentY)
    controls.offensivePriorityLabel:SetText(EmzTools:GetText("EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY"))
    ApplyTextColor(controls.offensivePriorityLabel, textColor)

    currentY = currentY - 25

    -- Boutons radio style checkbox pour la priorité offensive (sur la même ligne)
    local offensivePriorityOptions = {
        {value = "dispel", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_DISPEL"), x = 40},
        {value = "damage", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_DAMAGE"), x = 180},
        {value = "speed", text = EmzTools:GetText("EMZTOOLS_POTIONS_PRIORITY_SPEED"), x = 320}
    }

    for i, option in ipairs(offensivePriorityOptions) do
        local radioButton, radioText = CreateCheckboxStyleRadioButton(
            scrollChild,
            option.text,
            option.x,
            currentY,
            "offensivePriority",
            option.value,
            option.text
        )

        radioButton:SetChecked(potionConfig.offensivePriority == option.value and 1 or 0)

        radioButton:SetScript("OnClick", function()
            local button = this
            local isChecked = button:GetChecked() == 1
            if isChecked then
                potionConfig.offensivePriority = button.value
                SavePotionConfig()

                -- Décocher les autres boutons du même groupe
                for j, opt in ipairs(offensivePriorityOptions) do
                    if opt.value ~= button.value then
                        local otherButton = controls["offensivePriorityRadio" .. j]
                        if otherButton then
                            otherButton:SetChecked(nil)
                        end
                    end
                end

                ShowOptionFeedback(EmzTools:GetText("EMZTOOLS_POTIONS_OFFENSIVE_PRIORITY") .. ": " .. button.optionText, true)
            else
                -- On ne permet pas de décocher complètement
                button:SetChecked(1)
            end
        end)

        controls["offensivePriorityRadio" .. i] = radioButton
    end

    currentY = currentY - 40

    -- Ligne de séparation après Potions offensives
    CreateSeparator(scrollChild, currentY, 0.8)
    currentY = currentY - 30

    -- ===================================================
    -- SECTION 5 : BOUTONS D'ACTION
    -- ===================================================

    -- Bouton Réinitialiser seulement (centré)
    controls.resetButton = CreateStyledButton(scrollChild, EmzTools:GetText("EMZTOOLS_STATE_RESET"), 100, currentY, 200, 25, function()
        -- Créer la popup de confirmation
        if not StaticPopupDialogs["EMZTOOLS_RESET_POTIONS"] then
            StaticPopupDialogs["EMZTOOLS_RESET_POTIONS"] = {
                text = EmzTools:GetText("EMZTOOLS_POTIONS_RESET_CONFIRM"),
                button1 = EmzTools:GetText("EMZTOOLS_STATE_YES"),
                button2 = EmzTools:GetText("EMZTOOLS_STATE_NO"),
                timeout = 0,
                whileDead = true,
                hideOnEscape = true,
                OnAccept = function()
                    -- Réinitialiser la configuration
                    potionConfig = {
                        autoHeal = true,
                        autoMana = true,
                        healPriority = "smart",
                        soundAlert = true,
                        announce = false,
                        useHealthstone = true,
                        offensivePriority = "dispel"
                    }

                    -- Mettre à jour les contrôles
                    if controls.autoHealCheckbox then
                        controls.autoHealCheckbox:SetChecked(potionConfig.autoHeal and 1 or 0)
                    end
                    if controls.autoManaCheckbox then
                        controls.autoManaCheckbox:SetChecked(potionConfig.autoMana and 1 or 0)
                    end
                    if controls.useHealthstoneCheckbox then
                        controls.useHealthstoneCheckbox:SetChecked(potionConfig.useHealthstone and 1 or 0)
                    end
                    if controls.soundAlertCheckbox then
                        controls.soundAlertCheckbox:SetChecked(potionConfig.soundAlert and 1 or 0)
                    end
                    if controls.announceCheckbox then
                        controls.announceCheckbox:SetChecked(potionConfig.announce and 1 or 0)
                    end

                    -- Mettre à jour les boutons radio
                    for i, option in ipairs(healPriorityOptions) do
                        if controls["healPriorityRadio" .. i] then
                            controls["healPriorityRadio" .. i]:SetChecked(potionConfig.healPriority == option.value and 1 or 0)
                        end
                    end

                    for i, option in ipairs(offensivePriorityOptions) do
                        if controls["offensivePriorityRadio" .. i] then
                            controls["offensivePriorityRadio" .. i]:SetChecked(potionConfig.offensivePriority == option.value and 1 or 0)
                        end
                    end

                    -- Sauvegarder
                    SavePotionConfig()

                    EmzTools:Print(EmzTools:GetText("EMZTOOLS_POTIONS_RESET_SUCCESS"), "success")
                end
            }
        end
        StaticPopup_Show("EMZTOOLS_RESET_POTIONS")
    end)

    -- Icône d'aide pour Réinitialiser
    controls.resetHelpIcon = CreateHelpIcon(scrollChild, controls.resetButton,
        EmzTools:GetText("EMZTOOLS_POTIONS_RESET_HELP"), 10, 0)

    -- Stocker les références
    self.controls = controls

    EmzTools:Print(EmzTools:GetText("EMZTOOLS_POTIONS_TAB_LOADED"), "debug")
end

-- ===================================================
-- FONCTIONS DU MODULE
-- ===================================================

function PotionsTab:ResetToDefaults()
    if controls then
        -- Valeurs par défaut
        local defaults = {
            autoHeal = true,
            autoMana = true,
            healPriority = "smart",
            soundAlert = true,
            announce = false,
            useHealthstone = true,
            offensivePriority = "dispel"
        }

        if controls.autoHealCheckbox then
            controls.autoHealCheckbox:SetChecked(defaults.autoHeal and 1 or 0)
        end
        if controls.autoManaCheckbox then
            controls.autoManaCheckbox:SetChecked(defaults.autoMana and 1 or 0)
        end
        if controls.useHealthstoneCheckbox then
            controls.useHealthstoneCheckbox:SetChecked(defaults.useHealthstone and 1 or 0)
        end
        if controls.soundAlertCheckbox then
            controls.soundAlertCheckbox:SetChecked(defaults.soundAlert and 1 or 0)
        end
        if controls.announceCheckbox then
            controls.announceCheckbox:SetChecked(defaults.announce and 1 or 0)
        end
    end
end

function PotionsTab:UpdateControls()
    if not controls then return end

    LoadPotionConfig()

    if controls.autoHealCheckbox then
        controls.autoHealCheckbox:SetChecked(potionConfig.autoHeal and 1 or 0)
    end
    if controls.autoManaCheckbox then
        controls.autoManaCheckbox:SetChecked(potionConfig.autoMana and 1 or 0)
    end
    if controls.useHealthstoneCheckbox then
        controls.useHealthstoneCheckbox:SetChecked(potionConfig.useHealthstone and 1 or 0)
    end
    if controls.soundAlertCheckbox then
        controls.soundAlertCheckbox:SetChecked(potionConfig.soundAlert and 1 or 0)
    end
    if controls.announceCheckbox then
        controls.announceCheckbox:SetChecked(potionConfig.announce and 1 or 0)
    end
end

-- ===================================================
-- ENREGISTREMENT DU MODULE
-- ===================================================

EmzTools.Data.UIConfig["Potions"] = PotionsTab
EmzTools.Data.UIConfig.Potions = PotionsTab

-- Fonction pour enregistrer l'onglet
local function RegisterPotionsTab()
    if not EmzTools.Data.UIConfig then
        return false
    end

    if EmzTools.Data.UIConfig.RegisterModuleTab then
        local success = EmzTools.Data.UIConfig:RegisterModuleTab({
            name = "Potions",
            displayName = EmzTools:GetText("EMZTOOLS_POTIONS_TITLE"),
            description = EmzTools:GetText("EMZTOOLS_POTIONS_DESC"),
            file = "UIConfig_Potions",
            icon = "Interface\\Icons\\INV_Potion_54",
            iconColor = {0.8, 0.2, 0.2},
            group = EmzTools:GetText("EMZTOOLS_STATE_MODULES")
        })

        if success then
            EmzTools:Print(EmzTools:GetText("EMZTOOLS_POTIONS_TAB_REGISTERED"), "debug")
        end

        return success
    end

    return false
end

-- Initialisation différée
if EmzTools and EmzTools.ScheduleTimer then
    EmzTools:ScheduleTimer(RegisterPotionsTab, 1)
else
    local waitFrame = CreateFrame("Frame")
    waitFrame.timeElapsed = 0
    waitFrame:SetScript("OnUpdate", function()
        this.timeElapsed = this.timeElapsed + arg1
        if this.timeElapsed > 1 then
            RegisterPotionsTab()
            this:SetScript("OnUpdate", nil)
        end
    end)
end
