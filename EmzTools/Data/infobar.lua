-- =========================================================
-- EmzTools - InfoBar.lua
-- Barre d'information affichant les statistiques du joueur
-- =========================================================

-- Module principal InfoBar
EmzTools.InfoBar = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.InfoBar:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "InfoBar")
    return true
end

-- Alias pour la rétrocompatibilité
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.InfoBar = EmzTools.Data.InfoBar or {}

-- ===================================================
-- VARIABLES LOCALES
-- ===================================================

-- Frame principale de l'InfoBar
local infoBarFrame = nil
local infoContainer = nil

-- Gestion du système de mise à jour
local updateTimer = 0
local updateInterval = 0.5 -- Mise à jour toutes les 0.5 secondes pour optimiser les performances
local ICON_SCALE = 1.1 -- Dimension des icones sur l'infobar

-- Configuration du module (synchronisée avec la base de données)
local config = {
    enabled = true,          -- InfoBar activée par défaut
    showXP = true,           -- Affichage de l'expérience
    showGold = true,         -- Affichage de l'or
    showFPS = true,          -- Affichage des FPS
    showLatency = true,      -- Affichage de la latence (ping)
    locked = true,           -- Position VERROUILLÉE par défaut
    width = "full",          -- Largeur: "full" pour plein écran, ou valeur numérique
    height = 24,             -- Hauteur de la barre en pixels
    texture = "X-Perl",      -- Texture par défaut
    clock24Hour = true,      -- Format 24h (nil = auto selon locale, true = forcé 24h, false = forcé 12h)
}

-- Textures disponibles pour personnaliser l'apparence de l'InfoBar
local AVAILABLE_TEXTURES = {
    ["X-Perl"] = "Interface\\AddOns\\EmzTools\\Textures\\X-Perl",
    ["Holy"] = "Interface\\AddOns\\EmzTools\\Textures\\Holy",
    ["Tribal"] = "Interface\\AddOns\\EmzTools\\Textures\\Tribal"
}

-- ===================================================
-- INITIALISATION DU MODULE
-- ===================================================

-- Fonction appelée au chargement de l'addon pour initialiser l'InfoBar
function EmzTools.Data.InfoBar:Initialize()
    -- Charger la configuration sauvegardée depuis la base de données
    if EmzTools and EmzTools.Database then
        local savedConfig = EmzTools.Database:Get("InfoBar")
        if savedConfig and type(savedConfig) == "table" then
            for key, value in pairs(savedConfig) do
                if config[key] ~= nil then
                    config[key] = value
                end
            end
        else
            -- Première initialisation : sauvegarder les valeurs par défaut
            for key, value in pairs(config) do
                if key and value ~= nil then
                    EmzTools.Database:Set("InfoBar", key, value)
                end
            end
        end
    else
        -- Message de fallback si le module Database n'est pas disponible
        EmzTools:Print("EMZTOOLS_INFOBAR_DATABASE_UNAVAILABLE", "warning")
    end

    -- Créer et afficher l'InfoBar si elle est activée dans la configuration
    if config.enabled then
        self:CreateInfoBar()
        self:Show()
    end
end

-- ===================================================
-- CRÉATION DE L'INTERFACE GRAPHIQUE
-- ===================================================

-- Crée la frame principale de l'InfoBar avec tous ses éléments visuels
function EmzTools.Data.InfoBar:CreateInfoBar()
    -- Éviter de créer plusieurs fois la frame
    if infoBarFrame then
        return infoBarFrame
    end

    -- Création de la frame principale
    local frame = CreateFrame("Frame", "EmzToolsInfoBar", UIParent)

    -- Configuration de la largeur
    if config.width == "full" then
        -- Mode plein écran: adapter à la largeur de l'écran
        frame:SetWidth(GetScreenWidth())
        frame:SetPoint("TOP", UIParent, "TOP", 0, 0)
    else
        -- Mode largeur fixe: utiliser la valeur spécifiée
        frame:SetWidth(config.width)
        frame:SetPoint("TOP", UIParent, "TOP", 0, -50)
    end

    frame:SetHeight(config.height)

    -- Définir le strata et le niveau pour être visible au-dessus des autres éléments
    frame:SetFrameStrata("HIGH")
    frame:SetFrameLevel(10)

    -- Appliquer la texture sélectionnée
    self:ApplyTexture(frame)

    -- Rendre la frame déplaçable si elle n'est pas verrouillée
    if not config.locked then
        frame:SetMovable(true)
        frame:EnableMouse(true)
        frame:RegisterForDrag("LeftButton")

        -- Gestion du drag & drop
        frame:SetScript("OnDragStart", function()
            this:StartMoving()
        end)
        frame:SetScript("OnDragStop", function()
            this:StopMovingOrSizing()
        end)

        -- Tooltip pour indiquer que c'est déplaçable
        frame:SetScript("OnEnter", function()
            GameTooltip:SetOwner(this, "ANCHOR_BOTTOM")
            GameTooltip:SetText("EMZTOOLS_INFOBAR_UNLOCKED_TITLE")
            GameTooltip:AddLine("EMZTOOLS_INFOBAR_UNLOCKED_DESC", 1, 1, 1)
            GameTooltip:Show()
        end)

        frame:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
    else
        -- S'assurer qu'elle n'est pas déplaçable quand verrouillée
        frame:SetMovable(false)
        frame:EnableMouse(false)
    end

    -- Décalage vertical pour l'alignement des textes
    local verticalOffset = 4

    -- ===================================================
    -- CONTENEUR POUR LES INFORMATIONS
    -- ===================================================

    -- Frame conteneur pour organiser les éléments d'information
    infoContainer = CreateFrame("Frame", nil, frame)
    infoContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, 0)
    infoContainer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 0)

    -- ===================================================
    -- BOUTON RELOAD UI SIMPLE ET PROPRE
    -- ===================================================

    -- Créer le bouton reload tout à gauche de la barre
    local reloadButton = CreateFrame("Button", nil, frame)
    reloadButton:SetWidth(16)
    reloadButton:SetHeight(16)
    reloadButton:SetPoint("LEFT", frame, "LEFT", 8, verticalOffset)

    -- Utiliser une icône simple de flèche circulaire
    local reloadIcon = reloadButton:CreateTexture(nil, "ARTWORK")
    reloadIcon:SetAllPoints()
    reloadIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Reload")

    -- Juste un effet de survol simple
    reloadButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

    -- Script pour le clic avec confirmation
    reloadButton:SetScript("OnClick", function()
        StaticPopup_Show("EMZTOOLS_RELOAD_UI")
    end)

    -- Tooltip au survol
    reloadButton:SetScript("OnEnter", function()
        GameTooltip:SetOwner(this, "ANCHOR_BOTTOMRIGHT")
        GameTooltip:SetText("EMZTOOLS_INFOBAR_RELOAD_TITLE")
        GameTooltip:AddLine("EMZTOOLS_INFOBAR_RELOAD_DESC", 1, 1, 1)
        GameTooltip:Show()
    end)

    reloadButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- ===================================================
    -- CRÉATION DES TEXTES D'INFORMATION
    -- Ordre: FPS - Latence - HORLOGE (centre) - Gold - XP
    -- ===================================================

    -- Horloge (centre)
    frame.clockText = infoContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.clockText:SetPoint("CENTER", infoContainer, "CENTER", 0, verticalOffset)
    frame.clockText:SetText("|cFFFFFFFF00:00|r")

    -- Rendre l'horloge cliquable pour le menu contextuel
    local clockFrame = CreateFrame("Button", nil, infoContainer)
    clockFrame:SetAllPoints(frame.clockText)

    -- Script pour le clic droit
    clockFrame:SetScript("OnMouseUp", function()
        if arg1 == "RightButton" then
            EmzTools.Data.InfoBar:ShowClockContextMenu()
        end
    end)

    -- Tooltip au survol pour indiquer la fonctionnalité
    clockFrame:SetScript("OnEnter", function()
        GameTooltip:SetOwner(this, "ANCHOR_BOTTOM")
        GameTooltip:SetText("EMZTOOLS_INFOBAR_CLOCK_TITLE")
        GameTooltip:AddLine("EMZTOOLS_INFOBAR_CLOCK_DESC", 1, 1, 1)
        GameTooltip:Show()
    end)

    clockFrame:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    -- FPS
    frame.fpsText = infoContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.fpsText:SetPoint("RIGHT", frame.clockText, "LEFT", -20, verticalOffset)
    frame.fpsText:SetText(" 0")

    -- Latence
    frame.latencyText = infoContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.latencyText:SetPoint("RIGHT", frame.fpsText, "LEFT", -20, verticalOffset)
    frame.latencyText:SetText(" 0ms")

    -- Or
    frame.goldText = infoContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.goldText:SetPoint("LEFT", frame.clockText, "RIGHT", 20, verticalOffset)
    frame.goldText:SetText(" 0g 0s 0c")

    -- Expérience
    frame.xpText = infoContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.xpText:SetPoint("LEFT", frame.goldText, "RIGHT", 20, verticalOffset)
    frame.xpText:SetText(" 0/100 (0%)")

    -- ===================================================
    -- POPUP DE CONFIRMATION POUR RELOAD
    -- ===================================================

    -- Créer le popup de confirmation pour le reload
    StaticPopupDialogs["EMZTOOLS_RELOAD_UI"] = {
        text = "EMZTOOLS_INFOBAR_RELOAD_CONFIRM",
        button1 = "EMZTOOLS_STATE_YES",
        button2 = "EMZTOOLS_STATE_NO",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnAccept = function()
            ReloadUI()
        end,
    }

    -- ===================================================
    -- SYSTÈME DE MISE À JOUR AUTOMATIQUE
    -- ===================================================

    -- Script OnUpdate pour mettre à jour les données périodiquement
    frame:SetScript("OnUpdate", function()
        updateTimer = updateTimer + arg1

        -- Ne mettre à jour que toutes les 0.5 secondes pour économiser les performances
        if updateTimer >= updateInterval then
            EmzTools.Data.InfoBar:UpdateAllData()
            updateTimer = 0
        end
    end)

    -- Sauvegarder la référence de la frame
    infoBarFrame = frame

    -- Mettre à jour la visibilité des éléments selon la configuration
    self:UpdateVisibility()

    return frame
end

-- ===================================================
-- SYSTÈME DE GESTION DES TEXTURES
-- ===================================================

-- Applique la texture sélectionnée à la frame principale
function EmzTools.Data.InfoBar:ApplyTexture(frame)
    -- Récupérer le chemin de la texture sélectionnée
    local texturePath = AVAILABLE_TEXTURES[config.texture]

    -- Tentative d'application de la texture personnalisée
    local textureLoaded = false
    if texturePath then
        textureLoaded = pcall(function()
            -- Nettoyer les anciennes textures pour éviter les conflits
            for i = 1, 10 do
                local oldTex = getglobal("EmzToolsInfoBarTexture" .. i)
                if oldTex then
                    oldTex:Hide()
                end
            end

            -- Calculer le nombre de textures nécessaires pour couvrir toute la largeur
            local frameWidth = frame:GetWidth()
            local numTextures = math.ceil(frameWidth / 256)

            -- Créer et positionner plusieurs textures côte à côte
            for i = 1, numTextures do
                local texture = frame:CreateTexture("EmzToolsInfoBarTexture" .. i, "BACKGROUND")
                texture:SetWidth(256)
                texture:SetHeight(28)
                texture:SetPoint("TOPLEFT", frame, "TOPLEFT", (i-1) * 256, 0)
                texture:SetTexture(texturePath)
                texture:SetTexCoord(0, 1, 0, 1)
                texture:SetAlpha(1)
            end
        end)
    end

    -- Fallback vers un backdrop standard si la texture personnalisée échoue
    if not textureLoaded then
        frame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        frame:SetBackdropColor(0, 0, 0, 0.9)
        frame:SetBackdropBorderColor(1, 0.82, 0, 1)

        -- Message d'avertissement
        EmzTools:Print("EMZTOOLS_INFOBAR_TEXTURE_NOT_FOUND", "warning", config.texture)
    end
end

-- ===================================================
-- MENU CONTEXTUEL DE L'HORLOGE
-- ===================================================

function EmzTools.Data.InfoBar:ShowClockContextMenu()
    -- Créer une frame personnalisée pour le menu
    local menuFrame = CreateFrame("Frame", "EmzToolsClockMenu", UIParent)
    menuFrame:SetWidth(200)
    menuFrame:SetHeight(120)
    menuFrame:SetFrameStrata("DIALOG")

    -- Backdrop élégant
    menuFrame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    menuFrame:SetBackdropColor(0, 0, 0, 0.95)

    -- Titre
    local title = menuFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", menuFrame, "TOP", 0, -16)
    title:SetText("EMZTOOLS_INFOBAR_CLOCK_MENU_TITLE")

    -- Bouton Auto
    local autoBtn = CreateFrame("Button", nil, menuFrame, "UIPanelButtonTemplate")
    autoBtn:SetWidth(120)
    autoBtn:SetHeight(18)
    autoBtn:SetPoint("TOP", menuFrame, "TOP", 0, -36)
    autoBtn:SetText("EMZTOOLS_INFOBAR_CLOCK_AUTO")
    autoBtn:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 10)
    autoBtn:SetScript("OnClick", function()
        config.clock24Hour = nil
        if EmzTools and EmzTools.Database then
            EmzTools.Database:Set("InfoBar", "clock24Hour", nil)
        end
        EmzTools.Data.InfoBar:UpdateClock()
        menuFrame:Hide()
    end)

    -- Bouton 24h
    local btn24h = CreateFrame("Button", nil, menuFrame, "UIPanelButtonTemplate")
    btn24h:SetWidth(120)
    btn24h:SetHeight(18)
    btn24h:SetPoint("TOP", autoBtn, "BOTTOM", 0, -6)
    btn24h:SetText("EMZTOOLS_INFOBAR_CLOCK_24H")
    btn24h:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 10)
    btn24h:SetScript("OnClick", function()
        config.clock24Hour = true
        if EmzTools and EmzTools.Database then
            EmzTools.Database:Set("InfoBar", "clock24Hour", true)
        end
        EmzTools.Data.InfoBar:UpdateClock()
        menuFrame:Hide()
    end)

    -- Bouton 12h
    local btn12h = CreateFrame("Button", nil, menuFrame, "UIPanelButtonTemplate")
    btn12h:SetWidth(120)
    btn12h:SetHeight(18)
    btn12h:SetPoint("TOP", btn24h, "BOTTOM", 0, -6)
    btn12h:SetText("EMZTOOLS_INFOBAR_CLOCK_12H")
    btn12h:GetFontString():SetFont("Fonts\\FRIZQT__.TTF", 10)
    btn12h:SetScript("OnClick", function()
        config.clock24Hour = false
        if EmzTools and EmzTools.Database then
            EmzTools.Database:Set("InfoBar", "clock24Hour", false)
        end
        EmzTools.Data.InfoBar:UpdateClock()
        menuFrame:Hide()
    end)

    -- Positionner près du curseur
    local x, y = GetCursorPosition()
    local scale = UIParent:GetEffectiveScale()
    local uiScale = UIParent:GetScale()

    -- Calculer la position pour éviter les bords de l'écran
    local screenWidth = GetScreenWidth() / uiScale
    local screenHeight = GetScreenHeight() / uiScale

    local posX = x / scale
    local posY = y / scale

    -- Ajuster si trop près des bords
    if posX < 80 then posX = 80 end
    if posX > screenWidth - 80 then posX = screenWidth - 80 end
    if posY < 45 then posY = 45 end
    if posY > screenHeight - 45 then posY = screenHeight - 45 end

    menuFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", posX - 80, posY - 6)

    -- Fermer en cliquant à l'extérieur
    local closeFrame = CreateFrame("Frame", nil, UIParent)
    closeFrame:SetAllPoints(UIParent)
    closeFrame:SetFrameStrata("DIALOG")
    closeFrame:EnableMouse(true)
    closeFrame:SetScript("OnMouseDown", function()
        menuFrame:Hide()
        this:Hide()
    end)

    -- Cacher le frame de fermeture quand le menu est fermé
    menuFrame:SetScript("OnHide", function()
        if closeFrame then
            closeFrame:Hide()
        end
    end)

    menuFrame:Show()
    closeFrame:Show()
end

-- Change la texture de l'InfoBar et recrée la frame
function EmzTools.Data.InfoBar:SetTexture(textureName)
    -- Vérifications de sécurité
    if not textureName then
        EmzTools:Print("EMZTOOLS_INFOBAR_TEXTURE_NIL", "error")
        return false
    end

    -- Vérifier que la texture existe dans la liste
    if not AVAILABLE_TEXTURES[textureName] then
        EmzTools:Print("EMZTOOLS_INFOBAR_TEXTURE_UNKNOWN", "error", textureName)
        EmzTools:Print("EMZTOOLS_INFOBAR_TEXTURE_AVAILABLE", "info")
        return false
    end

    -- Sauvegarder la nouvelle texture dans la configuration
    config.texture = textureName
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "texture", textureName)
    end

    -- Recréer l'InfoBar avec la nouvelle texture
    if infoBarFrame then
        local wasShown = infoBarFrame:IsShown()
        infoBarFrame:Hide()
        infoBarFrame = nil

        if wasShown then
            self:CreateInfoBar()
            infoBarFrame:Show()
        end
    end

    return true
end

-- Cycle entre les textures disponibles dans l'ordre
function EmzTools.Data.InfoBar:CycleTexture()
    -- Liste manuelle des textures dans l'ordre souhaité
    local textureOrder = {"X-Perl", "Holy", "Tribal"}
    local currentIndex = 1
    local textureCount = 3

    -- Trouver l'index de la texture actuelle
    for i = 1, textureCount do
        if textureOrder[i] == config.texture then
            currentIndex = i
            break
        end
    end

    -- Calculer l'index de la texture suivante (boucle)
    local nextIndex = currentIndex + 1
    if nextIndex > textureCount then
        nextIndex = 1
    end

    -- Appliquer la texture suivante
    self:SetTexture(textureOrder[nextIndex])
end

-- ===================================================
-- FONCTIONS DE MISE À JOUR DES DONNÉES
-- ===================================================

function EmzTools.Data.InfoBar:UpdateXP()
    -- Safety checks
    if not infoBarFrame or not infoBarFrame.xpText or not config.showXP then
        -- Cacher l'icône si l'option est désactivée
        if infoBarFrame and infoBarFrame.xpIcon then
            infoBarFrame.xpIcon:Hide()
        end
        return
    end

    -- Create XP icon if missing
    if not infoBarFrame.xpIcon then
        infoBarFrame.xpIcon = infoBarFrame:CreateTexture(nil, "OVERLAY")
        infoBarFrame.xpIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Exp")
        infoBarFrame.xpIcon:SetWidth(12 * ICON_SCALE)
        infoBarFrame.xpIcon:SetHeight(12 * ICON_SCALE)
        infoBarFrame.xpIcon:SetPoint("RIGHT", infoBarFrame.xpText, "LEFT", -2, 0)
    end

    -- Get XP values
    local currentXP = UnitXP("player") or 0
    local maxXP = UnitXPMax("player") or 0
    local restXP = GetXPExhaustion() or 0
    local percentage = 0

    if maxXP > 0 then
        percentage = math.floor((currentXP / maxXP) * 100)
    end

    -- Build text: show current/max and percentage, and rested if available
    local text = ""
    if maxXP > 0 then
        text = string.format("|cFF00FF00%d/%d (%d%%)|r", currentXP, maxXP, percentage)
    else
        text = string.format("|cFF00FF00%d|r", currentXP)
    end

    if restXP > 0 then
        text = text .. string.format(" |cFF80FFFF+%d|r", restXP)
    end

    -- Apply the text
    infoBarFrame.xpText:SetText(text)

    -- S'assurer que l'icône est visible si l'option est activée
    if infoBarFrame and infoBarFrame.xpIcon and config.showXP then
        infoBarFrame.xpIcon:Show()
    end
end

-- Met à jour l'affichage de l'or avec formatage des pièces
function EmzTools.Data.InfoBar:UpdateGold()
    -- Safety checks
    if not infoBarFrame or not infoBarFrame.goldText or not config.showGold then
        -- Cacher l'icône si l'option est désactivée
        if infoBarFrame and infoBarFrame.goldIcon then
            infoBarFrame.goldIcon:Hide()
        end
        return
    end

    -- Create the icon texture on the frame
    if not infoBarFrame.goldIcon then
        infoBarFrame.goldIcon = infoBarFrame:CreateTexture(nil, "OVERLAY")
        infoBarFrame.goldIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Gold")
        infoBarFrame.goldIcon:SetWidth(12 * ICON_SCALE)
        infoBarFrame.goldIcon:SetHeight(12 * ICON_SCALE)
        infoBarFrame.goldIcon:SetPoint("RIGHT", infoBarFrame.goldText, "LEFT", -2, 0)
    end

    -- Read player's money
    local copper = GetMoney()
    local gold = floor(copper / 10000)
    local silver = floor(mod(copper, 10000) / 100)
    copper = mod(copper, 100)

    -- Build the colored text
    local text = ""
    if gold > 0 then
        text = text .. string.format("|cFFFFD700%dg|r ", gold)
    end
    if silver > 0 or gold > 0 then
        text = text .. string.format("|cFFC0C0C0%ds|r ", silver)
    end
    text = text .. string.format("|cFFCD7F32%dc|r", copper)

    -- Apply the text
    infoBarFrame.goldText:SetText(text)

    -- S'assurer que l'icône est visible si l'option est activée
    if infoBarFrame and infoBarFrame.goldIcon and config.showGold then
        infoBarFrame.goldIcon:Show()
    end
end

-- Met à jour l'affichage des FPS avec code couleur selon les performances
function EmzTools.Data.InfoBar:UpdateFPS()
    if not infoBarFrame or not infoBarFrame.fpsText or not config.showFPS then
        -- Cacher l'icône si l'option est désactivée
        if infoBarFrame and infoBarFrame.fpsIcon then
            infoBarFrame.fpsIcon:Hide()
        end
        return
    end

    -- Create icon
    if not infoBarFrame.fpsIcon then
        infoBarFrame.fpsIcon = infoBarFrame:CreateTexture(nil, "OVERLAY")
        infoBarFrame.fpsIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Fps")
        infoBarFrame.fpsIcon:SetWidth(12 * ICON_SCALE)
        infoBarFrame.fpsIcon:SetHeight(12 * ICON_SCALE)
        infoBarFrame.fpsIcon:SetPoint("RIGHT", infoBarFrame.fpsText, "LEFT", -2, 0)
    end

    local fps = floor(GetFramerate())
    infoBarFrame.fpsText:SetText("|cFFFFFFFF" .. fps .. " FPS|r")

    -- S'assurer que l'icône est visible si l'option est activée
    if infoBarFrame and infoBarFrame.fpsIcon and config.showFPS then
        infoBarFrame.fpsIcon:Show()
    end
end

function EmzTools.Data.InfoBar:UpdateLatency()
    -- Safety checks
    if not infoBarFrame or not infoBarFrame.latencyText or not config.showLatency then
        -- Cacher l'icône si l'option est désactivée
        if infoBarFrame and infoBarFrame.pingIcon then
            infoBarFrame.pingIcon:Hide()
        end
        return
    end

    -- Create ping icon if missing
    if not infoBarFrame.pingIcon then
        infoBarFrame.pingIcon = infoBarFrame:CreateTexture(nil, "OVERLAY")
        infoBarFrame.pingIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Latency")
        infoBarFrame.pingIcon:SetWidth(12 * ICON_SCALE)
        infoBarFrame.pingIcon:SetHeight(12 * ICON_SCALE)
        infoBarFrame.pingIcon:SetPoint("RIGHT", infoBarFrame.latencyText, "LEFT", -2, 0)
    end

    -- Get network stats
    local bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats()
    latencyHome = latencyHome or 0
    latencyWorld = latencyWorld or 0

    -- Use the higher latency as the displayed ping
    local latency = math.max(latencyHome, latencyWorld)

    -- Choose color based on latency thresholds
    local colorStart = "|cFF00FF00" -- green
    if latency > 500 then
        colorStart = "|cFFFF0000" -- red
    elseif latency > 200 then
        colorStart = "|cFFFF8000" -- orange
    elseif latency > 100 then
        colorStart = "|cFFFFFF00" -- yellow
    end

    -- Set the text
    infoBarFrame.latencyText:SetText(string.format(" %s%dms|r", colorStart, latency))

    -- S'assurer que l'icône est visible si l'option est activée
    if infoBarFrame and infoBarFrame.pingIcon and config.showLatency then
        infoBarFrame.pingIcon:Show()
    end
end

-- Met à jour l'affichage de l'horloge en heure locale
function EmzTools.Data.InfoBar:UpdateClock()
    -- Safety checks
    if not infoBarFrame or not infoBarFrame.clockText then
        -- Cacher l'icône si l'option est désactivée
        if infoBarFrame and infoBarFrame.clockIcon then
            infoBarFrame.clockIcon:Hide()
        end
        return
    end

    -- Create clock icon if missing
    if not infoBarFrame.clockIcon then
        infoBarFrame.clockIcon = infoBarFrame:CreateTexture(nil, "OVERLAY")
        infoBarFrame.clockIcon:SetTexture("Interface\\AddOns\\EmzTools\\Textures\\icon\\Clock")
        infoBarFrame.clockIcon:SetWidth(12 * ICON_SCALE)
        infoBarFrame.clockIcon:SetHeight(12 * ICON_SCALE)
        infoBarFrame.clockIcon:SetPoint("RIGHT", infoBarFrame.clockText, "LEFT", -2, 0)
    end

    local use24HourFormat

    -- Select format based on configuration
    if config.clock24Hour ~= nil then
        use24HourFormat = config.clock24Hour
    else
        -- Auto mode based on locale
        local locale = GetLocale()
        local twelveHourLocales = { "enUS", "enGB", "esMX", "ptBR" }
        use24HourFormat = true

        for i = 1, table.getn(twelveHourLocales) do
            if locale == twelveHourLocales[i] then
                use24HourFormat = false
                break
            end
        end
    end

    -- Get local time
    local timeStamp = time()
    local hours = tonumber(date("%H", timeStamp))
    local minutes = tonumber(date("%M", timeStamp))

    local timeFormat

    -- Format according to chosen mode
    if use24HourFormat then
        timeFormat = string.format("%02d:%02d", hours, minutes)
    else
        local displayHours = hours
        local ampm = "AM"

        if hours == 0 then
            displayHours = 12
        elseif hours == 12 then
            ampm = "PM"
        elseif hours > 12 then
            displayHours = hours - 12
            ampm = "PM"
        end

        timeFormat = string.format("%d:%02d%s", displayHours, minutes, ampm)
    end

    -- Update display
    infoBarFrame.clockText:SetText(string.format("|cFFFFFFFF%s|r", timeFormat))

    -- S'assurer que l'icône est visible
    if infoBarFrame and infoBarFrame.clockIcon then
        infoBarFrame.clockIcon:Show()
    end
end

-- ===================================================
-- FONCTION DE MISE À JOUR GLOBALE
-- ===================================================

-- Met à jour toutes les données affichées sur l'InfoBar
function EmzTools.Data.InfoBar:UpdateAllData()
    if not infoBarFrame then
        return
    end

    -- Mettre à jour chaque élément
    self:UpdateXP()
    self:UpdateGold()
    self:UpdateFPS()
    self:UpdateLatency()
    self:UpdateClock()
end

-- ===================================================
-- FONCTIONS DE CONTRÔLE
-- ===================================================

-- Bascule entre les formats 12h et 24h
function EmzTools.Data.InfoBar:ToggleClockFormat()
    if config.clock24Hour == nil then
        -- Si auto, forcer en 24h
        config.clock24Hour = true
    elseif config.clock24Hour == true then
        -- Si 24h, passer en 12h
        config.clock24Hour = false
    else
        -- Si 12h, repasser en auto
        config.clock24Hour = nil
    end

    -- Sauvegarder la configuration
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "clock24Hour", config.clock24Hour)
    end

    -- Mettre à jour l'affichage de l'horloge
    self:UpdateClock()

    -- Message de confirmation
    local formatText = "Auto"
    if config.clock24Hour == true then
        formatText = "24h"
    elseif config.clock24Hour == false then
        formatText = "12h"
    end

    EmzTools:Print("EMZTOOLS_INFOBAR_CLOCK_FORMAT_SET", "info", formatText)
end

-- Réinitialise la position de l'InfoBar
function EmzTools.Data.InfoBar:ResetPosition()
    -- Réinitialiser la position à la valeur par défaut
    if infoBarFrame then
        infoBarFrame:ClearAllPoints()
        if config.width == "full" then
            infoBarFrame:SetPoint("TOP", UIParent, "TOP", 0, 0)
        else
            infoBarFrame:SetPoint("TOP", UIParent, "TOP", 0, -50)
        end
        EmzTools:Print("EMZTOOLS_INFOBAR_POSITION_RESET", "success")
    end
end

-- Réinitialise la largeur à "full" (plein écran)
function EmzTools.Data.InfoBar:ResetWidth()
    config.width = "full"

    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "width", "full")
    end

    -- Recréer l'InfoBar avec la largeur par défaut
    if infoBarFrame then
        local wasShown = infoBarFrame:IsShown()
        infoBarFrame:Hide()
        infoBarFrame = nil

        if wasShown then
            self:CreateInfoBar()
            infoBarFrame:Show()
        end
    end
end

-- Affiche l'InfoBar
function EmzTools.Data.InfoBar:Show()
    if not infoBarFrame then
        self:CreateInfoBar()
    end

    infoBarFrame:Show()
    config.enabled = true
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "enabled", true)
    end
end

-- Cache l'InfoBar
function EmzTools.Data.InfoBar:Hide()
    if infoBarFrame then
        infoBarFrame:Hide()
    end

    config.enabled = false
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "enabled", false)
    end
end

-- Bascule l'affichage de l'InfoBar
function EmzTools.Data.InfoBar:Toggle()
    if infoBarFrame and infoBarFrame:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

-- Verrouille/déverrouille la position de l'InfoBar
function EmzTools.Data.InfoBar:ToggleLock()
    config.locked = not config.locked
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "locked", config.locked)
    end

    -- Recréer la barre pour appliquer les changements
    if infoBarFrame then
        local wasShown = infoBarFrame:IsShown()

        infoBarFrame:Hide()
        infoBarFrame = nil

        if wasShown then
            self:CreateInfoBar()
            infoBarFrame:Show()
        end
    end

    EmzTools:Print("EMZTOOLS_INFOBAR_LOCK_STATUS", "info", config.locked and "EMZTOOLS_STATE_LOCKED" or "EMZTOOLS_STATE_UNLOCKED")
end

-- Change la largeur de l'InfoBar
function EmzTools.Data.InfoBar:SetWidth(width)
    if type(width) == "string" and width == "full" then
        config.width = "full"
        if infoBarFrame then
            infoBarFrame:SetWidth(GetScreenWidth())
            infoBarFrame:SetPoint("TOP", UIParent, "TOP", 0, 0)
        end
    else
        local newWidth = tonumber(width) or 400
        config.width = newWidth
        if infoBarFrame then
            infoBarFrame:SetWidth(newWidth)
            infoBarFrame:SetPoint("TOP", UIParent, "TOP", 0, -50)
        end
    end

    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "width", config.width)
    end

    -- Mettre à jour la texture et la visibilité
    if infoBarFrame then
        self:ApplyTexture(infoBarFrame)
        self:UpdateVisibility()
    end

    -- Message de confirmation
    EmzTools:Print("EMZTOOLS_INFOBAR_WIDTH_SET", "success", config.width)
end

-- Change la hauteur de l'InfoBar
function EmzTools.Data.InfoBar:SetHeight(height)
    config.height = tonumber(height) or 24

    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "height", config.height)
    end

    -- Recréer l'InfoBar avec la nouvelle hauteur
    if infoBarFrame then
        local wasShown = infoBarFrame:IsShown()
        infoBarFrame:Hide()
        infoBarFrame = nil

        if wasShown then
            self:CreateInfoBar()
            infoBarFrame:Show()
        end
    end

    -- Message de confirmation
    EmzTools:Print("EMZTOOLS_INFOBAR_HEIGHT_SET", "success", config.height)
end

-- ===================================================
-- FONCTIONS TOGGLE POUR CHAQUE ÉLÉMENT
-- ===================================================

-- Toggle l'affichage de l'XP
function EmzTools.Data.InfoBar:ToggleXP()
    config.showXP = not config.showXP
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "showXP", config.showXP)
    end
    self:UpdateVisibility()
    EmzTools:Print("EMZTOOLS_INFOBAR_XP_DISPLAY", "info", config.showXP and "EMZTOOLS_ENABLED" or "EMZTOOLS_DISABLED")
end

-- Toggle l'affichage de l'Or
function EmzTools.Data.InfoBar:ToggleGold()
    config.showGold = not config.showGold
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "showGold", config.showGold)
    end
    self:UpdateVisibility()
    EmzTools:Print("EMZTOOLS_INFOBAR_GOLD_DISPLAY", "info", config.showGold and "EMZTOOLS_ENABLED" or "EMZTOOLS_DISABLED")
end

-- Toggle l'affichage des FPS
function EmzTools.Data.InfoBar:ToggleFPS()
    config.showFPS = not config.showFPS
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "showFPS", config.showFPS)
    end
    self:UpdateVisibility()
    EmzTools:Print("EMZTOOLS_INFOBAR_FPS_DISPLAY", "info", config.showFPS and "EMZTOOLS_ENABLED" or "EMZTOOLS_DISABLED")
end

-- Toggle l'affichage de la Latence
function EmzTools.Data.InfoBar:ToggleLatency()
    config.showLatency = not config.showLatency
    if EmzTools and EmzTools.Database then
        EmzTools.Database:Set("InfoBar", "showLatency", config.showLatency)
    end
    self:UpdateVisibility()
    EmzTools:Print("EMZTOOLS_INFOBAR_LATENCY_DISPLAY", "info", config.showLatency and "EMZTOOLS_ENABLED" or "EMZTOOLS_DISABLED")
end

-- Toggle la texture (cycle)
function EmzTools.Data.InfoBar:ToggleTexture()
    self:CycleTexture()
end

-- ===================================================
-- FONCTION DE MISE À JOUR DE LA VISIBILITÉ
-- ===================================================

-- Met à jour la visibilité et le positionnement des éléments
function EmzTools.Data.InfoBar:UpdateVisibility()
    -- Vérifier que la frame existe
    if not infoBarFrame or not infoContainer then
        return
    end

    -- Vérifier que tous les éléments existent avant de continuer
    if not infoBarFrame.fpsText or not infoBarFrame.latencyText or
       not infoBarFrame.clockText or not infoBarFrame.goldText or
       not infoBarFrame.xpText then
        return
    end

    -- Cacher tous les éléments d'abord
    infoBarFrame.fpsText:Hide()
    infoBarFrame.latencyText:Hide()
    infoBarFrame.goldText:Hide()
    infoBarFrame.xpText:Hide()

    -- Cacher les icônes
    if infoBarFrame.fpsIcon then infoBarFrame.fpsIcon:Hide() end
    if infoBarFrame.pingIcon then infoBarFrame.pingIcon:Hide() end
    if infoBarFrame.goldIcon then infoBarFrame.goldIcon:Hide() end
    if infoBarFrame.xpIcon then infoBarFrame.xpIcon:Hide() end

    -- Liste des éléments dans l'ordre d'affichage avec leurs paramètres
    local elementsInOrder = {
        {show = config.showLatency, element = infoBarFrame.latencyText, icon = infoBarFrame.pingIcon, type = "latency"},
        {show = config.showFPS, element = infoBarFrame.fpsText, icon = infoBarFrame.fpsIcon, type = "fps"},
        {show = true, element = infoBarFrame.clockText, icon = infoBarFrame.clockIcon, type = "clock"},
        {show = config.showGold, element = infoBarFrame.goldText, icon = infoBarFrame.goldIcon, type = "gold"},
        {show = config.showXP, element = infoBarFrame.xpText, icon = infoBarFrame.xpIcon, type = "xp"}
    }

    -- Étape 1: Collecter les éléments actifs et leurs largeurs
    local activeElements = {}
    local totalWidth = 0

    for i = 1, table.getn(elementsInOrder) do
        local elementData = elementsInOrder[i]

        if elementData and elementData.show and elementData.element then
            -- Mettre à jour le texte pour avoir la bonne largeur
            if elementData.type == "latency" then
                self:UpdateLatency()
            elseif elementData.type == "fps" then
                self:UpdateFPS()
            elseif elementData.type == "clock" then
                self:UpdateClock()
            elseif elementData.type == "gold" then
                self:UpdateGold()
            elseif elementData.type == "xp" then
                self:UpdateXP()
            end

            elementData.element:Show()

            -- Obtenir la largeur du texte
            if elementData.element.GetStringWidth then
                local textWidth = elementData.element:GetStringWidth()
                local iconWidth = 0

                -- Ajouter la largeur de l'icône si elle existe
                if elementData.icon then
                    elementData.icon:Show()
                    iconWidth = 12 * ICON_SCALE + 2 -- Largeur de l'icône + marge
                end

                local elementTotalWidth = textWidth + iconWidth
                totalWidth = totalWidth + elementTotalWidth

                table.insert(activeElements, {
                    element = elementData.element,
                    icon = elementData.icon,
                    textWidth = textWidth,
                    iconWidth = iconWidth,
                    totalWidth = elementTotalWidth
                })
            end
        end
    end

    local activeCount = table.getn(activeElements)
    if activeCount == 0 then
        return
    end

    -- Étape 2: Calculer l'espacement
    local frameWidth = infoBarFrame:GetWidth()
    local availableSpace = frameWidth - totalWidth

    -- Si on a peu d'éléments, utiliser un espacement fixe
    local spacing
    if activeCount <= 2 then
        spacing = 40  -- Espacement généreux pour peu d'éléments
    else
        spacing = availableSpace / (activeCount + 1)
        -- Limiter l'espacement entre 20px et 60px
        if spacing < 20 then
            spacing = 20
        elseif spacing > 60 then
            spacing = 60
        end
    end

    -- Étape 3: Positionner les éléments
    local totalWidthWithSpacing = totalWidth + (spacing * (activeCount - 1))
    local startX = (frameWidth - totalWidthWithSpacing) / 2
    local currentX = startX

    for i = 1, table.getn(activeElements) do
        local elementData = activeElements[i]
        if elementData and elementData.element then
            -- Positionner l'icône si elle existe
            if elementData.icon then
                elementData.icon:ClearAllPoints()
                elementData.icon:SetPoint("LEFT", infoBarFrame, "LEFT", currentX, 0)
                currentX = currentX + elementData.iconWidth
            end

            -- Positionner le texte
            elementData.element:ClearAllPoints()
            elementData.element:SetPoint("LEFT", infoBarFrame, "LEFT", currentX, 1)

            currentX = currentX + elementData.textWidth + spacing
        end
    end
end

-- ===================================================
-- FONCTION D'AFFICHAGE DE LA CONFIGURATION
-- ===================================================

-- Affiche la configuration actuelle dans le chat
function EmzTools.Data.InfoBar:PrintConfig()
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_HEADER", "info")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_ENABLED", "info", config.enabled and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_LOCKED", "info", config.locked and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_WIDTH", "info", tostring(config.width or "unknown"))
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_HEIGHT", "info", config.height or 24)
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_TEXTURE", "info", config.texture or "unknown")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_XP", "info", config.showXP and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_GOLD", "info", config.showGold and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_FPS", "info", config.showFPS and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_LATENCY", "info", config.showLatency and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")

    local clockFormat = "Auto"
    if config.clock24Hour == true then
        clockFormat = "24h"
    elseif config.clock24Hour == false then
        clockFormat = "12h"
    end
    EmzTools:Print("EMZTOOLS_INFOBAR_CONFIG_CLOCK_FORMAT", "info", clockFormat)
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

-- Définition des commandes slash pour contrôler l'InfoBar
SLASH_EMZINFOBAR1 = "/emz infobar"
SLASH_EMZINFOBAR2 = "/emztools infobar"
SlashCmdList["EMZINFOBAR"] = function(msg)
    local command = string.lower(msg or "")

    -- Commande vide ou toggle: basculer l'affichage
    if command == "" or command == "toggle" then
        EmzTools.Data.InfoBar:Toggle()

    -- Afficher l'InfoBar
    elseif command == "show" then
        EmzTools.Data.InfoBar:Show()

    -- Cacher l'InfoBar
    elseif command == "hide" then
        EmzTools.Data.InfoBar:Hide()

    -- Verrouiller/déverrouiller
    elseif command == "lock" then
        EmzTools.Data.InfoBar:ToggleLock()

    -- Réinitialiser à pleine largeur
    elseif command == "width" then
        EmzTools.Data.InfoBar:SetWidth("full")

    -- Définir une largeur spécifique
    elseif string.sub(command, 1, 6) == "width " then
        local width = string.sub(command, 7)
        EmzTools.Data.InfoBar:SetWidth(tonumber(width) or "full")

    -- Définir une hauteur spécifique
    elseif string.sub(command, 1, 7) == "height " then
        local height = string.sub(command, 8)
        EmzTools.Data.InfoBar:SetHeight(tonumber(height) or 24)

    -- Réinitialiser la largeur
    elseif command == "resetwidth" then
        EmzTools.Data.InfoBar:ResetWidth()

    -- Toggle XP
    elseif command == "xp" then
        EmzTools.Data.InfoBar:ToggleXP()

    -- Toggle Gold
    elseif command == "gold" then
        EmzTools.Data.InfoBar:ToggleGold()

    -- Toggle FPS
    elseif command == "fps" then
        EmzTools.Data.InfoBar:ToggleFPS()

    -- Toggle Latency
    elseif command == "latency" or command == "lag" then
        EmzTools.Data.InfoBar:ToggleLatency()

    -- Cycle texture
    elseif command == "texture" then
        EmzTools.Data.InfoBar:ToggleTexture()

    -- Définir une texture spécifique
    elseif string.sub(command, 1, 8) == "texture " then
        local textureName = string.sub(command, 9)
        EmzTools.Data.InfoBar:SetTexture(textureName)

    elseif command == "clock" or command == "time" then
        EmzTools.Data.InfoBar:ToggleClockFormat()

    -- Afficher l'aide
    elseif command == "help" then
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_HEADER", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_TOGGLE", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_SHOW", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_HIDE", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_LOCK", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_WIDTH", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_RESETWIDTH", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_HEIGHT", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_XP", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_GOLD", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_FPS", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_LATENCY", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_TEXTURE", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_TEXTURE_NAME", "info")
        EmzTools:Print("EMZTOOLS_INFOBAR_HELP_CLOCK", "info")

    -- Commande inconnue
    else
        EmzTools:Print("EMZTOOLS_INFOBAR_UNKNOWN_COMMAND", "warning")
    end
end

-- ===================================================
-- INITIALISATION AUTOMATIQUE AU CHARGEMENT
-- ===================================================

-- Créer une frame pour l'initialisation différée
local InfoBarLoader = CreateFrame("Frame")
InfoBarLoader:RegisterEvent("PLAYER_ENTERING_WORLD")
InfoBarLoader:SetScript("OnEvent", function()
    -- Se désinscrire de l'événement pour ne l'exécuter qu'une fois
    this:UnregisterEvent("PLAYER_ENTERING_WORLD")
    -- Initialiser l'InfoBar
    EmzTools.Data.InfoBar:Initialize()
end)
