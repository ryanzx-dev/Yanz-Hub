-- map_gate_and_loader.lua
-- LocalScript (letakkan di StarterPlayerScripts)
local EXPECTED_PLACE_ID = 100438336521838
local SCRIPT_URL = "https://raw.githubusercontent.com/ryanzx-dev/Yanz-Hub/refs/heads/main/script.lua"

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Simple notify helper (non-blocking)
local function notify(text, duration)
    duration = duration or 4
    if not player or not player:FindFirstChild("PlayerGui") then
        warn(text)
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MapGateNotify"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5, 0)
    frame.Position = UDim2.new(0.5, 0, 0.05, 0)
    frame.Size = UDim2.new(0.35, 0, 0, 50)
    frame.BackgroundTransparency = 0.15
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, -10)
    label.Position = UDim2.new(0, 5, 0, 5)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.Parent = frame

    spawn(function()
        wait(duration)
        pcall(function() screenGui:Destroy() end)
    end)
end

-- Loader: ambil code dari url lalu jalankan dengan pcall
local function fetchAndRun(url)
    -- Safety: pcall around HttpGet in case environment doesn't allow it
    local ok, body_or_err = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok or type(body_or_err) ~= "string" or #body_or_err == 0 then
        warn("Failed to fetch remote script: ", body_or_err)
        notify("Failed to load script (fetch error)", 6)
        return false
    end

    -- Optionally you can do lightweight checks here, e.g. size or keywords
    -- if #body_or_err > 100000 then ... end

    -- Run the fetched code (pcall to avoid runtime errors crashing this script)
    local success, result = pcall(function()
        local fn, loadErr = loadstring(body_or_err)
        if not fn then
            error("loadstring failed: " .. tostring(loadErr))
        end
        return fn()
    end)

    if not success then
        warn("Remote script execution error: ", result)
        notify("Script execution failed", 6)
        return false
    end

    return true
end

-- Main check + dispatch
local function checkPlaceThenRun()
    local current = tonumber(game.PlaceId) or 0
    if current == EXPECTED_PLACE_ID then
        notify("Map OK — loading script...", 3)
        -- run main
        local ok = fetchAndRun(SCRIPT_URL)
        if ok then
            notify("Script loaded", 3)
        end
    else
        notify("Script disabled — wrong map", 6)
        warn(("Map mismatch: expected %d but running on %s"):format(EXPECTED_PLACE_ID, tostring(current)))
    end
end

-- Ensure LocalPlayer available
if not player then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    player = Players.LocalPlayer
end

-- Run check (wrapped in pcall to be resilient)
pcall(checkPlaceThenRun)
