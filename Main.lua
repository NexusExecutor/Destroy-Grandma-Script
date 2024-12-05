-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- Create Main GUI Window
local Window = Rayfield:CreateWindow({
    Name = "Destroy Grandma | Enhanced Exploit",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Stay Undetected",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DestroyGrandmaConfigs",
        FileName = "EnhancedSettings"
    },
    KeySystem = false
})

-- Super Enhanced Anti-Ban
local function UltimateAntiBan()
    local player = game.Players.LocalPlayer

    -- Spoof attributes to avoid detection
    player:SetAttribute("SafeMode", true)

    -- Clear suspicious objects
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            if string.match(obj.Name:lower(), "ban") or string.match(obj.Name:lower(), "anticheat") then
                obj:Destroy()
            end
        end
    end

    -- Protect Remote Events
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)

    mt.__namecall = function(self, ...)
        local method = getnamecallmethod()
        if tostring(self):lower():find("remote") and method:lower():find("ban") then
            return nil -- Block detection attempts
        end
        return oldNamecall(self, ...)
    end

    setreadonly(mt, true)

    Rayfield:Notify({
        Title = "Anti-Ban Active",
        Content = "Maximum protections applied!",
        Duration = 5,
        Image = 4483362458
    })
end

-- Activate Anti-Ban on Startup
UltimateAntiBan()

-- Create Main Tab
local MainTab = Window:CreateTab("Main Features", 4483362458)

-- Auto Kill Grandmas
MainTab:CreateButton({
    Name = "Auto Kill All Grandmas",
    Callback = function()
        for _, grandma in pairs(workspace.Grandmas:GetChildren()) do
            if grandma:FindFirstChild("Humanoid") then
                grandma.Humanoid.Health = 0
            end
        end
        Rayfield:Notify({
            Title = "Success",
            Content = "All Grandmas defeated!",
            Duration = 5,
            Image = 4483362458
        })
    end
})

-- Fun Feature: Spawn Clones
MainTab:CreateButton({
    Name = "Spawn Grandma Clones",
    Callback = function()
        local clone = workspace.Grandmas:GetChildren()[1]:Clone()
        for i = 1, 10 do
            local newClone = clone:Clone()
            newClone.Parent = workspace.Grandmas
            newClone.HumanoidRootPart.CFrame = CFrame.new(math.random(-50, 50), 5, math.random(-50, 50))
        end
        Rayfield:Notify({
            Title = "Clones Spawned",
            Content = "10 new Grandmas appeared!",
            Duration = 5,
            Image = 4483362458
        })
    end
})

-- ESP and Aimbot Tab
local ESPTab = Window:CreateTab("ESP & Aimbot", 4483362458)

-- ESP Color Picker
ESPTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.new(1, 0, 0),
    Flag = "ESPColor",
    Callback = function(Value)
        for _, grandma in pairs(workspace.Grandmas:GetChildren()) do
            if grandma:FindFirstChild("Highlight") then
                grandma.Highlight.FillColor = Value
            end
        end
    end
})

-- Aimbot with FOV Settings
ESPTab:CreateSlider({
    Name = "Aimbot FOV Radius",
    Min = 50,
    Max = 500,
    Default = 200,
    Flag = "FOVRadius",
    Callback = function(Value)
        _G.AimbotFOV = Value
    end
})

ESPTab:CreateToggle({
    Name = "Auto Shoot",
    CurrentValue = false,
    Flag = "AutoShoot",
    Callback = function(Value)
        _G.AutoShoot = Value
    end
})

-- Fun Tab
local FunTab = Window:CreateTab("Fun Features", 4483362458)

-- Explode Grandmas
FunTab:CreateButton({
    Name = "Explode All Grandmas",
    Callback = function()
        for _, grandma in pairs(workspace.Grandmas:GetChildren()) do
            if grandma:FindFirstChild("HumanoidRootPart") then
                local explosion = Instance.new("Explosion")
                explosion.Position = grandma.HumanoidRootPart.Position
                explosion.BlastRadius = 10
                explosion.BlastPressure = 100000
                explosion.Parent = workspace
            end
        end
        Rayfield:Notify({
            Title = "Boom!",
            Content = "Grandmas have been exploded!",
            Duration = 5,
            Image = 4483362458
        })
    end
})

-- Miscellaneous Tab
local MiscTab = Window:CreateTab("Miscellaneous", 4483362458)

-- Player Speed
MiscTab:CreateSlider({
    Name = "Player Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Flag = "PlayerSpeed",
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        if player and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- Safe Mode Button
MiscTab:CreateButton({
    Name = "Activate Safe Mode",
    Callback = function()
        UltimateAntiBan()
        Rayfield:Notify({
            Title = "Safe Mode Enabled",
            Content = "Protections re-applied!",
            Duration = 5,
            Image = 4483362458
        })
    end
})
