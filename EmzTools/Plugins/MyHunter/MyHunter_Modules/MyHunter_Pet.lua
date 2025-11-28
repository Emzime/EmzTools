-- ===================================================
-- MyHunter - MyHunter_Pet.lua
-- Module utilitaire central pour la gestion du familier
-- COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ===================================================

local MyHunter_Pet = {}

MyHunter_Pet.supportedClasses = { "HUNTER" }

-- ===================================================
-- SYSTÈME DE PRÉFÉRENCES ALIMENTAIRES PAR FAMILIER
-- ===================================================

MyHunter_Pet.petFoodPreferences = {
    -- CHATS (Cats)
    ["Cat"] = {
        "Fish", "Meat", "Raw", "Smoked", "Roasted", "Haunch", "Jerky", "Sagefish", "Mackerel", "Salmon", "Trout"
    },

    -- LOUPS (Wolves)
    ["Wolf"] = {
        "Meat", "Haunch", "Jerky", "Chop", "Steak", "Shank", "Roasted", "Mutton", "Boar", "Wolf"
    },

    -- RAPACES (Birds of Prey)
    ["Bird of Prey"] = {
        "Meat", "Fish", "Raw", "Jerky", "Chop", "Bat", "Owl", "Hawk"
    },

    -- OURS (Bears)
    ["Bear"] = {
        "Fish", "Meat", "Fruit", "Bread", "Muffin", "Jerky", "Haunch", "Berry", "Honey", "Clam"
    },

    -- SERPENTS (Snakes)
    ["Serpent"] = {
        "Fish", "Raw", "Meat", "Egg", "Spider", "Snake"
    },

    -- CHOUETTES (Owls)
    ["Owl"] = {
        "Fish", "Meat", "Raw", "Rodent", "Mouse", "Rat"
    },

    -- RAVAGEURS (Ravagers)
    ["Ravager"] = {
        "Meat", "Fish", "Raw", "Fungus", "Spore", "Maggot"
    },

    -- PORCS-ÉPIQUES (Boars)
    ["Boar"] = {
        "Fruit", "Fungus", "Bread", "Muffin", "Cheese", "Mushroom", "Truffle"
    },

    -- CRABES (Crabs)
    ["Crab"] = {
        "Fish", "Clam", "Oyster", "Crawler", "Crab", "Shrimp", "Lobster"
    },

    -- GORILLES (Gorillas)
    ["Gorilla"] = {
        "Fruit", "Bread", "Fungus", "Nut", "Banana", "Coconut", "Melon"
    },

    -- RAPTOR (Raptors)
    ["Raptor"] = {
        "Meat", "Raw", "Fish", "Raptor", "Egg"
    },

    -- SCORPIDE (Scorpid)
    ["Scorpid"] = {
        "Meat", "Insect", "Maggot", "Beetle", "Scorpid"
    },

    -- TORTUE (Turtle)
    ["Turtle"] = {
        "Fish", "Bread", "Fruit", "Seaweed", "Turtle"
    },

    -- FALLBACK pour familles inconnues
    ["Default"] = {
        "Bread", "Muffin", "Jerky", "Fish", "Meat", "Fruit", "Conjured"
    }
}

-- Cache des types de nourriture compatibles
MyHunter_Pet.foodTypes = {
    "Conjured Muffin", "Conjured Bread", "Conjured Rye",
    "Tough Jerky", "Haunch of Meat", "Mutton Chop",
    "Wild Hog Shank", "Cured Ham Steak", "Roasted Quail",
    "Smoked Sagefish", "Raw Sagefish", "Brilliant Smallfish",
    "Slitherskin Mackerel", "Longjaw Mud Snapper",
    "Bristle Whisker Catfish", "Rockscale Cod", "Spotted Yellowtail",
    "Rainbow Fin Albacore", "Sunscale Salmon", "Spinefin Halibut"
}

-- ===================================================
-- INITIALISATION
-- ===================================================

function MyHunter_Pet:Initialize()
    -- Charger la localisation
    EmzTools:LoadPluginLocalization("MyHunter")

    -- Initialiser la configuration par défaut
    self:InitializeDefaults()

    -- Initialiser le cache de nourriture
    self:InitializeFoodCache()

    return true
end

function MyHunter_Pet:InitializeDefaults()
    if not EmzToolsDB then return end

    if not EmzToolsDB.MyHunter then
        EmzToolsDB.MyHunter = {}
    end

    if EmzToolsDB.MyHunter.pet == nil then
        EmzToolsDB.MyHunter.pet = {
            autoPetManagement = true,
            petHealThreshold = 50,
            petFeedingEnabled = true,
            autoRevivePet = true,
            autoCallPet = true,
            enableCombatHealing = true,
            happinessThreshold = 2,
            preferredFoodTypes = {}
        }
    end
end

function MyHunter_Pet:InitializeFoodCache()
    self.foodCache = {
        availableFood = {},
        lastScanTime = 0,
        scanCooldown = 30 -- Rescan toutes les 30 secondes
    }
end

-- ===================================================
-- VÉRIFICATIONS DE BASE
-- ===================================================

-- Vérifie si le joueur a un familier actif
-- @return: true si le familier existe et n'est pas mort
function MyHunter_Pet:HasPet()
    return UnitExists("pet") and not UnitIsDead("pet")
end

-- Vérifie si le familier est mort
-- @return: true si le familier existe mais est mort
function MyHunter_Pet:IsPetDead()
    return UnitExists("pet") and UnitIsDead("pet")
end

-- Vérifie si le familier a besoin de soins
-- @param threshold: Seuil de santé (défaut: configuration)
-- @return: true si besoin de soins
function MyHunter_Pet:NeedsHealing(threshold)
    if not self:HasPet() then
        return false
    end

    local petHP = self:GetPetHPPercent()
    local healThreshold = threshold or EmzToolsDB.MyHunter.pet.petHealThreshold

    return petHP < healThreshold
end

-- Vérifie si le familier est en combat
-- @return: true si le familier combat
function MyHunter_Pet:IsPetInCombat()
    return UnitAffectingCombat("pet")
end

-- ===================================================
-- UTILITAIRES D'INFORMATION
-- ===================================================

-- Récupère le pourcentage de santé du familier
-- @return: Pourcentage de santé (0-100)
function MyHunter_Pet:GetPetHPPercent()
    if not self:HasPet() then return 0 end
    local currentHP = UnitHealth("pet")
    local maxHP = UnitHealthMax("pet")
    if maxHP == 0 then return 0 end
    return (currentHP / maxHP) * 100
end

-- Récupère le pourcentage de mana du familier
-- @return: Pourcentage de mana (0-100)
function MyHunter_Pet:GetPetManaPercent()
    if not self:HasPet() then return 0 end
    local maxMana = UnitManaMax("pet")
    if maxMana == 0 then return 0 end
    return (UnitMana("pet") / maxMana) * 100
end

-- Récupère le niveau de bonheur du familier
-- @return: Niveau (1-3) et texte correspondant
function MyHunter_Pet:GetHappiness()
    local happiness = GetPetHappiness()
    local happinessText = {
        "EMZTOOLS_MYHUNTER_PET_UNHAPPY",
        "EMZTOOLS_MYHUNTER_PET_CONTENT",
        "EMZTOOLS_MYHUNTER_PET_HAPPY"
    }
    return happiness, happinessText[happiness] or "EMZTOOLS_STATE_UNKNOW"
end

-- Récupère le niveau du familier
-- @return: Niveau du familier
function MyHunter_Pet:GetPetLevel()
    if not self:HasPet() then return 0 end
    return UnitLevel("pet")
end

-- Récupère le nom du familier
-- @return: Nom du familier ou nil
function MyHunter_Pet:GetPetName()
    if not self:HasPet() then return nil end
    return UnitName("pet")
end

-- Récupère la famille du familier
-- @return: Famille (ex: "Wolf", "Cat") ou nil
function MyHunter_Pet:GetPetFamily()
    if not self:HasPet() then return nil end
    return UnitCreatureFamily("pet")
end

-- ===================================================
-- VÉRIFICATIONS DE BUFFS/DEBUFFS
-- ===================================================

-- Vérifie si Mend Pet est actif sur le familier
-- @return: true si Mend Pet est actif
function MyHunter_Pet:IsMendPetActive()
    if not self:HasPet() then return false end

    for i=1,16 do
        local buffName = UnitBuff("pet", i)
        if buffName and string.find(buffName, "Mend Pet") then
            return true
        end
    end
    return false
end

-- Vérifie si le familier a un buff spécifique
-- @param buffName: Nom du buff (partiel accepté)
-- @return: true si le buff est présent
function MyHunter_Pet:HasBuff(buffName)
    if not self:HasPet() then return false end

    for i=1,16 do
        local name = UnitBuff("pet", i)
        if name and string.find(name, buffName) then
            return true
        end
    end
    return false
end

-- Vérifie si le familier a un debuff spécifique
-- @param debuffName: Nom du debuff (partiel accepté)
-- @return: true si le debuff est présent
function MyHunter_Pet:HasDebuff(debuffName)
    if not self:HasPet() then return false end

    for i=1,16 do
        local name = UnitDebuff("pet", i)
        if name and string.find(name, debuffName) then
            return true
        end
    end
    return false
end

-- ===================================================
-- SYSTÈME DE NOURRITURE AMÉLIORÉ
-- ===================================================

-- Scanne les sacs pour trouver de la nourriture
function MyHunter_Pet:ScanForFood()
    local currentTime = GetTime()

    -- Vérifier le cooldown du scan
    if currentTime - self.foodCache.lastScanTime < self.foodCache.scanCooldown then
        return self.foodCache.availableFood
    end

    self.foodCache.availableFood = {}
    self.foodCache.lastScanTime = currentTime

    -- Scanner tous les sacs
    for bag = 0, 4 do
        local numSlots = GetContainerNumSlots(bag)
        for slot = 1, numSlots do
            local itemTexture, itemCount, locked, quality, readable, lootable, itemLink = GetContainerItemInfo(bag, slot)

            if itemLink then
                local itemName = GetItemInfo(itemLink)

                -- Vérifier si c'est de la nourriture
                if itemName and self:IsPetFood(itemName) then
                    table.insert(self.foodCache.availableFood, {
                        name = itemName,
                        count = itemCount,
                        bag = bag,
                        slot = slot,
                        link = itemLink
                    })
                end
            end
        end
    end

    return self.foodCache.availableFood
end

-- Vérifie si un item est de la nourriture pour familier
function MyHunter_Pet:IsPetFood(itemName)
    if not itemName then return false end

    -- Vérifier contre la liste des types de nourriture connus
    for _, foodType in ipairs(self.foodTypes) do
        if string.find(itemName, foodType) then
            return true
        end
    end

    return true -- Fallback basique
end

-- Vérifie si une nourriture est adaptée au familier
function MyHunter_Pet:IsFoodSuitableForPet(foodName, petFamily)
    if not foodName or not petFamily then
        return false
    end

    -- Obtenir les préférences de la famille
    local preferences = self.petFoodPreferences[petFamily] or self.petFoodPreferences["Default"]

    -- Vérifier chaque mot-clé
    for _, preference in ipairs(preferences) do
        if string.find(string.lower(foodName), string.lower(preference)) then
            return true
        end
    end

    return false
end

-- Trouve la MEILLEURE nourriture pour le familier actuel
function MyHunter_Pet:FindBestFoodForCurrentPet()
    local availableFood = self:ScanForFood()
    if #availableFood == 0 then
        return nil
    end

    local petFamily = self:GetPetFamily()
    local suitableFood = {}

    -- Filtrer seulement la nourriture adaptée
    for _, food in ipairs(availableFood) do
        if self:IsFoodSuitableForPet(food.name, petFamily) then
            table.insert(suitableFood, food)
        end
    end

    if #suitableFood == 0 then
        return nil
    end

    -- 🔥 MODIFICATION : Prioriser la PLUS PETITE quantité
    -- Pour libérer de l'espace dans les sacs
    table.sort(suitableFood, function(a, b)
        return a.count < b.count  -- ← PLUS PETITE quantité en premier
    end)

    return suitableFood[1]
end

-- Trouve la meilleure nourriture disponible (fallback)
function MyHunter_Pet:FindBestFood()
    local availableFood = self:ScanForFood()

    if #availableFood == 0 then
        return nil
    end

    -- 🔥 MODIFICATION : Plus petite quantité d'abord
    table.sort(availableFood, function(a, b)
        return a.count < b.count  -- ← PLUS PETITE quantité en premier
    end)

    return availableFood[1]
end

-- Vérifie si le familier a besoin d'être nourri
function MyHunter_Pet:NeedsFeeding()
    if not self:HasPet() then
        return false
    end

    local happiness, happinessLevel = self:GetHappiness()

    -- Nourrir seulement si le bonheur est en dessous du seuil
    local threshold = EmzToolsDB.MyHunter.pet.happinessThreshold or 2
    return happinessLevel < threshold
end

-- ===================================================
-- ACTIONS DE BASE
-- ===================================================

-- Soigner le familier (action basique)
-- @return: succès, message
function MyHunter_Pet:HealPet()
    if not self:HasPet() then
        return false, "EMZTOOLS_MYHUNTER_PET_NO_PET"
    end

    if self:IsMendPetActive() then
        return false, "EMZTOOLS_MYHUNTER_PET_MEND_ACTIVE"
    end

    -- Lancer le sort directement
    CastSpellByName("Mend Pet")

    -- Vérifier si le sort a été lancé
    if SpellIsTargeting() then
        SpellTargetUnit("pet")
        return true, "EMZTOOLS_MYHUNTER_PET_HEALING"
    else
        return false, "EMZTOOLS_MYHUNTER_PET_HEAL_FAILED"
    end
end

-- Nourrir le familier (action basique)
-- @return: succès, message
function MyHunter_Pet:FeedPet()
    if not self:HasPet() then
        return false, "EMZTOOLS_MYHUNTER_PET_NO_PET"
    end

    local happiness, _ = self:GetHappiness()
    if happiness and happiness >= 3 then
        return false, "EMZTOOLS_MYHUNTER_PET_ALREADY_HAPPY"
    end

    -- 🔥 MODIFICATION : UNIQUEMENT la nourriture ADAPTÉE
    local bestFood = self:FindBestFoodForCurrentPet()
    if not bestFood then
        -- ❌ PLUS de fallback - on refuse de nourrir avec de la mauvaise nourriture
        return false, "EMZTOOLS_MYHUNTER_PET_NO_SUITABLE_FOOD"
    end

    -- Lancer le sort Feed Pet
    CastSpellByName("Feed Pet")

    local waitTime = 0
    local maxWaitTime = 2.0

    local function WaitForSpellTarget()
        if SpellIsTargeting() then
            UseContainerItem(bestFood.bag, bestFood.slot)
            return true, "EMZTOOLS_MYHUNTER_PET_FEEDING"
        else
            waitTime = waitTime + 0.1
            if waitTime < maxWaitTime then
                MyHunter_Pet.feedWaitFrame = MyHunter_Pet.feedWaitFrame or CreateFrame("Frame")
                MyHunter_Pet.feedWaitFrame:SetScript("OnUpdate", function()
                    this:SetScript("OnUpdate", nil)
                    WaitForSpellTarget()
                end)
            else
                SpellStopTargeting()
                return false, "EMZTOOLS_MYHUNTER_PET_FEED_TIMEOUT"
            end
        end
    end

    return WaitForSpellTarget()
end

-- Invoquer le familier (action basique)
-- @return: succès, message
function MyHunter_Pet:CallPet()
    if self:HasPet() then
        return false, "EMZTOOLS_MYHUNTER_PET_ALREADY_ACTIVE"
    end

    if self:IsPetDead() then
        return false, "EMZTOOLS_MYHUNTER_PET_DEAD_REVIVE_FIRST"
    end

    -- Lancer le sort directement
    CastSpellByName("Call Pet")
    return true, "EMZTOOLS_MYHUNTER_PET_CALLING"
end

-- Renvoyer le familier (action basique)
-- @return: succès, message
function MyHunter_Pet:DismissPet()
    if not self:HasPet() then
        return false, "EMZTOOLS_MYHUNTER_PET_NO_PET"
    end

    -- Lancer le sort directement
    CastSpellByName("Dismiss Pet")
    return true, "EMZTOOLS_MYHUNTER_PET_DISMISSING"
end

-- Ressusciter le familier (action basique)
-- @return: succès, message
function MyHunter_Pet:RevivePet()
    if self:HasPet() then
        return false, "EMZTOOLS_MYHUNTER_PET_ALIVE"
    end

    if not self:IsPetDead() then
        return false, "EMZTOOLS_MYHUNTER_PET_NO_REVIVE"
    end

    -- Lancer le sort directement
    CastSpellByName("Revive Pet")
    return true, "EMZTOOLS_MYHUNTER_PET_REVIVING"
end

-- ===================================================
-- GESTION AUTOMATIQUE
-- ===================================================

-- Nourrit le familier automatiquement si nécessaire
function MyHunter_Pet:AutoFeedPet()
    if not EmzToolsDB.MyHunter.pet.petFeedingEnabled then
        return false
    end

    if not self:HasPet() then
        return false
    end

    if UnitAffectingCombat("player") then
        return false -- Ne pas nourrir en combat
    end

    if self:NeedsFeeding() then
        local success, message = self:FeedPet()
        if success then
            return true
        else
            return false
        end
    end

    return false
end

-- Gère le familier automatiquement
function MyHunter_Pet:AutoManagePet()
    if not EmzToolsDB.MyHunter.pet.autoPetManagement then
        return
    end

    -- Soins automatiques
    if self:NeedsHealing(EmzToolsDB.MyHunter.pet.petHealThreshold) then
        self:HealPet()
    end

    -- Nourrissage automatique
    if not UnitAffectingCombat("player") then
        self:AutoFeedPet()
    end

    -- Rappel automatique du familier
    if EmzToolsDB.MyHunter.pet.autoCallPet and not self:HasPet() and not self:IsPetDead() then
        self:CallPet()
    end

    -- Résurrection automatique
    if EmzToolsDB.MyHunter.pet.autoRevivePet and self:IsPetDead() then
        self:RevivePet()
    end
end

-- ===================================================
-- UTILITAIRES AMÉLIORÉS
-- ===================================================

-- Récupère des informations détaillées sur le bonheur
function MyHunter_Pet:GetHappinessDetails()
    local happiness, happinessText = self:GetHappiness()
    local damagePercent = 0

    if happiness == 1 then -- Unhappy
        damagePercent = 50
    elseif happiness == 2 then -- Content
        damagePercent = 75
    elseif happiness == 3 then -- Happy
        damagePercent = 125
    end

    return happiness, happinessText, damagePercent
end

-- Vérifie si le familier a de la nourriture dans son inventaire
function MyHunter_Pet:HasFoodInBags()
    local availableFood = self:ScanForFood()
    return #availableFood > 0
end

-- Affiche les informations de nourriture disponible
function MyHunter_Pet:PrintFoodInfo()
    local availableFood = self:ScanForFood()
    local petFamily = self:GetPetFamily()

    if #availableFood == 0 then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_FOOD_AVAILABLE", "warning")
        return
    end

    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_FOOD_AVAILABLE_HEADER", "info")

    local suitableCount = 0
    for i, food in ipairs(availableFood) do
        if i <= 8 then -- Limiter l'affichage
            local isSuitable = self:IsFoodSuitableForPet(food.name, petFamily)
            local suitability = isSuitable and "|cFF00FF00✓|r" or "|cFFFF0000✗|r"

            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_FOOD_ITEM_SUITABLE", "noPrefix",
                          food.name, tostring(food.count), suitability)

            if isSuitable then
                suitableCount = suitableCount + 1
            end
        end
    end

    -- Résumé des nourritures adaptées
    if suitableCount == 0 then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_SUITABLE_FOOD", "warning", petFamily or "EMZTOOLS_STATE_UNKNOW")
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_SUITABLE_FOOD_COUNT", "info",
                      tostring(suitableCount), petFamily or "EMZTOOLS_STATE_UNKNOW")
    end
end

-- Vérifie la compatibilité nourriture/familier
function MyHunter_Pet:CheckFoodCompatibility()
    if not self:HasPet() then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_PET", "warning")
        return
    end

    local petFamily = self:GetPetFamily()
    local availableFood = self:ScanForFood()
    local suitableFood = {}

    for _, food in ipairs(availableFood) do
        if self:IsFoodSuitableForPet(food.name, petFamily) then
            table.insert(suitableFood, food)
        end
    end

    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_FOOD_COMPATIBILITY_HEADER", "info", petFamily)

    if #suitableFood > 0 then
        for _, food in ipairs(suitableFood) do
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMPATIBLE_FOOD", "noPrefix", food.name, tostring(food.count))
        end
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_COMPATIBLE_FOOD", "warning")

        -- Suggérer des types de nourriture
        local preferences = self.petFoodPreferences[petFamily] or self.petFoodPreferences["Default"]
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_SUGGESTED_FOOD_TYPES", "noPrefix", table.concat(preferences, ", "))
    end
end

-- Affiche les préférences alimentaires du familier actuel
function MyHunter_Pet:PrintFoodPreferences()
    if not self:HasPet() then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_PET", "warning")
        return
    end

    local petFamily = self:GetPetFamily()
    local preferences = self.petFoodPreferences[petFamily] or self.petFoodPreferences["Default"]

    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_FOOD_PREFERENCES_HEADER", "info", petFamily)

    for i, preference in ipairs(preferences) do
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_FOOD_PREFERENCE", "noPrefix", i, preference)
    end
end

-- ===================================================
-- CONFIGURATION
-- ===================================================

-- Définit le seuil de soins automatiques
-- @param threshold: Seuil de santé (0-100)
-- @return: succès, message, valeur
function MyHunter_Pet:SetHealThreshold(threshold)
    if type(threshold) == "number" and threshold >= 0 and threshold <= 100 then
        EmzToolsDB.MyHunter.pet.petHealThreshold = threshold
        return true, "EMZTOOLS_MYHUNTER_PET_HEAL_THRESHOLD_SET", tostring(threshold)
    else
        return false, "EMZTOOLS_MYHUNTER_PET_INVALID_THRESHOLD"
    end
end

-- Récupère le seuil de soins automatiques
-- @return: Seuil de santé
function MyHunter_Pet:GetHealThreshold()
    return EmzToolsDB.MyHunter.pet.petHealThreshold
end

-- ===================================================
-- AFFICHAGE DES INFORMATIONS
-- ===================================================

-- Affiche les informations du familier
function MyHunter_Pet:PrintInfo()
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_HEADER", "info")

    if not self:HasPet() then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_NO_PET_SUMMONED", "noPrefix")
        return
    end

    local petName = self:GetPetName()
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_NAME", "noPrefix", petName)

    if self:IsPetDead() then
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_STATUS", "noPrefix", "EMZTOOLS_MYHUNTER_PET_STATUS_DEAD")
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_STATUS", "noPrefix", "EMZTOOLS_MYHUNTER_PET_STATUS_ALIVE")

        local petHP = self:GetPetHPPercent()
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_HP", "noPrefix", string.format("%.0f%%", petHP))

        local happiness, happinessText = self:GetHappiness()
        if happiness then
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_HAPPINESS", "noPrefix", EmzTools:GetText(happinessText))
        end

        local petLevel = self:GetPetLevel()
        EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_LEVEL", "noPrefix", tostring(petLevel))

        local petFamily = self:GetPetFamily()
        if petFamily then
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_INFO_FAMILY", "noPrefix", petFamily)
        end
    end
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

function MyHunter_Pet:SlashCommandHandler(msg)
    local command, param = msg:match("^(%S*)%s*(.-)$")
    command = string.lower(command or "")

    if command == "" or command == "help" then
        self:PrintHelp()

    elseif command == "info" then
        self:PrintInfo()

    elseif command == "heal" then
        local success, message = self:HealPet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "feed" then
        local success, message = self:FeedPet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "autofeed" then
        local success, message = self:AutoFeedPet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "call" then
        local success, message = self:CallPet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "dismiss" then
        local success, message = self:DismissPet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "revive" then
        local success, message = self:RevivePet()
        if message then
            EmzTools:Print(message, success and "success" or "warning")
        end

    elseif command == "food" then
        self:PrintFoodInfo()

    elseif command == "scanfood" then
        self:ScanForFood()

    elseif command == "compatibility" or command == "comp" then
        self:CheckFoodCompatibility()

    elseif command == "preferences" then
        self:PrintFoodPreferences()

    elseif command == "happiness" then
        local happiness, happinessText, damagePercent = self:GetHappinessDetails()

    elseif command == "threshold" then
        if param and param ~= "" then
            local threshold = tonumber(param)
            local success, message, value = self:SetHealThreshold(threshold)
            if message then
                EmzTools:Print(message, success and "success" or "error", value)
            end
        else
            EmzTools:Print("EMZTOOLS_MYHUNTER_PET_USAGE_THRESHOLD", "error")
        end

    else
        self:PrintHelp()
    end
end

-- Affiche l'aide des commandes
function MyHunter_Pet:PrintHelp()
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMANDS_HEADER", "info")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_INFO", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_HEAL", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_FEED", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_AUTOFEED", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_CALL", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_DISMISS", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_REVIVE", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_FOOD", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_SCANFOOD", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_COMPATIBILITY", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_PREFERENCES", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_HAPPINESS", "noPrefix")
    EmzTools:Print("EMZTOOLS_MYHUNTER_PET_COMMAND_THRESHOLD", "noPrefix")
end

-- ===================================================
-- INTÉGRATION AVEC LE FRAMEWORK
-- ===================================================

EmzTools.MyHunter_Pet = MyHunter_Pet

return MyHunter_Pet
