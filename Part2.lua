--// =====================================================
--//  BlueNerv Hub v1.1 - PART 2 (Hello + Key + Menu) FIXED
--//  Dev: Milover | Owner: DJC
--// =====================================================

print("[BlueNerv-P2] Loading menu...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local BN = _G.BN
local THEMES = _G.THEMES
local SETTINGS = _G.SETTINGS
local THEME = _G.Theme

--// ================== UTILS ==================
local function corner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 8); c.Parent = p; return c
end
local function stroke(p, c, t, trans)
    local s = Instance.new("UIStroke"); s.Color = c or THEME.Stroke; s.Thickness = t or 1
    s.Transparency = trans or 0; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = p; return s
end
local function gradient(p, c1, c2, rot)
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

    -- Stars
    for i = 1, 40 do
        local star = Instance.new("Frame")
        star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
        star.Position = UDim2.new(math.random(), 0, math.random(), 0)
        star.BackgroundColor3 = Color3.fromRGB(200, 230, 255)
        star.BorderSizePixel = 0; star.ZIndex = 2; star.Parent = sg
        corner(star, 99)
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
    subtitle.Text = "BlueNerv Hub"
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
    main.BackgroundColor3 = THEME.BG
    main.BorderSizePixel = 0; main.ClipsDescendants = true; main.Parent = sg
    corner(main, 16); stroke(main, THEME.Accent, 1.5, 0.3)

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 4)
    topBar.BackgroundColor3 = THEME.Accent
    topBar.BorderSizePixel = 0; topBar.Parent = main
    gradient(topBar, THEME.Accent, THEME.Accent2, 0)

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 60, 0, 60)
    icon.Position = UDim2.new(0.5, -30, 0, 20)
    icon.BackgroundTransparency = 1; icon.Text = "🔵"
    icon.TextSize = 40; icon.Parent = main

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 24)
    title.Position = UDim2.new(0, 0, 0, 88)
    title.BackgroundTransparency = 1
    title.Text = "BLUENERV HUB"
    title.TextColor3 = THEME.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18; title.Parent = main

    local sub = Instance.new("TextLabel")
    sub.Size = UDim2.new(1, 0, 0, 16)
    sub.Position = UDim2.new(0, 0, 0, 114)
    sub.BackgroundTransparency = 1
    sub.Text = "by Milover & DJC"
    sub.TextColor3 = THEME.TextDim
    sub.Font = Enum.Font.Gotham
    sub.TextSize = 11; sub.Parent = main

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -50, 0, 48)
    input.Position = UDim2.new(0, 25, 0, 148)
    input.BackgroundColor3 = THEME.Elem
    input.Text = ""; input.PlaceholderText = "Enter key..."
    input.PlaceholderColor3 = THEME.TextDim
    input.TextColor3 = THEME.Text
    input.Font = Enum.Font.GothamSemibold
    input.TextSize = 15; input.ClearTextOnFocus = false; input.Parent = main
    corner(input, 12); local inpStroke = stroke(input, THEME.Stroke, 1, 0)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -50, 0, 48)
    btn.Position = UDim2.new(0, 25, 0, 206)
    btn.BackgroundColor3 = THEME.Accent
    btn.Text = "🔓  ACTIVATE"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15; btn.AutoButtonColor = false; btn.Parent = main
    corner(btn, 12); gradient(btn, THEME.Accent, THEME.Accent2, 0)

    local tg = Instance.new("TextButton")
    tg.Size = UDim2.new(1, -50, 0, 40)
    tg.Position = UDim2.new(0, 25, 0, 262)
    tg.BackgroundColor3 = THEME.Telegram
    tg.Text = "📢  TELEGRAM"
    tg.TextColor3 = Color3.fromRGB(255, 255, 255)
    tg.Font = Enum.Font.GothamBold
    tg.TextSize = 13; tg.AutoButtonColor = false; tg.Parent = main
    corner(tg, 12)
    tg.MouseButton1Click:Connect(function()
        pcall(function() game:GetService("GuiService"):OpenBrowserWindow(BN.AUTHOR.TelegramURL) end)
        if setclipboard then pcall(function() setclipboard(BN.AUTHOR.TelegramURL) end) end
    end)

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -50, 0, 20)
    status.Position = UDim2.new(0, 25, 1, -30)
    status.BackgroundTransparency = 1; status.Text = ""
    status.TextColor3 = THEME.Danger
    status.Font = Enum.Font.Gotham
    status.TextSize = 12; status.Parent = main

    local function activate()
        if input.Text == BN.KEY then
            status.Text = "✅ Access granted!"; status.TextColor3 = THEME.Success
            inpStroke.Color = THEME.Success
            task.wait(0.5); sg:Destroy()
            if callback then callback() end
        else
            status.Text = "❌ Invalid key!"; status.TextColor3 = THEME.Danger
            inpStroke.Color = THEME.Danger
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

--// ================== BUILD MENU ==================
local function buildMenu()
    print("[BN-P2] Building menu...")

    local sg = Instance.new("ScreenGui")
    sg.Name = "BN_Menu"; sg.ResetOnSpawn = false; sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local SCREEN = Camera.ViewportSize
    local menuW = math.min(400, SCREEN.X - 30)
    local menuH = math.min(480, SCREEN.Y - 60)

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, menuW, 0, menuH)
    main.Position = UDim2.new(0.5, -menuW/2, 0.5, -menuH/2)
    main.BackgroundColor3 = THEME.BG
    main.BorderSizePixel = 0; main.Active = true; main.Draggable = true
    main.ClipsDescendants = true; main.Parent = sg
    corner(main, 16); stroke(main, THEME.Accent, 1.5, 0.3)

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 4)
    topBar.BackgroundColor3 = THEME.Accent
    topBar.BorderSizePixel = 0; topBar.Parent = main
    gradient(topBar, THEME.Accent, THEME.Accent2, 0)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 56)
    header.BackgroundColor3 = THEME.BGAlt
    header.BorderSizePixel = 0; header.Parent = main

    local logo = Instance.new("Frame")
    logo.Size = UDim2.new(0, 40, 0, 40)
    logo.Position = UDim2.new(0, 12, 0.5, -20)
    logo.BackgroundColor3 = THEME.Accent; logo.Parent = header
    corner(logo, 12); gradient(logo, THEME.Accent, THEME.Accent2, 45)

    local logoIcon = Instance.new("TextLabel")
    logoIcon.Size = UDim2.new(1, 0, 1, 0)
    logoIcon.BackgroundTransparency = 1
    logoIcon.Text = "🔵"; logoIcon.TextSize = 22
    logoIcon.Parent = logo

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 0, 20)
    title.Position = UDim2.new(0, 60, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "BLUENERV HUB"
    title.TextColor3 = THEME.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -100, 0, 16)
    subtitle.Position = UDim2.new(0, 60, 0, 30)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "by Milover & DJC"
    subtitle.TextColor3 = THEME.Accent2
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 10
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = header

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 40, 0, 40)
    close.Position = UDim2.new(1, -50, 0.5, -20)
    close.BackgroundColor3 = THEME.Danger
    close.Text = "✕"; close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 18; close.AutoButtonColor = false; close.Parent = header
    corner(close, 10)

    local tabsBar = Instance.new("Frame")
    tabsBar.Size = UDim2.new(1, -16, 0, 38)
    tabsBar.Position = UDim2.new(0, 8, 0, 62)
    tabsBar.BackgroundColor3 = THEME.BGAlt; tabsBar.Parent = main
    corner(tabsBar, 10)

    local tabsLayout = Instance.new("UIListLayout")
    tabsLayout.FillDirection = Enum.FillDirection.Horizontal
    tabsLayout.Padding = UDim.new(0, 4)
    tabsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabsLayout.Parent = tabsBar

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -16, 1, -120)
    content.Position = UDim2.new(0, 8, 0, 108)
    content.BackgroundTransparency = 1; content.BorderSizePixel = 0
    content.ScrollBarThickness = 5
    content.ScrollBarImageColor3 = THEME.Accent
    content.CanvasSize = UDim2.new(0, 0, 0, 5000)
    content.ScrollingDirection = Enum.ScrollingDirection.Y
    content.Parent = main

    local pages = {}
    local tabButtons = {}

    local function switchTab(name)
        for tabName, page in pairs(pages) do page.Visible = tabName == name end
        for tabName, btn in pairs(tabButtons) do
            local active = tabName == name
            TweenService:Create(btn, TweenInfo.new(0.2), {
                BackgroundColor3 = active and THEME.Accent or THEME.Elem
            }):Play()
            btn.TextColor3 = active and Color3.fromRGB(255,255,255) or THEME.TextDim
        end
    end

    local function createTab(name, icon)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 68, 0, 28)
        btn.BackgroundColor3 = THEME.Elem
        btn.Text = icon; btn.TextColor3 = THEME.TextDim
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14; btn.AutoButtonColor = false; btn.Parent = tabsBar
        corner(btn, 8)

        local page = Instance.new("Frame")
        page.Size = UDim2.new(1, -8, 1, -12)
        page.Position = UDim2.new(0, 4, 0, 6)
        page.BackgroundTransparency = 1; page.Visible = false; page.Parent = content

        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Padding = UDim.new(0, 6)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Parent = page

        pages[name] = page
        tabButtons[name] = btn

        btn.MouseButton1Click:Connect(function() switchTab(name) end)
        return page
    end

    local function section(parent, text)
        local sec = Instance.new("TextLabel")
        sec.Size = UDim2.new(1, 0, 0, 24)
        sec.BackgroundTransparency = 1
        sec.Text = "▬ " .. string.upper(text) .. " ▬"
        sec.TextColor3 = THEME.Accent2
        sec.Font = Enum.Font.GothamBold
        sec.TextSize = 11
        sec.TextXAlignment = Enum.TextXAlignment.Left
        sec.Parent = parent
    end

    local function toggle(parent, text, initial, cb)
        local state = initial
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 46)
        btn.BackgroundColor3 = THEME.Elem; btn.Text = ""
        btn.AutoButtonColor = false; btn.Parent = parent
        corner(btn, 10)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -80, 1, 0)
        lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text; lbl.TextColor3 = THEME.Text
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = btn

        local sw = Instance.new("Frame")
        sw.Size = UDim2.new(0, 48, 0, 26)
        sw.Position = UDim2.new(1, -60, 0.5, -13)
        sw.BackgroundColor3 = state and THEME.Success or Color3.fromRGB(50, 55, 70)
        sw.Parent = btn; corner(sw, 13)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 22, 0, 22)
        knob.Position = state and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.Parent = sw; corner(knob, 11)

        btn.MouseButton1Click:Connect(function()
            state = not state
            if cb then cb(state) end
            TweenService:Create(sw, TweenInfo.new(0.2), {
                BackgroundColor3 = state and THEME.Success or Color3.fromRGB(50, 55, 70)
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {
                Position = state and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
            }):Play()
        end)
    end

    local function slider(parent, text, min, max, init, cb)
        local val = init
        local f = Instance.new("Frame")
        f.Size = UDim2.new(1, 0, 0, 58)
        f.BackgroundColor3 = THEME.Elem; f.Parent = parent
        corner(f, 10)

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -80, 0, 20)
        lbl.Position = UDim2.new(0, 14, 0, 6)
        lbl.BackgroundTransparency = 1
        lbl.Text = text; lbl.TextColor3 = THEME.Text
        lbl.Font = Enum.Font.GothamSemibold
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = f

        local vl = Instance.new("TextLabel")
        vl.Size = UDim2.new(0, 60, 0, 20)
        vl.Position = UDim2.new(1, -74, 0, 6)
        vl.BackgroundTransparency = 1
        vl.Text = tostring(val); vl.TextColor3 = THEME.Accent2
        vl.Font = Enum.Font.GothamBold
        vl.TextSize = 13
        vl.TextXAlignment = Enum.TextXAlignment.Right
        vl.Parent = f

        local bar = Instance.new("Frame")
        bar.Size = UDim2.new(1, -28, 0, 10)
        bar.Position = UDim2.new(0, 14, 1, -20)
        bar.BackgroundColor3 = Color3.fromRGB(45, 50, 65)
        bar.Parent = f; corner(bar, 5)

        local pct = (val - min) / (max - min)
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new(pct, 0, 1, 0)
        fill.BackgroundColor3 = THEME.Accent
        fill.BorderSizePixel = 0; fill.Parent = bar; corner(fill, 5)
        gradient(fill, THEME.Accent, THEME.Accent2, 0)

        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.AnchorPoint = Vector2.new(0.5, 0.5)
        knob.Position = UDim2.new(pct, 0, 0.5, 0)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.Parent = bar; corner(knob, 9)
        stroke(knob, THEME.Accent, 2, 0)

        local drag = false
        local function update(inp)
            local p = math.clamp((inp.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(p, 0, 1, 0)
            knob.Position = UDim2.new(p, 0, 0.5, 0)
            val = math.floor(min + (max - min) * p)
            vl.Text = tostring(val)
            if cb then cb(val) end
        end
        bar.InputBegan:Conne
