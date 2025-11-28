-- ===================================================
-- MyHunter - MyHunter_Utils.lua
-- Fonctions utilitaires centralisées pour toutes les spécialisations
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- NE LANCE AUCUN SORT - Fournit seulement des informations et vérifications
-- ===================================================

local MyHunter_Utils = {}

MyHunter_Utils.supportedClasses = { "HUNTER" }

-- ===================================================
-- INITIALISATION
-- ===================================================

function MyHunter_Utils:Initialize()
    self:InitializeBlacklist()
    self:InitializeCombatState()

    return true
end

function MyHunter_Utils:InitializeBlacklist()
    self.Blacklist = {
        poisonImmuneTargets = {},
        blacklistDuration = 0  -- 0 = permanente
    }

    -- Charger la blacklist depuis la base de données si elle existe
    if EmzToolsDB and EmzToolsDB.MyHunter and EmzToolsDB.MyHunter.blacklist then
        self.Blacklist.poisonImmuneTargets = EmzToolsDB.MyHunter.blacklist.poisonImmuneTargets or {}
    else
        -- Initialiser la structure dans la base de données
        if not EmzToolsDB then EmzToolsDB = {} end
        if not EmzToolsDB.MyHunter then EmzToolsDB.MyHunter = {} end
        if not EmzToolsDB.MyHunter.blacklist then
            EmzToolsDB.MyHunter.blacklist = {
                poisonImmuneTargets = {}
            }
        end
    end
end

function MyHunter_Utils:InitializeCombatState()
    self.combatState = {
        -- Rapid Fire management
        rapidFireActive = false,
        rapidFireUsed = false,
        combatStartTime = 0,

        -- Combat statistics
        totalDamage = 0,
        lastDamageUpdate = 0,

        -- Timing
        lastShotTimes = {}
    }
end

-- ===================================================
-- VÉRIFICATIONS DE BASE
-- ===================================================

-- Vérifie si le joueur peut lancer un sort
-- @return: true si le joueur peut lancer un sort
function MyHunter_Utils:CanCast()
    return not UnitIsDead("player") and
           not UnitCastingInfo("player") and
           not UnitChannelInfo("player")
end

-- Vérifie si le joueur est en mouvement
-- @return: true si le joueur se déplace
function MyHunter_Utils:IsPlayerMoving()
    return GetUnitSpeed("player") > 0
end

-- Vérifie si le joueur est en combat
-- @return: true si en combat
function MyHunter_Utils:InCombat()
    return UnitAffectingCombat("player")
end

-- Vérifie si une cible existe et est valide
-- @param target: Unité cible (défaut: "target")
-- @return: true si la cible est valide
function MyHunter_Utils:HasTarget(target)
    target = target or "target"
    return UnitExists(target) and not UnitIsDead(target)
end

-- Vérifie si le joueur est prêt pour le combat
-- @return: true si prêt au combat
function MyHunter_Utils:IsReadyForCombat()
    return self:CanCast() and self:HasTarget() and not self:IsPlayerMoving()
end

-- ===================================================
-- VÉRIFICATIONS DE SORTS (INFORMATIONS UNIQUEMENT)
-- ===================================================

-- Vérifie si un sort est disponible
-- @param spellName: Nom du sort
-- @return: true si le sort est disponible
function MyHunter_Utils:HasSpell(spellName)
    if not spellName or type(spellName) ~= "string" then
        return false
    end

    local success, result = pcall(function()
        -- Utiliser MyHunter_SpellBook pour les informations
        if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.HasSpell then
            return EmzTools.MyHunter_SpellBook:HasSpell(spellName)
        end
        -- Fallback basique
        return true
    end)

    return success and result or false
end

-- Vérifie si un sort est prêt (pas en cooldown)
-- @param spellName: Nom du sort
-- @return: true si le sort est prêt
function MyHunter_Utils:IsReady(spellName)
    if not spellName or type(spellName) ~= "string" then
        return false
    end

    local success, result = pcall(function()
        -- Utiliser MyHunter_SpellBook pour les informations
        if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.IsReady then
            return EmzTools.MyHunter_SpellBook:IsReady(spellName)
        end
        -- Fallback basique
        return true
    end)

    return success and result or false
end

-- Récupère le cooldown restant d'un sort
-- @param spellName: Nom du sort
-- @return: Temps restant en secondes
function MyHunter_Utils:GetCooldown(spellName)
    -- Utiliser MyHunter_SpellBook pour les informations
    if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.GetCooldown then
        return EmzTools.MyHunter_SpellBook:GetCooldown(spellName)
    end

    -- Fallback basique
    return 0
end

-- Vérifie si le joueur a assez de mana pour un sort
-- @param spellName: Nom du sort
-- @return: true si assez de mana
function MyHunter_Utils:HasEnoughMana(spellName)
    -- Utiliser MyHunter_SpellBook pour les informations
    if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.HasEnoughMana then
        return EmzTools.MyHunter_SpellBook:HasEnoughMana(spellName)
    end

    -- Fallback basique
    return UnitMana("player") > 0
end

-- Vérifie si la cible est à portée d'un sort
-- @param spellName: Nom du sort
-- @param target: Unité cible (défaut: "target")
-- @return: true si à portée
function MyHunter_Utils:IsInRange(spellName, target)
    target = target or "target"

    -- Utiliser MyHunter_SpellBook pour les informations
    if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.IsInRange then
        return EmzTools.MyHunter_SpellBook:IsInRange(spellName, target)
    end

    -- Fallback basique
    return self:HasTarget(target)
end

-- ===================================================
-- GESTION DE RAPID FIRE INTELLIGENTE
-- ===================================================

-- Récupère le cooldown restant de Rapid Fire
-- @return: Temps restant en secondes
function MyHunter_Utils:GetRapidFireRemainingCooldown()
    -- Vérifier si Rapid Fire est connu
    if not self:HasSpell("Rapid Fire") then
        return 999
    end

    local cooldown = self:GetCooldown("Rapid Fire")
    return cooldown
end

-- Estime le temps avant la phase d'exécution (20% PV)
-- @param target: Unité cible (défaut: "target")
-- @return: Temps estimé en secondes
function MyHunter_Utils:EstimateTimeToExecute(target)
    target = target or "target"

    if not self:HasTarget(target) or UnitHealthMax(target) == 0 then
        return 999
    end

    local currentHealth = UnitHealth(target)
    local maxHealth = UnitHealthMax(target)
    local healthPercent = (currentHealth / maxHealth) * 100

    -- Si déjà en phase d'exécution
    if healthPercent <= 20 then
        return 0
    end

    -- Estimation basique du temps restant
    -- Cette estimation est simplifiée pour WoW 1.12.1
    local healthToLose = currentHealth - (maxHealth * 0.2)

    -- Estimation basée sur le DPS moyen d'un Hunter
    local estimatedDPS = 150  -- DPS moyen approximatif
    local timeToExecute = healthToLose / estimatedDPS

    return math.max(0, timeToExecute)
end

-- Calcule le DPS actuel (estimation basique)
-- @return: DPS estimé
function MyHunter_Utils:GetCurrentDPS()
    if self.combatState.combatStartTime == 0 then
        return 0
    end

    local combatDuration = GetTime() - self.combatState.combatStartTime
    if combatDuration < 3 then  -- Trop tôt pour avoir des données fiables
        return 0
    end

    -- Estimation basée sur les dégâts totaux
    if self.combatState.totalDamage > 0 then
        return self.combatState.totalDamage / combatDuration
    end

    return 0
end

-- Détermine si Rapid Fire doit être utilisé
-- @return: true si Rapid Fire doit être utilisé
function MyHunter_Utils:ShouldUseRapidFire()
    -- Vérifications de base
    if not self:HasSpell("Rapid Fire") then return false end
    if not self:IsReady("Rapid Fire") then return false end
    if self.combatState.rapidFireActive then return false end
    if not self:InCombat() then return false end
    if not UnitExists("target") then return false end

    -- Calculs pour la décision
    local timeToExecute = self:EstimateTimeToExecute("target")
    local cooldownLeft = self:GetRapidFireRemainingCooldown()

    -- Debug info
    if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
        EmzTools:Print(string.format("RapidFire Decision: TimeToExec=%.1fs, Cooldown=%.1fs", timeToExecute, cooldownLeft), "debug")
    end

    -- CRITÈRE PRINCIPAL : Rapid Fire sera-t-il rechargé avant l'exécution ?
    if cooldownLeft <= timeToExecute then
        -- Garanti pour l'exécution - peut utiliser maintenant
        return true
    else
        -- Doit CONSERVER pour l'exécution
        if EmzToolsDB and EmzToolsDB.core and EmzToolsDB.core.debug then
            EmzTools:Print("RAPIDFIRE_SAVING_FOR_EXECUTE", "debug")
        end
        return false
    end
end

-- Appelé quand Rapid Fire est utilisé
function MyHunter_Utils:OnRapidFireUsed()
    self.combatState.rapidFireActive = true
    self.combatState.rapidFireUsed = true

    -- Reset après la durée de l'effet (15 secondes)
    -- Note: En LUA 5.0, on utilise cette syntaxe pour les timers
    local function resetRapidFire()
        MyHunter_Utils.combatState.rapidFireActive = false
    end

    -- Simulation basique de timer (à améliorer si besoin)
    self.rapidFireEndTime = GetTime() + 15
end

-- Vérifie si Rapid Fire est toujours actif
function MyHunter_Utils:CheckRapidFireTimer()
    if self.combatState.rapidFireActive and self.rapidFireEndTime then
        if GetTime() >= self.rapidFireEndTime then
            self.combatState.rapidFireActive = false
            self.rapidFireEndTime = nil
        end
    end
end

-- ===================================================
-- DÉTECTION DE BUFFS/DEBUFFS
-- ===================================================

-- Vérifie si la cible a un debuff spécifique
-- @param target: Unité cible
-- @param debuffName: Nom du debuff
-- @return: true si le debuff est présent
function MyHunter_Utils:TargetHasDebuff(target, debuffName)
    if not UnitExists(target) then return false end

    for i=1,16 do
        local name, _, texture = UnitDebuff(target, i)
        if name then
            if string.find(name, debuffName) or (texture and string.find(texture, debuffName)) then
                return true
            end
        else
            break
        end
    end
    return false
end

-- Vérifie si la cible a un buff spécifique
-- @param target: Unité cible
-- @param buffName: Nom du buff
-- @return: true si le buff est présent
function MyHunter_Utils:TargetHasBuff(target, buffName)
    if not UnitExists(target) then return false end

    for i=1,16 do
        local name, _, texture = UnitBuff(target, i)
        if name then
            if string.find(name, buffName) or (texture and string.find(texture, buffName)) then
                return true
            end
        else
            break
        end
    end
    return false
end

-- Fonctions spécifiques pour les debuffs communs
function MyHunter_Utils:TargetHasHunterMark(target)
    return self:TargetHasDebuff(target, "Hunter's Mark") or
           self:TargetHasDebuff(target, "Ability_Hunter_SniperShot")
end

function MyHunter_Utils:TargetHasSerpentSting(target)
    return self:TargetHasDebuff(target, "Serpent Sting") or
           self:TargetHasDebuff(target, "Ability_Hunter_Quickshot")
end

-- Vérifie le débuff de Serpent Sting sur la cible
function MyHunter_Utils:GetSerpentStingTimeLeft(target)
    target = target or "target"

    if not UnitExists(target) then
        return 0
    end

    if self:TargetHasSerpentSting(target) then
        return 5
    end

    return 0
end

-- Vérifie si la cible a des buffs magiques
-- @param target: Unité cible
-- @return: true si des buffs magiques sont présents
function MyHunter_Utils:TargetHasMagicBuff(target)
    for i=1,16 do
        local buffTexture = UnitBuff(target, i)
        if buffTexture then
            local magicTextures = {
                "Ability_Mage_",
                "Spell_Holy_",
                "Spell_Nature_",
                "Spell_Shadow_",
                "Spell_Frost_",
                "Spell_Fire_",
                "Spell_Arcane_"
            }
            for _, magicPattern in ipairs(magicTextures) do
                if string.find(buffTexture, magicPattern) then
                    return true
                end
            end
        else
            break
        end
    end
    return false
end

-- ===================================================
-- GESTION DU TEMPS ET COOLDOWNS
-- ===================================================

-- Vérifie si un sort peut être lancé (respect des délais)
-- @param lastShotTimes: Table des derniers temps de tir
-- @param minDelay: Délai minimum entre les sorts
-- @return: true si le sort peut être lancé
function MyHunter_Utils:CanCastShot(lastShotTimes, minDelay)
    local currentTime = GetTime()
    local timeSinceLastShot = currentTime

    if lastShotTimes then
        for _, shotTime in pairs(lastShotTimes) do
            if shotTime and shotTime > 0 then
                timeSinceLastShot = math.min(timeSinceLastShot, currentTime - shotTime)
            end
        end
    end

    return timeSinceLastShot >= (minDelay or 1.5)
end

-- Vérifie si un sort est en cooldown
-- @param lastCastTime: Temps du dernier lancement
-- @param cooldown: Cooldown du sort
-- @return: true si le sort est en cooldown
function MyHunter_Utils:IsSpellOnCooldown(lastCastTime, cooldown)
    if not lastCastTime or lastCastTime == 0 then return false end
    local currentTime = GetTime()
    return (currentTime - lastCastTime) < cooldown
end

-- Met à jour les timings des sorts
-- @param combatState: État de combat
-- @param spellName: Nom du sort
function MyHunter_Utils:UpdateShotTiming(combatState, spellName)
    local currentTime = GetTime()

    if not combatState.lastShotTimes then
        combatState.lastShotTimes = {}
    end

    combatState.lastShotTimes[spellName] = currentTime

    -- Mise à jour des timings spécifiques pour compatibilité
    if spellName == "Aimed Shot" then
        combatState.lastAimedShotTime = currentTime
    elseif spellName == "Kill Command" then
        combatState.lastKillCommandTime = currentTime
    elseif spellName == "Baited Shot" then
        combatState.lastBaitedShotTime = currentTime
    elseif spellName == "Steady Shot" then
        combatState.lastSteadyShotTime = currentTime
    elseif spellName == "Raptor Strike" then
        combatState.lastRaptorStrikeTime = currentTime
    elseif spellName == "Mongoose Bite" then
        combatState.lastMongooseBiteTime = currentTime
    end
end

-- ===================================================
-- SYSTÈME DE BLACKLIST PERMANENT
-- ===================================================

-- Vérifie si une cible est blacklistée pour le poison
-- @param target: Unité cible
-- @return: true si blacklistée
function MyHunter_Utils:IsTargetBlacklistedForPoison(target)
    if not self:HasTarget(target) then return false end

    local targetName = UnitName(target)
    if not targetName then return false end

    -- Vérifier dans la blacklist permanente
    local blacklistEntry = self.Blacklist.poisonImmuneTargets[targetName]
    if blacklistEntry then
        return true
    end

    -- Vérifier également dans la base de données (pour la persistance entre sessions)
    if EmzToolsDB and EmzToolsDB.MyHunter and EmzToolsDB.MyHunter.blacklist then
        local dbBlacklistEntry = EmzToolsDB.MyHunter.blacklist.poisonImmuneTargets[targetName]
        if dbBlacklistEntry then
            -- Synchroniser avec la blacklist en mémoire
            self.Blacklist.poisonImmuneTargets[targetName] = dbBlacklistEntry
            return true
        end
    end

    return false
end

-- Ajoute une cible à la blacklist poison PERMANENTE
-- @param target: Unité cible
function MyHunter_Utils:AddToPoisonBlacklist(target)
    if not self:HasTarget(target) then return end

    local targetName = UnitName(target)
    if not targetName then return end

    local entry = {
        name = targetName,
        timestamp = GetTime(),
        reason = "poison_immune"
    }

    -- Ajouter à la blacklist en mémoire
    self.Blacklist.poisonImmuneTargets[targetName] = entry

    -- Sauvegarder dans la base de données pour la persistance
    if not EmzToolsDB then EmzToolsDB = {} end
    if not EmzToolsDB.MyHunter then EmzToolsDB.MyHunter = {} end
    if not EmzToolsDB.MyHunter.blacklist then
        EmzToolsDB.MyHunter.blacklist = {
            poisonImmuneTargets = {}
        }
    end

    EmzToolsDB.MyHunter.blacklist.poisonImmuneTargets[targetName] = entry

    if EmzTools and EmzTools.Print then
        EmzTools:Print("EMZTOOLS_MYHUNTER_TARGET_BLACKLISTED", "warning", targetName)
    end
end

-- Supprime une cible de la blacklist
-- @param targetName: Nom de la cible
function MyHunter_Utils:RemoveFromPoisonBlacklist(targetName)
    if not targetName then return end

    -- Supprimer de la blacklist en mémoire
    self.Blacklist.poisonImmuneTargets[targetName] = nil

    -- Supprimer de la base de données
    if EmzToolsDB and EmzToolsDB.MyHunter and EmzToolsDB.MyHunter.blacklist then
        EmzToolsDB.MyHunter.blacklist.poisonImmuneTargets[targetName] = nil
    end

    if EmzTools and EmzTools.Print then
        EmzTools:Print("EMZTOOLS_MYHUNTER_TARGET_REMOVED_FROM_BLACKLIST", "success", targetName)
    end
end

-- Vide la blacklist
function MyHunter_Utils:ClearBlacklist()
    self.Blacklist.poisonImmuneTargets = {}

    -- Vider également la base de données
    if EmzToolsDB and EmzToolsDB.MyHunter and EmzToolsDB.MyHunter.blacklist then
        EmzToolsDB.MyHunter.blacklist.poisonImmuneTargets = {}
    end

    if EmzTools and EmzTools.Print then
        EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_CLEARED", "success")
    end
end

-- Vérifie si une cible est immunisée au poison
-- @param target: Unité cible
-- @return: true si immunisée
function MyHunter_Utils:TargetImmuneToPoison(target)
    local creatureFamily = UnitCreatureFamily(target)

    local immuneFamilies = {
        ["Elemental"] = true,
        ["Undead"] = true,
        ["Demon"] = true,
        ["Mechanical"] = true,
    }

    if creatureFamily and immuneFamilies[creatureFamily] then
        return true
    end

    local targetName = UnitName(target)
    local immuneMobs = {
        ["Viscidus"] = true,
        ["Ouro"] = true,
    }

    if targetName and immuneMobs[targetName] then
        return true
    end

    return false
end

-- Vérifie et gère l'immunité au poison
-- @param target: Unité cible
-- @return: true si immunisée et blacklistée
function MyHunter_Utils:CheckAndHandlePoisonImmunity(target)
    if not self:TargetImmuneToPoison(target) then
        return false
    end

    self:AddToPoisonBlacklist(target)
    return true
end

-- ===================================================
-- GESTION DU FAMILIER (via MyHunter_Pet)
-- ===================================================

-- Vérifie si le joueur a un familier
-- @return: true si un familier est présent
function MyHunter_Utils:HasPet()
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:HasPet()
end

-- Vérifie si le familier est mort
-- @return: true si le familier est mort
function MyHunter_Utils:IsPetDead()
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:IsPetDead()
end

-- Récupère le nom du familier
-- @return: Nom du familier
function MyHunter_Utils:GetPetName()
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:GetPetName()
end

-- Récupère le pourcentage de santé du familier
-- @return: Pourcentage de santé
function MyHunter_Utils:GetPetHPPercent()
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:GetPetHPPercent() or 0
end

-- Vérifie si le familier est en combat
-- @return: true si en combat
function MyHunter_Utils:IsPetInCombat()
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:IsPetInCombat()
end

-- Vérifie si le familier a besoin de soins
-- @param threshold: Seuil de soins (défaut: 40%)
-- @return: true si besoin de soins
function MyHunter_Utils:PetNeedsHealing(threshold)
    return EmzTools.MyHunter_Pet and EmzTools.MyHunter_Pet:NeedsHealing(threshold)
end

-- Gère le familier (soins, nourriture, etc.)
function MyHunter_Utils:ManagePet()
    if not EmzTools.MyHunter_Pet then return end

    -- Vérifier Rapid Fire timer
    self:CheckRapidFireTimer()

    -- Soins du familier
    if self:PetNeedsHealing(40) then
        if EmzTools and EmzTools.Print then
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NEEDS_HEALING", "info", string.format("%.0f%%", self:GetPetHPPercent()))
        end
    end

    -- Le lancement effectif des sorts est géré par les spécialisations
end

-- ===================================================
-- SPÉCIALISATIONS
-- ===================================================

-- Récupère la spécialisation actuelle
-- @return: Nom de la spécialisation
function MyHunter_Utils:GetCurrentSpec()
    -- Lecture directe depuis la base de données
    if not EmzToolsDB or not EmzToolsDB.MyHunter then
        return "BeastMastery" -- Valeur par défaut
    end

    return EmzToolsDB.MyHunter.selectedSpec or "BeastMastery"
end

-- Vérifie si le joueur a Rapid Strikes (Survival)
-- @return: true si Rapid Strikes est disponible
function MyHunter_Utils:HasRapidStrikes()
    return self:GetCurrentSpec() == "Survival" and self:HasSpell("Rapid Strikes")
end

-- ===================================================
-- UTILITAIRES D'AFFICHAGE ET STATISTIQUES
-- ===================================================

-- Récupère le statut d'un sort pour l'affichage
-- @param spellName: Nom du sort
-- @return: Chaîne de statut formatée
function MyHunter_Utils:GetSpellStatus(spellName)
    -- Utiliser MyHunter_SpellBook pour les informations
    if EmzTools and EmzTools.MyHunter_SpellBook and EmzTools.MyHunter_SpellBook.GetSpellStatus then
        return EmzTools.MyHunter_SpellBook:GetSpellStatus(spellName)
    end

    -- Fallback basique
    if not self:HasSpell(spellName) then
        return "|cFF888888" .. "EMZTOOLS_STATE_NOT_LEARNED" .. "|r"
    end

    if self:IsReady(spellName) then
        return "|cFF00FF00" .. "EMZTOOLS_STATE_READY" .. "|r"
    else
        local cooldown = self:GetCooldown(spellName)
        if cooldown > 0 then
            return "|cFFFF0000" .. string.format("%.1fs", cooldown) .. "|r"
        else
            return "|cFFFFFF00" .. "EMZTOOLS_STATE_NOT_READY" .. "|r"
        end
    end
end

-- Affiche la blacklist
function MyHunter_Utils:PrintBlacklist()
    if not EmzTools or not EmzTools.Print then return end

    local count = 0
    for name, entry in pairs(self.Blacklist.poisonImmuneTargets) do
        count = count + 1
        local timeAdded = entry.timestamp
        local daysAgo = math.floor((GetTime() - timeAdded) / 86400) -- 86400 secondes dans une journée

        if daysAgo == 0 then
            EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_ENTRY_TODAY", "noPrefix", name)
        elseif daysAgo == 1 then
            EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_ENTRY_YESTERDAY", "noPrefix", name)
        else
            EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_ENTRY_DAYS", "noPrefix", name, daysAgo)
        end
    end

    if count == 0 then
        EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_EMPTY", "noPrefix")
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_BLACKLIST_COUNT", "noPrefix", count)
    end
end

-- ===================================================
-- COMMANDES SLASH POUR LA BLACKLIST
-- ===================================================

function MyHunter_Utils:SlashCommandHandler(msg)
    local command, param = msg:match("^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "blacklist" then
        self:PrintBlacklist()
    elseif command == "clearblacklist" then
        self:ClearBlacklist()
    elseif command == "removefromblacklist" then
        if param and param ~= "" then
            self:RemoveFromPoisonBlacklist(param)
        else
            EmzTools:Print("Usage: /emz myhunter removefromblacklist <targetname>", "error")
        end
    elseif command == "addtoblacklist" then
        if self:HasTarget() then
            local targetName = UnitName("target")
            self:AddToPoisonBlacklist("target")
        else
            EmzTools:Print("EMZTOOLS_MYHUNTER_NO_TARGET", "warning")
        end
    end
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

if EmzTools then
    EmzTools.MyHunter_Utils = MyHunter_Utils
end

return MyHunter_Utils
