--[[
    Carbon Studios - Key System
    Clean UI with Panda API
]]

-- =========================
-- CONFIG
-- =========================
local CONFIG = {
    BASE_URL = "https://new.pandadevelopment.net/api/v1",
    SERVICE_ID = "carbonstudios",
    KEY_PREFIX = "CARBON_",
    DISCORD_URL = "https://discord.gg/qphZBPNDPZ",
    SCRIPT_URL = "YOUR_SCRIPT_URL_HERE" -- Replace with your script URL
}

-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- =========================
-- LANGUAGE SYSTEM
-- =========================
local CURRENT_LANGUAGE = "en"

local LANGUAGES = {
    en = {
        title = "Carbon Studios",
        subtitle = "HWID Locked • Key Verification",
        instructions = "Paste your CARBON_ key and press Check",
        checkBtn = "Check Key",
        getKeyBtn = "Get Key",
        keyValidated = "Key validated",
        awaitingVerification = "Awaiting verification",
        verifyingKey = "Verifying key...",
        enterKey = "Please enter a key",
        invalidFormat = "Invalid key format (CARBON_)",
        invalidKey = "Invalid key!",
        keyVerified = "Key verified!",
        keyLinkCopied = "Key link copied!",
        discordCopied = "Discord link copied!",
        gameIdCopied = "Game ID copied!",
        game = "GAME",
        executor = "EXECUTOR",
        status = "STATUS",
        quickActions = "QUICK ACTIONS",
        discord = "Discord",
        copyGameId = "Copy GameId",
        helpTitle = "How to Get Key",
        helpStep1 = "1. Click 'Get Key' button",
        helpStep2 = "2. Complete the verification",
        helpStep3 = "3. Copy your key and paste it here",
        helpStep4 = "4. If any issues, join Discord",
    },
    es = {
        title = "Carbon Studios",
        subtitle = "Bloqueado por HWID • Verificación de Clave",
        instructions = "Pega tu clave CARBON_ y presiona Verificar",
        checkBtn = "Verificar Clave",
        getKeyBtn = "Obtener Clave",
        keyValidated = "Clave validada",
        awaitingVerification = "Esperando verificación",
        verifyingKey = "Verificando clave...",
        enterKey = "Por favor ingresa una clave",
        invalidFormat = "Formato de clave inválido (CARBON_)",
        invalidKey = "¡Clave inválida!",
        keyVerified = "¡Clave verificada!",
        keyLinkCopied = "¡Enlace de clave copiado!",
        discordCopied = "¡Enlace de Discord copiado!",
        gameIdCopied = "¡ID del juego copiado!",
        game = "JUEGO",
        executor = "EJECUTOR",
        status = "ESTADO",
        quickActions = "ACCIONES RÁPIDAS",
        discord = "Discord",
        copyGameId = "Copiar ID del Juego",
        helpTitle = "Cómo Obtener la Clave",
        helpStep1 = "1. Haz clic en 'Obtener Clave'",
        helpStep2 = "2. Completa la verificación",
        helpStep3 = "3. Copia tu clave y pégala aquí",
        helpStep4 = "4. Si hay problemas, únete a Discord",
    },
    fr = {
        title = "Carbon Studios",
        subtitle = "Verrouillé HWID • Vérification de Clé",
        instructions = "Collez votre clé CARBON_ et appuyez sur Vérifier",
        checkBtn = "Vérifier la Clé",
        getKeyBtn = "Obtenir la Clé",
        keyValidated = "Clé validée",
        awaitingVerification = "En attente de vérification",
        verifyingKey = "Vérification de la clé...",
        enterKey = "Veuillez entrer une clé",
        invalidFormat = "Format de clé invalide (CARBON_)",
        invalidKey = "Clé invalide!",
        keyVerified = "Clé vérifiée!",
        keyLinkCopied = "Lien de clé copié!",
        discordCopied = "Lien Discord copié!",
        gameIdCopied = "ID du jeu copié!",
        game = "JEU",
        executor = "EXÉCUTEUR",
        status = "STATUT",
        quickActions = "ACTIONS RAPIDES",
        discord = "Discord",
        copyGameId = "Copier ID du Jeu",
        helpTitle = "Comment Obtenir la Clé",
        helpStep1 = "1. Cliquez sur 'Obtenir la Clé'",
        helpStep2 = "2. Complétez la vérification",
        helpStep3 = "3. Copiez votre clé et collez-la ici",
        helpStep4 = "4. En cas de problème, rejoignez Discord",
    },
}

local function getText(key)
    return LANGUAGES[CURRENT_LANGUAGE][key] or LANGUAGES["en"][key]
end

-- =========================
-- NOTIFICATION SYSTEM
-- =========================
local function createNotification(message, duration, color)
    local NotifGui = Instance.new("ScreenGui")
    NotifGui.Name = "CarbonNotification"
    NotifGui.ResetOnSpawn = false
    NotifGui.Parent = game.CoreGui
    
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 300, 0, 60)
    NotifFrame.Position = UDim2.new(1, 10, 0, 20)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = NotifGui
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = NotifFrame
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = color or Color3.fromRGB(70, 70, 80)
    NotifStroke.Thickness = 1.5
    NotifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    NotifStroke.Parent = NotifFrame
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 1, 0)
    NotifText.Position = UDim2.new(0, 10, 0, 0)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = message
    NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.GothamMedium
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.Parent = NotifFrame
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(1, -310, 0, 20)}):Play()
    
    task.wait(duration or 3)
    TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 0, 20)}):Play()
    task.wait(0.3)
    NotifGui:Destroy()
end

-- =========================
-- HWID
-- =========================
local function getHWID()
    local success, hwid = pcall(gethwid)
    if success and hwid then
        return hwid
    end
    local analytics = game:GetService("RbxAnalyticsService")
    return analytics:GetClientId():gsub("-", "")
end

-- =========================
-- API FUNCTIONS
-- =========================
local function post(endpoint, body)
    local res = request({
        Url = CONFIG.BASE_URL .. endpoint,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode(body)
    })

    if not res or not res.Body then
        return nil
    end

    return HttpService:JSONDecode(res.Body)
end

local function GetKeyURL()
    return "https://new.pandadevelopment.net/getkey/" .. CONFIG.SERVICE_ID .. "?hwid=" .. getHWID()
end

local function OpenGetKey()
    local url = GetKeyURL()
    if setclipboard then
        setclipboard(url)
    end
    return url
end

local function ValidateKey(key)
    local response = post("/keys/validate", {
        ServiceID = CONFIG.SERVICE_ID,
        HWID = getHWID(),
        Key = key
    })

    if not response then
        return false, "Failed to connect to server"
    end

    if response.Authenticated_Status ~= "Success" then
        return false, response.Note or "Invalid key"
    end

    return true, {
        premium = response.Key_Premium or false,
        expires = response.Expire_Date
    }
end

-- =========================
-- DRAG FUNCTIONALITY
-- =========================
local function makeDraggable(frame)
    local dragToggle = nil
    local dragSpeed = 0
    local dragStart = nil
    local startPos = nil

    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
    end

    frame.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragToggle then
                updateInput(input)
            end
        end
    end)
end

-- =========================
-- MAIN KEY SYSTEM
-- =========================
local KeySystemGui = Instance.new("ScreenGui")
KeySystemGui.Name = "CarbonKeySystem"
KeySystemGui.Parent = PlayerGui
KeySystemGui.ResetOnSpawn = false
KeySystemGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 480, 0, 270)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = KeySystemGui

makeDraggable(MainFrame)

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 0, 0)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 8, 8)
CloseBtn.BackgroundTransparency = 0.1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 205)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 13
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 10
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(0, 0, 0)
CloseStroke.Thickness = 1
CloseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CloseStroke.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 60)}):Play()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 8, 8)}):Play()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 205)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    KeySystemGui:Destroy()
    player:Kick("❌ Key system closed")
end)

-- Logo Icon
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 32, 0, 32)
LogoFrame.Position = UDim2.new(0, 16, 0, 16)
LogoFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
LogoFrame.BackgroundTransparency = 0.05
LogoFrame.BorderSizePixel = 0
LogoFrame.Parent = MainFrame

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 10)
LogoCorner.Parent = LogoFrame

local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(0, 0, 0)
LogoStroke.Thickness = 1
LogoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LogoStroke.Parent = LogoFrame

local LogoImage = Instance.new("ImageLabel")
LogoImage.Size = UDim2.new(1, 0, 1, 0)
LogoImage.BackgroundTransparency = 1
LogoImage.Image = "rbxassetid://118658650540082"
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.Parent = LogoFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 0, 20)
Title.Position = UDim2.new(0, 56, 0, 18)
Title.BackgroundTransparency = 1
Title.Text = getText("title")
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 250, 0, 14)
Subtitle.Position = UDim2.new(0, 56, 0, 36)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = getText("subtitle")
Subtitle.TextColor3 = Color3.fromRGB(120, 120, 130)
Subtitle.TextSize = 9
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = MainFrame

-- Help Panel
local HelpPanel = Instance.new("Frame")
HelpPanel.Size = UDim2.new(0, 220, 0, 140)
HelpPanel.Position = UDim2.new(1, -230, 0, 10)
HelpPanel.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
HelpPanel.BackgroundTransparency = 0.15
HelpPanel.BorderSizePixel = 0
HelpPanel.Active = true
HelpPanel.Parent = KeySystemGui

makeDraggable(HelpPanel)

local HelpCorner = Instance.new("UICorner")
HelpCorner.CornerRadius = UDim.new(0, 12)
HelpCorner.Parent = HelpPanel

local HelpStroke = Instance.new("UIStroke")
HelpStroke.Color = Color3.fromRGB(0, 0, 0)
HelpStroke.Thickness = 2
HelpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
HelpStroke.Parent = HelpPanel

local HelpTitle = Instance.new("TextLabel")
HelpTitle.Size = UDim2.new(1, -20, 0, 18)
HelpTitle.Position = UDim2.new(0, 10, 0, 8)
HelpTitle.BackgroundTransparency = 1
HelpTitle.Text = getText("helpTitle")
HelpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HelpTitle.TextSize = 11
HelpTitle.Font = Enum.Font.GothamBold
HelpTitle.TextXAlignment = Enum.TextXAlignment.Left
HelpTitle.Parent = HelpPanel

local HelpSteps = Instance.new("TextLabel")
HelpSteps.Size = UDim2.new(1, -20, 0, 75)
HelpSteps.Position = UDim2.new(0, 10, 0, 30)
HelpSteps.BackgroundTransparency = 1
HelpSteps.Text = getText("helpStep1") .. "\n" .. getText("helpStep2") .. "\n" .. getText("helpStep3") .. "\n" .. getText("helpStep4")
HelpSteps.TextColor3 = Color3.fromRGB(180, 180, 190)
HelpSteps.TextSize = 10
HelpSteps.Font = Enum.Font.Gotham
HelpSteps.TextXAlignment = Enum.TextXAlignment.Left
HelpSteps.TextYAlignment = Enum.TextYAlignment.Top
HelpSteps.TextWrapped = true
HelpSteps.Parent = HelpPanel

-- Language Label
local LangLabel = Instance.new("TextLabel")
LangLabel.Size = UDim2.new(1, -20, 0, 12)
LangLabel.Position = UDim2.new(0, 10, 0, 108)
LangLabel.BackgroundTransparency = 1
LangLabel.Text = "Language:"
LangLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
LangLabel.TextSize = 9
LangLabel.Font = Enum.Font.GothamBold
LangLabel.TextXAlignment = Enum.TextXAlignment.Left
LangLabel.Parent = HelpPanel

-- Language Selector
local LangSelector = Instance.new("TextButton")
LangSelector.Size = UDim2.new(1, -20, 0, 18)
LangSelector.Position = UDim2.new(0, 10, 1, -24)
LangSelector.BackgroundColor3 = Color3.fromRGB(20, 7, 7)
LangSelector.BackgroundTransparency = 0.05
LangSelector.Text = ""
LangSelector.AutoButtonColor = false
LangSelector.Parent = HelpPanel

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 6)
LangCorner.Parent = LangSelector

local LangStroke = Instance.new("UIStroke")
LangStroke.Color = Color3.fromRGB(0, 0, 0)
LangStroke.Thickness = 1
LangStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LangStroke.Parent = LangSelector

local LangText = Instance.new("TextLabel")
LangText.Size = UDim2.new(1, -24, 1, 0)
LangText.Position = UDim2.new(0, 8, 0, 0)
LangText.BackgroundTransparency = 1
LangText.Text = "English"
LangText.TextColor3 = Color3.fromRGB(200, 200, 210)
LangText.TextSize = 10
LangText.Font = Enum.Font.GothamMedium
LangText.TextXAlignment = Enum.TextXAlignment.Left
LangText.Parent = LangSelector

local LangArrow = Instance.new("TextLabel")
LangArrow.Size = UDim2.new(0, 14, 1, 0)
LangArrow.Position = UDim2.new(1, -16, 0, 0)
LangArrow.BackgroundTransparency = 1
LangArrow.Text = "▼"
LangArrow.TextColor3 = Color3.fromRGB(150, 150, 160)
LangArrow.TextSize = 8
LangArrow.Font = Enum.Font.GothamMedium
LangArrow.Parent = LangSelector

-- Content Container
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -32, 1, -70)
ContentFrame.Position = UDim2.new(0, 16, 0, 58)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Left Panel
local LeftPanel = Instance.new("Frame")
LeftPanel.Size = UDim2.new(0, 185, 1, 0)
LeftPanel.Position = UDim2.new(0, 0, 0, 0)
LeftPanel.BackgroundColor3 = Color3.fromRGB(25, 8, 8)
LeftPanel.BackgroundTransparency = 0.1
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = ContentFrame

local LeftCorner = Instance.new("UICorner")
LeftCorner.CornerRadius = UDim.new(0, 12)
LeftCorner.Parent = LeftPanel

local LeftStroke = Instance.new("UIStroke")
LeftStroke.Color = Color3.fromRGB(0, 0, 0)
LeftStroke.Thickness = 1.5
LeftStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
LeftStroke.Parent = LeftPanel

-- Game Section
local GameLabel = Instance.new("TextLabel")
GameLabel.Size = UDim2.new(1, -20, 0, 10)
GameLabel.Position = UDim2.new(0, 10, 0, 10)
GameLabel.BackgroundTransparency = 1
GameLabel.Text = getText("game")
GameLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
GameLabel.TextSize = 8
GameLabel.Font = Enum.Font.GothamBold
GameLabel.TextXAlignment = Enum.TextXAlignment.Left
GameLabel.Parent = LeftPanel

local GameValue = Instance.new("Frame")
GameValue.Size = UDim2.new(1, -20, 0, 38)
GameValue.Position = UDim2.new(0, 10, 0, 24)
GameValue.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
GameValue.BackgroundTransparency = 0.05
GameValue.BorderSizePixel = 0
GameValue.Parent = LeftPanel

local GameValueCorner = Instance.new("UICorner")
GameValueCorner.CornerRadius = UDim.new(0, 10)
GameValueCorner.Parent = GameValue

local GameValueStroke = Instance.new("UIStroke")
GameValueStroke.Color = Color3.fromRGB(0, 0, 0)
GameValueStroke.Thickness = 1
GameValueStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GameValueStroke.Parent = GameValue

local GameValueText = Instance.new("TextLabel")
GameValueText.Size = UDim2.new(1, -16, 1, 0)
GameValueText.Position = UDim2.new(0, 8, 0, 0)
GameValueText.BackgroundTransparency = 1
GameValueText.Text = gameName
GameValueText.TextColor3 = Color3.fromRGB(255, 255, 255)
GameValueText.TextSize = 11
GameValueText.Font = Enum.Font.GothamBold
GameValueText.TextXAlignment = Enum.TextXAlignment.Left
GameValueText.TextYAlignment = Enum.TextYAlignment.Center
GameValueText.TextTruncate = Enum.TextTruncate.AtEnd
GameValueText.Parent = GameValue

-- Divider
local Divider1 = Instance.new("Frame")
Divider1.Size = UDim2.new(1, -20, 0, 1)
Divider1.Position = UDim2.new(0, 10, 0, 70)
Divider1.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
Divider1.BorderSizePixel = 0
Divider1.Parent = LeftPanel

-- Executor Section
local ExecLabel = Instance.new("TextLabel")
ExecLabel.Size = UDim2.new(1, -20, 0, 10)
ExecLabel.Position = UDim2.new(0, 10, 0, 78)
ExecLabel.BackgroundTransparency = 1
ExecLabel.Text = getText("executor")
ExecLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
ExecLabel.TextSize = 8
ExecLabel.Font = Enum.Font.GothamBold
ExecLabel.TextXAlignment = Enum.TextXAlignment.Left
ExecLabel.Parent = LeftPanel

local ExecValueFrame = Instance.new("Frame")
ExecValueFrame.Size = UDim2.new(1, -20, 0, 32)
ExecValueFrame.Position = UDim2.new(0, 10, 0, 92)
ExecValueFrame.BackgroundColor3 = Color3.fromRGB(20, 7, 7)
ExecValueFrame.BackgroundTransparency = 0.05
ExecValueFrame.BorderSizePixel = 0
ExecValueFrame.Parent = LeftPanel

local ExecFrameCorner = Instance.new("UICorner")
ExecFrameCorner.CornerRadius = UDim.new(0, 10)
ExecFrameCorner.Parent = ExecValueFrame

local ExecFrameStroke = Instance.new("UIStroke")
ExecFrameStroke.Color = Color3.fromRGB(0, 0, 0)
ExecFrameStroke.Thickness = 1
ExecFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ExecFrameStroke.Parent = ExecValueFrame

local ExecValue = Instance.new("TextLabel")
ExecValue.Size = UDim2.new(1, -16, 1, 0)
ExecValue.Position = UDim2.new(0, 8, 0, 0)
ExecValue.BackgroundTransparency = 1
ExecValue.Text = identifyexecutor and identifyexecutor() or "Unknown"
ExecValue.TextColor3 = Color3.fromRGB(210, 210, 225)
ExecValue.TextSize = 11
ExecValue.Font = Enum.Font.GothamMedium
ExecValue.TextXAlignment = Enum.TextXAlignment.Left
ExecValue.TextYAlignment = Enum.TextYAlignment.Center
ExecValue.Parent = ExecValueFrame

-- Divider 2
local Divider2 = Instance.new("Frame")
Divider2.Size = UDim2.new(1, -20, 0, 1)
Divider2.Position = UDim2.new(0, 10, 0, 132)
Divider2.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
Divider2.BorderSizePixel = 0
Divider2.Parent = LeftPanel

-- Status Section
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 10)
StatusLabel.Position = UDim2.new(0, 10, 0, 140)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = getText("status")
StatusLabel.TextColor3 = Color3.fromRGB(130, 130, 145)
StatusLabel.TextSize = 8
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = LeftPanel

local StatusBox = Instance.new("Frame")
StatusBox.Size = UDim2.new(1, -20, 0, 36)
StatusBox.Position = UDim2.new(0, 10, 0, 154)
StatusBox.BackgroundColor3 = Color3.fromRGB(20, 7, 7)
StatusBox.BackgroundTransparency = 0.05
StatusBox.BorderSizePixel = 0
StatusBox.Parent = LeftPanel

local StatusBoxCorner = Instance.new("UICorner")
StatusBoxCorner.CornerRadius = UDim.new(0, 10)
StatusBoxCorner.Parent = StatusBox

local StatusBoxStroke = Instance.new("UIStroke")
StatusBoxStroke.Color = Color3.fromRGB(0, 0, 0)
StatusBoxStroke.Thickness = 1
StatusBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
StatusBoxStroke.Parent = StatusBox

local StatusIndicator = Instance.new("Frame")
StatusIndicator.Size = UDim2.new(0, 6, 0, 6)
StatusIndicator.Position = UDim2.new(0, 10, 0.5, -3)
StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
StatusIndicator.BorderSizePixel = 0
StatusIndicator.Parent = StatusBox

local StatusIndicatorCorner = Instance.new("UICorner")
StatusIndicatorCorner.CornerRadius = UDim.new(1, 0)
StatusIndicatorCorner.Parent = StatusIndicator

local pulseIn = TweenService:Create(StatusIndicator, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.3})
pulseIn:Play()

local StatusValue = Instance.new("TextLabel")
StatusValue.Size = UDim2.new(1, -28, 1, 0)
StatusValue.Position = UDim2.new(0, 22, 0, 0)
StatusValue.BackgroundTransparency = 1
StatusValue.Text = getText("awaitingVerification")
StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
StatusValue.TextSize = 10
StatusValue.Font = Enum.Font.GothamBold
StatusValue.TextXAlignment = Enum.TextXAlignment.Left
StatusValue.TextYAlignment = Enum.TextYAlignment.Center
StatusValue.Parent = StatusBox

-- Right Panel
local RightPanel = Instance.new("Frame")
RightPanel.Size = UDim2.new(0, 240, 1, 0)
RightPanel.Position = UDim2.new(0, 199, 0, 0)
RightPanel.BackgroundTransparency = 1
RightPanel.Parent = ContentFrame

-- Instructions
local Instructions = Instance.new("TextLabel")
Instructions.Size = UDim2.new(1, -8, 0, 22)
Instructions.Position = UDim2.new(0, 0, 0, 2)
Instructions.BackgroundTransparency = 1
Instructions.Text = getText("instructions")
Instructions.TextColor3 = Color3.fromRGB(140, 140, 150)
Instructions.TextSize = 10
Instructions.Font = Enum.Font.Gotham
Instructions.TextXAlignment = Enum.TextXAlignment.Left
Instructions.TextWrapped = true
Instructions.Parent = RightPanel

-- Key Input Container
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, -8, 0, 36)
InputContainer.Position = UDim2.new(0, 0, 0, 28)
InputContainer.BackgroundColor3 = Color3.fromRGB(20, 7, 7)
InputContainer.BackgroundTransparency = 0.05
InputContainer.BorderSizePixel = 0
InputContainer.Parent = RightPanel

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = InputContainer

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(0, 0, 0)
InputStroke.Thickness = 1.5
InputStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
InputStroke.Parent = InputContainer

-- Key Input
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -16, 1, 0)
KeyInput.Position = UDim2.new(0, 8, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Text = ""
KeyInput.PlaceholderText = "Paste CARBON_ key..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(70, 70, 80)
KeyInput.TextColor3 = Color3.fromRGB(220, 220, 230)
KeyInput.TextSize = 11
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = InputContainer

pcall(function()
    if isfile("carbon_key.txt") then
        KeyInput.Text = readfile("carbon_key.txt")
    end
end)

KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(70, 70, 80)}):Play()
end)

KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 0, 0)}):Play()
end)

-- Check Button
local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(1, -8, 0, 32)
CheckBtn.Position = UDim2.new(0, 0, 0, 70)
CheckBtn.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
CheckBtn.BackgroundTransparency = 0.05
CheckBtn.Text = getText("checkBtn")
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 11
CheckBtn.AutoButtonColor = false
CheckBtn.Parent = RightPanel

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 10)
CheckCorner.Parent = CheckBtn

local CheckBtnStroke = Instance.new("UIStroke")
CheckBtnStroke.Color = Color3.fromRGB(0, 0, 0)
CheckBtnStroke.Thickness = 1.5
CheckBtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
CheckBtnStroke.Parent = CheckBtn

CheckBtn.MouseEnter:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 10, 10)}):Play()
end)

CheckBtn.MouseLeave:Connect(function()
    TweenService:Create(CheckBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 5, 5)}):Play()
end)

-- Actions Label
local ActionsLabel = Instance.new("TextLabel")
ActionsLabel.Size = UDim2.new(1, -8, 0, 16)
ActionsLabel.Position = UDim2.new(0, 0, 0, 110)
ActionsLabel.BackgroundTransparency = 1
ActionsLabel.Text = getText("quickActions")
ActionsLabel.TextColor3 = Color3.fromRGB(100, 100, 110)
ActionsLabel.TextSize = 9
ActionsLabel.Font = Enum.Font.GothamBold
ActionsLabel.TextXAlignment = Enum.TextXAlignment.Left
ActionsLabel.Parent = RightPanel

-- Actions Container
local ActionsContainer = Instance.new("Frame")
ActionsContainer.Size = UDim2.new(1, -8, 0, 64)
ActionsContainer.Position = UDim2.new(0, 0, 0, 132)
ActionsContainer.BackgroundColor3 = Color3.fromRGB(18, 6, 6)
ActionsContainer.BackgroundTransparency = 0.05
ActionsContainer.BorderSizePixel = 0
ActionsContainer.Parent = RightPanel

local ActionsCorner = Instance.new("UICorner")
ActionsCorner.CornerRadius = UDim.new(0, 10)
ActionsCorner.Parent = ActionsContainer

local ActionsStroke = Instance.new("UIStroke")
ActionsStroke.Color = Color3.fromRGB(0, 0, 0)
ActionsStroke.Thickness = 1.5
ActionsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ActionsStroke.Parent = ActionsContainer

-- Action Buttons
local function createActionBtn(text, posX, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 108, 0, 26)
    btn.Position = UDim2.new(0, posX, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(20, 7, 7)
    btn.BackgroundTransparency = 0.05
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = ActionsContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 0, 0)
    stroke.Thickness = 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = btn
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.Position = UDim2.new(0, 0, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    textLabel.TextSize = 10
    textLabel.Font = Enum.Font.GothamMedium
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 12, 12)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(20, 0, 0)}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 7, 7)}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.15), {Color = Color3.fromRGB(0, 0, 0)}):Play()
    end)
    
    return btn
end

local GetKeyBtn = createActionBtn(getText("getKeyBtn"), 6, 6)
local DiscordBtn = createActionBtn(getText("discord"), 120, 6)
local CopyGameBtn = createActionBtn(getText("copyGameId"), 6, 36)

-- Button Actions
GetKeyBtn.MouseButton1Click:Connect(function()
    OpenGetKey()
    StatusValue.Text = getText("keyLinkCopied")
    StatusValue.TextColor3 = Color3.fromRGB(100, 170, 255)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(100, 170, 255)
    task.spawn(function()
        createNotification(getText("keyLinkCopied"), 2.5, Color3.fromRGB(100, 170, 255))
    end)
    task.wait(2.5)
    StatusValue.Text = getText("awaitingVerification")
    StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
end)

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(CONFIG.DISCORD_URL)
        StatusValue.Text = getText("discordCopied")
        StatusValue.TextColor3 = Color3.fromRGB(50, 220, 130)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(50, 220, 130)
        task.spawn(function()
            createNotification(getText("discordCopied"), 2.5, Color3.fromRGB(50, 220, 130))
        end)
        task.wait(2.5)
        StatusValue.Text = getText("awaitingVerification")
        StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    end
end)

CopyGameBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(tostring(game.PlaceId))
        StatusValue.Text = getText("gameIdCopied")
        StatusValue.TextColor3 = Color3.fromRGB(50, 220, 130)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(50, 220, 130)
        task.spawn(function()
            createNotification(getText("gameIdCopied"), 2.5, Color3.fromRGB(50, 220, 130))
        end)
        task.wait(2.5)
        StatusValue.Text = getText("awaitingVerification")
        StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    end
end)

-- Language Selector
local languages = {
    {code = "en", name = "English"},
    {code = "es", name = "Español"},
    {code = "fr", name = "Français"},
}
local currentLangIndex = 1

LangSelector.MouseButton1Click:Connect(function()
    currentLangIndex = currentLangIndex % #languages + 1
    local selected = languages[currentLangIndex]
    CURRENT_LANGUAGE = selected.code
    LangText.Text = selected.name
    
    -- Update all text
    Title.Text = getText("title")
    Subtitle.Text = getText("subtitle")
    Instructions.Text = getText("instructions")
    CheckBtn.Text = getText("checkBtn")
    GameLabel.Text = getText("game")
    ExecLabel.Text = getText("executor")
    StatusLabel.Text = getText("status")
    ActionsLabel.Text = getText("quickActions")
    HelpTitle.Text = getText("helpTitle")
    HelpSteps.Text = getText("helpStep1") .. "\n" .. getText("helpStep2") .. "\n" .. getText("helpStep3") .. "\n" .. getText("helpStep4")
    
    GetKeyBtn:FindFirstChildOfClass("TextLabel").Text = getText("getKeyBtn")
    DiscordBtn:FindFirstChildOfClass("TextLabel").Text = getText("discord")
    CopyGameBtn:FindFirstChildOfClass("TextLabel").Text = getText("copyGameId")
    
    task.spawn(function()
        createNotification("Language changed to " .. selected.name, 2, Color3.fromRGB(100, 170, 255))
    end)
end)

-- =========================
-- VALIDATION LOGIC
-- =========================
local busy = false
local validated = false

CheckBtn.MouseButton1Click:Connect(function()
    if busy then return end
    busy = true
    
    local key = KeyInput.Text
    
    if key == "" then
        StatusValue.Text = getText("enterKey")
        StatusValue.TextColor3 = Color3.fromRGB(255, 80, 90)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 80, 90)
        task.spawn(function()
            createNotification(getText("enterKey"), 2, Color3.fromRGB(255, 80, 90))
        end)
        busy = false
        return
    end
    
    if not key:match("^" .. CONFIG.KEY_PREFIX) then
        StatusValue.Text = getText("invalidFormat")
        StatusValue.TextColor3 = Color3.fromRGB(255, 80, 90)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 80, 90)
        task.spawn(function()
            createNotification(getText("invalidFormat"), 2, Color3.fromRGB(255, 80, 90))
        end)
        busy = false
        return
    end
    
    StatusValue.Text = getText("verifyingKey")
    StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    CheckBtn.Text = "..."
    
    local ok, data = ValidateKey(key)
    
    if ok then
        pulseIn:Cancel()
        StatusValue.Text = getText("keyVerified")
        StatusValue.TextColor3 = Color3.fromRGB(50, 220, 130)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(50, 220, 130)
        StatusIndicator.BackgroundTransparency = 0
        CheckBtn.Text = getText("keyValidated")
        
        -- Green effect
        TweenService:Create(InputContainer, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 80, 50)}):Play()
        TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(50, 220, 130)}):Play()
        TweenService:Create(InputStroke, TweenInfo.new(0.3), {Thickness = 2}):Play()
        
        task.spawn(function()
            createNotification(getText("keyVerified"), 2, Color3.fromRGB(50, 220, 130))
        end)
        
        pcall(function()
            writefile("carbon_key.txt", key)
        end)
        
        validated = true
        
        task.wait(1)
        
        -- Destroy everything
        KeySystemGui:Destroy()
        
    else
        StatusValue.Text = data
        StatusValue.TextColor3 = Color3.fromRGB(255, 80, 90)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 80, 90)
        CheckBtn.Text = getText("checkBtn")
        KeyInput.Text = ""
        
        task.spawn(function()
            createNotification(getText("invalidKey") .. " " .. data, 3, Color3.fromRGB(255, 80, 90))
        end)
        
        -- Shake animation
        local originalPos = MainFrame.Position
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = UDim2.new(0.5, -10, 0.5, 0)}):Play()
        task.wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = UDim2.new(0.5, 10, 0.5, 0)}):Play()
        task.wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = UDim2.new(0.5, -10, 0.5, 0)}):Play()
        task.wait(0.05)
        TweenService:Create(MainFrame, TweenInfo.new(0.05), {Position = originalPos}):Play()
        
        task.wait(2)
        StatusValue.Text = getText("awaitingVerification")
        StatusValue.TextColor3 = Color3.fromRGB(255, 200, 50)
        StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
    end
    
    task.wait(0.5)
    busy = false
end)

-- =========================
-- WAIT FOR VALIDATION
-- =========================
print("🔐 Carbon Studios - Key System Loaded")

while not validated and KeySystemGui.Parent do
    task.wait(0.1)
end

if not validated then
    return
end

print("✅ Key validated - Loading main script...")

-- 🚀 MAIN SCRIPT STARTS HERE
loadstring(game:HttpGet("https://raw.githubusercontent.com/CStudios-Dev/csLoader.lua/main/CSLoader.lua"))()
