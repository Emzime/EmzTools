-- =====================================================
-- EmzTools - Data/InternalProfiler.lua
-- Profileur interne 100% compatible WoW 1.12 (LUA 5.0)
-- =====================================================

-- Module principal InternalProfiler
EmzTools.InternalProfiler = {
    enabled = false,
    frame = nil,
    monitorFrame = nil,
    isLocked = false,

    functionTimes = {},
    lastSampleTime = 0,
    sampleInterval = 3.0
}

-- ===================================================
-- Initialise le module InternalProfiler
-- @return: boolean - true si initialisation réussie
-- ===================================================

function EmzTools.InternalProfiler:Initialize()
    EmzTools:Print("EMZTOOLS_MODULE_LOADED", "debug", "InternalProfiler")
    return true
end

-- Alias pour organisation Data
EmzTools.Data = EmzTools.Data or {}
EmzTools.Data.InternalProfiler = EmzTools.InternalProfiler

-- ===================================================
-- FONCTIONS UTILITAIRES COMPATIBLES
-- ===================================================

-- ===================================================
-- Calcule la longueur d'une table
-- @param t: table - Table à mesurer
-- @return: number - Longueur de la table
-- ===================================================

function EmzTools.Data.InternalProfiler:TableLength(t)
    if not t then return 0 end
    return table.getn(t)
end

-- ===================================================
-- Sous-chaîne sécurisée
-- @param str: string - Chaîne d'origine
-- @param start: number - Position de départ
-- @param length: number - Longueur maximale
-- @return: string - Sous-chaîne
-- ===================================================

function EmzTools.Data.InternalProfiler:SafeSub(str, start, length)
    if not str then return "" end
    if string.len(str) <= length then return str end
    return string.sub(str, start, length)
end

-- ===================================================
-- WRAPPER COMPATIBLE
-- ===================================================

-- ===================================================
-- Crée un wrapper pour une fonction
-- @param moduleName: string - Nom du module
-- @param funcName: string - Nom de la fonction
-- @param originalFunc: function - Fonction originale
-- @return: function - Fonction wrappée
-- ===================================================

function EmzTools.Data.InternalProfiler:CreateWrapper(moduleName, funcName, originalFunc)
    return function(a1, a2, a3, a4, a5)
        if not self.enabled then
            return originalFunc(a1, a2, a3, a4, a5)
        end

        local startTime = GetTime()
        local r1, r2, r3 = originalFunc(a1, a2, a3, a4, a5)
        local endTime = GetTime()

        self:RecordFunctionCall(moduleName .. "." .. funcName, endTime - startTime)

        return r1, r2, r3
    end
end

-- =====================================================
-- Enregistre un appel de fonction
-- @param fullName: string - Nom complet de la fonction
-- @param execTime: number - Temps d'exécution
-- =====================================================

function EmzTools.Data.InternalProfiler:RecordFunctionCall(fullName, execTime)
    if not self.functionTimes[fullName] then
        self.functionTimes[fullName] = {
            total = 0,
            calls = 0,
            max = 0,
            min = 999
        }
    end

    local stats = self.functionTimes[fullName]
    stats.calls = stats.calls + 1
    stats.total = stats.total + execTime

    if execTime > stats.max then
        stats.max = execTime
    end

    if execTime < stats.min then
        stats.min = execTime
    end
end

-- ====================================================
-- Wrapper une fonction spécifique
-- @param module: table - Module contenant la fonction
-- @param funcName: string - Nom de la fonction
-- @return: boolean - true si réussi
-- ====================================================

function EmzTools.Data.InternalProfiler:WrapFunction(module, funcName)
    if not module or type(module[funcName]) ~= "function" then
        return false
    end

    local moduleName = "Unknown"
    for name, mod in pairs(EmzTools) do
        if mod == module then
            moduleName = name
            break
        end
    end

    local originalFunc = module[funcName]
    module[funcName] = self:CreateWrapper(moduleName, funcName, originalFunc)

    return true
end

-- ===================================================
-- FENÊTRE DE MONITORING
-- ===================================================

-- ===================================================
-- Crée la fenêtre de monitoring
-- ===================================================

function EmzTools.Data.InternalProfiler:CreateMonitorWindow()
    if self.monitorFrame then return end

    local frame = CreateFrame("Frame", "EmzToolsProfilerDisplay", UIParent)
    frame:SetWidth(320)
    frame:SetHeight(200)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    frame:SetFrameStrata("FULLSCREEN_DIALOG")
    frame:SetToplevel(true)

    frame:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.9)
    frame:SetBackdropBorderColor(0.3, 0.3, 0.5, 1)

    -- Titre
    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", frame, "TOP", 0, -8)
    title:SetText("EmzTools Profiler")
    frame.title = title

    -- Statistiques
    frame.stats = {}

    frame.stats.slowFunc = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.slowFunc:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -30)
    frame.stats.slowFunc:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_SLOWEST_FUNCTION"))

    frame.stats.avgTime = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.avgTime:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -45)
    frame.stats.avgTime:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_AVERAGE_TIME"))

    frame.stats.totalCalls = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.totalCalls:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -60)
    frame.stats.totalCalls:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_TOTAL_CALLS"))

    frame.stats.funcCount = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.funcCount:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -75)
    frame.stats.funcCount:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_FUNCTION_COUNT"))

    frame.stats.status = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.status:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -90)
    frame.stats.status:SetText(EmzTools:GetText("EMZTOOLS_STATE_STATUS"))

    frame.stats.problems = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.stats.problems:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -105)
    frame.stats.problems:SetWidth(300)
    frame.stats.problems:SetHeight(70)
    frame.stats.problems:SetJustifyH("LEFT")
    frame.stats.problems:SetText("")

    -- Boutons
    local closeBtn = CreateFrame("Button", nil, frame)
    closeBtn:SetWidth(20)
    closeBtn:SetHeight(20)
    closeBtn:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeBtn:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
    closeBtn:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
    closeBtn:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
    closeBtn:SetScript("OnClick", function()
        EmzTools.Data.InternalProfiler:Stop()
    end)

    frame.lockBtn = CreateFrame("Button", nil, frame)
    frame.lockBtn:SetWidth(70)
    frame.lockBtn:SetHeight(20)
    frame.lockBtn:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)

    frame.lockBtn.text = frame.lockBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    frame.lockBtn.text:SetPoint("CENTER", 0, 0)
    frame.lockBtn.text:SetText(EmzTools:GetText("EMZTOOLS_STATE_LOCKED"))

    frame.lockBtn:SetScript("OnClick", function()
        EmzTools.Data.InternalProfiler:ToggleLock()
    end)

    local resetBtn = CreateFrame("Button", nil, frame)
    resetBtn:SetWidth(70)
    resetBtn:SetHeight(20)
    resetBtn:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -10, 10)

    resetBtn.text = resetBtn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    resetBtn.text:SetPoint("CENTER", 0, 0)
    resetBtn.text:SetText(EmzTools:GetText("EMZTOOLS_STATE_RESET"))

    resetBtn:SetScript("OnClick", function()
        EmzTools.Data.InternalProfiler:ResetStats()
    end)

    -- Déplaçable
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")

    frame:SetScript("OnDragStart", function()
        if not EmzTools.Data.InternalProfiler.isLocked then
            this:StartMoving()
        end
    end)

    frame:SetScript("OnDragStop", function()
        this:StopMovingOrSizing()
    end)

    frame:Hide()
    self.monitorFrame = frame
end

-- ===================================================
-- ANALYSE DES DONNÉES
-- ===================================================

-- ===================================================
-- Analyse les données collectées
-- @return: table - Données analysées
-- ===================================================

function EmzTools.Data.InternalProfiler:AnalyzeData()
    local slowestName = EmzTools:GetText("EMZTOOLS_STATE_NONE")
    local slowestTime = 0
    local slowestCalls = 0
    local totalCalls = 0
    local totalTime = 0
    local funcCount = 0
    local problems = {}
    local problemCount = 0

    for funcName, stats in pairs(self.functionTimes) do
        if stats.calls > 0 then
            funcCount = funcCount + 1
            totalCalls = totalCalls + stats.calls
            totalTime = totalTime + stats.total

            local avgTime = stats.total / stats.calls

            if avgTime > slowestTime then
                slowestTime = avgTime
                slowestName = funcName
                slowestCalls = stats.calls
            end

            -- Détecter problèmes
            if avgTime > 0.1 then
                problemCount = problemCount + 1
                problems[problemCount] = self:SafeSub(funcName, 1, 25) .. ": " ..
                    string.format("%.0fms", avgTime * 1000)
            end
        end
    end

    local avgTotal = 0
    if totalCalls > 0 then
        avgTotal = totalTime / totalCalls
    end

    return {
        slowestName = slowestName,
        slowestTime = slowestTime,
        slowestCalls = slowestCalls,
        totalCalls = totalCalls,
        totalTime = totalTime,
        avgTotal = avgTotal,
        funcCount = funcCount,
        problems = problems,
        problemCount = problemCount
    }
end

-- ===================================================
-- Met à jour l'affichage
-- ===================================================

function EmzTools.Data.InternalProfiler:UpdateDisplay()
    if not self.monitorFrame then return end

    local data = self:AnalyzeData()
    local frame = self.monitorFrame

    -- Fonction la plus lente
    if data.slowestTime > 0 then
        local color = "|cFFFFFF00"
        if data.slowestTime > 0.1 then color = "|cFFFF0000" end

        frame.stats.slowFunc:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_SLOWEST_FUNCTION") .. ": " .. color .. self:SafeSub(data.slowestName, 1, 20) .. "|r")
    else
        frame.stats.slowFunc:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_SLOWEST_FUNCTION") .. ": " .. EmzTools:GetText("EMZTOOLS_STATE_NONE"))
    end

    -- Temps moyen
    local timeColor = "|cFF00FF00"
    if data.avgTotal > 0.05 then timeColor = "|cFFFFFF00" end
    if data.avgTotal > 0.1 then timeColor = "|cFFFF0000" end

    frame.stats.avgTime:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_AVERAGE_TIME") .. ": " .. timeColor .. string.format("%.1fms", data.avgTotal * 1000) .. "|r")

    -- Appels
    frame.stats.totalCalls:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_TOTAL_CALLS") .. ": " .. data.totalCalls)

    -- Fonctions
    frame.stats.funcCount:SetText(EmzTools:GetText("EMZTOOLS_PROFILER_FUNCTION_COUNT") .. ": " .. data.funcCount)

    -- Status
    if data.problemCount > 0 then
        frame.stats.status:SetText(EmzTools:GetText("EMZTOOLS_STATE_STATUS") .. ": " .. EmzTools:GetText("EMZTOOLS_PROFILER_PROBLEMS"))
    else
        frame.stats.status:SetText(EmzTools:GetText("EMZTOOLS_STATE_STATUS") .. ": " .. EmzTools:GetText("EMZTOOLS_PROFILER_OK"))
    end

    -- Problèmes
    local problemText = ""
    if data.problemCount > 0 then
        for i = 1, math.min(3, data.problemCount) do
            problemText = problemText .. data.problems[i] .. "\n"
        end
    else
        problemText = EmzTools:GetText("EMZTOOLS_PROFILER_NO_PROBLEMS")
    end

    frame.stats.problems:SetText(problemText)
end

-- ===================================================
-- WRAP FONCTIONS CRITIQUES
-- ===================================================

-- ===================================================
-- Wrapper les fonctions critiques
-- ===================================================

function EmzTools.Data.InternalProfiler:WrapCriticalFunctions()
    self:Print("EMZTOOLS_PROFILER_WRAPPING_FUNCTIONS", "debug")

    -- UI
    if EmzTools.Data and EmzTools.Data.UI then
        local uiFuncs = {"CreateMainFrame", "CreateBeautifulButton", "ApplyTheme"}
        for i = 1, table.getn(uiFuncs) do
            local funcName = uiFuncs[i]
            if self:WrapFunction(EmzTools.Data.UI, funcName) then
                self:Print("EMZTOOLS_PROFILER_WRAPPED_UI_FUNCTION", "debug", funcName)
            end
        end
    end

    -- Core
    local coreFuncs = {"Print", "SetDebug", "OpenMainConfig"}
    for i = 1, table.getn(coreFuncs) do
        local funcName = coreFuncs[i]
        if self:WrapFunction(EmzTools, funcName) then
            self:Print("EMZTOOLS_PROFILER_WRAPPED_CORE_FUNCTION", "debug", funcName)
        end
    end
end

-- ===================================================
-- GESTION DU PROFILER
-- ===================================================

-- ===================================================
-- Démarre le profileur
-- ===================================================

function EmzTools.Data.InternalProfiler:Start()
    if self.enabled then return end

    self:Initialize()
    self:CreateMonitorWindow()
    self:WrapCriticalFunctions()

    if not self.frame then
        self.frame = CreateFrame("Frame")
    end

    self.frame:SetScript("OnUpdate", function()
        local currentTime = GetTime()
        if currentTime - self.lastSampleTime >= self.sampleInterval then
            self.lastSampleTime = currentTime
            EmzTools.Data.InternalProfiler:UpdateDisplay()
        end
    end)

    self.enabled = true
    self.lastSampleTime = GetTime()

    if self.monitorFrame then
        self.monitorFrame:Show()
    end

    self:Print("EMZTOOLS_PROFILER_STARTED", "success")
end

-- ===================================================
-- Arrête le profileur
-- ===================================================

function EmzTools.Data.InternalProfiler:Stop()
    if not self.enabled then return end

    if self.frame then
        self.frame:SetScript("OnUpdate", nil)
    end

    self.enabled = false

    if self.monitorFrame then
        self.monitorFrame:Hide()
    end

    self:Print("EMZTOOLS_PROFILER_STOPPED", "success")
end

-- ===================================================
-- Génère un rapport détaillé
-- ===================================================

function EmzTools.Data.InternalProfiler:GenerateDetailedReport()
    self:Print("EMZTOOLS_PROFILER_REPORT_TITLE", "info")

    local data = self:AnalyzeData()

    self:Print(string.format("EMZTOOLS_PROFILER_FUNCTION_COUNT_FORMAT", data.funcCount), "info")
    self:Print(string.format("EMZTOOLS_PROFILER_TOTAL_CALLS_FORMAT", data.totalCalls), "info")
    self:Print(string.format("EMZTOOLS_PROFILER_TOTAL_TIME_FORMAT", string.format("%.1fms", data.totalTime * 1000)), "info")

    if data.slowestTime > 0 then
        self:Print(string.format("EMZTOOLS_PROFILER_SLOWEST_FUNCTION_DETAILS",
            data.slowestName,
            string.format("%.1fms", data.slowestTime * 1000),
            data.slowestCalls), "info")
    end

    if data.problemCount > 0 then
        self:Print("EMZTOOLS_PROFILER_PROBLEMS_TITLE", "warning")
        for i = 1, data.problemCount do
            self:Print(string.format("EMZTOOLS_PROFILER_PROBLEM_FORMAT", data.problems[i]), "warning")
        end
    end
end

-- ===================================================
-- Réinitialise les statistiques
-- ===================================================

function EmzTools.Data.InternalProfiler:ResetStats()
    self.functionTimes = {}
    self.lastSampleTime = GetTime()

    if self.monitorFrame then
        self:UpdateDisplay()
    end

    self:Print("EMZTOOLS_PROFILER_STATS_RESET", "success")
end

-- ===================================================
-- Bascule le verrouillage
-- ===================================================

function EmzTools.Data.InternalProfiler:ToggleLock()
    self.isLocked = not self.isLocked

    if self.monitorFrame and self.monitorFrame.lockBtn then
        if self.isLocked then
            self.monitorFrame:RegisterForDrag()
            self.monitorFrame.lockBtn.text:SetText(EmzTools:GetText("EMZTOOLS_STATE_UNLOCKED"))
        else
            self.monitorFrame:RegisterForDrag("LeftButton")
            self.monitorFrame.lockBtn.text:SetText(EmzTools:GetText("EMZTOOLS_STATE_LOCKED"))
        end
    end
end

-- ===================================================
-- Affiche un message
-- @param message: string - Message à afficher
-- @param msgType: string - Type de message
-- ===================================================

function EmzTools.Data.InternalProfiler:Print(message, msgType)
    if EmzTools and EmzTools.Print then
        EmzTools:Print("[Profiler] " .. message, msgType)
    else
        DEFAULT_CHAT_FRAME:AddMessage("Profiler: " .. EmzTools:GetText(message))
    end
end

-- ===================================================
-- COMMANDES SLASH
-- ===================================================

-- Commande principale via /emz profile
function EmzTools.Data.InternalProfiler:SlashCommand(msg)
    local command = string.lower(msg or "")

    if command == "" or command == "help" then
        EmzTools:Print("EMZTOOLS_PROFILER_COMMANDS_TITLE", "info")
        EmzTools:Print("EMZTOOLS_PROFILER_COMMAND_START", "noPrefix")
        EmzTools:Print("EMZTOOLS_PROFILER_COMMAND_STOP", "noPrefix")
        EmzTools:Print("EMZTOOLS_PROFILER_COMMAND_REPORT", "noPrefix")
        EmzTools:Print("EMZTOOLS_PROFILER_COMMAND_RESET", "noPrefix")

    elseif command == "start" then
        self:Start()

    elseif command == "stop" then
        self:Stop()

    elseif command == "report" then
        self:GenerateDetailedReport()

    elseif command == "reset" then
        self:ResetStats()

    else
        self:Print(string.format("EMZTOOLS_STATE_UNKNOWN_COMMAND", command), "warning")
    end
end

-- ===================================================
-- ENREGISTREMENT DES COMMANDES
-- ===================================================

-- Enregistrement dans le système de commandes principal EmzTools
if not EmzTools.SlashCommands then
    EmzTools.SlashCommands = {}
end

EmzTools.SlashCommands["profile"] = function(msg)
    EmzTools.Data.InternalProfiler:SlashCommand(msg)
end

EmzTools.SlashCommands["profiler"] = function(msg)
    EmzTools.Data.InternalProfiler:SlashCommand(msg)
end

-- ===================================================
-- COMPATIBILITÉ BIDIRECTIONNELLE
-- ===================================================

-- S'assurer que le module est disponible via Data
local function EnsureInternalProfilerCompatibility()
    if EmzTools.InternalProfiler and EmzTools.Data.InternalProfiler then
        -- Copier toutes les fonctions si nécessaire
        for funcName, func in pairs(EmzTools.InternalProfiler) do
            if type(func) == "function" then
                EmzTools.Data.InternalProfiler[funcName] = func
            end
        end
    end
end

-- Exécuter à la fin du fichier
EnsureInternalProfilerCompatibility()
