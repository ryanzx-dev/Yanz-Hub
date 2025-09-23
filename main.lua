do
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local ProximityPromptService = game:GetService("ProximityPromptService")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local Yanz = {
        Console = {
            print = rconsoleprint or print,
            clear = rconsoleclear or function() end,
            info = rconsoleinfo or print,
            error = rconsoleerror or print,
            name = rconsolename or function() end
        },
        FileSystem = {
            write = writefile or function() end,
            read = readfile or function() end,
            exists = isfile or function() return false; end,
            makefolder = makefolder or function() end
        },
        Drawing = {
            new = (Drawing and Drawing.new) or function() return {}; end
        }
    }

    Yanz.Console.name("Yanz Hub")
    Yanz.Console.clear()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "YanzHub"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 650, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -325, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame

    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 35)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 8)
    titleCorner.Parent = titleBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 15, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "YANZ HUB"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = titleBar

    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "SubtitleLabel"
    subtitleLabel.Size = UDim2.new(0, 60, 0, 15)
    subtitleLabel.Position = UDim2.new(0, 220, 0, 10)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = "by yanz"
    subtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitleLabel.TextScaled = true
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.Parent = titleBar

    local rainbowHue = 0
    local rainbowConnection
    rainbowConnection = RunService.Heartbeat:Connect(function()
        rainbowHue = (rainbowHue + 0.01) % 1
        local color = Color3.fromHSV(rainbowHue, 1, 1)
        local subtitleColor = Color3.fromHSV(rainbowHue, 0.8, 0.9)
        titleLabel.TextColor3 = color
        subtitleLabel.TextColor3 = subtitleColor
    end)

    local function cleanupRainbow()
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
    end

    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 25, 0, 25)
    minimizeButton.Position = UDim2.new(1, -60, 0, 5)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    minimizeButton.BorderSizePixel = 0
    minimizeButton.Text = "−"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.TextScaled = true
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.Parent = titleBar

    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 12)
    minimizeCorner.Parent = minimizeButton

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -30, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 12)
    closeCorner.Parent = closeButton

    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -20, 1, -55)
    contentFrame.Position = UDim2.new(0, 10, 0, 45)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame

    local miscPanel = Instance.new("Frame")
    miscPanel.Name = "MiscPanel"
    miscPanel.Size = UDim2.new(0.2, -5, 1, 0)
    miscPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    miscPanel.BorderSizePixel = 0
    miscPanel.Parent = contentFrame

    local miscCorner = Instance.new("UICorner")
    miscCorner.CornerRadius = UDim.new(0, 6)
    miscCorner.Parent = miscPanel

    local miscTitle = Instance.new("TextLabel")
    miscTitle.Name = "MiscTitle"
    miscTitle.Size = UDim2.new(1, 0, 0, 25)
    miscTitle.BackgroundTransparency = 1
    miscTitle.Text = "Misc"
    miscTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    miscTitle.TextScaled = true
    miscTitle.Font = Enum.Font.GothamBold
    miscTitle.Parent = miscPanel

    local serverHopButton = Instance.new("TextButton")
    serverHopButton.Name = "ServerHopButton"
    serverHopButton.Size = UDim2.new(1, -10, 0, 25)
    serverHopButton.Position = UDim2.new(0, 5, 0, 30)
    serverHopButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    serverHopButton.BorderSizePixel = 0
    serverHopButton.Text = "Server Hop"
    serverHopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    serverHopButton.TextScaled = true
    serverHopButton.Font = Enum.Font.GothamBold
    serverHopButton.Parent = miscPanel

    local serverHopCorner = Instance.new("UICorner")
    serverHopCorner.CornerRadius = UDim.new(0, 6)
    serverHopCorner.Parent = serverHopButton

    local tpSelectedBaseButton = Instance.new("TextButton")
    tpSelectedBaseButton.Name = "TpSelectedBaseButton"
    tpSelectedBaseButton.Size = UDim2.new(1, -10, 0, 25)
    tpSelectedBaseButton.Position = UDim2.new(0, 5, 0, 60)
    tpSelectedBaseButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    tpSelectedBaseButton.BorderSizePixel = 0
    tpSelectedBaseButton.Text = "Tp To Selected Base"
    tpSelectedBaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpSelectedBaseButton.TextScaled = true
    tpSelectedBaseButton.Font = Enum.Font.GothamBold
    tpSelectedBaseButton.Parent = miscPanel

    local tpSelectedBaseCorner = Instance.new("UICorner")
    tpSelectedBaseCorner.CornerRadius = UDim.new(0, 6)
    tpSelectedBaseCorner.Parent = tpSelectedBaseButton

    local tpYourBaseButton = Instance.new("TextButton")
    tpYourBaseButton.Name = "TpYourBaseButton"
    tpYourBaseButton.Size = UDim2.new(1, -10, 0, 25)
    tpYourBaseButton.Position = UDim2.new(0, 5, 0, 90)
    tpYourBaseButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    tpYourBaseButton.BorderSizePixel = 0
    tpYourBaseButton.Text = "Tp To Your Base"
    tpYourBaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpYourBaseButton.TextScaled = true
    tpYourBaseButton.Font = Enum.Font.GothamBold
    tpYourBaseButton.Parent = miscPanel

    local tpYourBaseCorner = Instance.new("UICorner")
    tpYourBaseCorner.CornerRadius = UDim.new(0, 6)
    tpYourBaseCorner.Parent = tpYourBaseButton

    local infiniteYieldButton = Instance.new("TextButton")
    infiniteYieldButton.Name = "InfiniteYieldButton"
    infiniteYieldButton.Size = UDim2.new(1, -10, 0, 25)
    infiniteYieldButton.Position = UDim2.new(0, 5, 0, 120)
    infiniteYieldButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    infiniteYieldButton.BorderSizePixel = 0
    infiniteYieldButton.Text = "Infinite Yield"
    infiniteYieldButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    infiniteYieldButton.TextScaled = true
    infiniteYieldButton.Font = Enum.Font.GothamBold
    infiniteYieldButton.Parent = miscPanel

    local infiniteYieldCorner = Instance.new("UICorner")
    infiniteYieldCorner.CornerRadius = UDim.new(0, 6)
    infiniteYieldCorner.Parent = infiniteYieldButton

    local leftPanel = Instance.new("Frame")
    leftPanel.Name = "LeftPanel"
    leftPanel.Size = UDim2.new(0.4, -5, 1, 0)
    leftPanel.Position = UDim2.new(0.2, 5, 0, 0)
    leftPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    leftPanel.BorderSizePixel = 0
    leftPanel.Parent = contentFrame

    local leftCorner = Instance.new("UICorner")
    leftCorner.CornerRadius = UDim.new(0, 6)
    leftCorner.Parent = leftPanel

    local leftTitle = Instance.new("TextLabel")
    leftTitle.Name = "LeftTitle"
    leftTitle.Size = UDim2.new(1, 0, 0, 25)
    leftTitle.BackgroundTransparency = 1
    leftTitle.Text = "Bases"
    leftTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    leftTitle.TextScaled = true
    leftTitle.Font = Enum.Font.GothamBold
    leftTitle.Parent = leftPanel

    local basesList = Instance.new("ScrollingFrame")
    basesList.Name = "BasesList"
    basesList.Size = UDim2.new(1, -10, 1, -35)
    basesList.Position = UDim2.new(0, 5, 0, 30)
    basesList.BackgroundTransparency = 1
    basesList.BorderSizePixel = 0
    basesList.ScrollBarThickness = 6
    basesList.Parent = leftPanel

    local rightPanel = Instance.new("Frame")
    rightPanel.Name = "RightPanel"
    rightPanel.Size = UDim2.new(0.4, 0, 1, 0)
    rightPanel.Position = UDim2.new(0.6, 0, 0, 0)
    rightPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    rightPanel.BorderSizePixel = 0
    rightPanel.Parent = contentFrame

    local rightCorner = Instance.new("UICorner")
    rightCorner.CornerRadius = UDim.new(0, 6)
    rightCorner.Parent = rightPanel

    local rightTitle = Instance.new("TextLabel")
    rightTitle.Name = "RightTitle"
    rightTitle.Size = UDim2.new(1, 0, 0, 25)
    rightTitle.BackgroundTransparency = 1
    rightTitle.Text = "NPCs"
    rightTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    rightTitle.TextScaled = true
    rightTitle.Font = Enum.Font.GothamBold
    rightTitle.Parent = rightPanel

    local searchBox = Instance.new("TextBox")
    searchBox.Name = "SearchBox"
    searchBox.Size = UDim2.new(1, -10, 0, 25)
    searchBox.Position = UDim2.new(0, 5, 0, 30)
    searchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    searchBox.BorderSizePixel = 0
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.TextScaled = true
    searchBox.Font = Enum.Font.Gotham
    searchBox.PlaceholderText = "Search..."
    searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    searchBox.Parent = rightPanel

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 4)
    searchCorner.Parent = searchBox

    local npcsList = Instance.new("ScrollingFrame")
    npcsList.Name = "NPCsList"
    npcsList.Size = UDim2.new(1, -10, 1, -160)
    npcsList.Position = UDim2.new(0, 5, 0, 60)
    npcsList.BackgroundTransparency = 1
    npcsList.BorderSizePixel = 0
    npcsList.ScrollBarThickness = 6
    npcsList.Parent = rightPanel

    local quickStealButton = Instance.new("TextButton")
    quickStealButton.Name = "QuickStealButton"
    quickStealButton.Size = UDim2.new(0, 120, 0, 25)
    quickStealButton.Position = UDim2.new(0, 5, 1, -90)
    quickStealButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    quickStealButton.BorderSizePixel = 0
    quickStealButton.Text = "Quick Steal"
    quickStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    quickStealButton.TextScaled = true
    quickStealButton.Font = Enum.Font.GothamBold
    quickStealButton.Active = false
    quickStealButton.Parent = rightPanel

    local quickStealCorner = Instance.new("UICorner")
    quickStealCorner.CornerRadius = UDim.new(0, 6)
    quickStealCorner.Parent = quickStealButton

    local activateButton = Instance.new("TextButton")
    activateButton.Name = "ActivateButton"
    activateButton.Size = UDim2.new(0, 120, 0, 25)
    activateButton.Position = UDim2.new(1, -125, 1, -90)
    activateButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    activateButton.BorderSizePixel = 0
    activateButton.Text = "Tp To Npc"
    activateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    activateButton.TextScaled = true
    activateButton.Font = Enum.Font.GothamBold
    activateButton.Active = false
    activateButton.Parent = rightPanel

    local activateCorner = Instance.new("UICorner")
    activateCorner.CornerRadius = UDim.new(0, 6)
    activateCorner.Parent = activateButton

    local selectionInfo = Instance.new("TextLabel")
    selectionInfo.Name = "SelectionInfo"
    selectionInfo.Size = UDim2.new(1, -10, 0, 20)
    selectionInfo.Position = UDim2.new(0, 5, 1, -25)
    selectionInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    selectionInfo.BorderSizePixel = 0
    selectionInfo.Text = "No NPC selected"
    selectionInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    selectionInfo.TextScaled = true
    selectionInfo.Font = Enum.Font.Gotham
    selectionInfo.Parent = rightPanel

    local selectionCorner = Instance.new("UICorner")
    selectionCorner.CornerRadius = UDim.new(0, 4)
    selectionCorner.Parent = selectionInfo

    local autoClaimFrame = Instance.new("Frame")
    autoClaimFrame.Name = "AutoClaimFrame"
    autoClaimFrame.Size = UDim2.new(0, 250, 0, 30)
    autoClaimFrame.Position = UDim2.new(0, 10, 1, -70)
    autoClaimFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    autoClaimFrame.BorderSizePixel = 0
    autoClaimFrame.Parent = mainFrame

    local autoClaimCorner = Instance.new("UICorner")
    autoClaimCorner.CornerRadius = UDim.new(0, 6)
    autoClaimCorner.Parent = autoClaimFrame

    local autoClaimLabel = Instance.new("TextLabel")
    autoClaimLabel.Name = "AutoClaimLabel"
    autoClaimLabel.Size = UDim2.new(0, 150, 1, 0)
    autoClaimLabel.Position = UDim2.new(0, 5, 0, 0)
    autoClaimLabel.BackgroundTransparency = 1
    autoClaimLabel.Text = "Auto Claim Money:"
    autoClaimLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoClaimLabel.TextScaled = true
    autoClaimLabel.Font = Enum.Font.Gotham
    autoClaimLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoClaimLabel.Parent = autoClaimFrame

    local autoClaimToggle = Instance.new("TextButton")
    autoClaimToggle.Name = "AutoClaimToggle"
    autoClaimToggle.Size = UDim2.new(0, 60, 0, 20)
    autoClaimToggle.Position = UDim2.new(1, -65, 0, 5)
    autoClaimToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    autoClaimToggle.BorderSizePixel = 0
    autoClaimToggle.Text = "ON"
    autoClaimToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoClaimToggle.TextScaled = true
    autoClaimToggle.Font = Enum.Font.GothamBold
    autoClaimToggle.Parent = autoClaimFrame

    local autoClaimToggleCorner = Instance.new("UICorner")
    autoClaimToggleCorner.CornerRadius = UDim.new(0, 10)
    autoClaimToggleCorner.Parent = autoClaimToggle
    
    local autoLockFrame = Instance.new("Frame")
    autoLockFrame.Name = "AutoLockFrame"
    autoLockFrame.Size = UDim2.new(0, 250, 0, 30)
    autoLockFrame.Position = UDim2.new(0, 10, 1, -35)
    autoLockFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    autoLockFrame.BorderSizePixel = 0
    autoLockFrame.Parent = mainFrame

    local autoLockCorner = Instance.new("UICorner")
    autoLockCorner.CornerRadius = UDim.new(0, 6)
    autoLockCorner.Parent = autoLockFrame

    local autoLockLabel = Instance.new("TextLabel")
    autoLockLabel.Name = "AutoLockLabel"
    autoLockLabel.Size = UDim2.new(0, 150, 1, 0)
    autoLockLabel.Position = UDim2.new(0, 5, 0, 0)
    autoLockLabel.BackgroundTransparency = 1
    autoLockLabel.Text = "Auto Lock Base:"
    autoLockLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoLockLabel.TextScaled = true
    autoLockLabel.Font = Enum.Font.Gotham
    autoLockLabel.TextXAlignment = Enum.TextXAlignment.Left
    autoLockLabel.Parent = autoLockFrame

    local autoLockToggle = Instance.new("TextButton")
    autoLockToggle.Name = "AutoLockToggle"
    autoLockToggle.Size = UDim2.new(0, 60, 0, 20)
    autoLockToggle.Position = UDim2.new(1, -65, 0, 5)
    autoLockToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    autoLockToggle.BorderSizePixel = 0
    autoLockToggle.Text = "ON"
    autoLockToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoLockToggle.TextScaled = true
    autoLockToggle.Font = Enum.Font.GothamBold
    autoLockToggle.Parent = autoLockFrame

    local autoLockToggleCorner = Instance.new("UICorner")
    autoLockToggleCorner.CornerRadius = UDim.new(0, 10)
    autoLockToggleCorner.Parent = autoLockToggle
    -- === Invisible Frame ===
local invisibleFrame = Instance.new("Frame")
invisibleFrame.Name = "InvisibleFrame"
invisibleFrame.Size = UDim2.new(0, 250, 0, 30)
invisibleFrame.Position = UDim2.new(0, 10, 1, -105) -- taruh di bawah AutoClaim & AutoLock
invisibleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
invisibleFrame.BorderSizePixel = 0
invisibleFrame.Parent = mainFrame

local invisibleCorner = Instance.new("UICorner")
invisibleCorner.CornerRadius = UDim.new(0, 6)
invisibleCorner.Parent = invisibleFrame

local invisibleLabel = Instance.new("TextLabel")
invisibleLabel.Name = "InvisibleLabel"
invisibleLabel.Size = UDim2.new(0, 150, 1, 0)
invisibleLabel.Position = UDim2.new(0, 5, 0, 0)
invisibleLabel.BackgroundTransparency = 1
invisibleLabel.Text = "Invisible:"
invisibleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibleLabel.TextScaled = true
invisibleLabel.Font = Enum.Font.Gotham
invisibleLabel.TextXAlignment = Enum.TextXAlignment.Left
invisibleLabel.Parent = invisibleFrame

local invisibleToggle = Instance.new("TextButton")
invisibleToggle.Name = "InvisibleToggle"
invisibleToggle.Size = UDim2.new(0, 60, 0, 20)
invisibleToggle.Position = UDim2.new(1, -65, 0, 5)
invisibleToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
invisibleToggle.BorderSizePixel = 0
invisibleToggle.Text = "OFF"
invisibleToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
invisibleToggle.TextScaled = true
invisibleToggle.Font = Enum.Font.GothamBold
invisibleToggle.Parent = invisibleFrame

local invisibleToggleCorner = Instance.new("UICorner")
invisibleToggleCorner.CornerRadius = UDim.new(0, 10)
invisibleToggleCorner.Parent = invisibleToggle

-- === Logic Invisible ===
local invisActive = false
local player = game.Players.LocalPlayer

local function setInvisible(state)
    local character = player.Character or player.CharacterAdded:Wait()
    if state then
        -- Bikin tidak terlihat oleh orang lain
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.Transparency = 1
                part.CanCollide = false
            end
        end
        -- Tapi tetap terlihat oleh diri sendiri
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    else
        -- Balikin ke normal
        for _, part in ipairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.LocalTransparencyModifier = 0
                part.CanCollide = true
            end
        end
    end
end

-- === Toggle Button ===
invisibleToggle.MouseButton1Click:Connect(function()
    invisActive = not invisActive
    if invisActive then
        invisibleToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        invisibleToggle.Text = "ON"
        setInvisible(true)
    else
        invisibleToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        invisibleToggle.Text = "OFF"
        setInvisible(false)
    end
end)

    local selectedBase = nil
    local selectedNPC = nil
    local bases = {}
    local npcs = {}
    local isActivated = false
    local teleportConnection = nil
    local originalPosition = nil
    local visualIndicators = {}
    local isMinimized = false
    local autoLockActive = true
    local autoLockConnection = nil
    local autoClaimActive = true
    local autoClaimConnection = nil
    local baseIndexToPlayer = {}
    local playerToBaseIndex = {}
    local config = {
        teleportOffset = 3,
        logTeleports = true,
        showVisualIndicators = true,
        teleportCooldown = 0.1
    }
    Yanz.FileSystem.makefolder("YanzHub")

    local function minimizeGUI()
        if isMinimized then
            mainFrame.Size = UDim2.new(0, 650, 0, 350)
            mainFrame.Position = UDim2.new(0.5, -325, 0.5, -175)
            contentFrame.Visible = true
            autoClaimFrame.Visible = true
            autoLockFrame.Visible = true
            minimizeButton.Text = "−"
            isMinimized = false
            Yanz.Console.info("GUI unminimized")
        else
            mainFrame.Size = UDim2.new(0, 200, 0, 35)
            mainFrame.Position = UDim2.new(0.5, -100, 0.5, -17.5)
            contentFrame.Visible = false
            autoClaimFrame.Visible = false
            autoLockFrame.Visible = false
            minimizeButton.Text = "+"
            isMinimized = true
            Yanz.Console.info("GUI minimized")
        end
        if isMinimized then
            titleLabel.Size = UDim2.new(0, 120, 1, 0)
            subtitleLabel.Size = UDim2.new(0, 40, 0, 10)
            subtitleLabel.Position = UDim2.new(0, 125, 0, 12)
        else
            titleLabel.Size = UDim2.new(0, 200, 1, 0)
            subtitleLabel.Size = UDim2.new(0, 60, 0, 15)
            subtitleLabel.Position = UDim2.new(0, 220, 0, 10)
        end
    end

    local function getPlayerByBaseIndex(baseIndex)
        return baseIndexToPlayer[tostring(baseIndex)]
    end

    local function getBaseIndexByPlayer(playerName)
        return playerToBaseIndex[playerName]
    end

    local function updateBaseIndexMappings()
        baseIndexToPlayer = {}
        playerToBaseIndex = {}
        for _, plr in pairs(Players:GetPlayers()) do
            local baseIndex = plr:GetAttribute("BaseIndex")
            if baseIndex then
                baseIndexToPlayer[tostring(baseIndex)] = plr.Name
                playerToBaseIndex[plr.Name] = tostring(baseIndex)
                Yanz.Console.info(plr.Name .. " is in Base " .. baseIndex)
            end
        end
    end

    local function getBaseDisplayName(baseIndex)
        local playerName = getPlayerByBaseIndex(baseIndex)
        if playerName then
            return playerName .. "'s Base"
        else
            return "None"
        end
    end

    local function getNPCDisplayName(npc)
        local configName = npc:GetAttribute("ConfigName")
        if configName then
            return configName
        else
            return npc.Name
        end
    end

    local function findStealPrompt(npc)
        local torso = npc:FindFirstChild("Torso")
        if torso then
            local stealPrompt = torso:FindFirstChild("Steal")
            if (stealPrompt and stealPrompt:IsA("ProximityPrompt")) then
                return stealPrompt
            end
        end
        for _, child in pairs(npc:GetChildren()) do
            if child:IsA("BasePart") then
                local stealPrompt = child:FindFirstChild("Steal")
                if (stealPrompt and stealPrompt:IsA("ProximityPrompt")) then
                    return stealPrompt
                end
            end
        end
        return nil
    end

    local dragging = false
    local dragStart = nil
    local startPos = nil
    local function startDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end

    local function updateDrag(input)
        if dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    local function stopDrag()
        dragging = false
        dragStart = nil
        startPos = nil
    end

    titleBar.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1) then
            startDrag(input)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if ((input.UserInputType == Enum.UserInputType.MouseMovement) and dragging) then
            updateDrag(input)
        end
    end)

    titleBar.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1) then
            stopDrag()
        end
    end)

    local function storeOriginalPosition()
        local character = player.Character
        if (character and character:FindFirstChild("HumanoidRootPart")) then
            originalPosition = character.HumanoidRootPart.CFrame
            Yanz.Console.info("Original position stored")
        end
    end

    local function returnToPlayerBase()
        local character = player.Character
        if (not character or not character:FindFirstChild("HumanoidRootPart")) then
            Yanz.Console.error("Character not found for return teleport!")
            selectionInfo.Text = "Character not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local playerBaseIndex = player:GetAttribute("BaseIndex")
        if not playerBaseIndex then
            Yanz.Console.error("Player has no BaseIndex attribute!")
            selectionInfo.Text = "No base assigned to player!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local playerBase = workspace:WaitForChild("Bases"):FindFirstChild(tostring(playerBaseIndex))
        if not playerBase then
            Yanz.Console.error("Player base not found!")
            selectionInfo.Text = "Player base not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local plotTeritory = playerBase:WaitForChild("PlotTeritory")
        if not plotTeritory then
            Yanz.Console.error("PlotTeritory not found for player base!")
            selectionInfo.Text = "PlotTeritory not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        character.HumanoidRootPart.CFrame = plotTeritory.CFrame + Vector3.new(0, 5, 0)
        Yanz.Console.info("Returned to player's base")
        selectionInfo.Text = "Returned to player's base"
        selectionInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
        if config.showVisualIndicators then
            createVisualIndicator(plotTeritory.Position, Color3.fromRGB(0, 0, 255))
        end
        return true
    end

    local function createVisualIndicator(position, color)
        if not config.showVisualIndicators then
            return
        end
        local circle = Yanz.Drawing.new("Circle")
        circle.Radius = 15
        circle.Color = color or Color3.fromRGB(255, 0, 0)
        circle.Filled = false
        circle.Visible = true
        circle.Thickness = 2
        local camera = workspace.CurrentCamera
        local screenPos = camera:WorldToViewportPoint(position)
        if (screenPos.Z > 0) then
            circle.Position = Vector2.new(screenPos.X, screenPos.Y)
        end
        table.insert(visualIndicators, circle)
        spawn(function()
            wait(2)
            if circle then
                circle:Remove()
            end
        end)
    end

    local function clearVisualIndicators()
        for _, indicator in pairs(visualIndicators) do
            if indicator then
                indicator:Remove()
            end
        end
        visualIndicators = {}
    end

    local function getNPCPosition(npc)
        local teleportPoint = npc:FindFirstChild("TeleportPoint")
        if teleportPoint then
            if teleportPoint:IsA("Attachment") then
                return teleportPoint.WorldPosition
            elseif teleportPoint:IsA("BasePart") then
                return teleportPoint.Position
            end
        end
        local primaryPart = npc.PrimaryPart
        if primaryPart then
            return primaryPart.Position
        end
        local largestPart = nil
        local largestSize = 0
        for _, part in pairs(npc:GetChildren()) do
            if part:IsA("BasePart") then
                local size = part.Size.X * part.Size.Y * part.Size.Z
                if (size > largestSize) then
                    largestSize = size
                    largestPart = part
                end
            end
        end
        if largestPart then
            return largestPart.Position
        end
        return nil
    end

    local function teleportToNPC(npc)
        local character = player.Character
        if not character then
            Yanz.Console.error("Character not found!")
            selectionInfo.Text = "Character not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            Yanz.Console.error("HumanoidRootPart not found!")
            selectionInfo.Text = "HumanoidRootPart not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local npcPosition = getNPCPosition(npc)
        if not npcPosition then
            Yanz.Console.error("Could not find NPC position!")
            selectionInfo.Text = "Could not find NPC position!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        if not originalPosition then
            storeOriginalPosition()
        end

        local safePosition = npcPosition + Vector3.new(0, config.teleportOffset, 0)
        local teleportCFrame = CFrame.new(safePosition, safePosition + Vector3.new(0, 0, 1))
        humanoidRootPart.CFrame = teleportCFrame
        if config.showVisualIndicators then
            createVisualIndicator(npcPosition, Color3.fromRGB(0, 255, 0))
        end
        Yanz.Console.info("Teleported to " .. getNPCDisplayName(npc))
        return true
    end

    local function quickSteal()
        if (not selectedNPC or not selectedBase) then
            Yanz.Console.error("No NPC selected for quick steal!")
            selectionInfo.Text = "No NPC selected!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local character = player.Character
        if (not character or not character:FindFirstChild("HumanoidRootPart")) then
            Yanz.Console.error("Character not found for quick steal!")
            selectionInfo.Text = "Character not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        local stealStartPosition = character.HumanoidRootPart.CFrame
        local originalCameraCFrame = workspace.CurrentCamera.CFrame
        local stealPrompt = findStealPrompt(selectedNPC)
        if not stealPrompt then
            Yanz.Console.error("Steal prompt not found in " .. getNPCDisplayName(selectedNPC))
            selectionInfo.Text = "Steal prompt not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return false
        end

        Yanz.Console.info("Starting quick steal for " .. getNPCDisplayName(selectedNPC))
        selectionInfo.Text = "Quick stealing " .. getNPCDisplayName(selectedNPC) .. "..."
        selectionInfo.TextColor3 = Color3.fromRGB(255, 165, 0)

        local connection
        connection = ProximityPromptService.PromptShown:Connect(function(prompt)
            if (prompt == stealPrompt) then
                prompt.HoldDuration = 0
                prompt.RequiresLineOfSight = false
                prompt.MaxActivationDistance = 1000
                connection:Disconnect()
            end
        end)

        stealPrompt.HoldDuration = 0
        stealPrompt.RequiresLineOfSight = false
        stealPrompt.MaxActivationDistance = 1000

        local startTime = tick()
        local teleportConnection
        local rotationAngle = 0
        teleportConnection = RunService.Heartbeat:Connect(function()
            if ((tick() - startTime) >= 2) then
                teleportConnection:Disconnect()
                return
            end
            if (selectedNPC and selectedNPC.Parent) then
                teleportToNPC(selectedNPC)
                local character = player.Character
                if (character and character:FindFirstChild("HumanoidRootPart")) then
                    local humanoidRootPart = character.HumanoidRootPart
                    local camera = workspace.CurrentCamera
                    rotationAngle = rotationAngle + 0.1
                    local radius = 2
                    local x = math.cos(rotationAngle) * radius
                    local z = math.sin(rotationAngle) * radius
                    local upDirection = Vector3.new(x, 1, z).Unit
                    local lookCFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + upDirection)
                    camera.CFrame = lookCFrame
                end
            end
        end)

        spawn(function()
            local attempts = 0
            while ((tick() - startTime) < 2) and selectedNPC and selectedNPC.Parent do
                stealPrompt:InputHoldBegin()
                wait(0.05)
                stealPrompt:InputHoldEnd()
                wait(0.05)
                attempts = attempts + 1
            end
            Yanz.Console.info("Fired proximity prompt " .. attempts .. " times")
        end)

        wait(2)
        if teleportConnection then
            teleportConnection:Disconnect()
        end

        workspace.CurrentCamera.CFrame = originalCameraCFrame

        local playerBaseIndex = player:GetAttribute("BaseIndex")
        if playerBaseIndex then
            local playerBase = workspace:WaitForChild("Bases"):FindFirstChild(tostring(playerBaseIndex))
            if playerBase then
                local plotTeritory = playerBase:WaitForChild("PlotTeritory")
                if plotTeritory then
                    character.HumanoidRootPart.CFrame = plotTeritory.CFrame + Vector3.new(0, 5, 0)
                else
                    local basePosition = getNPCPosition(playerBase)
                    if basePosition then
                        character.HumanoidRootPart.CFrame = CFrame.new(basePosition + Vector3.new(0, 5, 0))
                    else
                        character.HumanoidRootPart.CFrame = stealStartPosition
                    end
                end
            else
                character.HumanoidRootPart.CFrame = stealStartPosition
            end
        else
            character.HumanoidRootPart.CFrame = stealStartPosition
        end

        Yanz.Console.info("Quick steal completed for " .. getNPCDisplayName(selectedNPC))
        selectionInfo.Text = "Quick steal completed!"
        selectionInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
        if config.showVisualIndicators then
            createVisualIndicator(returnPosition.Position, Color3.fromRGB(0, 255, 0))
        end
        return true
    end

    local function fireAllBaseLocks()
        if autoLockActive then
            local playerBaseIndex = player:GetAttribute("BaseIndex")
            if not playerBaseIndex then
                Yanz.Console.error("Player has no BaseIndex attribute for auto lock!")
                return
            end
            local dataRemote = ReplicatedStorage:WaitForChild("ncxyzero_bridgenet2-fork@1.1.5"):WaitForChild("dataRemoteEvent")
            local args = {{
                workspace:WaitForChild("Bases"):WaitForChild(tostring(playerBaseIndex)):WaitForChild("LockgateButton"):WaitForChild("Button"),
                "\014"
            }}
            dataRemote:FireServer(unpack(args))
            Yanz.Console.info("Fired base lock for base " .. playerBaseIndex)
        end
    end

    local function fireAllClaimButtons()
        if not autoClaimActive then
            return
        end
        local playerBaseIndex = player:GetAttribute("BaseIndex")
        if not playerBaseIndex then
            Yanz.Console.error("Player has no BaseIndex attribute for auto claim!")
            return
        end
        local success, dataRemote = pcall(function()
            return ReplicatedStorage:WaitForChild("ncxyzero_bridgenet2-fork@1.1.5"):WaitForChild("dataRemoteEvent")
        end)
        if not success then
            Yanz.Console.error("Failed to get dataRemoteEvent")
            return
        end
        for slotNum = 1, 10 do
            local success, args = pcall(function()
                return {{
                    workspace:WaitForChild("Bases"):WaitForChild(tostring(playerBaseIndex)):WaitForChild("PlotSlots"):WaitForChild("Slot" .. tostring(slotNum)):WaitForChild("ClaimButton"):WaitForChild("Button"),
                    "\015"
                }}
            end)
            if success then
                dataRemote:FireServer(unpack(args))
            else
                Yanz.Console.error("Failed to create args for slot " .. slotNum)
            end
        end
        Yanz.Console.info("Fired ALL claim buttons (slots 1-10) for base " .. playerBaseIndex)
    end

    local function startAutoLockLoop()
        local lastFire = 0
        autoLockConnection = RunService.Heartbeat:Connect(function()
            if not autoLockActive then
                autoLockConnection:Disconnect()
                Yanz.Console.info("Auto lock loop stopped")
                return
            end
            local currentTime = tick()
            if ((currentTime - lastFire) >= 1) then
                fireAllBaseLocks()
                lastFire = currentTime
            end
        end)
    end

    local function startAutoClaimLoop()
        local lastFire = 0
        autoClaimConnection = RunService.Heartbeat:Connect(function()
            if not autoClaimActive then
                autoClaimConnection:Disconnect()
                Yanz.Console.info("Auto claim loop stopped")
                return
            end
            local currentTime = tick()
            if ((currentTime - lastFire) >= 1) then
                fireAllClaimButtons()
                lastFire = currentTime
            end
        end)
    end

    autoLockToggle.MouseButton1Click:Connect(function()
        autoLockActive = not autoLockActive
        if autoLockActive then
            autoLockToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            autoLockToggle.Text = "ON"
            Yanz.Console.info("Auto Lock Base activated")
            startAutoLockLoop()
        else
            autoLockToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            autoLockToggle.Text = "OFF"
            Yanz.Console.info("Auto Lock Base deactivated")
            if autoLockConnection then
                autoLockConnection:Disconnect()
            end
        end
    end)

    autoClaimToggle.MouseButton1Click:Connect(function()
        autoClaimActive = not autoClaimActive
        if autoClaimActive then
            autoClaimToggle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            autoClaimToggle.Text = "ON"
            Yanz.Console.info("Auto Claim Money activated")
            startAutoClaimLoop()
        else
            autoClaimToggle.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            autoClaimToggle.Text = "OFF"
            Yanz.Console.info("Auto Claim Money deactivated")
            if autoClaimConnection then
                autoClaimConnection:Disconnect()
            end
        end
    end)

    quickStealButton.MouseButton1Click:Connect(function()
        if (not selectedNPC or not selectedBase) then
            Yanz.Console.error("No NPC selected for quick steal!")
            selectionInfo.Text = "No NPC selected!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        quickSteal()
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        minimizeGUI()
    end)

    serverHopButton.MouseButton1Click:Connect(function()
        Yanz.Console.info("Server hopping...")
        local p = game.PlaceId
        local place = p
        TeleportService:Teleport(place, Players.LocalPlayer)
    end)

    tpSelectedBaseButton.MouseButton1Click:Connect(function()
        if not selectedBase then
            Yanz.Console.error("No base selected!")
            selectionInfo.Text = "No base selected!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end

        local character = player.Character
        if (not character or not character:FindFirstChild("HumanoidRootPart")) then
            Yanz.Console.error("Character not found!")
            return
        end

        local baseNumber = selectedBase.Name
        local plotTeritory = workspace:WaitForChild("Bases"):WaitForChild(baseNumber):WaitForChild("PlotTeritory")
        if plotTeritory then
            Yanz.Console.info("Teleporting to selected base PlotTeritory: " .. baseNumber)
            local startTime = tick()
            local teleportConnection
            teleportConnection = RunService.Heartbeat:Connect(function()
                if ((tick() - startTime) >= 1.5) then
                    teleportConnection:Disconnect()
                    Yanz.Console.info("Finished teleporting to selected base")
                    return
                end
                character.HumanoidRootPart.CFrame = plotTeritory.CFrame + Vector3.new(0, 5, 0)
            end)
        else
            Yanz.Console.error("PlotTeritory not found for base: " .. baseNumber)
            selectionInfo.Text = "PlotTeritory not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    tpYourBaseButton.MouseButton1Click:Connect(function()
        local character = player.Character
        if (not character or not character:FindFirstChild("HumanoidRootPart")) then
            Yanz.Console.error("Character not found!")
            return
        end

        local playerBaseIndex = player:GetAttribute("BaseIndex")
        if not playerBaseIndex then
            Yanz.Console.error("Player has no BaseIndex attribute!")
            selectionInfo.Text = "No base assigned to player!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end

        local playerBase = workspace:WaitForChild("Bases"):WaitForChild(tostring(playerBaseIndex))
        if playerBase then
            local plotTeritory = playerBase:WaitForChild("PlotTeritory")
            if plotTeritory then
                Yanz.Console.info("Teleporting to your base PlotTeritory: " .. playerBaseIndex)
                local startTime = tick()
                local teleportConnection
                teleportConnection = RunService.Heartbeat:Connect(function()
                    if ((tick() - startTime) >= 1.5) then
                        teleportConnection:Disconnect()
                        Yanz.Console.info("Finished teleporting to your base")
                        return
                    end
                    character.HumanoidRootPart.CFrame = plotTeritory.CFrame + Vector3.new(0, 5, 0)
                end)
            else
                Yanz.Console.error("PlotTeritory not found for player base: " .. playerBaseIndex)
                selectionInfo.Text = "PlotTeritory not found!"
                selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
        else
            Yanz.Console.error("Player base not found!")
            selectionInfo.Text = "Player base not found!"
            selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    local function createBaseItem(base, baseIndex)
        local item = Instance.new("TextButton")
        item.Name = base.Name
        item.Size = UDim2.new(1, -5, 0, 30)
        item.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        item.BorderSizePixel = 0
        item.Text = ""
        item.Parent = basesList
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 4)
        corner.Parent = item

        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(0.5, -5, 1, 0)
        label.Position = UDim2.new(0, 8, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = getBaseDisplayName(baseIndex)
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = item

        local lockStatus = Instance.new("TextLabel")
        lockStatus.Name = "LockStatus"
        lockStatus.Size = UDim2.new(0, 70, 1, 0)
        lockStatus.Position = UDim2.new(0.5, 5, 0, 0)
        lockStatus.BackgroundTransparency = 1
        lockStatus.Text = (base:FindFirstChild("Gate") and "Locked") or "Unlocked"
        lockStatus.TextColor3 = (base:FindFirstChild("Gate") and Color3.fromRGB(255, 100, 100)) or Color3.fromRGB(100, 255, 100)
        lockStatus.TextScaled = true
        lockStatus.Font = Enum.Font.GothamBold
        lockStatus.TextXAlignment = Enum.TextXAlignment.Center
        lockStatus.Parent = item

        local npcCount = 0
        local npcsContainer = base:FindFirstChild("NPCs")
        if npcsContainer then
            for _, child in pairs(npcsContainer:GetChildren()) do
                if child:IsA("Model") then
                    npcCount = npcCount + 1
                end
            end
        end
        local badge = Instance.new("TextLabel")
        badge.Name = "Badge"
        badge.Size = UDim2.new(0, 25, 0, 18)
        badge.Position = UDim2.new(1, -28, 0, 6)
        badge.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
        badge.BorderSizePixel = 0
        badge.Text = tostring(npcCount)
        badge.TextColor3 = Color3.fromRGB(255, 255, 255)
        badge.TextScaled = true
        badge.Font = Enum.Font.GothamBold
        badge.Parent = item

        local badgeCorner = Instance.new("UICorner")
        badgeCorner.CornerRadius = UDim.new(0, 9)
        badgeCorner.Parent = badge

        item.MouseEnter:Connect(function()
            if (item.BackgroundColor3 ~= Color3.fromRGB(100, 150, 255)) then
                TweenService:Create(item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(75, 75, 75)}):Play()
            end
        end)

        item.MouseLeave:Connect(function()
            if (item.BackgroundColor3 ~= Color3.fromRGB(100, 150, 255)) then
                TweenService:Create(item, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
            end
        end)

        item.MouseButton1Click:Connect(function()
            for _, child in pairs(basesList:GetChildren()) do
                if (child:IsA("TextButton") and (child ~= item)) then
                    child.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                end
            end
            item.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            selectedBase = base
            searchBox.Text = ""
            Yanz.Console.info("Loading NPCs for base: " .. getBaseDisplayName(baseIndex))
            for _, child in pairs(npcsList:GetChildren()) do
                if child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            npcs = {}
            selectedNPC = nil
            activateButton.Active = false
            activateButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
            activateButton.Text = "Tp To Npc"
            quickStealButton.Active = false
            quickStealButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            selectionInfo.Text = "No NPC selected"
            selectionInfo.TextColor3 = Color3.fromRGB(200, 200, 200)

            local npcsContainer = base:FindFirstChild("NPCs")
            if not npcsContainer then
                local errorLabel = Instance.new("TextLabel")
                errorLabel.Size = UDim2.new(1, -5, 0, 20)
                errorLabel.BackgroundTransparency = 1
                errorLabel.Text = "No NPCs found"
                errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                errorLabel.TextScaled = true
                errorLabel.Font = Enum.Font.Gotham
                errorLabel.Parent = npcsList
                Yanz.Console.error("NPCs container not found in " .. getBaseDisplayName(baseIndex))
                return
            end

            local index = 1
            for _, npc in pairs(npcsContainer:GetChildren()) do
                if npc:IsA("Model") then
                    local npcItem = Instance.new("TextButton")
                    npcItem.Name = npc.Name
                    npcItem.Size = UDim2.new(1, -5, 0, 25)
                    npcItem.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                    npcItem.BorderSizePixel = 0
                    npcItem.Text = getNPCDisplayName(npc)
                    npcItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                    npcItem.TextScaled = true
                    npcItem.Font = Enum.Font.Gotham
                    npcItem.Parent = npcsList
                    npcItem.Position = UDim2.new(0, 2, 0, (index - 1) * 30)
                    local npcCorner = Instance.new("UICorner")
                    npcCorner.CornerRadius = UDim.new(0, 4)
                    npcCorner.Parent = npcItem

                    npcItem.MouseEnter:Connect(function()
                        if (npcItem.BackgroundColor3 ~= Color3.fromRGB(100, 150, 255)) then
                            TweenService:Create(npcItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(75, 75, 75)}):Play()
                        end
                    end)

                    npcItem.MouseLeave:Connect(function()
                        if (npcItem.BackgroundColor3 ~= Color3.fromRGB(100, 150, 255)) then
                            TweenService:Create(npcItem, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
                        end
                    end)

                    npcItem.MouseButton1Click:Connect(function()
                        for _, child in pairs(npcsList:GetChildren()) do
                            if (child:IsA("TextButton") and (child ~= npcItem)) then
                                child.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
                            end
                        end
                        npcItem.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                        selectedNPC = npc
                        activateButton.Active = true
                        activateButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                        quickStealButton.Active = true
                        quickStealButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                        selectionInfo.Text = "Selected: " .. getNPCDisplayName(npc) .. " (" .. getBaseDisplayName(baseIndex) .. ")"
                        selectionInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
                        Yanz.Console.info("Selected NPC: " .. getNPCDisplayName(npc) .. " from " .. getBaseDisplayName(baseIndex))
                    end)
                    npcs[npc.Name] = npc
                    index = index + 1
                end
            end
            npcsList.CanvasSize = UDim2.new(0, 0, 0, (index - 1) * 30)
            Yanz.Console.info("Instantly loaded " .. (index - 1) .. " NPCs for " .. getBaseDisplayName(baseIndex))
        end)
        return item
    end

    local function updateBasesList()
        for _, child in pairs(basesList:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        bases = {}
        updateBaseIndexMappings()
        local basesFolder = workspace:WaitForChild("Bases", 10)
        if not basesFolder then
            local errorLabel = Instance.new("TextLabel")
            errorLabel.Size = UDim2.new(1, -5, 0, 20)
            errorLabel.BackgroundTransparency = 1
            errorLabel.Text = "Bases folder not found!"
            errorLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            errorLabel.TextScaled = true
            errorLabel.Font = Enum.Font.Gotham
            errorLabel.Parent = basesList
            Yanz.Console.error("Bases folder not found!")
            return
        end

        local index = 1
        for _, base in pairs(basesFolder:GetChildren()) do
            if base:IsA("Model") then
                local item = createBaseItem(base, base.Name)
                item.Position = UDim2.new(0, 2, 0, (index - 1) * 35)
                bases[base.Name] = base
                index = index + 1
            end
        end
        basesList.CanvasSize = UDim2.new(0, 0, 0, (index - 1) * 35)
        Yanz.Console.info("Found " .. (index - 1) .. " bases")
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        if not selectedBase then
            return
        end
        local searchText = searchBox.Text:lower()
        if (searchText == "") then
            for _, child in pairs(npcsList:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = true
                end
            end
            return
        end
        for _, child in pairs(npcsList:GetChildren()) do
            if child:IsA("TextButton") then
                local npcDisplayName = child.Text:lower()
                if npcDisplayName:find(searchText) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end)

    activateButton.MouseButton1Click:Connect(function()
        if (not selectedNPC or not selectedBase) then
            return
        end

        isActivated = not isActivated
        if isActivated then
            activateButton.Text = "Activated"
            activateButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            selectionInfo.Text = "Teleporting to " .. getNPCDisplayName(selectedNPC)
            selectionInfo.TextColor3 = Color3.fromRGB(100, 255, 100)
            Yanz.Console.info("Started continuous teleportation to " .. getNPCDisplayName(selectedNPC))
            teleportConnection = RunService.Heartbeat:Connect(function()
                if (selectedNPC and selectedNPC.Parent and selectedBase and selectedBase.Parent) then
                    teleportToNPC(selectedNPC)
                    wait(config.teleportCooldown)
                else
                    isActivated = false
                    activateButton.Text = "Tp To Npc"
                    activateButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                    selectionInfo.Text = "NPC or base no longer exists"
                    selectionInfo.TextColor3 = Color3.fromRGB(255, 100, 100)
                    if teleportConnection then
                        teleportConnection:Disconnect()
                    end
                    Yanz.Console.error("NPC or base no longer exists - stopping teleportation")
                end
            end)
        else
            activateButton.Text = "Tp To Npc"
            activateButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            selectionInfo.Text = "Returning to original position..."
            selectionInfo.TextColor3 = Color3.fromRGB(255, 165, 0)
            if teleportConnection then
                teleportConnection:Disconnect()
            end
            spawn(function()
                wait(0.5)
                returnToPlayerBase()
            end)
            Yanz.Console.info("Stopped teleportation - returning to player's base")
        end
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end
        if (input.KeyCode == Enum.KeyCode.Escape) then
            screenGui.Enabled = false
            Yanz.Console.info("GUI closed")
        elseif (input.KeyCode == Enum.KeyCode.Return) then
            if selectedNPC then
                activateButton.MouseButton1Click:Fire()
            end
        elseif (input.KeyCode == Enum.KeyCode.F1) then
            config.showVisualIndicators = not config.showVisualIndicators
            Yanz.Console.info("Visual indicators: " .. ((config.showVisualIndicators and "ON") or "OFF"))
        elseif (input.KeyCode == Enum.KeyCode.F2) then
            clearVisualIndicators()
            Yanz.Console.info("Visual indicators cleared")
        elseif (input.KeyCode == Enum.KeyCode.M) then
            minimizeGUI()
        end
    end)

    closeButton.MouseButton1Click:Connect(function()
        cleanupRainbow()
        screenGui.Enabled = false
        Yanz.Console.info("GUI closed by user")
    end)

    infiniteYieldButton.MouseButton1Click:Connect(function()
        Yanz.Console.info("Loading Infinite Yield...")
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Infinite-Yield-43437"))()
        Yanz.Console.info("Infinite Yield loaded successfully")
    end)

    Players.PlayerAdded:Connect(function(plr)
        Yanz.Console.info("Player " .. plr.Name .. " joined")
        updateBaseIndexMappings()
        updateBasesList()
    end)

    Players.PlayerRemoving:Connect(function(plr)
        Yanz.Console.info("Player " .. plr.Name .. " left")
        updateBaseIndexMappings()
        updateBasesList()
    end)

    Yanz.Console.info("Yanz Hub loaded")
    updateBaseIndexMappings()
    updateBasesList()
    startAutoLockLoop()
    startAutoClaimLoop()
    spawn(function()
        while true do
            wait(10)
            if screenGui.Enabled then
                local currentSelectedBase = selectedBase
                updateBaseIndexMappings()
                updateBasesList()
                if (currentSelectedBase and currentSelectedBase.Parent) then
                    selectedBase = currentSelectedBase
                    for _, child in pairs(basesList:GetChildren()) do
                        if (child:IsA("TextButton") and (child.Name == currentSelectedBase.Name)) then
                            child.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                        end
                    end
                end
            end
        end
    end)
end