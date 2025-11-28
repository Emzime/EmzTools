-- ===================================================
-- MyHunter - MyHunter_RotationDisplay.lua
-- Affichage visuel avec gestion distance/mêlée
-- Affiche uniquement les sorts valides pour la distance
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_RotationDisplay = {}

-- Classes supportées (uniquement Hunter)
MyHunter_RotationDisplay.supportedClasses = { "HUNTER" }

-- Variables locales
local displayFrame = nil
local spellIcons = {}
local updateInterval = 0.1
local lastUpdate = 0

-- Configuration
local ICON_SIZE = 48
local ICON_SPACING = 5
local MAX_ICONS = 3

-- État de la liste glissante
local rotationQueue = {}
local lastCastSpell = nil
local lastCastTime = 0
local currentRangeType = "RANGED" -- "RANGED" ou "MELEE"

-- ===================================================
-- LISTES DE SORTS AUTORISÉS
-- ===================================================

-- Sorts de mêlée uniquement (MONO-CIBLE)
MyHunter_RotationDisplay.MeleeSpells = {
    "Mongoose Bite",
    "Raptor Strike",
    "Attack"
}

-- Sorts à distance uniquement (MONO-CIBLE)
MyHunter_RotationDisplay.RangedSpells = {
    "Aimed Shot",
    "Arcane Shot",
    "Serpent Sting",
    "Steady Shot",
    "Auto Shot"
}

-- ===================================================
-- INITIALISATION
-- ===================================================

function MyHunter_RotationDisplay:Initialize()
    EmzTools:LoadPluginLocalization("MyHunter")
    self:InitializeDefaults()
    self:CreateDisplayFrame()
    self:InitializeRotationQueue()

    local showDisplay = MyHunter:GetOption("showRotationDisplay", true)
    if showDisplay then
        self:Show()
    else
        self:Hide()
    end

    return true
end

function MyHunter_RotationDisplay:InitializeDefaults()
    if not EmzToolsDB then return end

    if not EmzToolsDB.MyHunter then
        EmzToolsDB.MyHunter = {}
    end

    if EmzToolsDB.MyHunter.rotationDisplay == nil then
        EmzToolsDB.MyHunter.rotationDisplay = {
            showDisplay = true,
            displayLocked = false,
            enableCooldownText = true,
            showOnlyInCombat = false,
            displayScale = 1.0,
            enableSlidingEffect = true,
            autoSwitchRange = true
        }
    end
end

function MyHunter_RotationDisplay:InitializeRotationQueue()
    rotationQueue = {}
    lastCastSpell = nil
    lastCastTime = 0
    currentRangeType = "RANGED"

    for i = 1, MAX_ICONS do
        rotationQueue[i] = "Auto Shot"
    end
end

-- ===================================================
-- DÉTECTION DE DISTANCE
-- ===================================================

-- Vérifie si le joueur est en portée de mêlée
function MyHunter_RotationDisplay:IsInMeleeRange(target)
    if not UnitExists(target) then return false end
    return CheckInteractDistance(target, 3) -- 3 = portée de mêlée
end

-- Détermine le type de rotation à utiliser
function MyHunter_RotationDisplay:GetCurrentRangeType()
    if not UnitExists("target") then
        return "RANGED"
    end

    local inMeleeRange = self:IsInMeleeRange("target")

    if inMeleeRange then
        return "MELEE"
    else
        return "RANGED"
    end
end

-- Vérifie si le type de rotation a changé
function MyHunter_RotationDisplay:CheckRangeSwitch()
    local newRangeType = self:GetCurrentRangeType()

    if newRangeType ~= currentRangeType then
        currentRangeType = newRangeType
        self:ForceRecalculateQueue()

        if EmzTools and EmzTools.Print and EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print("EMZTOOLS_MYHUNTER_DISPLAY_RANGE_SWITCH", "debug", currentRangeType)
        end
    end
end

-- ===================================================
-- GESTION DES ROTATIONS PAR TYPE
-- ===================================================

-- Récupère la rotation selon le type (distance/mêlée)
function MyHunter_RotationDisplay:GetRotationByType(rangeType)
    local specModule = self:GetSpecModule()
    if not specModule then
        -- Rotation par défaut selon la distance
        if rangeType == "MELEE" then
            return self.MeleeSpells
        else
            return self.RangedSpells
        end
    end

    -- Utiliser les rotations de la spécialisation
    if rangeType == "MELEE" then
        if specModule.meleeSpellPriority then
            return self:FilterValidSpells(specModule.meleeSpellPriority, "MELEE")
        else
            return self.MeleeSpells
        end
    else
        if specModule.spellPriority then
            return self:FilterValidSpells(specModule.spellPriority, "RANGED")
        else
            return self.RangedSpells
        end
    end
end

-- Filtre uniquement les sorts valides pour la distance
function MyHunter_RotationDisplay:FilterValidSpells(spellList, rangeType)
    local validSpells = {}

    for _, spellName in ipairs(spellList) do
        if self:IsSpellValidForRange(spellName, rangeType) then
            table.insert(validSpells, spellName)
        end
    end

    return validSpells
end

-- Vérifie si un sort est valide pour la distance
function MyHunter_RotationDisplay:IsSpellValidForRange(spellName, rangeType)
    if rangeType == "MELEE" then
        return self:IsMeleeSpell(spellName)
    else
        return self:IsRangedSpell(spellName)
    end
end

-- Vérifie si un sort est de mêlée
function MyHunter_RotationDisplay:IsMeleeSpell(spellName)
    for _, meleeSpell in ipairs(self.MeleeSpells) do
        if spellName == meleeSpell then
            return true
        end
    end
    return false
end

-- Vérifie si un sort est à distance
function MyHunter_RotationDisplay:IsRangedSpell(spellName)
    for _, rangedSpell in ipairs(self.RangedSpells) do
        if spellName == rangedSpell then
            return true
        end
    end
    return false
end

-- ===================================================
-- GESTION INTELLIGENTE DE LA FILE D'ATTENTE
-- ===================================================

-- Met à jour la file d'attente avec gestion distance/mêlée
function MyHunter_RotationDisplay:UpdateRotationQueue()
    -- Vérifier le changement de distance
    if EmzToolsDB.MyHunter.rotationDisplay.autoSwitchRange then
        self:CheckRangeSwitch()
    end

    local rotationSpells = self:GetRotationByType(currentRangeType)
    if #rotationSpells == 0 then
        -- Fallback selon le type
        if currentRangeType == "MELEE" then
            rotationSpells = self.MeleeSpells
        else
            rotationSpells = self.RangedSpells
        end
    end

    -- Trouver les 3 sorts les plus prioritaires DISPONIBLES
    local availableSpells = {}

    for i, spellName in ipairs(rotationSpells) do
        local isReady = self:IsSpellReady(spellName)
        local hasMana = self:HasEnoughMana(spellName)

        table.insert(availableSpells, {
            name = spellName,
            priority = i,
            available = isReady and hasMana,
            ready = isReady,
            hasMana = hasMana
        })

        -- On s'arrête à 3 sorts maximum
        if #availableSpells >= MAX_ICONS then
            break
        end
    end

    -- Compléter avec des sorts moins prioritaires si nécessaire
    if #availableSpells < MAX_ICONS then
        for i, spellName in ipairs(rotationSpells) do
            local alreadyExists = false
            for _, spell in ipairs(availableSpells) do
                if spell.name == spellName then
                    alreadyExists = true
                    break
                end
            end

            if not alreadyExists then
                table.insert(availableSpells, {
                    name = spellName,
                    priority = i,
                    available = false,
                    ready = self:IsSpellReady(spellName),
                    hasMana = self:HasEnoughMana(spellName)
                })

                if #availableSpells >= MAX_ICONS then
                    break
                end
            end
        end
    end

    -- Construire la nouvelle file
    local newQueue = {}
    for i = 1, MAX_ICONS do
        if availableSpells[i] then
            newQueue[i] = availableSpells[i].name
        else
            -- Fallback selon le type
            if currentRangeType == "MELEE" then
                newQueue[i] = "Attack"
            else
                newQueue[i] = "Auto Shot"
            end
        end
    end

    -- Appliquer avec logique glissante
    self:ApplyQueueUpdate(newQueue)
end

-- Applique la mise à jour de la file
function MyHunter_RotationDisplay:ApplyQueueUpdate(newQueue)
    local shouldForceUpdate = self:ShouldForceQueueUpdate(newQueue)

    if shouldForceUpdate then
        -- Recalcul complet (changement de distance)
        rotationQueue = newQueue
    else
        -- Mise à jour glissante normale
        rotationQueue[1] = rotationQueue[2] or newQueue[1]
        rotationQueue[2] = rotationQueue[3] or newQueue[2]
        rotationQueue[3] = newQueue[3] or (currentRangeType == "MELEE" and "Attack" or "Auto Shot")
    end
end

-- Détermine si on doit forcer la mise à jour
function MyHunter_RotationDisplay:ShouldForceQueueUpdate(newQueue)
    -- Vérifier si le type de sort a changé
    for i = 1, MAX_ICONS do
        local currentSpell = rotationQueue[i] or ""
        local newSpell = newQueue[i] or ""

        if currentSpell ~= newSpell then
            local currentIsMelee = self:IsMeleeSpell(currentSpell)
            local newIsMelee = self:IsMeleeSpell(newSpell)

            if currentIsMelee ~= newIsMelee then
                return true
            end
        end
    end

    return false
end

-- Force le recalcul complet de la file
function MyHunter_RotationDisplay:ForceRecalculateQueue()
    rotationQueue = {}
    self:UpdateRotationQueue()
end

-- ===================================================
-- MISE À JOUR DE L'AFFICHAGE
-- ===================================================

function MyHunter_RotationDisplay:OnUpdate(elapsed)
    lastUpdate = lastUpdate + elapsed

    if lastUpdate < updateInterval then
        return
    end

    lastUpdate = 0

    -- Gestion affichage combat seulement
    if EmzToolsDB.MyHunter.rotationDisplay.showOnlyInCombat and not UnitAffectingCombat("player") then
        if displayFrame and displayFrame:IsShown() then
            displayFrame:Hide()
        end
        return
    elseif EmzToolsDB.MyHunter.rotationDisplay.showOnlyInCombat and UnitAffectingCombat("player") then
        if displayFrame and not displayFrame:IsShown() and EmzToolsDB.MyHunter.rotationDisplay.showDisplay then
            displayFrame:Show()
        end
    end

    -- Mettre à jour la file d'attente
    self:UpdateRotationQueue()

    -- Mettre à jour l'affichage
    self:UpdateDisplay()
end

function MyHunter_RotationDisplay:UpdateDisplay()
    if not displayFrame or not displayFrame:IsShown() then
        return
    end

    -- Mettre à jour l'indicateur de type
    self:UpdateRangeIndicator()

    -- Mettre à jour les icônes
    for i = 1, MAX_ICONS do
        local icon = spellIcons[i]
        local spellName = rotationQueue[i]

        if spellName and self:HasSpell(spellName) then
            local spellTexture = self:GetSpellTexture(spellName)
            icon.texture:SetTexture(spellTexture)

            -- Vérifier l'état du sort
            local isReady = self:IsSpellReady(spellName)
            local hasResources = self:HasEnoughMana(spellName)
            local cooldown = self:GetSpellCooldown(spellName)

            -- Gestion des bordures et couleurs
            self:UpdateIconAppearance(icon, i, isReady, hasResources, cooldown)

            icon:Show()
        else
            icon:Hide()
        end
    end
end

-- Met à jour l'apparence d'une icône
function MyHunter_RotationDisplay:UpdateIconAppearance(icon, position, isReady, hasResources, cooldown)
    -- Réinitialiser
    icon.texture:SetVertexColor(1, 1, 1)
    icon.border:Hide()
    icon.secondaryBorder:Hide()
    icon.cooldownText:SetText("")

    -- Bordure selon la position
    if position == 1 then
        icon.border:Show()
        icon.border:SetVertexColor(0, 1, 0) -- Vert pour prochain
    else
        icon.secondaryBorder:Show()
        icon.secondaryBorder:SetVertexColor(0.5, 0.5, 0.5) -- Gris pour suivants
    end

    -- Couleur selon l'état
    if not isReady then
        -- En cooldown
        icon.texture:SetVertexColor(0.5, 0.5, 0.5) -- Grisé
        if cooldown > 0 and EmzToolsDB.MyHunter.rotationDisplay.enableCooldownText then
            icon.cooldownText:SetText(string.format("%.0f", cooldown))
            icon.cooldownText:SetTextColor(1, 0, 0)
        end
    elseif not hasResources then
        -- Pas de mana
        icon.texture:SetVertexColor(0.5, 0.5, 0.5) -- Grisé
        if EmzToolsDB.MyHunter.rotationDisplay.enableCooldownText then
            icon.cooldownText:SetText("OOM")
            icon.cooldownText:SetTextColor(1, 1, 0)
        end
    else
        -- Prêt à lancer
        icon.texture:SetVertexColor(1, 1, 1) -- Normal
    end
end

-- Met à jour l'indicateur de type (distance/mêlée)
function MyHunter_RotationDisplay:UpdateRangeIndicator()
    if not displayFrame.rangeIndicator then
        displayFrame.rangeIndicator = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        displayFrame.rangeIndicator:SetPoint("TOP", displayFrame, "TOP", 0, -5)
    end

    local color = "|cFF00FF00" -- Vert pour distance
    local text = "DISTANCE"

    if currentRangeType == "MELEE" then
        color = "|cFF00BFFF" -- Bleu clair (Deep Sky Blue) pour mêlée
        text = "MÊLÉE"
    end

    displayFrame.rangeIndicator:SetText(color .. text .. "|r")
end

-- ===================================================
-- GESTION DES LANCEMENTS DE SORTS
-- ===================================================

function MyHunter_RotationDisplay:OnSpellCast(spellName)
    if not spellName then return end

    lastCastSpell = spellName
    lastCastTime = GetTime()

    -- Mettre à jour la file avec effet glissant
    if EmzToolsDB.MyHunter.rotationDisplay.enableSlidingEffect then
        rotationQueue[1] = rotationQueue[2] or "Auto Shot"
        rotationQueue[2] = rotationQueue[3] or "Auto Shot"
        rotationQueue[3] = self:GetNextWaitingSpell()
    else
        self:UpdateRotationQueue()
    end

    if EmzTools and EmzTools.Print and EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
        EmzTools:Print("EMZTOOLS_MYHUNTER_DISPLAY_SPELL_CAST", "debug", spellName)
    end
end

-- Récupère le prochain sort en attente
function MyHunter_RotationDisplay:GetNextWaitingSpell()
    local rotationSpells = self:GetRotationByType(currentRangeType)

    for _, spellName in ipairs(rotationSpells) do
        if spellName ~= rotationQueue[1] and spellName ~= rotationQueue[2] and spellName ~= rotationQueue[3] then
            if self:IsSpellReady(spellName) and self:HasEnoughMana(spellName) then
                return spellName
            end
        end
    end

    -- Fallback
    if currentRangeType == "MELEE" then
        return "Attack"
    else
        return "Auto Shot"
    end
end

-- ===================================================
-- FONCTIONS UTILITAIRES
-- ===================================================

function MyHunter_RotationDisplay:GetSpecModule()
    if EmzTools.MyHunter_Rotation and EmzTools.MyHunter_Rotation.GetSpecModule then
        return EmzTools.MyHunter_Rotation:GetSpecModule()
    end
    return EmzTools.MyHunter_BeastMastery or EmzTools.MyHunter_Marksman or EmzTools.MyHunter_Survival
end

function MyHunter_RotationDisplay:HasSpell(spellName)
    if EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.HasSpell then
        return EmzTools.MyHunter_SpellBook:HasSpell(spellName)
    end
    return true
end

function MyHunter_RotationDisplay:IsSpellReady(spellName)
    if EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.IsReady then
        return EmzTools.MyHunter_SpellBook:IsReady(spellName)
    end
    return true
end

function MyHunter_RotationDisplay:HasEnoughMana(spellName)
    if EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.HasEnoughMana then
        return EmzTools.MyHunter_SpellBook:HasEnoughMana(spellName)
    end
    return UnitMana("player") > 0
end

function MyHunter_RotationDisplay:GetSpellCooldown(spellName)
    if EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.GetCooldown then
        return EmzTools.MyHunter_SpellBook:GetCooldown(spellName)
    end
    return 0
end

function MyHunter_RotationDisplay:GetSpellTexture(spellName)
    local spellId = self:GetSpellId(spellName)
    if spellId then
        return GetSpellTexture(spellId)
    end
    return "Interface\\Icons\\INV_Misc_QuestionMark"
end

function MyHunter_RotationDisplay:GetSpellId(spellName)
    local spellIds = {
        -- Sorts de mêlée
        ["Raptor Strike"] = 2973,
        ["Mongoose Bite"] = 1495,
        ["Attack"] = 6603,
        -- Sorts à distance
        ["Aimed Shot"] = 19434,
        ["Arcane Shot"] = 3044,
        ["Serpent Sting"] = 1978,
        ["Steady Shot"] = 34120,
        ["Auto Shot"] = 75,
    }
    return spellIds[spellName]
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

EmzTools.MyHunter_RotationDisplay = MyHunter_RotationDisplay

return MyHunter_RotationDisplay
