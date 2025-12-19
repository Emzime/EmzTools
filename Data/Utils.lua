-- ===================================================
-- EmzTools - Data/Utils.lua
-- Fonctions utilitaires globales pour EmzTools
-- Compatible WoW 1.12 (LUA 5.0)
-- ===================================================

-- ===================================================
-- MODULE PRINCIPAL UTILS
-- ===================================================

-- Module principal Utils
EmzTools.Utils = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

-- ===================================================
-- Initialise le module Utils
-- @return: boolean - true si initialisation réussie
-- ===================================================

function EmzTools.Utils:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Utils")
    return true
end

-- Alias pour la rétrocompatibilité et organisation Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Utils = EmzTools.Utils

-- ===================================================
-- INFORMATIONS JOUEUR
-- ===================================================

-- ===================================================
-- Obtient la classe du joueur en anglais
-- @return: string - Nom de classe en anglais (ex: "WARRIOR")
-- ===================================================

function EmzTools.Utils:GetPlayerClass()
    local _, englishClass = UnitClass("player")
    return englishClass or "UNKNOWN"
end

-- ===================================================
-- Obtient la classe du joueur localisée
-- @return: string - Nom de classe localisé
-- ===================================================

function EmzTools.Utils:GetLocalizedPlayerClass()
    local localizedClass = UnitClass("player")
    return localizedClass or EmzTools:GetText("EMZTOOLS_STATE_UNKNOWN")
end

-- ===================================================
-- Obtient le nom de classe localisé pour l'affichage
-- @param className: string - (optionnel) Nom de classe en anglais
-- @return: string - Nom de classe localisé
-- ===================================================

function EmzTools.Utils:GetLocalizedClassName(className)
    if not className then
        className = self:GetPlayerClass()
    end

    if not className or type(className) ~= "string" then
        return EmzTools:GetText("EMZTOOLS_STATE_UNKNOWN")
    end

    className = string.upper(className)
    local key = "CLASS_" .. className

    -- Utiliser la fonction GetText de Core.lua
    if EmzTools and EmzTools.GetText then
        local localized = EmzTools:GetText(key)
        if localized and localized ~= key then
            return localized
        end
    end

    -- Fallback : retourner le nom de classe en anglais
    return className
end

-- ===================================================
-- Récupère le niveau du joueur
-- @return: number - Niveau actuel du joueur
-- ===================================================

function EmzTools.Utils:GetPlayerLevel()
    return UnitLevel("player")
end

-- ===================================================
-- CARACTÉRISTIQUES DE CLASSE
-- ===================================================

-- ===================================================
-- Vérifie si le joueur a une ressource de mana
-- @return: boolean - true si le joueur utilise de la mana
-- ===================================================

function EmzTools.Utils:PlayerHasMana()
    local class = self:GetPlayerClass()
    local manaClasses = {
        ["MAGE"] = true,
        ["WARLOCK"] = true,
        ["PRIEST"] = true,
        ["DRUID"] = true,
        ["SHAMAN"] = true,
        ["PALADIN"] = true,
        ["HUNTER"] = true
    }
    return manaClasses[class] or false
end

-- ===================================================
-- Vérifie si le joueur utilise de la rage (Guerrier/Druide en forme d'ours)
-- @return: boolean - true si le joueur utilise de la rage
-- ===================================================

function EmzTools.Utils:PlayerHasRage()
    local class = self:GetPlayerClass()
    return class == "WARRIOR" or class == "DRUID"  -- Druide en forme d'ours
end

-- ===================================================
-- Vérifie si le joueur utilise de l'énergie (Voleur/Druide en forme de félin)
-- @return: boolean - true si le joueur utilise de l'énergie
-- ===================================================

function EmzTools.Utils:PlayerHasEnergy()
    local class = self:GetPlayerClass()
    return class == "ROGUE" or class == "DRUID"  -- Druide en forme de félin
end

-- ===================================================
-- Vérifie si le joueur peut avoir un pet
-- @return: boolean - true si le joueur peut avoir un pet
-- ===================================================

function EmzTools.Utils:PlayerCanHavePet()
    local class = self:GetPlayerClass()
    return class == "HUNTER" or class == "WARLOCK"
end

-- ===================================================
-- Vérifie si le druide est dans une forme spécifique
-- Note: Implémentation simplifiée pour WoW 1.12
-- @param form: string - Forme à vérifier ("bear", "cat", "travel", "aquatic", "moonkin")
-- @return: boolean - true si dans la forme spécifiée
-- ===================================================

function EmzTools.Utils:IsDruidInForm(form)
    if self:GetPlayerClass() ~= "DRUID" then
        return false
    end

    -- IDs de sorts de formes en WoW 1.12
    local formSpells = {
        bear = 5487,      -- Forme d'ours
        cat = 768,        -- Forme de félin
        travel = 783,     -- Forme de voyage
        aquatic = 1066,   -- Forme aquatique
        moonkin = 24858   -- Forme de sélénien
    }

    local spellId = formSpells[form]
    if not spellId then return false end

    -- Vérifier si le buff est présent
    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, currentSpellId = UnitBuff("player", i)
        if not currentSpellId then break end
        if currentSpellId == spellId then
            return true
        end
    end

    return false
end

-- ===================================================
-- ÉTAT DU JOUEUR
-- ===================================================

-- ===================================================
-- Vérifie si le joueur est en combat
-- @return: boolean - true si en combat
-- ===================================================

function EmzTools.Utils:IsInCombat()
    return UnitAffectingCombat("player")
end

-- ===================================================
-- Vérifie si le joueur est assis (en train de manger/boire)
-- @return: boolean - true si assis
-- ===================================================

function EmzTools.Utils:IsSitting()
    local isResting = IsResting()
    local isMounted = self:IsMounted()
    local isDead = self:IsDead()
    local isFlying = UnitOnTaxi("player")
    local isInCombat = self:IsInCombat()
    local isMoving = self:IsPlayerMoving()

    -- Can't be sitting if dead, swimming, mounted, flying, in combat, or moving
    if isDead or isMounted or isFlying or isInCombat or isMoving then
        return false
    end

    return isResting
end

-- ===================================================
-- Détecte si le joueur est en mouvement
-- @return: boolean - true si le joueur bouge
-- ===================================================

function EmzTools.Utils:IsPlayerMoving()
    -- En Lua 5.0, on n'a pas de GetPlayerPosition, donc utilisation simplifiée
    -- On va vérifier si le joueur a une vitesse
    local speed = GetUnitSpeed("player")
    return speed > 0
end

-- ===================================================
-- Vérifie si le joueur est mort
-- @return: boolean - true si mort
-- ===================================================

function EmzTools.Utils:IsDead()
    return UnitIsDead("player") or UnitIsGhost("player")
end

-- ===================================================
-- Vérifie si le joueur est monté
-- Note: WoW 1.12 n'a pas d'API directe pour vérifier les montures
-- On vérifie les buffs de monture
-- @return: boolean - true si monté
-- ===================================================

function EmzTools.Utils:IsMounted()
    for i = 1, 40 do
        local buff = UnitBuff("player", i)
        if not buff then break end

        -- Vérifier si c'est un buff de monture par le nom
        local buffName = buff
        if buffName and (string.find(string.lower(buffName), "mount") or
                         string.find(string.lower(buffName), "chevaucher") or
                         string.find(string.lower(buffName), "ride")) then
            return true
        end
    end
    return false
end

-- ===================================================
-- Vérifie si le joueur peut lancer des sorts
-- @return: boolean - true si le joueur peut caster
-- ===================================================

function EmzTools.Utils:CanCast()
    -- Vérifie si le joueur est en train de caster
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
        return false
    end

    -- Vérifie si le joueur est mort
    if self:IsDead() then
        return false
    end

    -- Vérifie si le joueur est en train de looter
    if UnitIsDeadOrGhost("player") then
        return false
    end

    return true
end

-- ===================================================
-- SANTÉ ET RESSOURCES
-- ===================================================

-- ===================================================
-- Récupère le pourcentage de vie du joueur
-- @return: number - Pourcentage de HP (0-100)
-- ===================================================

function EmzTools.Utils:GetPlayerHPPercent()
    local hp = UnitHealth("player")
    local maxHP = UnitHealthMax("player")
    if maxHP == 0 then return 0 end
    return (hp / maxHP) * 100
end

-- ===================================================
-- Récupère le pourcentage de mana du joueur
-- @return: number - Pourcentage de mana (0-100)
-- ===================================================

function EmzTools.Utils:GetPlayerManaPercent()
    local mana = UnitMana("player")
    local maxMana = UnitManaMax("player")
    if maxMana == 0 then return 0 end
    return (mana / maxMana) * 100
end

-- =============================================================
-- Récupère le pourcentage de la ressource principale du joueur
-- @return: number - Pourcentage de la ressource (0-100)
-- =============================================================

function EmzTools.Utils:GetPlayerResourcePercent()
    if self:PlayerHasMana() then
        return self:GetPlayerManaPercent()
    elseif self:PlayerHasRage() then
        local rage = UnitMana("player")
        local maxRage = UnitManaMax("player")
        if maxRage == 0 then return 0 end
        return (rage / maxRage) * 100
    elseif self:PlayerHasEnergy() then
        local energy = UnitMana("player")
        local maxEnergy = UnitManaMax("player")
        if maxEnergy == 0 then return 0 end
        return (energy / maxEnergy) * 100
    else
        -- Pour les classes sans ressource spéciale
        return self:GetPlayerHPPercent()
    end
end

-- ===================================================
-- POSITION ET MOUVEMENT
-- ===================================================

-- ===================================================
-- Obtient la position du joueur (simplifié pour 1.12)
-- @return: number, number, number - Coordonnées X, Y, Z
-- ===================================================

function EmzTools.Utils:GetPlayerPosition()
    -- En WoW 1.12, on utilise GetPlayerMapPosition
    local x, y = GetPlayerMapPosition("player")
    return x or 0, y or 0, 0
end

-- ===================================================
-- Calcule la distance entre deux points 2D (simplifié)
-- @param x1: number - Coordonnée X du premier point
-- @param y1: number - Coordonnée Y du premier point
-- @param x2: number - Coordonnée X du second point
-- @param y2: number - Coordonnée Y du second point
-- @return: number - Distance entre les points
-- ===================================================

function EmzTools.Utils:CalculateDistance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- ===================================================
-- PET
-- ===================================================

-- ===================================================
-- Vérifie si le joueur a un pet actif
-- @return: boolean - true si le joueur a un pet
-- ===================================================

function EmzTools.Utils:HasPet()
    return UnitExists("pet") and not UnitIsDead("pet")
end

-- ===================================================
-- Récupère le pourcentage de vie du pet
-- @return: number - Pourcentage de HP du pet (0-100), ou 0 si pas de pet
-- ===================================================

function EmzTools.Utils:GetPetHPPercent()
    if not UnitExists("pet") then return 0 end
    local hp = UnitHealth("pet")
    local maxHP = UnitHealthMax("pet")
    if maxHP == 0 then return 0 end
    return (hp / maxHP) * 100
end

-- =============================================================
-- Vérifie si le pet est en combat
-- @return: boolean - true si le pet est en combat, false sinon
-- =============================================================

function EmzTools.Utils:IsPetInCombat()
    if not self:HasPet() then
        return false
    end

    -- Vérifier si le pet combat activement
    if UnitAffectingCombat("pet") then
        return true
    end

    -- Vérifier si le pet a une cible en combat
    if UnitExists("pettarget") then
        if UnitAffectingCombat("pettarget") then
            return true
        end
    end

    return false
end

-- ===================================================
-- UNITÉS ET CIBLES
-- ===================================================

-- ===================================================
-- Récupère le pourcentage de santé d'une unité
-- @param unit: string - Unité cible (ex: "player", "target", "pet")
-- @return: number - Pourcentage de santé (0-100)
-- ===================================================

function EmzTools.Utils:GetUnitHealthPercent(unit)
    if not unit or not UnitExists(unit) then
        return 0
    end

    local health = UnitHealth(unit)
    local maxHealth = UnitHealthMax(unit)

    if not health or not maxHealth or maxHealth == 0 then
        return 0
    end

    return (health / maxHealth) * 100
end

-- =========================================================
-- Vérifie si une unité existe et est vivante
-- @param unit: string - Nom de l'unité
-- @return: boolean - true si l'unité existe et est vivante
-- =========================================================

function EmzTools.Utils:IsValidUnit(unit)
    return UnitExists(unit) and not UnitIsDead(unit)
end

-- ===================================================
-- Vérifie si une unité est hostile
-- @param unit: string - Nom de l'unité
-- @return: boolean - true si l'unité est hostile
-- ===================================================

function EmzTools.Utils:IsHostile(unit)
    unit = unit or "target"
    return UnitCanAttack("player", unit)
end

-- ===================================================
-- Récupère la distance approximative à une cible
-- @param unit: string - Nom de l'unité
-- @return: number - Distance en yards (approximative), ou nil si impossible
-- ===================================================

function EmzTools.Utils:GetDistanceToUnit(unit)
    unit = unit or "target"
    if not UnitExists(unit) then return nil end

    -- Utilise CheckInteractDistance pour une estimation
    if CheckInteractDistance(unit, 1) then return 5 end  -- Inspect (environ 5 yards)
    if CheckInteractDistance(unit, 2) then return 10 end -- Trade (environ 10 yards)
    if CheckInteractDistance(unit, 3) then return 30 end -- Duel (environ 30 yards)
    return 40 -- Au-delà de 30 yards
end

-- ===================================================
-- Compte le nombre d'ennemis à portée
-- @param range: number - Portée en yards
-- @return: number - Nombre d'ennemis à portée
-- ===================================================

function EmzTools.Utils:GetEnemiesInRange(range)
    local count = 0
    range = range or 40

    -- Méthode basique pour WoW 1.12 : vérifier les unités ciblables
    -- Vérifier la cible principale
    if self:IsValidUnit("target") and self:IsHostile("target") then
        local distance = self:GetDistanceToUnit("target")
        if distance and distance <= range then
            count = count + 1
        end
    end

    -- Note: En WoW 1.12, on ne peut pas scanner tous les ennemis autour facilement
    return count
end

-- ===================================================
-- OBJETS ET INVENTAIRE
-- ===================================================

-- ===================================================
-- Vérifie si le joueur possède un objet
-- @param itemId: number|string - ID de l'objet OU nom de l'objet
-- @return: boolean - true si le joueur possède l'objet
-- ===================================================

function EmzTools.Utils:HasItem(itemId)
    if type(itemId) == "number" then
        return self:GetItemCount(itemId) > 0
    elseif type(itemId) == "string" then
        -- Pour les noms d'objets, on doit parcourir l'inventaire
        return self:GetItemCountByName(itemId) > 0
    end
    return false
end

-- ===================================================
-- Compte le nombre d'exemplaires d'un objet par son ID
-- @param itemID: number - ID de l'objet
-- @return: number - Nombre d'exemplaires
-- ===================================================

function EmzTools.Utils:GetItemCount(itemID)
    if not itemID then
        return 0
    end

    local totalCount = 0

    -- Parcourir tous les sacs (0-4) et les emplacements
    for bag = 0, 4 do
        local numSlots = GetContainerNumSlots(bag)
        if numSlots and numSlots > 0 then
            for slot = 1, numSlots do
                local itemLink = GetContainerItemLink(bag, slot)
                if itemLink then
                    local _, _, itemString = string.find(itemLink, "|Hitem:(%d+):")
                    if itemString then
                        local currentItemID = tonumber(itemString)
                        if currentItemID == itemID then
                            local _, itemCount = GetContainerItemInfo(bag, slot)
                            totalCount = totalCount + (itemCount or 1)
                        end
                    end
                end
            end
        end
    end

    return totalCount
end

-- ===================================================
-- Compte le nombre d'exemplaires d'un objet par son nom
-- @param itemName: string - Nom de l'objet
-- @return: number - Nombre d'exemplaires
-- ===================================================

function EmzTools.Utils:GetItemCountByName(itemName)
    if not itemName then
        return 0
    end

    local totalCount = 0

    -- Parcourir tous les sacs (0-4) et les emplacements
    for bag = 0, 4 do
        local numSlots = GetContainerNumSlots(bag)
        if numSlots and numSlots > 0 then
            for slot = 1, numSlots do
                local itemLink = GetContainerItemLink(bag, slot)
                if itemLink then
                    local name = GetItemInfo(itemLink)
                    if name == itemName then
                        local _, itemCount = GetContainerItemInfo(bag, slot)
                        totalCount = totalCount + (itemCount or 1)
                    end
                end
            end
        end
    end

    return totalCount
end

-- ===================================================
-- Utilise un objet par son nom
-- @param itemName: string - Nom de l'objet
-- @return: boolean - true si l'objet a été utilisé
-- ===================================================

function EmzTools.Utils:UseItemByName(itemName)
    if not itemName then return false end

    -- Chercher l'objet dans les sacs
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot)
            if link then
                local name = GetItemInfo(link)
                if name == itemName then
                    UseContainerItem(bag, slot)
                    return true
                end
            end
        end
    end

    return false
end

-- ===================================================
-- Utilise un objet par son ID
-- @param itemID: number - ID de l'objet
-- @return: boolean - true si l'objet a été utilisé
-- ===================================================

function EmzTools.Utils:UseItemByID(itemID)
    if not itemID then return false end

    -- Chercher l'objet dans les sacs
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local link = GetContainerItemLink(bag, slot)
            if link then
                local _, _, itemString = string.find(link, "|Hitem:(%d+):")
                if itemString then
                    local currentItemID = tonumber(itemString)
                    if currentItemID == itemID then
                        UseContainerItem(bag, slot)
                        return true
                    end
                end
            end
        end
    end

    return false
end

-- ===================================================
-- MATHÉMATIQUES ET CALCULS
-- ===================================================

-- ===================================================
-- Arrondit un nombre à N décimales
-- @param num: number - Nombre à arrondir
-- @param decimals: number - Nombre de décimales (défaut: 0)
-- @return: number - Nombre arrondi
-- ===================================================

function EmzTools.Utils:Round(num, decimals)
    decimals = decimals or 0
    local mult = 10^decimals
    return math.floor(num * mult + 0.5) / mult
end

-- ===================================================
-- Calcule un pourcentage
-- @param value: number - Valeur actuelle
-- @param max: number - Valeur maximale
-- @return: number - Pourcentage (0-100)
-- ===================================================

function EmzTools.Utils:CalculatePercent(value, max)
    if max == 0 then return 0 end
    return (value / max) * 100
end

-- ===================================================
-- Interpole linéairement entre deux valeurs
-- @param a: number - Première valeur
-- @param b: number - Deuxième valeur
-- @param t: number - Facteur d'interpolation (0-1)
-- @return: number - Valeur interpolée
-- ===================================================

function EmzTools.Utils:Lerp(a, b, t)
    return a + (b - a) * t
end

-- ===================================================
-- TEMPS
-- ===================================================

-- ===================================================
-- Récupère le temps actuel en secondes
-- @return: number - Temps en secondes
-- ===================================================

function EmzTools.Utils:GetTime()
    return GetTime()
end

-- ===================================================
-- Formate un temps en secondes en format lisible
-- @param seconds: number - Temps en secondes
-- @return: string - Temps formaté (ex: "1h 23m 45s")
-- ===================================================

function EmzTools.Utils:FormatTime(seconds)
    if not seconds or seconds < 0 then
        return "0s"
    end

    local hours = math.floor(seconds / 3600)
    local minutes = math.floor(math.fmod(seconds, 3600) / 60)
    local secs = math.floor(math.fmod(seconds, 60))

    if hours > 0 then
        return string.format("%dh %dm %ds", hours, minutes, secs)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, secs)
    else
        return string.format("%ds", secs)
    end
end

-- ===================================================
-- CHAÎNES DE CARACTÈRES
-- ===================================================

-- ===================================================
-- Divise une chaîne en mots (implémentation Lua 5.0)
-- @param str: string - Chaîne à diviser
-- @param delimiter: string - Délimiteur (défaut: espace)
-- @return: table - Table des mots
-- ===================================================

function EmzTools.Utils:Split(str, delimiter)
    delimiter = delimiter or " "
    local result = {}
    local pattern = "(.-)" .. delimiter .. "()"
    local lastPos = 1

    for part, pos in string.gfind(str, pattern) do
        table.insert(result, part)
        lastPos = pos
    end

    -- Ajouter la dernière partie
    table.insert(result, string.sub(str, lastPos))

    return result
end

-- ===================================================
-- Supprime les espaces au début et à la fin
-- @param str: string - Chaîne à nettoyer
-- @return: string - Chaîne nettoyée
-- ===================================================

function EmzTools.Utils:Trim(str)
    return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

-- ===================================================
-- DEBUG TABLE (POUR DÉVELOPPEMENT)
-- ===================================================

-- ===================================================
-- Dump une table dans le chat
-- @param tbl: table - Table à afficher
-- @param indent: number - Indentation (usage interne)
-- ===================================================

function EmzTools.Utils:DumpTable(tbl, indent)
    indent = indent or 0
    local formatting = string.rep("  ", indent)

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            DEFAULT_CHAT_FRAME:AddMessage(formatting .. tostring(k) .. " = {")
            self:DumpTable(v, indent + 1)
            DEFAULT_CHAT_FRAME:AddMessage(formatting .. "}")
        else
            DEFAULT_CHAT_FRAME:AddMessage(formatting .. tostring(k) .. " = " .. tostring(v))
        end
    end
end

-- ===================================================
-- Ajuste les couleurs selon un facteur
-- @param color: table - Couleur d'origine {r, g, b, a}
-- @param factor: number - Facteur d'ajustement
-- @return: table - Couleur ajustée
-- ===================================================

function EmzTools.Utils:AdjustColor(color, factor)
    if not color or table.getn(color) < 3 then return {1, 1, 1, 1} end

    local r = color[1] * factor
    local g = color[2] * factor
    local b = color[3] * factor
    local a = color[4] or 1

    -- Limiter entre 0 et 1
    r = math.min(1, math.max(0, r))
    g = math.min(1, math.max(0, g))
    b = math.min(1, math.max(0, b))

    return {r, g, b, a}
end

-- ===================================================
-- FONCTIONS DE SÉCURITÉ ET DE COMPATIBILITÉ
-- ===================================================

-- ===================================================
-- Vérifie si le module Utils est disponible via Data
-- @return: boolean - true si disponible
-- ===================================================

function EmzTools.Utils:IsAvailable()
    return EmzTools.Data and EmzTools.Data.Utils ~= nil
end

-- ===================================================
-- Assure la compatibilité bidirectionnelle
-- S'assure que toutes les fonctions sont disponibles
-- via les deux chemins d'accès
-- ===================================================

local function EnsureCompatibility()
    -- Copier toutes les fonctions de EmzTools.Utils vers EmzTools.Data.Utils
    if EmzTools.Utils and EmzTools.Data.Utils then
        for funcName, func in pairs(EmzTools.Utils) do
            if type(func) == "function" then
                EmzTools.Data.Utils[funcName] = func
            end
        end
    end

    -- Afficher un message de confirmation
    EmzTools:Print("EMZTOOLS_UTILS_COMPATIBILITY_ESTABLISHED", "debug")
end

-- ===================================================
-- EXÉCUTION À LA FIN DU FICHIER
-- ===================================================

-- S'exécuter quand le fichier est chargé
EnsureCompatibility()
