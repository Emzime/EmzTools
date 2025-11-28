-- ===================================================
-- MyHunter - MyHunter_SpellBook.lua
-- BIBLIOTHÈQUE D'INFORMATIONS SUR LES SORTS
-- NE LANCE AUCUN SORT - Fournit seulement des informations
-- Compatible avec le framework EmzTools
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_SpellBook = {}

-- Classes supportées (uniquement Hunter)
MyHunter_SpellBook.supportedClasses = { "HUNTER" }

-- Cache des sorts disponibles
MyHunter_SpellBook.availableSpells = {}

-- ===================================================
-- LISTE DES SORTS HUNTER (MONO-CIBLE UNIQUEMENT)
-- ===================================================

-- Sorts de base (mono-cible uniquement)
MyHunter_SpellBook.BasicSpells = {
    "Auto Shot",
    "Raptor Strike",
    "Serpent Sting",
    "Arcane Shot",
    "Concussive Shot",
    "Hunter's Mark",
    "Track Beasts",
    "Aspect of the Monkey",
    "Aspect of the Hawk",
}

-- Sorts de DPS (mono-cible uniquement - pas de AOE)
MyHunter_SpellBook.DamageSpells = {
    "Aimed Shot",
    "Arcane Shot",
    "Serpent Sting",
    "Steady Shot",
    "Kill Command",
    "Chimera Shot",
    "Explosive Shot",
    "Black Arrow",
}

-- Sorts de contrôle (limités - pas de pièges automatiques)
MyHunter_SpellBook.ControlSpells = {
    "Concussive Shot",
    "Scare Beast",
    "Wing Clip",
}

-- Sorts de pet
MyHunter_SpellBook.PetSpells = {
    "Call Pet",
    "Dismiss Pet",
    "Feed Pet",
    "Revive Pet",
    "Mend Pet",
    "Kill Command",
}

-- Sorts d'aspects
MyHunter_SpellBook.AspectSpells = {
    "Aspect of the Monkey",
    "Aspect of the Hawk",
    "Aspect of the Cheetah",
    "Aspect of the Pack",
    "Aspect of the Wild",
    "Aspect of the Beast",
    "Aspect of the Viper",
    "Aspect of the Dragonhawk",
}

-- Sorts de cooldown
MyHunter_SpellBook.CooldownSpells = {
    "Rapid Fire",
    "Bestial Wrath",
}

-- ===================================================
-- COÛTS DE MANA APPROXIMATIFS
-- ===================================================

MyHunter_SpellBook.ManaCosts = {
    ["Aimed Shot"] = 310,
    ["Arcane Shot"] = 70,
    ["Serpent Sting"] = 80,
    ["Hunter's Mark"] = 100,
    ["Steady Shot"] = 110,
    ["Kill Command"] = 150,
    ["Multi-Shot"] = 200,
    ["Raptor Strike"] = 60,
    ["Mongoose Bite"] = 40,
    ["Rapid Fire"] = 100,
    ["Bestial Wrath"] = 100,
    ["Trueshot Aura"] = 100,
}

-- ===================================================
-- INITIALISATION
-- ===================================================

-- Initialise le SpellBook
function MyHunter_SpellBook:Initialize()
    -- Charger la localisation
    EmzTools:LoadPluginLocalization("MyHunter")

    -- Scanner le spellbook au démarrage
    self:ScanSpellBook()

    return true
end

-- ===================================================
-- SCANNING DU SPELLBOOK
-- ===================================================

-- Scanne le spellbook pour détecter tous les sorts disponibles
-- @return: Nombre de sorts détectés
function MyHunter_SpellBook:ScanSpellBook()
    self.availableSpells = {}

    local numTabs = GetNumSpellTabs()

    for tabIndex = 1, numTabs do
        local _, _, offset, numSpells = GetSpellTabInfo(tabIndex)

        for spellIndex = offset + 1, offset + numSpells do
            local spellName, spellRank = GetSpellName(spellIndex, BOOKTYPE_SPELL)

            if spellName then
                -- Ajouter le sort au cache
                if not self.availableSpells[spellName] then
                    self.availableSpells[spellName] = {
                        name = spellName,
                        rank = spellRank,
                        index = spellIndex,
                    }
                else
                    -- Mettre à jour si c'est un rang supérieur
                    local currentRank = self:ExtractRank(self.availableSpells[spellName].rank)
                    local newRank = self:ExtractRank(spellRank)

                    if newRank > currentRank then
                        self.availableSpells[spellName] = {
                            name = spellName,
                            rank = spellRank,
                            index = spellIndex,
                        }
                    end
                end
            end
        end
    end

    local spellCount = self:GetSpellCount()
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_SCANNED", "debug", tostring(spellCount))
    return spellCount
end

-- Extrait le numéro de rang d'une chaîne de rang
-- @param rankString: Chaîne de rang (ex: "Rank 5")
-- @return: Numéro de rang, ou 0 si aucun
function MyHunter_SpellBook:ExtractRank(rankString)
    if not rankString or rankString == "" then
        return 0
    end

    local rank = string.match(rankString, "(%d+)")
    return tonumber(rank) or 0
end

-- ===================================================
-- VÉRIFICATIONS D'INFORMATIONS (NE LANCE PAS DE SORTS)
-- ===================================================

-- Vérifie si un sort est disponible
-- @param spellName: Nom du sort
-- @return: true si le sort est disponible
function MyHunter_SpellBook:HasSpell(spellName)
    return self.availableSpells[spellName] ~= nil
end

-- Vérifie si un sort est prêt (pas en cooldown)
-- @param spellName: Nom du sort
-- @return: true si le sort est prêt
function MyHunter_SpellBook:IsReady(spellName)
    if not self:HasSpell(spellName) then
        return false
    end

    local spellIndex = self.availableSpells[spellName].index
    local start, duration = GetSpellCooldown(spellIndex, BOOKTYPE_SPELL)

    -- Si start == 0, le sort est prêt
    -- Si duration <= 1.5, c'est le GCD, considérer comme prêt
    return start == 0 or duration <= 1.5
end

-- Vérifie si le joueur a assez de mana pour un sort
-- @param spellName: Nom du sort
-- @return: true si assez de mana
function MyHunter_SpellBook:HasEnoughMana(spellName)
    if not self:HasSpell(spellName) then
        return false
    end

    local currentMana = UnitMana("player")
    local cost = self.ManaCosts[spellName] or 0

    return currentMana >= cost
end

-- Vérifie si la cible est à portée du sort
-- @param spellName: Nom du sort
-- @param target: Unité cible (défaut: "target")
-- @return: true si à portée
function MyHunter_SpellBook:IsInRange(spellName, target)
    target = target or "target"

    if not self:HasSpell(spellName) then
        return false
    end

    if not UnitExists(target) then
        return false
    end

    local spellIndex = self.availableSpells[spellName].index
    local inRange = IsSpellInRange(spellIndex, BOOKTYPE_SPELL, target)

    return inRange == 1
end

-- ===================================================
-- INFORMATIONS DÉTAILLÉES SUR LES SORTS
-- ===================================================

-- Récupère le nombre de sorts disponibles
-- @return: Nombre de sorts
function MyHunter_SpellBook:GetSpellCount()
    local count = 0
    for _ in pairs(self.availableSpells) do
        count = count + 1
    end
    return count
end

-- Récupère le cooldown restant d'un sort
-- @param spellName: Nom du sort
-- @return: Temps restant en secondes, ou 0
function MyHunter_SpellBook:GetCooldown(spellName)
    if not self:HasSpell(spellName) then
        return 0
    end

    local spellIndex = self.availableSpells[spellName].index
    local start, duration = GetSpellCooldown(spellIndex, BOOKTYPE_SPELL)

    if start == 0 or duration <= 1.5 then
        return 0
    end

    local remaining = duration - (GetTime() - start)
    return math.max(0, remaining)
end

-- Récupère le coût en mana d'un sort
-- @param spellName: Nom du sort
-- @return: Coût en mana, ou 0 si inconnu
function MyHunter_SpellBook:GetManaCost(spellName)
    return self.ManaCosts[spellName] or 0
end

-- Récupère les informations complètes d'un sort
-- @param spellName: Nom du sort
-- @return: Table d'informations, ou nil
function MyHunter_SpellBook:GetSpellInfo(spellName)
    if not self:HasSpell(spellName) then
        return nil
    end

    local spell = self.availableSpells[spellName]
    local cooldown = self:GetCooldown(spellName)
    local ready = self:IsReady(spellName)
    local hasMana = self:HasEnoughMana(spellName)
    local manaCost = self:GetManaCost(spellName)

    return {
        name = spell.name,
        rank = spell.rank,
        index = spell.index,
        cooldown = cooldown,
        ready = ready,
        hasMana = hasMana,
        manaCost = manaCost,
    }
end

-- Récupère le statut d'un sort pour l'affichage
-- @param spellName: Nom du sort
-- @return: Chaîne de statut formatée
function MyHunter_SpellBook:GetSpellStatus(spellName)
    if not self:HasSpell(spellName) then
        return "|cFF888888" .. "EMZTOOLS_STATE_NOT_LEARNED" .. "|r"
    end

    if self:IsReady(spellName) then
        if self:HasEnoughMana(spellName) then
            return "|cFF00FF00" .. "EMZTOOLS_STATE_READY" .. "|r"
        else
            return "|cFFFFFF00" .. "EMZTOOLS_STATE_NO_MANA" .. "|r"
        end
    else
        local cooldown = self:GetCooldown(spellName)
        if cooldown > 0 then
            return "|cFFFF0000" .. string.format("%.1fs", cooldown) .. "|r"
        else
            return "|cFFFFA500" .. "EMZTOOLS_STATE_NOT_READY" .. "|r"
        end
    end
end

-- ===================================================
-- FONCTIONS DE RECHERCHE ET FILTRAGE
-- ===================================================

-- Vérifie si un sort est dans une catégorie spécifique
-- @param spellName: Nom du sort
-- @param category: Catégorie ("Damage", "Control", etc.)
-- @return: true si le sort est dans la catégorie
function MyHunter_SpellBook:IsSpellInCategory(spellName, category)
    local categoryLists = {
        Damage = self.DamageSpells,
        Control = self.ControlSpells,
        Pet = self.PetSpells,
        Aspect = self.AspectSpells,
        Cooldown = self.CooldownSpells,
    }

    local list = categoryLists[category]
    if not list then return false end

    for _, spell in ipairs(list) do
        if spell == spellName then
            return true
        end
    end
    return false
end

-- Récupère tous les sorts d'une catégorie spécifique
-- @param category: Catégorie ("Damage", "Control", etc.)
-- @return: Table des sorts de la catégorie
function MyHunter_SpellBook:GetSpellsInCategory(category)
    local categoryLists = {
        Damage = self.DamageSpells,
        Control = self.ControlSpells,
        Pet = self.PetSpells,
        Aspect = self.AspectSpells,
        Cooldown = self.CooldownSpells,
    }

    local result = {}
    local list = categoryLists[category] or {}

    for _, spellName in ipairs(list) do
        if self:HasSpell(spellName) then
            table.insert(result, spellName)
        end
    end

    return result
end

-- ===================================================
-- AFFICHAGE DES INFORMATIONS
-- ===================================================

-- Affiche tous les sorts disponibles
function MyHunter_SpellBook:PrintAvailableSpells()
    EmzTools:Print("EMZTOOLS_MYHUNTER_AVAILABLE_SPELLS_HEADER", "info")

    local categories = {
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_BASIC", list = self.BasicSpells},
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_DAMAGE", list = self.DamageSpells},
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_CONTROL", list = self.ControlSpells},
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_PET", list = self.PetSpells},
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_ASPECTS", list = self.AspectSpells},
        {name = "EMZTOOLS_MYHUNTER_SPELL_CATEGORY_COOLDOWNS", list = self.CooldownSpells},
    }

    for _, category in ipairs(categories) do
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_CATEGORY_TITLE", "noPrefix", EmzTools:GetText(category.name))

        local count = 0
        for _, spellName in ipairs(category.list) do
            if self:HasSpell(spellName) then
                local spell = self.availableSpells[spellName]
                local status = self:GetSpellStatus(spellName)
                EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_WITH_STATUS", "noPrefix", spell.name, spell.rank, status)
                count = count + 1
            end
        end

        if count == 0 then
            EmzTools:Print("EMZTOOLS_MYHUNTER_NO_SPELLS_IN_CATEGORY", "noPrefix")
        end
    end
end

-- Affiche les informations détaillées d'un sort
-- @param spellName: Nom du sort
function MyHunter_SpellBook:PrintSpellInfo(spellName)
    local info = self:GetSpellInfo(spellName)
    if not info then
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_NOT_FOUND", "error", spellName)
        return
    end

    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_HEADER", "info", info.name)
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_RANK", "noPrefix", info.rank)
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_MANA_COST", "noPrefix", tostring(info.manaCost))
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_READY", "noPrefix", info.ready and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")
    EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_MANA", "noPrefix", info.hasMana and "EMZTOOLS_STATE_YES" or "EMZTOOLS_STATE_NO")

    if info.cooldown > 0 then
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELL_INFO_COOLDOWN", "noPrefix", string.format("%.1fs", info.cooldown))
    end
end

-- ===================================================
-- COMMANDES SLASH (INFORMATIONS UNIQUEMENT)
-- ===================================================

function MyHunter_SpellBook:SlashCommandHandler(msg)
    local command, param = msg:match("^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "" or command == "help" then
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMANDS_HEADER", "info")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMAND_SCAN", "noPrefix")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMAND_LIST", "noPrefix")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMAND_INFO", "noPrefix")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMAND_COUNT", "noPrefix")
        EmzTools:Print("EMZTOOLS_MYHUNTER_SPELLBOOK_COMMAND_STATUS", "noPrefix")

    elseif command == "scan" then
        local count = self:ScanSpellBook()

    elseif command == "list" then
        self:PrintAvailableSpells()

    elseif command == "count" then
        local count = self:GetSpellCount()

    elseif command == "info" then
        if param and param ~= "" then
            self:PrintSpellInfo(param)
        end

    elseif command == "status" then
        if param and param ~= "" then
            local status = self:GetSpellStatus(param)
        end

    else
        EmzTools:Print("EMZTOOLS_STATE_UNKNOWN_COMMAND", "warning")
    end
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

-- Enregistrement du module avec EmzTools
EmzTools.MyHunter_SpellBook = MyHunter_SpellBook

return MyHunter_SpellBook
