-- ===================================================
-- EmzTools - Utils.lua
-- Fonctions utilitaires globales pour EmzTools
-- ===================================================

-- Module principal Utils
EmzTools.Utils = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

function EmzTools.Utils:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "Utils")
    return true
end

-- Alias pour la rétrocompatibilité
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.Utils = EmzTools.Utils

-- ===================================================
-- INFORMATIONS JOUEUR
-- ===================================================

-- Récupère la classe du joueur (en anglais, majuscules)
-- @return string: Classe du joueur (ex: "WARRIOR", "MAGE", etc.)
function EmzTools.Utils:GetPlayerClass()
    local _, englishClass = UnitClass("player")
    return englishClass
end

-- Récupère le niveau du joueur
-- @return number: Niveau actuel du joueur
function EmzTools.Utils:GetPlayerLevel()
    return UnitLevel("player")
end

-- Vérifie si le joueur a une ressource de mana
-- @return boolean: true si le joueur utilise de la mana
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

-- Vérifie si le joueur peut avoir un pet
-- @return boolean: true si le joueur peut avoir un pet
function EmzTools.Utils:PlayerCanHavePet()
    local class = self:GetPlayerClass()
    return class == "HUNTER" or class == "WARLOCK"
end

-- ===================================================
-- SANTÉ ET RESSOURCES
-- ===================================================

-- Récupère le pourcentage de vie du joueur
-- @return number: Pourcentage de HP (0-100)
function EmzTools.Utils:GetPlayerHPPercent()
    local hp = UnitHealth("player")
    local maxHP = UnitHealthMax("player")
    if maxHP == 0 then return 0 end
    return (hp / maxHP) * 100
end

-- Récupère le pourcentage de mana du joueur
-- @return number: Pourcentage de mana (0-100)
function EmzTools.Utils:GetPlayerManaPercent()
    local mana = UnitMana("player")
    local maxMana = UnitManaMax("player")
    if maxMana == 0 then return 0 end
    return (mana / maxMana) * 100
end

-- Récupère le pourcentage de vie du pet
-- @return number: Pourcentage de HP du pet (0-100), ou 0 si pas de pet
function EmzTools.Utils:GetPetHPPercent()
    if not UnitExists("pet") then return 0 end
    local hp = UnitHealth("pet")
    local maxHP = UnitHealthMax("pet")
    if maxHP == 0 then return 0 end
    return (hp / maxHP) * 100
end

-- Récupère le pourcentage de santé d'une unité
-- @param unit: Unité cible (ex: "player", "target", "pet")
-- @return: Pourcentage de santé (0-100)
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

-- ===================================================
-- ÉTAT DU JOUEUR
-- ===================================================

-- Vérifie si le joueur est en combat
-- @return boolean: true si en combat
function EmzTools.Utils:IsInCombat()
    return UnitAffectingCombat("player")
end

-- Vérifie si le joueur est assis (en train de manger/boire)
-- @return boolean: true si assis
function EmzTools.Utils:IsSitting()
    return UnitIsSitting("player")
end

-- Vérifie si le joueur est mort
-- @return boolean: true si mort
function EmzTools.Utils:IsDead()
    return UnitIsDead("player") or UnitIsGhost("player")
end

-- Vérifie si le joueur est monté
-- @return boolean: true si monté
function EmzTools.Utils:IsMounted()
    for i = 1, 40 do
        local _, _, _, _, _, _, _, _, _, spellId = UnitBuff("player", i)
        if not spellId then break end

        -- IDs de sorts de monture principaux en WoW 1.12
        local mountSpellIDs = {
            -- Mounts terrestres classiques
            458,    -- Brown Horse
            470,    -- Black Horse
            472,    -- Pinto
            580,    -- Timber Wolf
            6648,   -- Chestnut Mare
            6653,   -- Dire Wolf
            6654,   -- Brown Wolf
            6777,   -- Gray Ram
            6899,   -- Brown Ram
            8394,   -- Striped Frostsaber
            8395,   -- Emerald Raptor
            10789,  -- Spotted Frostsaber
            10790,  -- Tiger
            10793,  -- Striped Nightsaber
            10795,  -- Ivory Raptor
            10796,  -- Turquoise Raptor
            10799,  -- Violet Raptor
            10873,  -- Red Mechanostrider
            10969,  -- Blue Mechanostrider
            13819,  -- Warhorse
            15779,  -- White Mechanostrider
            16055,  -- Black Nightsaber
            16056,  -- Ancient Frostsaber
            16058,  -- Primal Leopard
            16059,  -- Primal Tiger
            16060,  -- Golden Sabercat
            16080,  -- Red Wolf
            16081,  -- Arctic Wolf
            16082,  -- Palomino
            16083,  -- White Stallion
            16084,  -- Mottled Red Raptor
            17229,  -- Winterspring Frostsaber
            17453,  -- Green Mechanostrider
            17454,  -- Unpainted Mechanostrider
            17459,  -- Icy Blue Mechanostrider
            17460,  -- Frost Ram
            17461,  -- Black Ram
            17462,  -- Red Skeletal Horse
            17463,  -- Blue Skeletal Horse
            17464,  -- Brown Skeletal Horse
            17465,  -- Green Skeletal Warhorse
            18363,  -- Riding Kodo
            18989,  -- Gray Kodo
            18990,  -- Brown Kodo
            18991,  -- Green Kodo
            18992,  -- Teal Kodo
            22717,  -- Black War Steed
            22719,  -- Black Battlestrider
            22720,  -- Black War Ram
            22721,  -- Black War Raptor
            22722,  -- Red Skeletal Warhorse
            22723,  -- Black War Kodo
            22724,  -- Black War Tiger
            23338,  -- Swift Stormsaber
            23509,  -- Frostwolf Howler
            23510,  -- Stormpike Battle Charger,
        }

        -- Vérifier si le spellId correspond à une monture
        for _, mountId in pairs(mountSpellIDs) do
            if spellId == mountId then
                return true
            end
        end
    end
    return false
end

-- Vérifie si le joueur peut lancer des sorts
-- @return boolean: true si le joueur peut caster
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
-- PET
-- ===================================================

-- Vérifie si le joueur a un pet actif
-- @return boolean: true si le joueur a un pet
function EmzTools.Utils:HasPet()
    return UnitExists("pet") and not UnitIsDead("pet")
end

-- Vérifie si le pet est en combat
-- @return boolean: true si le pet est en combat
function EmzTools.Utils:IsPetInCombat()
    if not self:HasPet() then return false end
    return UnitAffectingCombat("pet")
end

-- ===================================================
-- UNITÉS ET CIBLES
-- ===================================================

-- Vérifie si une unité existe et est vivante
-- @param unit: Nom de l'unité
-- @return boolean: true si l'unité existe et est vivante
function EmzTools.Utils:IsValidUnit(unit)
    return UnitExists(unit) and not UnitIsDead(unit)
end

-- Vérifie si une unité est hostile
-- @param unit: Nom de l'unité
-- @return boolean: true si l'unité est hostile
function EmzTools.Utils:IsHostile(unit)
    unit = unit or "target"
    return UnitCanAttack("player", unit)
end

-- Récupère la distance approximative à une cible
-- @param unit: Nom de l'unité
-- @return number: Distance en yards (approximative), ou nil si impossible
function EmzTools.Utils:GetDistanceToUnit(unit)
    unit = unit or "target"
    if not UnitExists(unit) then return nil end

    -- Utilise CheckInteractDistance pour une estimation
    if CheckInteractDistance(unit, 1) then return 5 end  -- Inspect (environ 5 yards)
    if CheckInteractDistance(unit, 2) then return 10 end -- Trade (environ 10 yards)
    if CheckInteractDistance(unit, 3) then return 30 end -- Duel (environ 30 yards)
    return 40 -- Au-delà de 30 yards
end

-- Compte le nombre d'ennemis à portée
-- @param range: Portée en yards
-- @return number: Nombre d'ennemis à portée
function EmzTools.Utils:GetEnemiesInRange(range)
    local count = 0
    range = range or 40

    -- Méthode basique pour WoW 1.12 : vérifier les unités ciblables
    -- Cette méthode est limitée mais fonctionne pour les cibles proches

    -- Vérifier la cible principale
    if self:IsValidUnit("target") and self:IsHostile("target") then
        local distance = self:GetDistanceToUnit("target")
        if distance and distance <= range then
            count = count + 1
        end
    end

    -- Vérifier le focus (si disponible)
    if self:IsValidUnit("focus") and self:IsHostile("focus") then
        local distance = self:GetDistanceToUnit("focus")
        if distance and distance <= range then
            count = count + 1
        end
    end

    -- Note: En WoW 1.12, on ne peut pas scanner tous les ennemis autour
    -- sans utiliser des techniques avancées (nameplates, etc.)

    return count
end

-- ===================================================
-- OBJETS ET INVENTAIRE
-- ===================================================

-- Vérifie si le joueur possède un objet
-- @param itemId: ID de l'objet OU nom de l'objet
-- @return boolean: true si le joueur possède l'objet
function EmzTools.Utils:HasItem(itemId)
    if type(itemId) == "number" then
        return GetItemCount(itemId) > 0
    elseif type(itemId) == "string" then
        return GetItemCount(itemId) > 0
    end
    return false
end

-- Compte le nombre d'exemplaires d'un objet
-- @param itemId: ID de l'objet OU nom de l'objet
-- @return number: Nombre d'exemplaires
function EmzTools.Utils:GetItemCount(itemId)
    return GetItemCount(itemId) or 0
end

-- Utilise un objet par son nom
-- @param itemName: Nom de l'objet
-- @return boolean: true si l'objet a été utilisé
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
-- MATHÉMATIQUES ET CALCULS
-- ===================================================

-- Arrondit un nombre à N décimales
-- @param num: Nombre à arrondir
-- @param decimals: Nombre de décimales (défaut: 0)
-- @return number: Nombre arrondi
function EmzTools.Utils:Round(num, decimals)
    decimals = decimals or 0
    local mult = 10^decimals
    return math.floor(num * mult + 0.5) / mult
end

-- Calcule un pourcentage
-- @param value: Valeur actuelle
-- @param max: Valeur maximale
-- @return number: Pourcentage (0-100)
function EmzTools.Utils:CalculatePercent(value, max)
    if max == 0 then return 0 end
    return (value / max) * 100
end

-- Interpole linéairement entre deux valeurs
-- @param a: Première valeur
-- @param b: Deuxième valeur
-- @param t: Facteur d'interpolation (0-1)
-- @return number: Valeur interpolée
function EmzTools.Utils:Lerp(a, b, t)
    return a + (b - a) * t
end

-- ===================================================
-- TEMPS
-- ===================================================

-- Récupère le temps actuel en secondes
-- @return number: Temps en secondes
function EmzTools.Utils:GetTime()
    return GetTime()
end

-- Formate un temps en secondes en format lisible
-- @param seconds: Temps en secondes
-- @return string: Temps formaté (ex: "1h 23m 45s")
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

-- Divise une chaîne en mots
-- @param str: Chaîne à diviser
-- @param delimiter: Délimiteur (défaut: espace)
-- @return table: Table des mots
function EmzTools.Utils:Split(str, delimiter)
    delimiter = delimiter or " "
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

-- Supprime les espaces au début et à la fin
-- @param str: Chaîne à nettoyer
-- @return string: Chaîne nettoyée
function EmzTools.Utils:Trim(str)
    return str:match("^%s*(.-)%s*$")
end

-- ===================================================
-- DEBUG TABLE (POUR DÉVELOPPEMENT)
-- ===================================================

-- Dump une table dans le chat
-- @param tbl: Table à afficher
-- @param indent: Indentation (usage interne)
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
