--// =====================================================
--//  BlueNerv Hub v1.0 - PART 1 (Core + Logic)
--//  Dev: Milover | Owner: DJC
--//  Telegram: @DeverJomdsCodeCC
--//  Key: FREE_324445184
--// =====================================================

print("[BlueNerv-P1] Loading...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.BN = {
    AUTHOR = {Dev = "Milover", Owner = "DJC", Version = "1.0", Telegram = "@DeverJomdsCodeCC", TelegramURL = "https://t.me/DeverJomdsCodeCC"},
    KEY = "FREE_324445184",
    LANG = "en",
    THEME_NAME = "Blue",
}

_G.THEMES = {
    Blue = {
        BG = Color3.fromRGB(10, 14, 26),
        BGAlt = Color3.fromRGB(17, 24, 39),
        Elem = Color3.fromRGB(30, 41, 59),
        Accent = Color3.fromRGB(0, 136, 255),
        Accent2 = Color3.fromRGB(0, 212, 255),
        Success = Color3.fromRGB(0, 229, 160),
        Danger = Color3.fromRGB(255, 59, 92),
        Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(245, 248, 255),
        TextDim = Color3.fromRGB(140, 150, 170),
        Stroke = Color3.fromRGB(45, 60, 90),
    },
    Purple = {
        BG = Color3.fromRGB(15, 15, 22),
        BGAlt = Color3.fromRGB(22, 22, 32),
        Elem = Color3.fromRGB(38, 38, 54),
        Accent = Color3.fromRGB(155, 90, 255),
        Accent2 = Color3.fromRGB(220, 130, 255),
        Success = Color3.fromRGB(80, 230, 130),
        Danger = Color3.fromRGB(255, 75, 100),
        Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(245, 245, 255),
        TextDim = Color3.fromRGB(150, 150, 170),
        Stroke = Color3.fromRGB(70, 70, 100),
    },
    Red = {
        BG = Color3.fromRGB(20, 10, 12),
        BGAlt = Color3.fromRGB(30, 15, 18),
        Elem = Color3.fromRGB(50, 25, 30),
        Accent = Color3.fromRGB(255, 60, 60),
        Accent2 = Color3.fromRGB(255, 130, 60),
        Success = Color3.fromRGB(80, 230, 130),
        Danger = Color3.fromRGB(255, 0, 0),
        Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(255, 240, 240),
        TextDim = Color3.fromRGB(180, 140, 140),
        Stroke = Color3.fromRGB(90, 45, 50),
    },
    Green = {
        BG = Color3.fromRGB(10, 20, 14),
        BGAlt = Color3.fromRGB(15, 30, 20),
        Elem = Color3.fromRGB(25, 50, 35),
        Accent = Color3.fromRGB(0, 200, 100),
        Accent2 = Color3.fromRGB(0, 255, 150),
        Success = Color3.fromRGB(100, 255, 130),
        Danger = Color3.fromRGB(255, 75, 100),
        Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(240, 255, 245),
        TextDim = Color3.fromRGB(140, 180, 150),
        Stroke = Color3.fromRGB(45, 90, 60),
    },
}

_G.SETTINGS = {
    Speed = {Enabled=false, Value=45, Max=100},
    Godmode = {Enabled=false},
    Jump = {Enabled=false, Value=100},
    Fly = {Enabled=false, Speed=50, Key=Enum.KeyCode.F},
    Noclip = {Enabled=false},
    ESP = {Enabled=true, ShowEntity=true, ShowItem=true, ShowHighlight=true, ShowBox=true, ShowDistance=true, MaxDistance=300, Color=Color3.fromRGB(0, 200, 255)},
    DoorGlow = {Enabled=true, Radius=100},
    Fullbright = {Enabled=true},
    NoFog = {Enabled=true},
    AutoLoot = {Enabled=false},
    AutoBreaker = {Enabled=false},
    AutoPuzzle = {Enabled=false},
    AutoHide = {Enabled=false},
    Sound = {Enabled=true},
    MenuTransparency = 0,
}

--// ================== TRANSLATIONS ==================
_G.T = {
    en = {
        title="BlueNerv Hub", by="by Milover & DJC",
        main="Main", visual="Visual", automation="Automation", misc="Misc", settings="Settings",
        speed="Speed Boost", godmode="Godmode", jump="Jump Power", fly="Fly", noclip="Noclip",
        entity_esp="Entity ESP", item_esp="Item ESP", highlight="Highlight", box="Box",
        distance="Show Distance", door_glow="Door Glow (Rainbow)", fullbright="Fullbright", no_fog="No Fog",
        auto_loot="Auto Loot", auto_breaker="Auto Breaker", auto_puzzle="Auto Puzzle", auto_hide="Auto Hide",
        telegram="Join Telegram", discord="Join Discord", credits="Credits", reset="Reset All",
        language="Language", theme="Theme", sound="Menu Sounds", transparency="Menu Transparency",
        hotkeys="Hotkeys", quick="Quick Actions", enter_key="ENTER ACCESS KEY", activate="ACTIVATE",
        invalid="Invalid key!", granted="Access granted!", dev="Developer", owner="Owner",
    },
    ru = {
        title="BlueNerv Hub", by="от Milover & DJC",
        main="Главное", visual="Визуал", automation="Автоматизация", misc="Разное", settings="Настройки",
        speed="Ускорение", godmode="Бессмертие", jump="Сила прыжка", fly="Полёт", noclip="Проход сквозь стены",
        entity_esp="ESP сущностей", item_esp="ESP предметов", highlight="Подсветка", box="Рамка",
        distance="Показывать расстояние", door_glow="Свечение дверей (Радуга)", fullbright="Яркий свет", no_fog="Без тумана",
        auto_loot="Авто-сбор", auto_breaker="Авто-взлом", auto_puzzle="Авто-решение", auto_hide="Авто-прятки",
        telegram="Телеграм", discord="Дискорд", credits="Авторы", reset="Сбросить всё",
        language="Язык", theme="Тема", sound="Звуки меню", transparency="Прозрачность меню",
        hotkeys="Горячие клавиши", quick="Быстрые действия", enter_key="ВВЕДИТЕ КЛЮЧ", activate="АКТИВИРОВАТЬ",
        invalid="Неверный ключ!", granted="Доступ разрешён!", dev="Разработчик", owner="Владелец",
    },
}

_G.Theme = _G.THEMES[_G.BN.THEME_NAME]

--// ================== SPEED BOOST (Anti-Cheat Bypass) ==================
local speedConn
local function startSpeed()
    if speedConn then speedConn:Disconnect() end
    speedConn = RunService.Heartbeat:Connect(function()
        if not _G.SETTINGS.Speed.Enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        -- Не меняем WalkSpeed (обход античита)
        -- Используем CFrame напрямую с плавным движением
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            local speed = _G.SETTINGS.Speed.Value / 16
            hrp.CFrame = hrp.CFrame + moveDir * (speed * 0.5)
        end
    end)
end
startSpeed()

--// ================== GODMODE ==================
local godConn
local function startGodmode()
    if godConn then godConn:Disconnect() end
    godConn = RunService.Heartbeat:Connect(function()
        if not _G.SETTINGS.Godmode.Enabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        -- Держим здоровье на максимуме + убираем ForceField
        if hum.Health < hum.MaxHealth then
            hum.Health = hum.MaxHealth
        end
        -- Защита от разных источников урона
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("ForceField") then obj:Destroy() end
        end
    end)
end
startGodmode()

--// ================== JUMP ==================
RunService.Heartbeat:Connect(function()
    if not _G.SETTINGS.Jump.Enabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if hum.FloorMaterial ~= Enum.Material.Air then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = Instance.new("BodyVelocity")
            bv.Velocity = Vector3.new(0, _G.SETTINGS.Jump.Value / 2, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Parent = hrp
            task.delay(0.15, function() bv:Destroy() end)
        end
    end
end)

--// ================== FLY ==================
local flyGyro, flyVelocity
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    if _G.SETTINGS.Fly.Enabled then
        hum.PlatformStand = true
        if not flyGyro or flyGyro.Parent ~= hrp then
            if flyGyro then flyGyro:Destroy() end
            if flyVelocity then flyVelocity:Destroy() end
            flyGyro = Instance.new("BodyGyro"); flyGyro.P = 9e4
            flyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
            flyGyro.CFrame = hrp.CFrame; flyGyro.Parent = hrp
            flyVelocity = Instance.new("BodyVelocity")
            flyVelocity.Velocity = Vector3.zero
            flyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
            flyVelocity.P = 1250; flyVelocity.Parent = hrp
        end
        flyGyro.CFrame = Camera.CFrame
        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
        if move.Magnitude > 0 then flyVelocity.Velocity = move.Unit * _G.SETTINGS.Fly.Speed
        else flyVelocity.Velocity = Vector3.zero end
    else
        if flyGyro then flyGyro:Destroy(); flyGyro = nil end
        if flyVelocity then flyVelocity:Destroy(); flyVelocity = nil end
        if hum then hum.PlatformStand = false end
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == _G.SETTINGS.Fly.Key then
        _G.SETTINGS.Fly.Enabled = not _G.SETTINGS.Fly.Enabled
    end
end)

--// ================== NOCLIP ==================
RunService.Stepped:Connect(function()
    if not _G.SETTINGS.Noclip.Enabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
    end
end)

--// ================== DOOR GLOW (Rainbow) ==================
local doorParts = {}
local hue = 0
RunService.Heartbeat:Connect(function(dt)
    if not _G.SETTINGS.DoorGlow.Enabled then
        for _, d in pairs(doorParts) do if d.light then d.light:Destroy() end; if d.hl then d.hl:Destroy() end end
        doorParts = {}
        return
    end
    hue = (hue + dt * 0.3) % 1
    local color = Color3.fromHSV(hue, 1, 1)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("door") then
            local dist = (hrp.Position - obj.Position).Magnitude
            if dist <= _G.SETTINGS.DoorGlow.Radius then
                if not doorParts[obj] then
                    local hl = Instance.new("Highlight")
                    hl.FillColor = color
                    hl.FillTransparency = 0.5
                    hl.OutlineTransparency = 0
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Parent = obj
                    local light = Instance.new("PointLight")
                    light.Color = color
                    light.Range = 15
                    light.Brightness = 2
                    light.Parent = obj
                    doorParts[obj] = {hl = hl, light = light}
                else
                    doorParts[obj].hl.FillColor = color
                    doorParts[obj].light.Color = color
                end
            end
        end
    end
end)

--// ================== FULLBRIGHT / NO FOG ==================
RunService.Heartbeat:Connect(function()
    if _G.SETTINGS.Fullbright.Enabled then
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.Ambient = Color3.fromRGB(200, 200, 200)
        Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
    end
    if _G.SETTINGS.NoFog.Enabled then
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
    end
end)

--// ================== ENTITY ESP ==================
local espData = {}
local ENTITY_NAMES = {"Rush","Ambush","Screech","Eyes","Hide","Seek","Figure","Glitch","Jack","Window","Dupe","Shadow"}

local function createESP(entity, label)
    if espData[entity] then return end
    if not entity:IsA("Model") or not entity:FindFirstChild("HumanoidRootPart") then return end
    local hl = Instance.new("Highlight")
    hl.FillColor = _G.SETTINGS.ESP.Color
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = entity

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 40)
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true
    bb.Parent = entity

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 100, 100)
    lbl.TextStrokeTransparency = 0.3
    lbl.TextScaled = true
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = label
    lbl.Parent = bb

    espData[entity] = {hl = hl, bb = bb, lbl = lbl}
end

RunService.Heartbeat:Connect(function()
    if not _G.SETTINGS.ESP.Enabled then
        for _, d in pairs(espData) do d.hl:Destroy(); d.bb:Destroy() end
        espData = {}
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, entity in ipairs(workspace:GetDescendants()) do
        if entity:IsA("Model") then
            for _, ename in ipairs(ENTITY_NAMES) do
                if entity.Name:lower():find(ename:lower()) then
                    local ehrp = entity:FindFirstChild("HumanoidRootPart") or entity:FindFirstChildOfClass("BasePart")
                    if ehrp then
                        local dist = (hrp.Position - ehrp.Position).Magnitude
                        if dist <= _G.SETTINGS.ESP.MaxDistance then
                            createESP(entity, entity.Name)
                        end
                    end
                end
            end
        end
    end
end)

--// ================== AUTO-LOOT / BREAKER / PUZZLE / HIDE ==================
RunService.Heartbeat:Connect(function()
    if not (_G.SETTINGS.AutoLoot.Enabled or _G.SETTINGS.AutoBreaker.Enabled or _G.SETTINGS.AutoPuzzle.Enabled or _G.SETTINGS.AutoHide.Enabled) then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, obj in ipairs(workspace:GetDescendants()) do
        if _G.SETTINGS.AutoLoot.Enabled and obj:IsA("BasePart") then
            if obj.Name:lower():find("gold") or obj.Name:lower():find("key") or obj.Name:lower():find("coin") then
                local dist = (hrp.Position - obj.Position).Magnitude
                if dist < 10 then
                    pcall(function()
                        hrp.CFrame = CFrame.new(obj.Position)
                    end)
                end
            end
        end
        if _G.SETTINGS.AutoBreaker.Enabled and obj:IsA("ProximityPrompt") then
            if obj.Parent and obj.Parent.Name:lower():find("breaker") then
                pcall(function() fireproximityprompt(obj) end)
            end
        end
    end
end)

--// ================== GLOBALS ==================
_G.BN.applyTheme = function(name)
    _G.BN.THEME_NAME = name
    _G.Theme = _G.THEMES[name]
    if _G.BN.refreshMenu then _G.BN.refreshMenu() end
end

print("[BlueNerv-P1] Core loaded! Loading menu...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/DJCscripts/BlueNerv-Hub/main/Part2.lua", true))()
