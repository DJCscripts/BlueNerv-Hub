--// =====================================================
--//  BlueNerv Admin Panel v2.0 - PART 1
--//  Dev: Milover | Owner: DJC
--//  Telegram: @DeverJomdsCodeCC
--//  Key: FREE_324445184
--// =====================================================

print("[BlueNerv-P1] Loading...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.BN = {
    AUTHOR = {Dev = "Milover", Owner = "DJC", Version = "2.0", Telegram = "@DeverJomdsCodeCC", TelegramURL = "https://t.me/DeverJomdsCodeCC"},
    KEY = "FREE_324445184",
    LANG = "en",
    THEME_NAME = "Blue",
}

_G.THEMES = {
    Blue = {
        BG = Color3.fromRGB(10, 14, 26), BGAlt = Color3.fromRGB(17, 24, 39),
        Elem = Color3.fromRGB(30, 41, 59), Accent = Color3.fromRGB(0, 136, 255),
        Accent2 = Color3.fromRGB(0, 212, 255), Success = Color3.fromRGB(0, 229, 160),
        Danger = Color3.fromRGB(255, 59, 92), Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(245, 248, 255), TextDim = Color3.fromRGB(140, 150, 170),
        Stroke = Color3.fromRGB(45, 60, 90),
    },
    Purple = {
        BG = Color3.fromRGB(15, 15, 22), BGAlt = Color3.fromRGB(22, 22, 32),
        Elem = Color3.fromRGB(38, 38, 54), Accent = Color3.fromRGB(155, 90, 255),
        Accent2 = Color3.fromRGB(220, 130, 255), Success = Color3.fromRGB(80, 230, 130),
        Danger = Color3.fromRGB(255, 75, 100), Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(245, 245, 255), TextDim = Color3.fromRGB(150, 150, 170),
        Stroke = Color3.fromRGB(70, 70, 100),
    },
    Red = {
        BG = Color3.fromRGB(20, 10, 12), BGAlt = Color3.fromRGB(30, 15, 18),
        Elem = Color3.fromRGB(50, 25, 30), Accent = Color3.fromRGB(255, 60, 60),
        Accent2 = Color3.fromRGB(255, 130, 60), Success = Color3.fromRGB(80, 230, 130),
        Danger = Color3.fromRGB(255, 0, 0), Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(255, 240, 240), TextDim = Color3.fromRGB(180, 140, 140),
        Stroke = Color3.fromRGB(90, 45, 50),
    },
    Green = {
        BG = Color3.fromRGB(10, 20, 14), BGAlt = Color3.fromRGB(15, 30, 20),
        Elem = Color3.fromRGB(25, 50, 35), Accent = Color3.fromRGB(0, 200, 100),
        Accent2 = Color3.fromRGB(0, 255, 150), Success = Color3.fromRGB(100, 255, 130),
        Danger = Color3.fromRGB(255, 75, 100), Telegram = Color3.fromRGB(0, 136, 204),
        Text = Color3.fromRGB(240, 255, 245), TextDim = Color3.fromRGB(140, 180, 150),
        Stroke = Color3.fromRGB(45, 90, 60),
    },
}

_G.SETTINGS = {
    Speed = {Enabled=false, Value=100},
    Jump = {Enabled=false, Value=100},
    Fly = {Enabled=false, Speed=50},
    Noclip = {Enabled=false},
    InfiniteJump = {Enabled=false},
    Gravity = {Enabled=false, Value=196},
    TimeOfDay = {Enabled=false, Value=14},
    Brightness = {Enabled=false, Value=2},
    FogEnd = {Enabled=false, Value=1000},
    BodyColor = {Enabled=false, R=255, G=255, B=255},
    Transparency = {Enabled=false, Value=0},
    Size = {Enabled=false, Value="Normal"},
    Material = {Enabled=false, Value="Plastic"},
    Sound = {Enabled=true},
    MenuTransparency = 0,
}

_G.Theme = _G.THEMES[_G.BN.THEME_NAME]

--// ================== UI UTILS ==================
_G.BN.corner = function(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 8); c.Parent = p; return c
end
_G.BN.stroke = function(p, c, t, trans)
    local s = Instance.new("UIStroke"); s.Color = c or _G.Theme.Stroke; s.Thickness = t or 1
    s.Transparency = trans or 0; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = p; return s
end
_G.BN.gradient = function(p, c1, c2, rot)
    local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0; g.Parent = p; return g
end

--// ================== HELLO ANIMATION ==================
local function showHelloAnimation(callback)
    local sg = Instance.new("ScreenGui")
    sg.Name = "BN_Hello"; sg.ResetOnSpawn = false; sg.IgnoreGuiInset = true
    sg.DisplayOrder = 9999; sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(5, 10, 25)
    bg.BorderSizePixel = 0; bg.ZIndex = 1; bg.Parent = sg
    local bgGrad = Instance.new("UIGradient")
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 10, 25)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 30, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 10, 25)),
    })
    bgGrad.Rotation = 90; bgGrad.Parent = bg

    for i = 1, 40 do
        local star = Instance.new("Frame")
        star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
        star.Position = UDim2.new(math.random(), 0, math.random(), 0)
        star.BackgroundColor3 = Color3.fromRGB(200, 230, 255)
        star.BorderSizePixel = 0; star.ZIndex = 2; star.Parent = sg
        _G.BN.corner(star, 99)
        TweenService:Create(star, TweenInfo.new(math.random(15, 30), Enum.EasingStyle.Linear), {
            Position = UDim2.new(math.random(), 0, 1, 0)
        }):Play()
    end

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 200)
    container.Position = UDim2.new(0, 0, 0.5, -100)
    container.BackgroundTransparency = 1; container.ZIndex = 3
    container.Parent = sg

    local letters = {"H", "E", "L", "L", "O"}
    local labels = {}
    for i, letter in ipairs(letters) do
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0, 0, 0, 0)
        lbl.Position = UDim2.new(0.5, 0, 0.5, 0)
        lbl.AnchorPoint = Vector2.new(0.5, 0.5)
        lbl.BackgroundTransparency = 1
        lbl.Text = letter
        lbl.TextColor3 = Color3.fromRGB(0, 200, 255)
        lbl.TextStrokeTransparency = 0.3
        lbl.TextStrokeColor3 = Color3.fromRGB(0, 136, 255)
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextScaled = true; lbl.ZIndex = 4; lbl.Parent = container
        labels[i] = lbl
    end

    local letterW = 60
    local totalW = letterW * #letters
    local startX = -totalW / 2 + letterW / 2

    for i, lbl in ipairs(labels) do
        task.wait(0.18)
        lbl.Position = UDim2.new(0.5, startX + (i-1) * letterW, 0.5, 0)
        TweenService:Create(lbl, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 50, 0, 100)
        }):Play()
    end

    task.wait(0.6)

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 30)
    subtitle.Position = UDim2.new(0, 0, 0.5, 80)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "BlueNerv Admin Panel"
    subtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    subtitle.Font = Enum.Font.GothamBold
    subtitle.TextSize = 22
    subtitle.TextTransparency = 1
    subtitle.ZIndex = 4; subtitle.Parent = container
    TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    local credit = Instance.new("TextLabel")
    credit.Size = UDim2.new(1, 0, 0, 20)
    credit.Position = UDim2.new(0, 0, 0.5, 115)
    credit.BackgroundTransparency = 1
    credit.Text = "by Milover & DJC"
    credit.TextColor3 = Color3.fromRGB(0, 200, 255)
    credit.Font = Enum.Font.Gotham
    credit.TextSize = 13
    credit.TextTransparency = 1
    credit.ZIndex = 4; credit.Parent = container
    TweenService:Create(credit, TweenInfo.new(0.5), {TextTransparency = 0}):Play()

    task.wait(1.2)

    TweenService:Create(bg, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    for _, lbl in ipairs(labels) do
        TweenService:Create(lbl, TweenInfo.new(0.6), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    end
    TweenService:Create(subtitle, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
    TweenService:Create(credit, TweenInfo.new(0.6), {TextTransparency = 1}):Play()

    task.wait(0.7)
    sg:Destroy()
    if callback then callback() end
end

--// ================== KEY SCREEN ==================
local function keyScreen(callback)
    local sg = Instance.new("ScreenGui")
    sg.Name = "BN_KeyUI"; sg.ResetOnSpawn = false; sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999; sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.new(0, 0, 0)
    bg.BackgroundTransparency = 0.4
    bg.BorderSizePixel = 0; bg.Parent = sg

    local SCREEN = Camera.ViewportSize
    local w = math.min(370, SCREEN.X - 30)
    local h = 360

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, w, 0, h)
    main.Position = UDim2.new(0.5, -w/2, 0.5, -h/2)
    main.BackgroundColor3 = _G.Theme.BG
    main.BorderSizePixel = 0; main.ClipsDescendants = true; main.Parent = sg
    _G.BN.corner(main, 16); _G.BN.stroke(main, _G.Theme.Accent, 1.5, 0.3)

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 4)
    topBar.BackgroundColor3 = _G.Theme.Accent
    topBar.BorderSizePixel = 0; topBar.Parent = main
    _G.BN.gradient(topBar, _G.Theme.Accent, _G.Theme.Accent2, 0)

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 60, 0, 60)
    icon.Position = UDim2.new(0.5, -30, 0, 20)
    icon.BackgroundTransparency = 1; icon.Text = "🛠"
    icon.TextSize = 40; icon.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 24)
    title.Position = UDim2.new(0, 0, 0, 88)
    title.BackgroundTransparency = 1
    title.Text = "BLUENERV ADMIN"
    title.TextColor3 = _G.Theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18; title.Parent = main

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 16)
    sub.Position = UDim2.new(0, 0, 0, 114)
    sub.BackgroundTransparency = 1
    sub.Text = "by Milover & DJC"
    sub.TextColor3 = _G.Theme.TextDim
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 11; sub.Parent = main

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -50, 0, 48)
    input.Position = UDim2.new(0, 25, 0, 148)
    input.BackgroundColor3 = _G.Theme.Elem
    input.Text = ""; input.PlaceholderText = "Enter key..."
    input.PlaceholderColor3 = _G.Theme.TextDim
    input.TextColor3 = _G.Theme.Text
    input.Font = Enum.Font.GothamSemibold
    input.TextSize = 15; input.ClearTextOnFocus = false; input.Parent = main
    _G.BN.corner(input, 12); local inpStroke = _G.BN.stroke(input, _G.Theme.Stroke, 1, 0)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -50, 0, 48)
    btn.Position = UDim2.new(0, 25, 0, 206)
    btn.BackgroundColor3 = _G.Theme.Accent
    btn.Text = "🔓  ACTIVATE"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15; btn.AutoButtonColor = false; btn.Parent = main
    _G.BN.corner(btn, 12); _G.BN.gradient(btn, _G.Theme.Accent, _G.Theme.Accent2, 0)

    local tg = Instance.new("TextButton")
    tg.Size = UDim2.new(1, -50, 0, 40)
    tg.Position = UDim2.new(0, 25, 0, 262)
    tg.BackgroundColor3 = _G.Theme.Telegram
    tg.Text = "📢  TELEGRAM"
    tg.TextColor3 = Color3.fromRGB(255, 255, 255)
    tg.Font = Enum.Font.GothamBold
    tg.TextSize = 13; tg.AutoButtonColor = false; tg.Parent = main
    _G.BN.corner(tg, 12)
    tg.MouseButton1Click:Connect(function()
        pcall(function() game:GetService("GuiService"):OpenBrowserWindow(_G.BN.AUTHOR.TelegramURL) end)
        if setclipboard then pcall(function() setclipboard(_G.BN.AUTHOR.TelegramURL) end) end
    end)

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -50, 0, 20)
    status.Position = UDim2.new(0, 25, 1, -30)
    status.BackgroundTransparency = 1; status.Text = ""
    status.TextColor3 = _G.Theme.Danger
    status.Font = Enum.Font.Gotham
    status.TextSize = 12; status.Parent = main

    local function activate()
        if input.Text == _G.BN.KEY then
            status.Text = "✅ Access granted!"; status.TextColor3 = _G.Theme.Success
            inpStroke.Color = _G.Theme.Success
            task.wait(0.5); sg:Destroy()
            if callback then callback() end
        else
            status.Text = "❌ Invalid key!"; status.TextColor3 = _G.Theme.Danger
            inpStroke.Color = _G.Theme.Danger
            local orig = main.Position
            for i = 1, 4 do
                TweenService:Create(main, TweenInfo.new(0.05), {
                    Position = orig + UDim2.new(0, (i % 2 == 0 and 8 or -8), 0, 0)
                }):Play()
                task.wait(0.05)
            end
            TweenService:Create(main, TweenInfo.new(0.05), {Position = orig}):Play()
        end
    end
    btn.MouseButton1Click:Connect(activate)
    input.FocusLost:Connect(function(e) if e then activate() end end)
end

--// ================== START ==================
task.spawn(function()
    local ok1, err1 = pcall(showHelloAnimation, function()
        print("[BlueNerv-P1] Hello animation done")
        local ok2, err2 = pcall(keyScreen, function()
            print("[BlueNerv-P1] Key accepted! Loading Part2...")
            loadstring(game:HttpGet("https://raw.githubusercontent.com/DJCscripts/BlueNerv-Hub/main/Part2.lua", true))()
        end)
        if not ok2 then warn("[BN-KEY ERROR] "..tostring(err2)) end
    end)
    if not ok1 then warn("[BN-HELLO ERROR] "..tostring(err1)) end
end)
