-- ===========================================================
-- EmzTools - Data/EventManager.lua
-- Gestionnaire centralisé des événements WoW (Lua 5.0 / 1.12)
-- ===========================================================

-- Module principal EventManager DANS Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.EventManager = {
    supportedClasses = { "WARRIOR", "MAGE", "ROGUE", "DRUID", "HUNTER", "SHAMAN", "PRIEST", "WARLOCK", "PALADIN" }
}

-- ===================================================
-- Initialise le module EventManager
-- @return: boolean - true si initialisation réussie
-- ===================================================

function EmzTools.Data.EventManager:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "EventManager")
    return true
end

-- ===================================================
-- VARIABLES LOCALES
-- ===================================================

local eventFrame = CreateFrame("Frame", "EmzToolsEventFrame")
local eventCallbacks = {}
local registeredEvents = {}

-- ===================================================
-- FONCTIONS PRINCIPALES
-- ===================================================

function EmzTools.Data.EventManager:RegisterCallback(event, callback, identifier)
    if not event or type(callback) ~= "function" then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_INVALID_CALLBACK", "error")
        return false
    end

    if not eventCallbacks[event] then
        eventCallbacks[event] = {}
    end

    local callbackData = {
        func = callback,
        id = identifier or tostring(callback)
    }

    table.insert(eventCallbacks[event], callbackData)

    if not registeredEvents[event] then
        eventFrame:RegisterEvent(event)
        registeredEvents[event] = true
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_EVENT_REGISTERED", "debug", event)
    end

    EmzTools:Print("EMZTOOLS_EVENTMANAGER_CALLBACK_ADDED", "debug", event)
    return true
end

function EmzTools.Data.EventManager:UnregisterCallback(event, identifier)
    if not event or not identifier then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_MISSING_PARAMS", "error")
        return false
    end

    if not eventCallbacks[event] then
        return false
    end

    for i = table.getn(eventCallbacks[event]), 1, -1 do
        if eventCallbacks[event][i].id == identifier then
            table.remove(eventCallbacks[event], i)
            EmzTools:Print("EMZTOOLS_EVENTMANAGER_CALLBACK_REMOVED", "debug", event)

            if table.getn(eventCallbacks[event]) == 0 then
                eventFrame:UnregisterEvent(event)
                registeredEvents[event] = nil
                eventCallbacks[event] = nil
                EmzTools:Print("EMZTOOLS_EVENTMANAGER_EVENT_UNREGISTERED", "debug", event)
            end

            return true
        end
    end

    return false
end

function EmzTools.Data.EventManager:UnregisterAllCallbacks(event)
    if not event then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_EVENT_REQUIRED", "error")
        return false
    end

    if eventCallbacks[event] then
        eventCallbacks[event] = nil
    end

    if registeredEvents[event] then
        eventFrame:UnregisterEvent(event)
        registeredEvents[event] = nil
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_ALL_CALLBACKS_REMOVED", "debug", event)
    end

    return true
end

-- ===================================================
-- GESTION DES ÉVÉNEMENTS
-- ===================================================

function EmzTools.Data.EventManager:OnEvent(event, argsTable)
    if not event or not eventCallbacks[event] then return end

    local n = table.getn(eventCallbacks[event])
    for i = 1, n do
        local callbackData = eventCallbacks[event][i]
        if callbackData and callbackData.func then
            local success, err = pcall(function()
                if argsTable then
                    callbackData.func(event, unpack(argsTable))
                else
                    callbackData.func(event)
                end
            end)
            if not success then
                EmzTools:Print("EMZTOOLS_EVENTMANAGER_CALLBACK_ERROR", "error", callbackData.id, tostring(err))
            end
        end
    end
end

-- Frame OnEvent compatible Lua 5.0
eventFrame:SetScript("OnEvent", function()
    -- En Lua 5.0, les arguments sont dans 'arg1', 'arg2', etc.
    local event = arg1
    local args = {}

    -- Collecter les arguments d'événement
    if arg2 then table.insert(args, arg2) end
    if arg3 then table.insert(args, arg3) end
    if arg4 then table.insert(args, arg4) end
    if arg5 then table.insert(args, arg5) end
    if arg6 then table.insert(args, arg6) end
    if arg7 then table.insert(args, arg7) end
    if arg8 then table.insert(args, arg8) end
    if arg9 then table.insert(args, arg9) end

    EmzTools.Data.EventManager:OnEvent(event, args)
end)

-- ===================================================
-- ÉVÉNEMENTS PERSONNALISÉS
-- ===================================================

function EmzTools.Data.EventManager:FireCustomEvent(eventName, argsTable)
    if not eventName then return end
    EmzTools:Print("EMZTOOLS_EVENTMANAGER_CUSTOM_EVENT_FIRED", "debug", eventName)
    self:OnEvent(eventName, argsTable)
end

-- ===================================================
-- ÉVÉNEMENTS COMMUNS
-- ===================================================

function EmzTools.Data.EventManager:RegisterCommonEvents()
    self:RegisterCallback("PLAYER_REGEN_DISABLED", function()
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_ENTERED_COMBAT", "debug")
    end, "EmzTools_CombatStart")

    self:RegisterCallback("PLAYER_REGEN_ENABLED", function()
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_LEFT_COMBAT", "debug")
    end, "EmzTools_CombatEnd")

    self:RegisterCallback("PLAYER_LEVEL_UP", function(event, level)
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_LEVEL_UP", "success", level)
    end, "EmzTools_LevelUp")

    self:RegisterCallback("PLAYER_DEAD", function()
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_PLAYER_DIED", "debug")
    end, "EmzTools_PlayerDead")

    self:RegisterCallback("PLAYER_ENTERING_WORLD", function()
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_ENTERING_WORLD", "debug")
    end, "EmzTools_EnteringWorld")

    self:RegisterCallback("PLAYER_LEAVING_WORLD", function()
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_LEAVING_WORLD", "debug")
    end, "EmzTools_LeavingWorld")

    EmzTools:Print("EMZTOOLS_EVENTMANAGER_COMMON_EVENTS_REGISTERED", "debug")
end

-- ===================================================
-- UTILITAIRES
-- ===================================================

function EmzTools.Data.EventManager:IsEventRegistered(event)
    return registeredEvents[event] ~= nil
end

function EmzTools.Data.EventManager:GetCallbackCount(event)
    if not eventCallbacks[event] then return 0 end
    return table.getn(eventCallbacks[event])
end

-- ===================================================
-- DEBUGGING
-- ===================================================

function EmzTools.Data.EventManager:ListRegisteredEvents()
    EmzTools:Print("EMZTOOLS_EVENTMANAGER_REGISTERED_EVENTS_HEADER", "info")

    local count = 0
    for eventName, _ in pairs(registeredEvents) do
        local callbackCount = self:GetCallbackCount(eventName)
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_EVENT_WITH_CALLBACKS", "info", eventName, callbackCount)
        count = count + 1
    end

    if count == 0 then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_NO_EVENTS", "info")
    else
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_TOTAL_EVENTS", "info", count)
    end
end

function EmzTools.Data.EventManager:ListCallbacks(eventName)
    if not eventName then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_EVENT_NAME_REQUIRED", "error")
        return
    end

    EmzTools:Print("EMZTOOLS_EVENTMANAGER_CALLBACKS_FOR_EVENT", "info", eventName)

    if not eventCallbacks[eventName] then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_NO_CALLBACKS", "info")
        return
    end

    local count = 0
    for i = 1, table.getn(eventCallbacks[eventName]) do
        local callbackData = eventCallbacks[eventName][i]
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_CALLBACK_ID", "info", callbackData.id)
        count = count + 1
    end

    if count == 0 then
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_NO_CALLBACKS", "info")
    end
end

function EmzTools.Data.EventManager:PrintStats()
    EmzTools:Print("EMZTOOLS_EVENTMANAGER_STATS_HEADER", "info")

    local eventCount = 0
    local totalCallbacks = 0

    for eventName, _ in pairs(registeredEvents) do
        eventCount = eventCount + 1
        totalCallbacks = totalCallbacks + self:GetCallbackCount(eventName)
    end

    if eventCount > 0 then
        local avg = totalCallbacks / eventCount
        avg = math.floor(avg * 10 + 0.5) / 10
        EmzTools:Print("EMZTOOLS_EVENTMANAGER_AVERAGE_CALLBACKS", "info", string.format("%.1f", avg))
    end
end

-- ===================================================
-- COMPATIBILITÉ POUR Core.lua
-- ===================================================

-- Créer aussi une référence dans EmzTools.EventManager pour compatibilité
EmzTools.EventManager = EmzTools.Data.EventManager
