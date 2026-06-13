-- // Grow a Garden 2 — Pet Spawner GUI (Visual Only)
-- // LocalScript inside StarterGui

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

for _, g in ipairs(PlayerGui:GetChildren()) do
    if g.Name == "PetSpawnerGUI" then g:Destroy() end
end

-------------------------------------------------
-- ACTUAL GROW A GARDEN 2 PETS
-------------------------------------------------
local PETS = {
    -- Common
    { name = "Bee",              rarity = "Common",    emoji = "🐝" },
    { name = "Butterfly",        rarity = "Common",    emoji = "🦋" },
    { name = "Caterpillar",      rarity = "Common",    emoji = "🐛" },
    { name = "Snail",            rarity = "Common",    emoji = "🐌" },
    { name = "Ladybug",          rarity = "Common",    emoji = "🐞" },
    { name = "Earthworm",        rarity = "Common",    emoji = "🪱" },
    { name = "Cricket",          rarity = "Common",    emoji = "🦗" },
    { name = "Ant",              rarity = "Common",    emoji = "🐜" },
    -- Uncommon
    { name = "Frog",             rarity = "Uncommon",  emoji = "🐸" },
    { name = "Hedgehog",         rarity = "Uncommon",  emoji = "🦔" },
    { name = "Rabbit",           rarity = "Uncommon",  emoji = "🐇" },
    { name = "Squirrel",         rarity = "Uncommon",  emoji = "🐿️" },
    { name = "Turtle",           rarity = "Uncommon",  emoji = "🐢" },
    { name = "Duck",             rarity = "Uncommon",  emoji = "🦆" },
    { name = "Chipmunk",         rarity = "Uncommon",  emoji = "🐾" },
    -- Rare
    { name = "Fox",              rarity = "Rare",      emoji = "🦊" },
    { name = "Deer",             rarity = "Rare",      emoji = "🦌" },
    { name = "Owl",              rarity = "Rare",      emoji = "🦉" },
    { name = "Peacock",          rarity = "Rare",      emoji = "🦚" },
    { name = "Flamingo",         rarity = "Rare",      emoji = "🦩" },
    { name = "Parrot",           rarity = "Rare",      emoji = "🦜" },
    { name = "Axolotl",          rarity = "Rare",      emoji = "🫧" },
    -- Legendary
    { name = "Dragon",           rarity = "Legendary", emoji = "🐉" },
    { name = "Phoenix",          rarity = "Legendary", emoji = "🔥" },
    { name = "Kirin",            rarity = "Legendary", emoji = "🦄" },
    { name = "Moonbear",         rarity = "Legendary", emoji = "🐻" },
    { name = "Sunflower Spirit", rarity = "Legendary", emoji = "🌻" },
    { name = "Frost Bunny",      rarity = "Legendary", emoji = "❄️" },
    -- Mythical
    { name = "Starblossom",      rarity = "Mythical",  emoji = "🌸" },
    { name = "Voidpetal",        rarity = "Mythical",  emoji = "🌑" },
    { name = "Sunsprite",        rarity = "Mythical",  emoji = "☀️" },
    { name = "Crystalhorn",      rarity = "Mythical",  emoji = "💎" },
    { name = "Bloomwing",        rarity = "Mythical",  emoji = "🪷" },
    { name = "Galeleaf",         rarity = "Mythical",  emoji = "🍃" },
    { name = "Raccoon",      rarity = "Legendary", emoji = "🦝" },
    { name = "Robin",        rarity = "Rare",      emoji = "🐦" },
    { name = "Bee Queen",    rarity = "Mythical",  emoji = "👑" },
    { name = "Mole",         rarity = "Uncommon",  emoji = "🕳️" },
    { name = "Crow",         rarity = "Rare",      emoji = "🐦‍⬛" },
    { name = "Firefly",      rarity = "Legendary", emoji = "✨" },
    { name = "Mantis",       rarity = "Mythical",  emoji = "🦗" },
}

local RARITY_ORDER = { "Common", "Uncommon", "Rare", "Legendary", "Mythical" }

local RARITY_COLOR = {
    Common    = Color3.fromRGB(160, 210, 130),
    Uncommon  = Color3.fromRGB(70,  160, 230),
    Rare      = Color3.fromRGB(170, 100, 255),
    Legendary = Color3.fromRGB(255, 185,  40),
    Mythical  = Color3.fromRGB(255,  80, 180),
}

local RARITY_DIM = {
    Common    = Color3.fromRGB(18, 36, 14),
    Uncommon  = Color3.fromRGB(14, 28, 46),
    Rare      = Color3.fromRGB(28, 14, 52),
    Legendary = Color3.fromRGB(46, 34,  8),
    Mythical  = Color3.fromRGB(46, 10, 34),
}

-------------------------------------------------
-- HELPERS
-------------------------------------------------
local function tw(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props):Play()
end

local function mkCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 10)
    c.Parent = parent
    return c
end

local function mkStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or Color3.fromRGB(50, 80, 50)
    s.Thickness = thickness or 1.2
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function mkLabel(props, parent)
    local o = Instance.new("TextLabel")
    o.BackgroundTransparency = 1
    o.Font = Enum.Font.GothamBold
    o.TextXAlignment = Enum.TextXAlignment.Center
    o.TextYAlignment = Enum.TextYAlignment.Center
    o.TextWrapped = true
    for k, v in pairs(props) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end

-------------------------------------------------
-- SCREEN GUI
-------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PetSpawnerGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-------------------------------------------------
-- BACKDROP
-------------------------------------------------
local Backdrop = Instance.new("Frame")
Backdrop.Size = UDim2.fromScale(1, 1)
Backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Backdrop.BackgroundTransparency = 0.4
Backdrop.BorderSizePixel = 0
Backdrop.ZIndex = 1
Backdrop.Parent = ScreenGui

-------------------------------------------------
-- FLOATING PARTICLES
-------------------------------------------------
local PARTICLES = { "🌱","🌿","🍃","🌾","🌻","🌷","✨","🍀","🌸","🐝","🦋","💫","🪴","🌼" }

local function spawnParticle()
    local p = Instance.new("TextLabel")
    p.Size = UDim2.fromOffset(24, 24)
    p.BackgroundTransparency = 1
    p.Text = PARTICLES[math.random(1, #PARTICLES)]
    p.TextScaled = true
    p.TextTransparency = math.random(3, 6) / 10
    p.ZIndex = 2
    p.Position = UDim2.new(math.random(2, 98) / 100, 0, 1.05, 0)
    p.Parent = Backdrop

    TweenService:Create(p,
        TweenInfo.new(math.random(55, 100) / 10, Enum.EasingStyle.Linear),
        {
            Position = UDim2.new(p.Position.X.Scale + math.random(-6, 6) / 100, 0, -0.06, 0),
            TextTransparency = 1,
        }
    ):Play()
    task.delay(11, function() if p then p:Destroy() end end)
end

task.spawn(function()
    for i = 1, 12 do task.delay(i * 0.09, spawnParticle) end
    while ScreenGui and ScreenGui.Parent do
        spawnParticle()
        task.wait(math.random(3, 7) / 10)
    end
end)

-------------------------------------------------
-- WINDOW SIZE
-------------------------------------------------
local isMobile = UserInputService.TouchEnabled
local W = isMobile and math.floor(workspace.CurrentCamera.ViewportSize.X * 0.92) or 500
local H = isMobile and math.floor(workspace.CurrentCamera.ViewportSize.Y * 0.84) or 560

-------------------------------------------------
-- MAIN WINDOW
-------------------------------------------------
local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, W, 0, 0) -- starts collapsed for open anim
Window.Position = UDim2.new(0.5, -W/2, 0.5, 0)
Window.BackgroundColor3 = Color3.fromRGB(8, 16, 8)
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.ZIndex = 10
Window.Parent = ScreenGui
mkCorner(Window, 18)
mkStroke(Window, Color3.fromRGB(76, 175, 80), 2)

local winGrad = Instance.new("UIGradient")
winGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 32, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6,  10,  6)),
})
winGrad.Rotation = 135
winGrad.Parent = Window

-------------------------------------------------
-- TOPBAR
-------------------------------------------------
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 46)
Topbar.BackgroundColor3 = Color3.fromRGB(10, 22, 10)
Topbar.BorderSizePixel = 0
Topbar.ZIndex = 11
Topbar.Parent = Window
mkCorner(Topbar, 18)

-- Square off bottom of topbar
local tbFill = Instance.new("Frame")
tbFill.Size = UDim2.new(1, 0, 0, 18)
tbFill.Position = UDim2.new(0, 0, 1, -18)
tbFill.BackgroundColor3 = Color3.fromRGB(10, 22, 10)
tbFill.BorderSizePixel = 0
tbFill.ZIndex = 11
tbFill.Parent = Topbar

mkLabel({
    Size = UDim2.new(1, -50, 1, 0),
    Position = UDim2.new(0, 14, 0, 0),
    Text = "🌱  Grow a Garden 2  —  Pet Spawner",
    TextColor3 = Color3.fromRGB(210, 255, 190),
    TextSize = 15,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 12,
}, Topbar)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(210, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 12
CloseBtn.Parent = Topbar
mkCorner(CloseBtn, 7)

CloseBtn.MouseButton1Click:Connect(function()
    tw(Window, {
        Size = UDim2.new(0, W, 0, 0),
        Position = UDim2.new(0.5, -W/2, 0.5, 0),
    }, 0.3, Enum.EasingStyle.Back)
    task.wait(0.35)
    ScreenGui:Destroy()
end)

-------------------------------------------------
-- DIVIDER
-------------------------------------------------
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -28, 0, 1)
Divider.Position = UDim2.new(0, 14, 0, 46)
Divider.BackgroundColor3 = Color3.fromRGB(40, 90, 40)
Divider.BorderSizePixel = 0
Divider.ZIndex = 11
Divider.Parent = Window

-------------------------------------------------
-- RARITY FILTER TABS
-------------------------------------------------
local FilterBar = Instance.new("Frame")
FilterBar.Size = UDim2.new(1, -28, 0, 30)
FilterBar.Position = UDim2.new(0, 14, 0, 54)
FilterBar.BackgroundTransparency = 1
FilterBar.ZIndex = 11
FilterBar.Parent = Window

local FilterLayout = Instance.new("UIListLayout")
FilterLayout.FillDirection = Enum.FillDirection.Horizontal
FilterLayout.SortOrder = Enum.SortOrder.LayoutOrder
FilterLayout.Padding = UDim.new(0, 5)
FilterLayout.VerticalAlignment = Enum.VerticalAlignment.Center
FilterLayout.Parent = FilterBar

local selectedRarity = "All"
local filterBtns = {}

local FILTERS = { "All", "Common", "Uncommon", "Rare", "Legendary", "Mythical" }

local function applyFilter(rarity, query)
    query = (query or ""):lower()
    for _, entry in ipairs(filterBtns) do
        local active = entry.name == rarity
        tw(entry.btn, {
            BackgroundColor3 = active and (RARITY_COLOR[rarity] or Color3.fromRGB(76, 175, 80)) or Color3.fromRGB(18, 34, 18),
            TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 160, 90),
        }, 0.15)
    end
end

for i, name in ipairs(FILTERS) do
    local color = RARITY_COLOR[name] or Color3.fromRGB(76, 175, 80)
    local btnW = name == "All" and 36 or math.floor((W - 28 - 30) / (#FILTERS - 1) - 5)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, btnW, 0, 26)
    btn.BackgroundColor3 = name == "All" and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(18, 34, 18)
    btn.Text = name == "All" and "All" or name
    btn.TextColor3 = name == "All" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 160, 90)
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.LayoutOrder = i
    btn.ZIndex = 12
    btn.Parent = FilterBar
    mkCorner(btn, 7)

    table.insert(filterBtns, { btn = btn, name = name })

    btn.MouseButton1Click:Connect(function()
        selectedRarity = name
        applyFilter(name)
        -- reapply search too
        local query = (ScreenGui:FindFirstChild("Window") and Window:FindFirstChild("SearchBox") and Window.SearchBox.Text) or ""
        for _, card in ipairs(Window.ScrollFrame:GetChildren()) do
            if card:IsA("TextButton") then
                local petName = card.Name
                local petRarity = card:GetAttribute("Rarity") or ""
                local matchRarity = (name == "All") or (petRarity == name)
                local matchSearch = petName:lower():find(query:lower(), 1, true) ~= nil
                card.Visible = matchRarity and matchSearch
            end
        end
    end)
end

-------------------------------------------------
-- SEARCH BAR
-------------------------------------------------
local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -28, 0, 30)
SearchBox.Position = UDim2.new(0, 14, 0, 92)
SearchBox.BackgroundColor3 = Color3.fromRGB(14, 26, 14)
SearchBox.PlaceholderText = "🔍  Search by name or rarity..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(70, 120, 60)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(210, 255, 190)
SearchBox.TextSize = 12
SearchBox.Font = Enum.Font.Gotham
SearchBox.BorderSizePixel = 0
SearchBox.ClearTextOnFocus = false
SearchBox.ZIndex = 11
SearchBox.Parent = Window
mkCorner(SearchBox, 9)
mkStroke(SearchBox, Color3.fromRGB(45, 95, 45), 1)

local sp = Instance.new("UIPadding")
sp.PaddingLeft = UDim.new(0, 10)
sp.Parent = SearchBox

-------------------------------------------------
-- PET COUNT LABEL
-------------------------------------------------
local CountLbl = mkLabel({
    Size = UDim2.new(1, -28, 0, 16),
    Position = UDim2.new(0, 14, 0, 128),
    Text = #PETS .. " pets available",
    TextColor3 = Color3.fromRGB(70, 130, 60),
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11,
}, Window)

-------------------------------------------------
-- SCROLL FRAME
-------------------------------------------------
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -14, 1, -206)
ScrollFrame.Position = UDim2.new(0, 7, 0, 150)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(76, 175, 80)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ZIndex = 11
ScrollFrame.Parent = Window

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0, math.floor((W - 50) / 3) - 4, 0, 90)
Grid.CellPadding = UDim2.new(0, 6, 0, 6)
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = ScrollFrame

local GridPad = Instance.new("UIPadding")
GridPad.PaddingTop    = UDim.new(0, 6)
GridPad.PaddingLeft   = UDim.new(0, 6)
GridPad.PaddingRight  = UDim.new(0, 6)
GridPad.PaddingBottom = UDim.new(0, 8)
GridPad.Parent = ScrollFrame

-------------------------------------------------
-- BUILD PET CARDS
-------------------------------------------------
local function showNotif(text)
    local notif = mkLabel({
        Size = UDim2.new(0, 240, 0, 34),
        Position = UDim2.new(0.5, -120, 1, -52),
        Text = text,
        TextColor3 = Color3.fromRGB(200, 255, 170),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = Color3.fromRGB(10, 26, 10),
        BackgroundTransparency = 0.05,
        ZIndex = 20,
    }, Window)
    mkCorner(notif, 10)
    mkStroke(notif, Color3.fromRGB(76, 175, 80), 1)

    notif.TextTransparency = 1
    notif.BackgroundTransparency = 1
    tw(notif, { TextTransparency = 0, BackgroundTransparency = 0.05 }, 0.2)
    task.delay(1.8, function()
        tw(notif, { TextTransparency = 1, BackgroundTransparency = 1 }, 0.3)
        task.wait(0.35)
        notif:Destroy()
    end)
end

for i, pet in ipairs(PETS) do
    local rc  = RARITY_COLOR[pet.rarity]
    local rdim = RARITY_DIM[pet.rarity]

    local card = Instance.new("TextButton")
    card.Name = pet.name
    card.LayoutOrder = i
    card.BackgroundColor3 = rdim
    card.BorderSizePixel = 0
    card.Text = ""
    card.AutoButtonColor = false
    card.ZIndex = 12
    card.Parent = ScrollFrame
    card:SetAttribute("Rarity", pet.rarity)
    mkCorner(card, 12)
    local cs = mkStroke(card, rc, 1.2)

    local innerLayout = Instance.new("UIListLayout")
    innerLayout.FillDirection = Enum.FillDirection.Vertical
    innerLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    innerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    innerLayout.Padding = UDim.new(0, 2)
    innerLayout.Parent = card

    -- Emoji icon
    mkLabel({
        Size = UDim2.new(1, 0, 0, 36),
        Text = pet.emoji,
        TextSize = 28,
        ZIndex = 13,
    }, card)

    -- Pet name
    mkLabel({
        Size = UDim2.new(1, -6, 0, 17),
        Text = pet.name,
        TextColor3 = Color3.fromRGB(230, 255, 215),
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        ZIndex = 13,
        TextWrapped = true,
    }, card)

    -- Rarity badge
    local badge = Instance.new("Frame")
    badge.Size = UDim2.new(0, 0, 0, 15)
    badge.AutomaticSize = Enum.AutomaticSize.X
    badge.BackgroundColor3 = rc
    badge.BackgroundTransparency = 0.6
    badge.BorderSizePixel = 0
    badge.ZIndex = 13
    badge.Parent = card
    mkCorner(badge, 4)

    local bp = Instance.new("UIPadding")
    bp.PaddingLeft  = UDim.new(0, 5)
    bp.PaddingRight = UDim.new(0, 5)
    bp.Parent = badge

    mkLabel({
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = pet.rarity,
        TextColor3 = rc,
        TextSize = 8,
        Font = Enum.Font.GothamBold,
        ZIndex = 14,
    }, badge)

    -- Hover
    card.MouseEnter:Connect(function()
        tw(card, { BackgroundColor3 = rdim:Lerp(rc, 0.2) }, 0.15)
        tw(cs, { Thickness = 2.2 }, 0.15)
    end)
    card.MouseLeave:Connect(function()
        tw(card, { BackgroundColor3 = rdim }, 0.15)
        tw(cs, { Thickness = 1.2 }, 0.15)
    end)

    -- Click
    card.MouseButton1Click:Connect(function()
        tw(card, { BackgroundColor3 = rc:Lerp(Color3.fromRGB(255,255,255), 0.1) }, 0.07)
        task.wait(0.09)
        tw(card, { BackgroundColor3 = rdim }, 0.2)
        showNotif("✅  Spawning " .. pet.name .. "...")
    end)
end

-------------------------------------------------
-- SEARCH FILTER LOGIC
-------------------------------------------------
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    local visible = 0
    for _, card in ipairs(ScrollFrame:GetChildren()) do
        if card:IsA("TextButton") then
            local matchSearch  = card.Name:lower():find(query, 1, true) ~= nil
                or (card:GetAttribute("Rarity") or ""):lower():find(query, 1, true) ~= nil
            local matchRarity  = selectedRarity == "All" or card:GetAttribute("Rarity") == selectedRarity
            card.Visible = matchSearch and matchRarity
            if card.Visible then visible += 1 end
        end
    end
    CountLbl.Text = visible .. " pets available"
end)

-------------------------------------------------
-- BOTTOM BAR
-------------------------------------------------
local BottomBar = Instance.new("Frame")
BottomBar.Size = UDim2.new(1, -28, 0, 34)
BottomBar.Position = UDim2.new(0, 14, 1, -44)
BottomBar.BackgroundColor3 = Color3.fromRGB(8, 18, 8)
BottomBar.BorderSizePixel = 0
BottomBar.ZIndex = 11
BottomBar.Parent = Window
mkCorner(BottomBar, 9)

mkLabel({
    Size = UDim2.fromScale(1, 1),
    Text = "🌿  Grow a Garden 2  •  Pet Spawner  •  v2.0.1",
    TextColor3 = Color3.fromRGB(50, 100, 40),
    TextSize = 10,
    Font = Enum.Font.Gotham,
    ZIndex = 12,
}, BottomBar)

-------------------------------------------------
-- OPEN ANIMATION
-------------------------------------------------
tw(Window, {
    Size = UDim2.new(0, W, 0, H),
    Position = UDim2.new(0.5, -W/2, 0.5, -H/2),
}, 0.45, Enum.EasingStyle.Back)

-------------------------------------------------
-- DRAG
-------------------------------------------------
local dragging, dragStart, startPos = false, nil, nil

Topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos  = Window.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        Window.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + d.X,
            startPos.Y.Scale, startPos.Y.Offset + d.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
