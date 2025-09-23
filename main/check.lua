local EXPECTED_PLACE_ID = 100438336521838
local SCRIPT_URL = "https://raw.githubusercontent.com/ryanzx-dev/Yanz-Hub/refs/heads/main/main.lua"
local SCRIPT_URL2 = "https://raw.githubusercontent.com/ryanzx-dev/Yanz-Hub/refs/heads/main/invis.lua"
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function notify(text, duration)
    duration = duration or 3
    if not player or not player:FindFirstChild("PlayerGui") then
        warn(text)
        return
    end
    local gui = player.PlayerGui:FindFirstChild("YanzNotifyGui")
    if not gui then
        gui = Instance.new("ScreenGui")
        gui.Name = "YanzNotifyGui"
        gui.ResetOnSpawn = false
        gui.Parent = player.PlayerGui
    else
        gui:ClearAllChildren()
    end
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.35, 0, 0, 50)
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Position = UDim2.new(0.5, 0, 0.05, 0)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Parent = gui
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Text = text
    label.Parent = frame
    game:GetService("Debris"):AddItem(gui, duration)
end

local function fetchAndRun(url)
    local ok, body_or_err = pcall(function() return game:HttpGet(url) end)
    if not ok or type(body_or_err) ~= "string" or #body_or_err == 0 then
        warn("Failed to fetch:", body_or_err)
        notify("Fetch error", 4)
        return false
    end
    local success, result = pcall(function()
        local fn, err = loadstring(body_or_err)
        if not fn then error(err) end
        return fn()
    end)
    if not success then
        warn("Exec error:", result)
        notify("Exec failed", 4)
        return false
    end
    return true
end

local function checkAndExecute()
    notify("loading..", 2)
    wait(1.5)
    if game.PlaceId == EXPECTED_PLACE_ID then
        notify("YANZ HUB LOADED", 2)
        wait(1.5)
        spawn(function()
            wait(0.5)
            fetchAndRun(SCRIPT_URL)
            fetchAndRun(SCRIPT_URL2)
        end)
    else
        notify("PLS JOIN RIP BRAINROT MAP", 2)
        wait(1.5)
        warn("Wrong map, expected:", EXPECTED_PLACE_ID, "current:", game.PlaceId)
    end
end

checkAndExecute()
