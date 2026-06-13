-- // Grow a Garden 2 — Pet Spawner GUI v4
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
-- ALL 10 CONFIRMED GROW A GARDEN 2 PETS
-------------------------------------------------
local PETS = {
    -- Common
    { name = "Frog",             rarity = "Common",    emoji = "🐸",  price = "10k"  },
    { name = "Bunny",            rarity = "Common",    emoji = "🐇",  price = "20k"  },
    -- Uncommon
    { name = "Owl",              rarity = "Uncommon",  emoji = "🦉",  price = "25k"  },
    { name = "Big Owl",          rarity = "Uncommon",  emoji = "🦅",  price = "50k"  },
    -- Rare
    { name = "Deer",             rarity = "Rare",      emoji = "🦌",  price = "50k"  },
    -- Legendary
    { name = "Robin",            rarity = "Legendary", emoji = "🐦",  price = "75k"  },
    { name = "Bee",              rarity = "Legendary", emoji = "🐝",  price = "1M"   },
    -- Mythic
    { name = "Golden Dragonfly", rarity = "Mythic",    emoji = "🪲",  price = "3M"   },
    -- Super
    { name = "Raccoon",          rarity = "Super",     emoji = "🦝",  price = "???"  },
    -- Secret
    { name = "Unicorn",          rarity = "Secret",    emoji = "🦄",  price = "12M"  },
}

local RARITY_COLOR = {
    Common    = Color3.fromRGB(160, 210, 130),
    Uncommon  = Color3.fromRGB(70,  160, 230),
    Rare      = Color3.fromRGB(170, 100, 255),
    Legendary = Color3.fromRGB(255, 185,  40),
    Mythic    = Color3.fromRGB(255,  80, 200),
    Super     = Color3.fromRGB(255, 120,  40),
    Secret    = Color3.fromRGB(220, 180, 255),
}

local RARITY_DIM = {
    Common    = Color3.fromRGB(18, 36, 14),
    Uncommon  = Color3.fromRGB(14, 28, 46),
    Rare      = Color3.fromRGB(28, 14, 52),
    Legendary = Color3.fromRGB(46, 34,  8),
    Mythic    = Color3.fromRGB(46,  8, 38),
    Super     = Color3.fromRGB(46, 22,  8),
    Secret    = Color3.fromRGB(30, 18, 50),
}

-------------------------------------------------
-- STATE
-------------------------------------------------
local heldPet       = nil
local inventoryList = {}

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
-- WINDOW
-------------------------------------------------
local isMobile = UserInputService.TouchEnabled
local W = isMobile and math.floor(workspace.CurrentCamera.ViewportSize.X * 0.88) or 340
local H = isMobile and math.floor(workspace.CurrentCamera.ViewportSize.Y * 0.72) or 460

local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.new(0, W, 0, 0)
Window.Position = UDim2.new(0.5, -W/2, 0.5, 0)
Window.BackgroundColor3 = Color3.fromRGB(8, 16, 8)
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.ZIndex = 10
Window.Parent = ScreenGui
mkCorner(Window, 14)
mkStroke(Window, Color3.fromRGB(76, 175, 80), 2)

local winGrad = Instance.new("UIGradient")
winGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(16, 32, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6, 10, 6)),
})
winGrad.Rotation = 135
winGrad.Parent = Window

-------------------------------------------------
-- TOPBAR
-------------------------------------------------
local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundColor3 = Color3.fromRGB(10, 22, 10)
Topbar.BorderSizePixel = 0
Topbar.ZIndex = 11
Topbar.Parent = Window
mkCorner(Topbar, 14)

local tbFill = Instance.new("Frame")
tbFill.Size = UDim2.new(1, 0, 0, 14)
tbFill.Position = UDim2.new(0, 0, 1, -14)
tbFill.BackgroundColor3 = Color3.fromRGB(10, 22, 10)
tbFill.BorderSizePixel = 0
tbFill.ZIndex = 11
tbFill.Parent = Topbar

mkLabel({
    Size = UDim2.new(1, -46, 1, 0),
    Position = UDim2.new(0, 12, 0, 0),
    Text = "🌱  GAG 2 — Pet Spawner",
    TextColor3 = Color3.fromRGB(210, 255, 190),
    TextSize = 13,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 12,
}, Topbar)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 55, 55)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 11
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.ZIndex = 12
CloseBtn.Parent = Topbar
mkCorner(CloseBtn, 6)

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
local function mkDivider(yPos)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1, -20, 0, 1)
    d.Position = UDim2.new(0, 10, 0, yPos)
    d.BackgroundColor3 = Color3.fromRGB(40, 90, 40)
    d.BorderSizePixel = 0
    d.ZIndex = 11
    d.Parent = Window
    return d
end
mkDivider(40)

-------------------------------------------------
-- HELD PET VISUAL PANEL
-------------------------------------------------
local HeldPanel = Instance.new("Frame")
HeldPanel.Size = UDim2.new(1, -20, 0, 56)
HeldPanel.Position = UDim2.new(0, 10, 0, 48)
HeldPanel.BackgroundColor3 = Color3.fromRGB(12, 24, 12)
HeldPanel.BorderSizePixel = 0
HeldPanel.ZIndex = 11
HeldPanel.Parent = Window
mkCorner(HeldPanel, 10)
mkStroke(HeldPanel, Color3.fromRGB(40, 90, 40), 1)

local HeldLayout = Instance.new("UIListLayout")
HeldLayout.FillDirection = Enum.FillDirection.Horizontal
HeldLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HeldLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
HeldLayout.Padding = UDim.new(0, 8)
HeldLayout.Parent = HeldPanel

local HeldPad = Instance.new("UIPadding")
HeldPad.PaddingLeft  = UDim.new(0, 10)
HeldPad.PaddingRight = UDim.new(0, 10)
HeldPad.Parent = HeldPanel

local HeldIcon = Instance.new("Frame")
HeldIcon.Size = UDim2.new(0, 40, 0, 40)
HeldIcon.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
HeldIcon.BorderSizePixel = 0
HeldIcon.ZIndex = 12
HeldIcon.Parent = HeldPanel
mkCorner(HeldIcon, 10)
local HeldIconStroke = mkStroke(HeldIcon, Color3.fromRGB(76, 175, 80), 1.5)

local HeldEmoji = mkLabel({
    Size = UDim2.fromScale(1, 1),
    Text = "❓",
    TextSize = 24,
    ZIndex = 13,
}, HeldIcon)

local HeldTextFrame = Instance.new("Frame")
HeldTextFrame.Size = UDim2.new(1, -60, 1, 0)
HeldTextFrame.BackgroundTransparency = 1
HeldTextFrame.ZIndex = 12
HeldTextFrame.Parent = HeldPanel

local HeldTextLayout = Instance.new("UIListLayout")
HeldTextLayout.FillDirection = Enum.FillDirection.Vertical
HeldTextLayout.VerticalAlignment = Enum.VerticalAlignment.Center
HeldTextLayout.Padding = UDim.new(0, 1)
HeldTextLayout.Parent = HeldTextFrame

local HeldTitle = mkLabel({
    Size = UDim2.new(1, 0, 0, 18),
    Text = "Holding: None",
    TextColor3 = Color3.fromRGB(180, 230, 160),
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 13,
}, HeldTextFrame)

local HeldRarityLbl = mkLabel({
    Size = UDim2.new(1, 0, 0, 14),
    Text = "Click a pet to equip",
    TextColor3 = Color3.fromRGB(80, 130, 70),
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 13,
}, HeldTextFrame)

-------------------------------------------------
-- INVENTORY STRIP
-------------------------------------------------
local InvLabel = mkLabel({
    Size = UDim2.new(1, -20, 0, 14),
    Position = UDim2.new(0, 10, 0, 110),
    Text = "Inventory  (0 spawned)",
    TextColor3 = Color3.fromRGB(70, 130, 60),
    TextSize = 9,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11,
}, Window)

local InvStrip = Instance.new("ScrollingFrame")
InvStrip.Size = UDim2.new(1, -20, 0, 34)
InvStrip.Position = UDim2.new(0, 10, 0, 126)
InvStrip.BackgroundColor3 = Color3.fromRGB(10, 20, 10)
InvStrip.BorderSizePixel = 0
InvStrip.ScrollBarThickness = 2
InvStrip.ScrollBarImageColor3 = Color3.fromRGB(76, 175, 80)
InvStrip.CanvasSize = UDim2.new(0, 0, 0, 0)
InvStrip.AutomaticCanvasSize = Enum.AutomaticSize.X
InvStrip.ScrollingDirection = Enum.ScrollingDirection.X
InvStrip.ZIndex = 11
InvStrip.Parent = Window
mkCorner(InvStrip, 8)
mkStroke(InvStrip, Color3.fromRGB(30, 70, 30), 1)

local InvLayout = Instance.new("UIListLayout")
InvLayout.FillDirection = Enum.FillDirection.Horizontal
InvLayout.VerticalAlignment = Enum.VerticalAlignment.Center
InvLayout.Padding = UDim.new(0, 4)
InvLayout.Parent = InvStrip

local InvPad = Instance.new("UIPadding")
InvPad.PaddingLeft = UDim.new(0, 6)
InvPad.PaddingTop  = UDim.new(0, 4)
InvPad.Parent = InvStrip

local InvEmpty = mkLabel({
    Size = UDim2.new(0, 140, 1, 0),
    Text = "No pets spawned yet",
    TextColor3 = Color3.fromRGB(50, 90, 45),
    TextSize = 9,
    Font = Enum.Font.Gotham,
    ZIndex = 12,
}, InvStrip)

mkDivider(166)

-------------------------------------------------
-- SCROLL FRAME (pet cards)
-------------------------------------------------
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -12, 1, -178)
ScrollFrame.Position = UDim2.new(0, 6, 0, 170)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(76, 175, 80)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ZIndex = 11
ScrollFrame.Parent = Window

local cellW = math.floor((W - 32) / 2) - 4

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.new(0, cellW, 0, 90)
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
-- NOTIFICATION
-------------------------------------------------
local function showNotif(text)
    local notif = mkLabel({
        Size = UDim2.new(0, 220, 0, 30),
        Position = UDim2.new(0.5, -110, 1, -42),
        Text = text,
        TextColor3 = Color3.fromRGB(200, 255, 170),
        TextSize = 11,
        Font = Enum.Font.GothamBold,
        BackgroundColor3 = Color3.fromRGB(10, 26, 10),
        BackgroundTransparency = 0.05,
        ZIndex = 20,
    }, Window)
    mkCorner(notif, 8)
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

-------------------------------------------------
-- INVENTORY REFRESH
-------------------------------------------------
local function refreshInventory()
    InvLabel.Text = "Inventory  (" .. #inventoryList .. " spawned)"
    for _, ch in ipairs(InvStrip:GetChildren()) do
        if ch:IsA("Frame") then ch:Destroy() end
    end
    if #inventoryList == 0 then
        InvEmpty.Visible = true
        return
    end
    InvEmpty.Visible = false
    for _, entry in ipairs(inventoryList) do
        local pd = nil
        for _, p in ipairs(PETS) do if p.name == entry then pd = p break end end
        if pd then
            local rc = RARITY_COLOR[pd.rarity]
            local bubble = Instance.new("Frame")
            bubble.Size = UDim2.new(0, 26, 0, 26)
            bubble.BackgroundColor3 = RARITY_DIM[pd.rarity]
            bubble.BorderSizePixel = 0
            bubble.ZIndex = 12
            bubble.Parent = InvStrip
            mkCorner(bubble, 6)
            mkStroke(bubble, rc, 1)
            mkLabel({ Size = UDim2.fromScale(1,1), Text = pd.emoji, TextSize = 16, ZIndex = 13 }, bubble)
        end
    end
end

-------------------------------------------------
-- HELD PANEL UPDATE
-------------------------------------------------
local function updateHeld(pet)
    heldPet = pet
    if pet then
        local rc = RARITY_COLOR[pet.rarity]
        HeldEmoji.Text          = pet.emoji
        HeldTitle.Text          = "Holding: " .. pet.name
        HeldRarityLbl.Text      = pet.rarity
        HeldRarityLbl.TextColor3 = rc
        HeldIcon.BackgroundColor3 = RARITY_DIM[pet.rarity]
        HeldIconStroke.Color    = rc
    else
        HeldEmoji.Text          = "❓"
        HeldTitle.Text          = "Holding: None"
        HeldRarityLbl.Text      = "Click a pet to equip"
        HeldRarityLbl.TextColor3 = Color3.fromRGB(80, 130, 70)
        HeldIcon.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
        HeldIconStroke.Color    = Color3.fromRGB(76, 175, 80)
    end
end

-------------------------------------------------
-- BUILD PET CARDS
-------------------------------------------------
for i, pet in ipairs(PETS) do
    local rc   = RARITY_COLOR[pet.rarity]
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

    local inner = Instance.new("UIListLayout")
    inner.FillDirection = Enum.FillDirection.Vertical
    inner.HorizontalAlignment = Enum.HorizontalAlignment.Center
    inner.VerticalAlignment = Enum.VerticalAlignment.Center
    inner.Padding = UDim.new(0, 2)
    inner.Parent = card

    mkLabel({ Size = UDim2.new(1,0,0,30), Text = pet.emoji, TextSize = 24, ZIndex = 13 }, card)
    mkLabel({
        Size = UDim2.new(1,-4,0,15),
        Text = pet.name,
        TextColor3 = Color3.fromRGB(230, 255, 215),
        TextSize = 9,
        Font = Enum.Font.GothamBold,
        ZIndex = 13,
        TextWrapped = true,
    }, card)
    mkLabel({
        Size = UDim2.new(1,-4,0,12),
        Text = "💰 " .. pet.price,
        TextColor3 = Color3.fromRGB(200, 220, 160),
        TextSize = 8,
        Font = Enum.Font.Gotham,
        ZIndex = 13,
    }, card)

    local badge = Instance.new("Frame")
    badge.Size = UDim2.new(0, 0, 0, 14)
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
        Size = UDim2.new(0,0,1,0),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = pet.rarity,
        TextColor3 = rc,
        TextSize = 8,
        Font = Enum.Font.GothamBold,
        ZIndex = 14,
    }, badge)

    card.MouseEnter:Connect(function()
        tw(card, { BackgroundColor3 = rdim:Lerp(rc, 0.2) }, 0.15)
        tw(cs, { Thickness = 2.2 }, 0.15)
    end)
    card.MouseLeave:Connect(function()
        tw(card, { BackgroundColor3 = rdim }, 0.15)
        tw(cs, { Thickness = 1.2 }, 0.15)
    end)

    card.MouseButton1Click:Connect(function()
        tw(card, { BackgroundColor3 = rc:Lerp(Color3.fromRGB(255,255,255), 0.1) }, 0.07)
        task.wait(0.09)
        tw(card, { BackgroundColor3 = rdim }, 0.2)

        table.insert(inventoryList, pet.name)
        refreshInventory()
        updateHeld(pet)
        showNotif("✅  Spawned " .. pet.emoji .. " " .. pet.name)
    end)
end

-- Right-click held icon = unequip
HeldIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        updateHeld(nil)
    end
end)

-------------------------------------------------
-- OPEN ANIMATION
-------------------------------------------------
tw(Window, {
    Size = UDim2.new(0, W, 0, H),
    Position = UDim2.new(0.5, -W/2, 0.5, -H/2),
}, 0.4, Enum.EasingStyle.Back)

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
