-- ===================================================
-- MyHunter - MyHunter_Stings.lua
-- Gestion automatique des piqûres
-- Compatible avec le framework EmzTools
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_Stings = {}

-- Classes supportées (uniquement Hunter)
MyHunter_Stings.supportedClasses = { "HUNTER" }

-- ===================================================
-- LISTE DES PIQÛRES DISPONIBLES
-- ===================================================
MyHunter_Stings.List = {
    Serpent = "Serpent Sting",
    Scorpid = "Scorpid Sting",
    Viper = "Viper Sting",
}

-- ===================================================
-- INITIALISATION
-- ===================================================

-- Initialise le module des piqûres
function MyHunter_Stings:Initialize()
    -- Charger la localisation via le framework
    EmzTools:LoadPluginLocalization("MyHunter")

    -- Initialiser la configuration par défaut
    self:InitializeDefaults()

    return true
end

-- Initialise les valeurs par défaut dans la base de données
function MyHunter_Stings:InitializeDefaults()
    if not EmzToolsDB then return end

    -- Assurer que la structure de base existe
    if not EmzToolsDB.MyHunter then
        EmzToolsDB.MyHunter = {}
    end

    -- Initialiser les paramètres des piqûres
    if EmzToolsDB.MyHunter.stings == nil then
        EmzToolsDB.MyHunter.stings = {
            autoStings = true,              -- Activation automatique
            pveSting = "Serpent Sting",     -- Piqûre PvE par défaut
            pvpSting = "Viper Sting",       -- Piqûre PvP par défaut
            bossSting = "Scorpid Sting",    -- Piqûre boss par défaut
            enableSmartStings = true,       -- Sélection intelligente
            stingRotation = true            -- Rotation automatique
        }
    end
end

-- ===================================================
-- VÉRIFICATIONS ET DÉTECTION
-- ===================================================

-- Vérifie si la cible a une piqûre active
-- @param stingName: Nom de la piqûre (optionnel)
-- @return: true si la piqûre est active
function MyHunter_Stings:TargetHasSting(stingName)
    if not UnitExists("target") then
        return false
    end

    if stingName then
        -- Vérifier une piqûre spécifique
        return UnitDebuff("target", stingName) ~= nil
    else
        -- Vérifier si n'importe quelle piqûre est active
        for _, sting in pairs(self.List) do
            if UnitDebuff("target", sting) then
                return true
            end
        end
        return false
    end
end

-- Récupère la piqûre actuellement active sur la cible
-- @return: Nom de la piqûre active, ou nil
function MyHunter_Stings:GetTargetSting()
    if not UnitExists("target") then
        return nil
    end

    -- Parcourir toutes les piqûres pour trouver celle active
    for _, sting in pairs(self.List) do
        if UnitDebuff("target", sting) then
            return sting
        end
    end
    return nil
end

-- Vérifie si une piqûre est disponible (apprise)
-- @param stingName: Nom de la piqûre
-- @return: true si la piqûre est disponible
function MyHunter_Stings:IsStingAvailable(stingName)
    if not stingName then
        return false
    end

    -- Vérification directe via l'ID du sort
    local spellId = self:GetStingSpellId(stingName)
    if spellId then
        return IsSpellKnown(spellId)
    end

    return false
end

-- Récupère l'ID de sort d'une piqûre
-- @param stingName: Nom de la piqûre
-- @return: ID du sort, ou nil
function MyHunter_Stings:GetStingSpellId(stingName)
    local stingIds = {
        ["Serpent Sting"] = 1978,   -- ID pour Serpent Sting
        ["Scorpid Sting"] = 3043,   -- ID pour Scorpid Sting
        ["Viper Sting"] = 3034      -- ID pour Viper Sting
    }
    return stingIds[stingName]
end

-- ===================================================
-- ACTIVATION DES PIQÛRES
-- ===================================================

-- Active une piqûre spécifique sur la cible
-- @param stingName: Nom de la piqûre
-- @return: true si la piqûre a été activée
function MyHunter_Stings:ActivateSting(stingName)
    if not stingName or not UnitExists("target") then
        return false
    end

    -- Vérifier si le sort existe
    if not self:IsStingAvailable(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_NOT_AVAILABLE", "debug", stingName)
        return false
    end

    -- Vérifier si la piqûre est déjà active
    if self:TargetHasSting(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_ALREADY_ACTIVE", "debug", stingName)
        return true
    end

    -- Vérifier la portée
    if not self:IsStingInRange(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_OUT_OF_RANGE", "debug", stingName)
        return false
    end

    -- Lancer la piqûre
    CastSpellByName(stingName)

    -- Cibler si nécessaire
    if SpellIsTargeting() then
        SpellTargetUnit("target")
    end

    EmzTools:Print("EMZTOOLS_MYHUNTER_STING_ACTIVATED", "debug", stingName)
    return true
end

-- Vérifie si la piqûre est à portée
-- @param stingName: Nom de la piqûre
-- @return: true si à portée
function MyHunter_Stings:IsStingInRange(stingName)
    if not UnitExists("target") then
        return false
    end

    local spellId = self:GetStingSpellId(stingName)
    if spellId then
        -- IsSpellInRange retourne 1 si à portée, 0 sinon
        local inRange = IsSpellInRange(spellId, "target")
        return inRange == 1
    end

    return false
end

-- ===================================================
-- MÉTHODES SPÉCIFIQUES PAR PIQÛRE
-- ===================================================

-- Active Serpent Sting
function MyHunter_Stings:ActivateSerpent()
    return self:ActivateSting(self.List.Serpent)
end

-- Active Scorpid Sting
function MyHunter_Stings:ActivateScorpid()
    return self:ActivateSting(self.List.Scorpid)
end

-- Active Viper Sting
function MyHunter_Stings:ActivateViper()
    return self:ActivateSting(self.List.Viper)
end

-- ===================================================
-- GESTION AUTOMATIQUE INTELLIGENTE
-- ===================================================

-- Sélectionne la piqûre optimale selon le contexte
-- @return: Nom de la piqûre optimale, ou nil
function MyHunter_Stings:GetOptimalSting()
    if not UnitExists("target") then
        return nil
    end

    local targetType = self:GetTargetType()

    if targetType == "player" then
        -- PvP : Viper Sting pour drainer le mana
        return self.List.Viper
    elseif targetType == "boss" then
        -- Boss : Scorpid Sting pour réduire l'armure
        return self.List.Scorpid
    else
        -- PvE normal : Serpent Sting pour les dégâts
        return self.List.Serpent
    end
end

-- Détermine le type de cible
-- @return: "player", "boss", ou "normal"
function MyHunter_Stings:GetTargetType()
    if not UnitExists("target") then
        return "normal"
    end

    if UnitIsPlayer("target") then
        return "player"
    elseif UnitClassification("target") == "worldboss" or UnitClassification("target") == "rareelite" then
        return "boss"
    else
        return "normal"
    end
end

-- Gestion intelligente des piqûres (sélection automatique)
-- @return: true si une piqûre a été activée
function MyHunter_Stings:SmartSting()
    if not EmzToolsDB.MyHunter.stings.enableSmartStings then
        return false
    end

    if not UnitExists("target") then
        EmzTools:Print("EMZTOOLS_MYHUNTER_NO_TARGET_FOR_STING", "warning")
        return false
    end

    local optimalSting = self:GetOptimalSting()

    if optimalSting and self:IsStingAvailable(optimalSting) then
        return self:ActivateSting(optimalSting)
    end

    return false
end

-- Rotation automatique des piqûres
-- @return: true si une action a été effectuée
function MyHunter_Stings:AutoStingRotation()
    if not EmzToolsDB.MyHunter.stings.stingRotation then
        return false
    end

    if not UnitExists("target") or not UnitAffectingCombat("target") then
        return false
    end

    -- Vérifier si une piqûre est déjà active
    local currentSting = self:GetTargetSting()
    if currentSting then
        return true -- Piqûre déjà active, rien à faire
    end

    -- Appliquer la piqûre optimale
    return self:SmartSting()
end

-- ===================================================
-- CONFIGURATION ET PARAMÉTRAGE
-- ===================================================

-- Active/désactive les piqûres automatiques
-- @param enabled: true pour activer, false pour désactiver
function MyHunter_Stings:SetAutoStings(enabled)
    EmzToolsDB.MyHunter.stings.autoStings = enabled
    if enabled then
        EmzTools:Print("EMZTOOLS_MYHUNTER_AUTO_STINGS_ENABLED", "success")
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_AUTO_STINGS_DISABLED", "success")
    end
end

-- Définit la piqûre pour le PvE
-- @param stingName: Nom de la piqûre
-- @return: true si la configuration a été appliquée
function MyHunter_Stings:SetPvESting(stingName)
    if not self:IsStingAvailable(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_NOT_AVAILABLE", "error", stingName)
        return false
    end

    EmzToolsDB.MyHunter.stings.pveSting = stingName
    EmzTools:Print("EMZTOOLS_MYHUNTER_PVE_STING_SET", "success", stingName)
    return true
end

-- Définit la piqûre pour le PvP
-- @param stingName: Nom de la piqûre
-- @return: true si la configuration a été appliquée
function MyHunter_Stings:SetPvPSting(stingName)
    if not self:IsStingAvailable(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_NOT_AVAILABLE", "error", stingName)
        return false
    end

    EmzToolsDB.MyHunter.stings.pvpSting = stingName
    EmzTools:Print("EMZTOOLS_MYHUNTER_PVP_STING_SET", "success", stingName)
    return true
end

-- Définit la piqûre pour les boss
-- @param stingName: Nom de la piqûre
-- @return: true si la configuration a été appliquée
function MyHunter_Stings:SetBossSting(stingName)
    if not self:IsStingAvailable(stingName) then
        EmzTools:Print("EMZTOOLS_MYHUNTER_STING_NOT_AVAILABLE", "error", stingName)
        return false
    end

    EmzToolsDB.MyHunter.stings.bossSting = stingName
    EmzTools:Print("EMZTOOLS_MYHUNTER_BOSS_STING_SET", "success", stingName)
    return true
end

-- ===================================================
-- INFORMATIONS ET AFFICHAGE
-- ===================================================

-- Affiche la piqûre actuelle sur la cible
function MyHunter_Stings:PrintTargetSting()
    if not UnitExists("target") then
        EmzTools:Print("EMZTOOLS_MYHUNTER_NO_TARGET", "warning")
        return
    end

    local currentSting = self:GetTargetSting()

    if currentSting then
        EmzTools:Print("EMZTOOLS_MYHUNTER_CURRENT_TARGET_STING", "info", currentSting)
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_NO_STING_ON_TARGET", "info")
    end
end

-- Affiche toutes les piqûres disponibles
function MyHunter_Stings:PrintAvailableStings()
    EmzTools:Print("EMZTOOLS_MYHUNTER_AVAILABLE_STINGS_HEADER", "info")

    local hasAvailable = false
    for name, sting in pairs(self.List) do
        if self:IsStingAvailable(sting) then
            hasAvailable = true
            EmzTools:Print("EMZTOOLS_MYHUNTER_STING_AVAILABLE", "noPrefix", sting)
        end
    end

    if not hasAvailable then
        EmzTools:Print("EMZTOOLS_MYHUNTER_NO_STINGS_AVAILABLE", "noPrefix")
    end
end

-- Affiche la configuration actuelle
function MyHunter_Stings:PrintConfig()
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_CONFIG_HEADER", "info")

    local autoStings = EmzToolsDB.MyHunter.stings.autoStings
    EmzTools:Print("EMZTOOLS_MYHUNTER_AUTO_STINGS_STATUS", "noPrefix",
                   autoStings and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED")

    local pveSting = EmzToolsDB.MyHunter.stings.pveSting
    EmzTools:Print("EMZTOOLS_MYHUNTER_PVE_STING_STATUS", "noPrefix", pveSting)

    local pvpSting = EmzToolsDB.MyHunter.stings.pvpSting
    EmzTools:Print("EMZTOOLS_MYHUNTER_PVP_STING_STATUS", "noPrefix", pvpSting)

    local bossSting = EmzToolsDB.MyHunter.stings.bossSting
    EmzTools:Print("EMZTOOLS_MYHUNTER_BOSS_STING_STATUS", "noPrefix", bossSting)

    local enableSmartStings = EmzToolsDB.MyHunter.stings.enableSmartStings
    EmzTools:Print("EMZTOOLS_MYHUNTER_SMART_STINGS_STATUS", "noPrefix",
                   enableSmartStings and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED")

    local stingRotation = EmzToolsDB.MyHunter.stings.stingRotation
    EmzTools:Print("EMZTOOLS_MYHUNTER_STING_ROTATION_STATUS", "noPrefix",
                   stingRotation and "EMZTOOLS_STATE_ENABLED" or "EMZTOOLS_STATE_DISABLED")
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

-- Gestionnaire principal des commandes slash
-- @param msg: Message de commande
function MyHunter_Stings:SlashCommandHandler(msg)
    local command, param = msg:match("^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "" or command == "help" then
        self:PrintHelp()

    elseif command == "status" then
        self:PrintTargetSting()

    elseif command == "list" then
        self:PrintAvailableStings()

    elseif command == "config" then
        self:PrintConfig()

    elseif command == "smart" then
        self:SmartSting()

    elseif command == "serpent" then
        self:ActivateSerpent()

    elseif command == "scorpid" then
        self:ActivateScorpid()

    elseif command == "viper" then
        self:ActivateViper()

    elseif command == "auto" then
        local newState = not EmzToolsDB.MyHunter.stings.autoStings
        self:SetAutoStings(newState)

    elseif command == "setpve" then
        if param and param ~= "" then
            self:SetPvESting(param)
        end

    elseif command == "setpvp" then
        if param and param ~= "" then
            self:SetPvPSting(param)
        end

    elseif command == "setboss" then
        if param and param ~= "" then
            self:SetBossSting(param)
        end

    else
        self:PrintHelp()
    end
end

-- Affiche l'aide des commandes
function MyHunter_Stings:PrintHelp()
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMANDS_HEADER", "info")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_STATUS", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_LIST", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_CONFIG", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SMART", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SERPENT", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SCORPID", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_VIPER", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_AUTO", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SET_PVE", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SET_PVP", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_STINGS_COMMAND_SET_BOSS", "noPrefix")
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

-- Enregistrement du module avec EmzTools
EmzTools.MyHunter_Stings = MyHunter_Stings

return MyHunter_Stings
