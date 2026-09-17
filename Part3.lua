--// =====================================================
--//  BlueNerv Admin Panel v2.0 - PART 3 (Menu UI)
--//  Dev: Milover | Owner: DJC
--//  Telegram: @DeverJomdsCodeCC
--// =====================================================

print("[BlueNerv-P3] Building menu...")

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
local Actions = BN.Actions

local corner = BN.corner
local stroke = BN.stroke
local gradient = BN.gradient

--// ================== BUILD MENU ==================
local function buildMenu()
    local sg = Instance.new("ScreenGui")
    sg.Name = "BN_AdminMenu"; sg.ResetOnSpawn = false; sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local SCREEN = Camera.ViewportSize
    local menuW = math.min(420, SCREEN.X - 30)
    local menuH = math.min(520, SCREEN.Y - 60)

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

    -- HEADER
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
    logoIcon.Text = "🛠"; logoIcon.TextSize = 22
    logoIcon.Parent = logo

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 0, 20)
    title.Position = UDim2.new(0, 60, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "BLUENERV ADMIN"
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

    -- TABS
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

    -- CONTENT
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

    local function createTab(name, label)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 74, 0, 28)
        btn.BackgroundColor3 = THEME.Elem
        btn.Text = label
        btn.TextColor3 = THEME.TextDim
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11; btn.AutoButtonColor = false; btn.Parent = tabsBar
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

    -- SECTION
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

    -- TOGGLE (связан напрямую с SETTINGS)
    local function toggle(parent, text, settingKey, callback)
        local state = SETTINGS[settingKey].Enabled
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 42)
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
            SETTINGS[settingKey].Enabled = state
            if callback then callback(state) end
            TweenService:Create(sw, TweenInfo.new(0.2), {
                BackgroundColor3 = state and THEME.Success or Color3.fromRGB(50, 55, 70)
            }):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {
                Position = state and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
            }):Play()
        end)
    end

    -- SLIDER (связан напрямую с SETTINGS)
    local function slider(parent, text, settingKey, min, max, callback)
        local val = SETTINGS[settingKey].Value
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
            SETTINGS[settingKey].Value = val
            if callback then callback(val) end
        end
        bar.InputBegan:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = true; update(i)
            end
        end)
        UserInputService.InputChanged:Connect(function(i)
            if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                update(i)
            end
        end)
        UserInputService.InputEnded:Connect(function(i)
            if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                drag = false
            end
        end)
    end

    -- BUTTON
    local function button(parent, text, callback, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 42)
        btn.BackgroundColor3 = color or THEME.Accent
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13; btn.AutoButtonColor = false
        btn.Parent = parent; corner(btn, 10)
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- ========== MAIN TAB (Movement) ==========
    local mainTab = createTab("main", "🚶 MOVEMENT")
    section(mainTab, "Speed")
    toggle(mainTab, "Enable Speed", "Speed")
    slider(mainTab, "Speed Value", "Speed", 16, 500)
    section(mainTab, "Jump")
    toggle(mainTab, "Enable Jump Power", "Jump")
    slider(mainTab, "Jump Value", "Jump", 50, 500)
    section(mainTab, "Fly")
    toggle(mainTab, "Enable Fly (WASD + Space)", "Fly")
    slider(mainTab, "Fly Speed", "Fly", 10, 300)
    section(mainTab, "Other")
    toggle(mainTab, "Noclip", "Noclip")
    toggle(mainTab, "Infinite Jump", "InfiniteJump")

    -- ========== WORLD TAB ==========
    local worldTab = createTab("world", "🌍 WORLD")
    section(worldTab, "Gravity")
    toggle(worldTab, "Enable Gravity", "Gravity")
    slider(worldTab, "Gravity Value", "Gravity", 0, 200)
    section(worldTab, "Time")
    toggle(worldTab, "Enable Time of Day", "TimeOfDay")
    slider(worldTab, "Hour (0-24)", "TimeOfDay", 0, 24)
    section(worldTab, "Lighting")
    toggle(worldTab, "Enable Brightness", "Brightness")
    slider(worldTab, "Brightness", "Brightness", 0, 5)
    toggle(worldTab, "Enable Fog", "FogEnd")
    slider(worldTab, "Fog End", "FogEnd", 0, 10000)
    section(worldTab, "Actions")
    button(worldTab, "🔄 Reset Lighting & Gravity", function()
        if Actions.ResetLighting then Actions.ResetLighting() end
    end, THEME.Warning)

    -- ========== CHARACTER TAB ==========
    local charTab = createTab("char", "🎨 CHAR")
    section(charTab, "Body Color")
    toggle(charTab, "Enable Body Color", "BodyColor")
    slider(charTab, "Red (0-255)", "BodyColor", 0, 255, function(v) SETTINGS.BodyColor.R = v end)
    slider(charTab, "Green (0-255)", "BodyColor", 0, 255, function(v) SETTINGS.BodyColor.G = v end)
    slider(charTab, "Blue (0-255)", "BodyColor", 0, 255, function(v) SETTINGS.BodyColor.B = v end)
    section(charTab, "Transparency")
    toggle(charTab, "Enable Transparency", "Transparency")
    slider(charTab, "Transparency %", "Transparency", 0, 100)

    -- ========== TOOLS TAB ==========
    local toolsTab = createTab("tools", "🛠 TOOLS")
    section(toolsTab, "Actions")
    button(toolsTab, "🔫 Fire All Prompts (50 studs)", function()
        if Actions.FirePrompts then Actions.FirePrompts() end
    end, THEME.Accent)
    button(toolsTab, "📋 Copy My Position", function()
        if Actions.CopyPosition then Actions.CopyPosition() end
    end, THEME.Accent)
    button(toolsTab, "⬆ Teleport Up 50 studs", function()
        if Actions.TeleportUp then Actions.TeleportUp() end
    end, THEME.Accent)
    section(toolsTab, "Danger Zone")
    button(toolsTab, "☠ Reset Character", function()
        if Actions.ResetCharacter then Actions.ResetCharacter() end
    end, THEME.Danger)
    button(toolsTab, "🔄 Rejoin Server", function()
        if Actions.Rejoin then Actions.Rejoin() end
    end, THEME.Danger)
    button(toolsTab, "🌐 Server Hop", function()
        if Actions.ServerHop then Actions.ServerHop() end
    end, THEME.Danger)

    -- ========== SETTINGS TAB ==========
    local settingsTab = createTab("settings", "⚙ SET")
    section(settingsTab, "Language")
    local langRow = Instance.new("Frame")
    langRow.Size = UDim2.new(1, 0, 0, 40)
    langRow.BackgroundColor3 = THEME.Elem
    langRow.Parent = settingsTab
    corner(langRow, 10)

    local function makeLangBtn(text, lang, xOffset)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0.5, -8, 0, 32)
        b.Position = UDim2.new(xOffset, 4, 0.5, -16)
        b.BackgroundColor3 = BN.LANG == lang and THEME.Accent or Color3.fromRGB(50,55,70)
        b.Text = text
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 12; b.AutoButtonColor = false
        b.Parent = langRow; corner(b, 8)
        b.MouseButton1Click:Connect(function()
            BN.LANG = lang
            for _, child in ipairs(langRow:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundColor3 = (child.Text:find("English") and lang=="en" or child.Text:find("Русский") and lang=="ru") and THEME.Accent or Color3.fromRGB(50,55,70)
                end
            end
        end)
    end
    makeLangBtn("🇬🇧 English", "en", 0)
    makeLangBtn("🇷🇺 Русский", "ru", 0.5)

    section(settingsTab, "Theme")
    local themeRow = Instance.new("Frame")
    themeRow.Size = UDim2.new(1, 0, 0, 40)
    themeRow.BackgroundColor3 = THEME.Elem
    themeRow.Parent = settingsTab
    corner(themeRow, 10)

    local themeNames = {"Blue", "Purple", "Red", "Green"}
    for i, tname in ipairs(themeNames) do
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 70, 0, 32)
        b.Position = UDim2.new(0, (i-1) * 74 + 6, 0.5, -16)
        b.BackgroundColor3 = THEMES[tname].Accent
        b.Text = tname
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 10; b.AutoButtonColor = false
        b.Parent = themeRow; corner(b, 8)
        b.MouseButton1Click:Connect(function()
            if BN.applyTheme then BN.applyTheme(tname) end
        end)
    end

    section(settingsTab, "Menu")
    slider(settingsTab, "Menu Transparency", "MenuTransparency", 0, 50, function(v)
        main.BackgroundTransparency = v / 100
    end)

    section(settingsTab, "Info")
    local creditInfo = Instance.new("TextLabel")
    creditInfo.Size = UDim2.new(1, 0, 0, 80)
    creditInfo.BackgroundColor3 = THEME.Elem
    creditInfo.Text = "ℹ️ BlueNerv Admin Panel v2.0\n\nDeveloper: Milover\nOwner: DJC\nTelegram: "..BN.AUTHOR.Telegram
    creditInfo.TextColor3 = THEME.Text
    creditInfo.Font = Enum.Font.Gotham
    creditInfo.TextSize = 12
    creditInfo.Parent = settingsTab
    corner(creditInfo, 10)

    -- START TAB
    switchTab("main")

    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    -- Reopen button
    local reopen = Instance.new("TextButton")
    reopen.Size = UDim2.new(0, 60, 0, 60)
    reopen.Position = UDim2.new(0, 20, 0.5, -30)
    reopen.BackgroundColor3 = THEME.Accent
    reopen.Text = "🛠"
    reopen.TextColor3 = Color3.fromRGB(255,255,255)
    reopen.Font = Enum.Font.GothamBold
    reopen.TextSize = 24; reopen.AutoButtonColor = false
    reopen.Active = true; reopen.Draggable = true
    reopen.Visible = false
    reopen.Parent = sg
    corner(reopen, 30)
    stroke(reopen, THEME.Accent2, 2, 0)
    gradient(reopen, THEME.Accent, THEME.Accent2, 45)

    close.MouseButton1Click:Connect(function()
        sg:Destroy()
        local rp = Instance.new("ScreenGui")
        rp.Name = "BN_Reopen"; rp.ResetOnSpawn = false; rp.IgnoreGuiInset = true
        rp.Parent = LocalPlayer:WaitForChild("PlayerGui")
        local rbtn = Instance.new("TextButton")
        rbtn.Size = UDim2.new(0, 60, 0, 60)
        rbtn.Position = UDim2.new(0, 20, 0.5, -30)
        rbtn.BackgroundColor3 = THEME.Accent
        rbtn.Text = "🛠"
        rbtn.TextColor3 = Color3.fromRGB(255,255,255)
        rbtn.Font = Enum.Font.GothamBold
        rbtn.TextSize = 24; rbtn.AutoButtonColor = false
        rbtn.Active = true; rbtn.Draggable = true
        rbtn.Parent = rp
        corner(rbtn, 30)
        stroke(rbtn, THEME.Accent2, 2, 0)
        gradient(rbtn, THEME.Accent, THEME.Accent2, 45)
        rbtn.MouseButton1Click:Connect(function()
            rp:Destroy()
            buildMenu()
        end)
    end)

    print("[BlueNerv-P3] Menu built successfully!")
end

--// ================== START ==================
local ok, err = pcall(buildMenu)
if not ok then
    warn("[BN-MENU ERROR] "..tostring(err))
end

print("[BlueNerv] Admin Panel fully loaded!")
