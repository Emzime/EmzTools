-- ==========================================================
-- MyHunter - MyHunter_Aspects.lua
-- Gestion automatique des aspects avec verrouillage visuel
-- 100% COMPATIBLE WOW 1.12.1 - LUA 5.0
-- ==========================================================

local MyHunter_Aspects = {}

MyHunter_Aspects.supportedClasses = { "HUNTER" }

MyHunter_Aspects.List = {
    Hawk = "Aspect of the Hawk",
    Monkey = "Aspect of the Monkey",
    Cheetah = "Aspect of the Cheetah",
    Pack = "Aspect of the Pack",
    Wild = "Aspect of the Wild",
    Beast = "Aspect of the Beast",
}

local lockFrame = nil
local eventFrame = nil

function MyHunter_Aspects:Initialize()
    EmzTools:LoadPluginLocalization("MyHunter")
    self:InitializeDefaults()
    self:CreateLockFrame()
    self:CreateEventFrame()
    self:RegisterEvents()

    if EmzToolsDB.MyHunter.aspects.autoAspects and not self:IsLocked() then
        self:ApplyInitialAspect()
    end

    return true
end

function MyHunter_Aspects:InitializeDefaults()
    if not EmzToolsDB then return end

    if not EmzToolsDB.MyHunter then
        EmzToolsDB.MyHunter = {}
    end

    if EmzToolsDB.MyHunter.aspects == nil then
        EmzToolsDB.MyHunter.aspects = {
            autoAspects = true,
            combatAspect = "Aspect of the Hawk",
            travelAspect = "Aspect of the Cheetah",
            enableSmartAspects = true,
            aspectLocked = false,
            lockFramePosition = { x = 0, y = 0 }
        }
    end
end

function MyHunter_Aspects:CreateLockFrame()
    if lockFrame then return end

    lockFrame = CreateFrame("Frame", "MyHunterAspectsLockFrame", UIParent)
    lockFrame:SetWidth(200)
    lockFrame:SetHeight(60)
    lockFrame:SetPoint("CENTER", UIParent, "CENTER",
                       EmzToolsDB.MyHunter.aspects.lockFramePosition.x,
                       EmzToolsDB.MyHunter.aspects.lockFramePosition.y)

    lockFrame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    lockFrame:SetBackdropColor(0, 0, 0, 0.8)
    lockFrame:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
    lockFrame:Hide()

    lockFrame:SetMovable(true)
    lockFrame:EnableMouse(true)
    lockFrame:RegisterForDrag("LeftButton")
    lockFrame:SetScript("OnDragStart", function()
        this:StartMoving()
    end)
    lockFrame:SetScript("OnDragStop", function()
        this:StopMovingOrSizing()
        local x, y = this:GetCenter()
        local ux, uy = UIParent:GetCenter()
        EmzToolsDB.MyHunter.aspects.lockFramePosition.x = x - ux
        EmzToolsDB.MyHunter.aspects.lockFramePosition.y = y - uy
    end)

    lockFrame.text = lockFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    lockFrame.text:SetPoint("TOP", lockFrame, "TOP", 0, -10)
    lockFrame.text:SetText("EMZTOOLS_MYHUNTER_LOCKFRAME_TITLE")
    lockFrame.text:SetTextColor(1, 1, 0, 1)

    lockFrame.unlockButton = CreateFrame("Button", nil, lockFrame, "UIPanelButtonTemplate")
    lockFrame.unlockButton:SetWidth(120)
    lockFrame.unlockButton:SetHeight(24)
    lockFrame.unlockButton:SetPoint("BOTTOM", lockFrame, "BOTTOM", 0, 10)
    lockFrame.unlockButton:SetText("EMZTOOLS_MYHUNTER_LOCKFRAME_UNLOCK")
    lockFrame.unlockButton:SetScript("OnClick", function()
        MyHunter_Aspects:SetAspectLock(false)
    end)

    lockFrame.closeButton = CreateFrame("Button", nil, lockFrame, "UIPanelCloseButton")
    lockFrame.closeButton:SetWidth(24)
    lockFrame.closeButton:SetHeight(24)
    lockFrame.closeButton:SetPoint("TOPRIGHT", lockFrame, "TOPRIGHT", 2, 2)
    lockFrame.closeButton:SetScript("OnClick", function()
        lockFrame:Hide()
    end)
end

function MyHunter_Aspects:UpdateLockFrame()
    if not lockFrame then return end

    if self:IsLocked() then
        lockFrame:Show()
    else
        lockFrame:Hide()
    end
end

function MyHunter_Aspects:IsLocked()
    return EmzToolsDB.MyHunter.aspects.aspectLocked
end

function MyHunter_Aspects:SetAspectLock(locked)
    EmzToolsDB.MyHunter.aspects.aspectLocked = locked

    if locked then
        local currentAspect = self:GetCurrentAspect() or "EMZTOOLS_MYHUNTER_NO_ASPECT_ACTIVE"
        EmzTools:Print("EMZTOOLS_MYHUNTER_ASPECT_LOCKED", "success", currentAspect)
    else
        EmzTools:Print("EMZTOOLS_MYHUNTER_ASPECT_UNLOCKED", "success")
        if EmzToolsDB.MyHunter.aspects.autoAspects then
            self:SmartAspect()
        end
    end

    self:UpdateLockFrame()
end

function MyHunter_Aspects:ToggleAspectLock()
    self:SetAspectLock(not self:IsLocked())
end

function MyHunter_Aspects:DetectManualAspectChange(spellName)
    if not self:IsLocked() then
        self:SetAspectLock(true)
    end
end

function MyHunter_Aspects:CreateEventFrame()
    if eventFrame then return end

    eventFrame = CreateFrame("Frame", "MyHunterAspectsEventFrame")

    eventFrame:SetScript("OnEvent", function()
        if event == "SPELLCAST_START" then
            local spellName = arg1
            MyHunter_Aspects:OnSpellCastStart(spellName)
        else
            MyHunter_Aspects:OnEvent(event)
        end
    end)
end

function MyHunter_Aspects:RegisterEvents()
    if not eventFrame then return end

    eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
    eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
    eventFrame:RegisterEvent("SPELLCAST_START")
    eventFrame:RegisterEvent("ZONE_CHANGED")
    eventFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
end

function MyHunter_Aspects:OnSpellCastStart(spellName)
    for _, aspect in pairs(self.List) do
        if spellName == aspect then
            self:DetectManualAspectChange(spellName)
            break
        end
    end
end

function MyHunter_Aspects:OnEvent(event)
    if self:IsLocked() then
        return
    end

    if not EmzToolsDB.MyHunter.aspects.autoAspects then
        return
    end

    if event == "PLAYER_REGEN_DISABLED" then
        self:SwitchToCombatAspect()
    elseif event == "PLAYER_REGEN_ENABLED" then
        self:SwitchToTravelAspect()
    elseif event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
        self:DelayedAspectCheck()
    end
end

function MyHunter_Aspects:DelayedAspectCheck()
    local checkTime = GetTime() + 1
    local function CheckAspect()
        if GetTime() >= checkTime then
            if not UnitAffectingCombat("player") then
                MyHunter_Aspects:SwitchToTravelAspect()
            end
            return
        end
        MyHunter_Aspects.aspectCheckFrame = MyHunter_Aspects.aspectCheckFrame or CreateFrame("Frame")
        MyHunter_Aspects.aspectCheckFrame:SetScript("OnUpdate", function()
            this:SetScript("OnUpdate", nil)
            CheckAspect()
        end)
    end

    CheckAspect()
end

function MyHunter_Aspects:ApplyInitialAspect()
    local applyTime = GetTime() + 3
    local function ApplyAspect()
        if GetTime() >= applyTime then
            if not UnitAffectingCombat("player") then
                MyHunter_Aspects:SwitchToTravelAspect()
            end
            return
        end
        MyHunter_Aspects.initialAspectFrame = MyHunter_Aspects.initialAspectFrame or CreateFrame("Frame")
        MyHunter_Aspects.initialAspectFrame:SetScript("OnUpdate", function()
            this:SetScript("OnUpdate", nil)
            ApplyAspect()
        end)
    end

    ApplyAspect()
end

function MyHunter_Aspects:ActivateAspect(aspectName)
    if not aspectName then return false end

    if self:HasAspect(aspectName) then
        return true
    end

    local isKnown = false
    for i = 1, 180 do
        local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
        if spellName and spellName == aspectName then
            isKnown = true
            break
        end
    end

    if not isKnown then
        return false
    end

    CastSpellByName(aspectName)
    return true
end

function MyHunter_Aspects:ActivateHawk()
    return self:ActivateAspect(self.List.Hawk)
end

function MyHunter_Aspects:ActivateMonkey()
    return self:ActivateAspect(self.List.Monkey)
end

function MyHunter_Aspects:ActivateCheetah()
    return self:ActivateAspect(self.List.Cheetah)
end

function MyHunter_Aspects:ActivatePack()
    return self:ActivateAspect(self.List.Pack)
end

function MyHunter_Aspects:ActivateWild()
    return self:ActivateAspect(self.List.Wild)
end

function MyHunter_Aspects:ActivateBeast()
    return self:ActivateAspect(self.List.Beast)
end

function MyHunter_Aspects:HasAspect(aspectName)
    if aspectName then
        for i = 1, 16 do
            local texture = UnitBuff("player", i)
            if not texture then break end
            if string.find(texture, "Aspect", 1, true) then
                local buffName = GetPlayerBuffTexture(i)
                if buffName and string.find(buffName, aspectName, 1, true) then
                    return true
                end
            end
        end
        return false
    else
        for i = 1, 16 do
            local texture = UnitBuff("player", i)
            if not texture then break end
            if string.find(texture, "Aspect", 1, true) then
                return true
            end
        end
        return false
    end
end

function MyHunter_Aspects:GetCurrentAspect()
    for i = 1, 16 do
        local texture = UnitBuff("player", i)
        if not texture then break end
        if string.find(texture, "Aspect", 1, true) then
            local buffName = GetPlayerBuffTexture(i)
            if buffName then
                for _, aspect in pairs(self.List) do
                    if string.find(buffName, aspect, 1, true) then
                        return aspect
                    end
                end
            end
        end
    end
    return nil
end

function MyHunter_Aspects:SwitchToCombatAspect()
    local combatAspect = EmzToolsDB.MyHunter.aspects.combatAspect or "Aspect of the Hawk"
    if self:HasAspect(combatAspect) then return true end
    return self:ActivateAspect(combatAspect)
end

function MyHunter_Aspects:SwitchToTravelAspect()
    local travelAspect = EmzToolsDB.MyHunter.aspects.travelAspect or "Aspect of the Cheetah"
    if self:HasAspect(travelAspect) then return true end
    return self:ActivateAspect(travelAspect)
end

function MyHunter_Aspects:SmartAspect()
    if not EmzToolsDB.MyHunter.aspects.enableSmartAspects then return false end
    if UnitAffectingCombat("player") then
        return self:SwitchToCombatAspect()
    end
    return self:SwitchToTravelAspect()
end

function MyHunter_Aspects:SetCombatAspect(aspectName)
    local isKnown = false
    for i = 1, 180 do
        local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
        if spellName and spellName == aspectName then
            isKnown = true
            break
        end
    end

    if not isKnown then
        EmzTools:Print("EMZTOOLS_MYHUNTER_ASPECT_NOT_AVAILABLE", "error", aspectName)
        return false
    end

    EmzToolsDB.MyHunter.aspects.combatAspect = aspectName
    EmzTools:Print("EMZTOOLS_MYHUNTER_COMBAT_ASPECT_SET", "success", aspectName)
    return true
end

function MyHunter_Aspects:SetTravelAspect(aspectName)
    local isKnown = false
    for i = 1, 180 do
        local spellName, spellRank = GetSpellName(i, BOOKTYPE_SPELL)
        if spellName and spellName == aspectName then
            isKnown = true
            break
        end
    end

    if not isKnown then
        EmzTools:Print("EMZTOOLS_MYHUNTER_ASPECT_NOT_AVAILABLE", "error", aspectName)
        return false
    end

    EmzToolsDB.MyHunter.aspects.travelAspect = aspectName
    EmzTools:Print("EMZTOOLS_MYHUNTER_TRAVEL_ASPECT_SET", "success", aspectName)
    return true
end

function MyHunter_Aspects:SetAutoAspects(enabled)
    EmzToolsDB.MyHunter.aspects.autoAspects = enabled
    if enabled then
        self:RegisterEvents()
        if not self:IsLocked() then
            self:SmartAspect()
        end
        EmzTools:Print("EMZTOOLS_MYHUNTER_AUTO_ASPECTS_ENABLED", "success")
    else
        self:UnregisterEvents()
        EmzTools:Print("EMZTOOLS_MYHUNTER_AUTO_ASPECTS_DISABLED", "success")
    end
end

function MyHunter_Aspects:UnregisterEvents()
    if eventFrame then
        eventFrame:UnregisterAllEvents()
    end
end

function MyHunter_Aspects:SlashCommandHandler(msg)
    local command, param = self:ParseSlashCommand(msg)
    command = string.lower(command or "")

    if command == "" or command == "help" then
        self:PrintHelp()
    elseif command == "status" then
        self:PrintCurrentAspect()
    elseif command == "list" then
        self:PrintAvailableAspects()
    elseif command == "config" then
        self:PrintConfig()
    elseif command == "smart" then
        self:SmartAspect()
    elseif command == "hawk" then
        self:ActivateHawk()
    elseif command == "monkey" then
        self:ActivateMonkey()
    elseif command == "cheetah" then
        self:ActivateCheetah()
    elseif command == "pack" then
        self:ActivatePack()
    elseif command == "wild" then
        self:ActivateWild()
    elseif command == "beast" then
        self:ActivateBeast()
    elseif command == "combat" then
        self:SwitchToCombatAspect()
    elseif command == "travel" then
        self:SwitchToTravelAspect()
    elseif command == "setcombat" then
        if param and param ~= "" then
            self:SetCombatAspect(param)
        end
    elseif command == "settravel" then
        if param and param ~= "" then
            self:SetTravelAspect(param)
        end
    elseif command == "auto" then
        local newState = not EmzToolsDB.MyHunter.aspects.autoAspects
        self:SetAutoAspects(newState)
    elseif command == "lock" then
        self:SetAspectLock(true)
    elseif command == "unlock" then
        self:SetAspectLock(false)
    elseif command == "toggle" then
        self:ToggleAspectLock()
    else
        EmzTools:Print("EMZTOOLS_STATE_UNKNOWN_COMMAND", "warning")
    end
end

function MyHunter_Aspects:ParseSlashCommand(msg)
    local command, param = string.match(msg or "", "^(%S*)%s*(.-)$")
    return command or "", param or ""
end

EmzTools.MyHunter_Aspects = MyHunter_Aspects

return MyHunter_Aspects
