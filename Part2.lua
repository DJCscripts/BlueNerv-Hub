--// =====================================================
--//  BlueNerv Admin Panel v2.0 - PART 2 (Logic)
--//  Dev: Milover | Owner: DJC
--//  Telegram: @DeverJomdsCodeCC
--// =====================================================

print("[BlueNerv-P2] Loading logic...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local SETTINGS = _G.SETTINGS

--// ================== HELPER ==================
local function getChar()
    return LocalPlayer.Character
end
local function getHum()
    local ch = getChar()
    return ch and ch:FindFirstChildOfClass("Humanoid")
end
local function getHRP()
    local ch = getChar()
    return ch and ch:FindFirstChild("HumanoidRootPart")
end

--// ================== MOVEMENT: Speed ==================
RunService.Heartbeat:Connect(function()
    local hum = getHum()
    if not hum then return end
    if SETTINGS.Speed.Enabled then
        hum.WalkSpeed = SETTINGS.Speed.Value
    else
        hum.WalkSpeed = 16
    end
end)

--// ================== MOVEMENT: Jump ==================
RunService.Heartbeat:Connect(function()
    local hum = getHum()
    if not hum then return end
    if SETTINGS.Jump.Enabled then
        hum.JumpPower = SETTINGS.Jump.Value
        hum.UseJumpPower = true
    else
        hum.JumpPower = 50
    end
end)

--// ================== MOVEMENT: Fly ==================
local flyGyro, flyVelocity
RunService.RenderStepped:Connect(function()
    local hrp = getHRP()
    local hum = getHum()
    if not hrp or not hum then return end

    if SETTINGS.Fly.Enabled then
        hum.PlatformStand = true
        if not flyGyro or flyGyro.Parent ~= hrp then
            if flyGyro then flyGyro:Destroy() end
            if flyVelocity then flyVelocity:Destroy() end
            flyGyro = Instance.new("BodyGyro")
            flyGyro.P = 9e4
            flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            flyGyro.CFrame = hrp.CFrame
            flyGyro.Parent = hrp
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.Velocity = Vector3.zero
            flyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            flyVelocity.P = 1250
            flyVelocity.Parent = hrp
        end
        flyGyro.CFrame = Camera.CFrame
        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then
            flyVelocity.Velocity = move.Unit * SETTINGS.FlySpeed.Value
        else
            flyVelocity.Velocity = Vector3.zero
        end
    else
        if flyGyro then flyGyro:Destroy(); flyGyro = nil end
        if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
        if hum then hum.PlatformStand = false end
    end
end)

--// ================== MOVEMENT: Noclip ==================
RunService.Stepped:Connect(function()
    if not SETTINGS.Noclip.Enabled then return end
    local ch = getChar()
    if not ch then return end
    for _, part in ipairs(ch:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end)

--// ================== MOVEMENT: Infinite Jump ==================
UserInputService.JumpRequest:Connect(function()
    if not SETTINGS.InfiniteJump.Enabled then return end
    local hum = getHum()
    if hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

--// ================== WORLD: Gravity ==================
RunService.Heartbeat:Connect(function()
    if SETTINGS.Gravity.Enabled then
        workspace.Gravity = SETTINGS.Gravity.Value
    else
        workspace.Gravity = 196.2
    end
end)

--// ================== WORLD: Time of Day ==================
RunService.Heartbeat:Connect(function()
    if SETTINGS.TimeOfDay.Enabled then
        Lighting.ClockTime = SETTINGS.TimeOfDay.Value
    end
end)

--// ================== WORLD: Brightness ==================
RunService.Heartbeat:Connect(function()
    if SETTINGS.Brightness.Enabled then
        Lighting.Brightness = SETTINGS.Brightness.Value
    else
        Lighting.Brightness = 1
    end
end)

--// ================== WORLD: Fog End ==================
RunService.Heartbeat:Connect(function()
    if SETTINGS.FogEnd.Enabled then
        Lighting.FogEnd = SETTINGS.FogEnd.Value
    else
        Lighting.FogEnd = 100000
    end
end)

--// ================== CHARACTER: Body Color ==================
RunService.Heartbeat:Connect(function()
    if not SETTINGS.BodyColor.Enabled then return end
    local ch = getChar()
    if not ch then return end
    local color = Color3.fromRGB(SETTINGS.BodyColor.R, SETTINGS.BodyColor.G, SETTINGS.BodyColor.B)
    for _, part in ipairs(ch:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Color = color
        end
    end
end)

--// ================== CHARACTER: Transparency ==================
RunService.Heartbeat:Connect(function()
    if not SETTINGS.Transparency.Enabled then return end
    local ch = getChar()
    if not ch then return end
    local trans = SETTINGS.Transparency.Value / 100
    for _, part in ipairs(ch:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Transparency = trans
        end
    end
end)

--// ================== CHARACTER: Size ==================
RunService.Heartbeat:Connect(function()
    if not SETTINGS.Size.Enabled then return end
    local ch = getChar()
    if not ch then return end
    local hum = getHum()
    if not hum then return end
    if SETTINGS.Size.Value == "Small" then
        hum.BodyDepthScale.Value = 0.5
        hum.BodyWidthScale.Value = 0.5
        hum.BodyHeightScale.Value = 0.5
        hum.HeadScale.Value = 0.5
    elseif SETTINGS.Size.Value == "Big" then
        hum.BodyDepthScale.Value = 2
        hum.BodyWidthScale.Value = 2
        hum.BodyHeightScale.Value = 2
        hum.HeadScale.Value = 2
    else
        hum.BodyDepthScale.Value = 1
        hum.BodyWidthScale.Value = 1
        hum.BodyHeightScale.Value = 1
        hum.HeadScale.Value = 1
    end
end)

--// ================== CHARACTER: Material ==================
RunService.Heartbeat:Connect(function()
    if not SETTINGS.Material.Enabled then return end
    local ch = getChar()
    if not ch then return end
    local mat = Enum.Material.Plastic
    if SETTINGS.Material.Value == "Neon" then mat = Enum.Material.Neon
    elseif SETTINGS.Material.Value == "Glass" then mat = Enum.Material.Glass
    elseif SETTINGS.Material.Value == "ForceField" then mat = Enum.Material.ForceField
    elseif SETTINGS.Material.Value == "Metal" then mat = Enum.Material.Metal end
    for _, part in ipairs(ch:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Material = mat
        end
    end
end)

--// ================== ACTIONS ==================
_G.BN.Actions = {
    ResetCharacter = function()
        local hum = getHum()
        if hum then hum.Health = 0 end
    end,
    
    FirePrompts = function()
        local ch = getChar()
        if not ch then return end
        local hrp = getHRP()
        if not hrp then return end
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                local parent = prompt.Parent
                if parent and parent:IsA("BasePart") then
                    local dist = (hrp.Position - parent.Position).Magnitude
                    if dist < 50 then
                        pcall(function() fireproximityprompt(prompt) end)
                    end
                end
            end
        end
    end,
    
    CopyPosition = function()
        local hrp = getHRP()
        if hrp and setclipboard then
            local pos = hrp.Position
            setclipboard(string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z))
        end
    end,
    
    TeleportUp = function()
        local hrp = getHRP()
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
        end
    end,
    
    Rejoin = function()
        pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end)
    end,
    
    ServerHop = function()
        pcall(function()
            local TS = game:GetService("TeleportService")
            local Http = game:GetService("HttpService")
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local ok, res = pcall(function() return Http:JSONDecode(game:HttpGet(url)) end)
            if ok and res and res.data then
                for _, srv in ipairs(res.data) do
                    if srv.playing < srv.maxPlayers and srv.id ~= game.JobId then
                        TS:TeleportToPlaceInstance(game.PlaceId, srv.id, LocalPlayer)
                        return
                    end
                end
            end
        end)
    end,
    
    ResetLighting = function()
        Lighting.Brightness = 1
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        workspace.Gravity = 196.2
    end,
}

--// ================== APPLY THEME ==================
_G.BN.applyTheme = function(name)
    _G.BN.THEME_NAME = name
    _G.Theme = _G.THEMES[name]
end

print("[BlueNerv-P2] Logic loaded! Loading Part3...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/DJCscripts/BlueNerv-Hub/main/Part3.lua", true))()
