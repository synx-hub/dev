-- // Grow a Garden 2 — Pet Spawner GUI v5
-- // LocalScript inside StarterPlayerScripts or StarterGui

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

-- cleanup old GUI
for _, g in ipairs(PlayerGui:GetChildren()) do
    if g.Name == "PetSpawnerGUI" then g:Destroy() end
end

-------------------------------------------------
-- ALL 10 CONFIRMED GROW A GARDEN 2 PETS
-------------------------------------------------
local PETS = {
    { name = "Frog",             rarity = "Common",    emoji = "🐸", price = "10k"  },
    { name = "Bunny",            rarity = "Common",    emoji = "🐇", price = "20k"  },
    { name = "Owl",              rarity = "Uncommon",  emoji = "🦉", price = "25k"  },
    { name = "Big Owl",          rarity = "Uncommon",  emoji = "🦅", price = "50k"  },
    { name = "Deer",             rarity = "Rare",      emoji = "🦌", price = "50k"  },
    { name = "Robin",            rarity = "Legendary", emoji = "🐦", price = "75k"  },
    { name = "Bee",              rarity = "Legendary", emoji = "🐝", price = "1M"   },
    { name = "Golden Dragonfly", rarity = "Mythic",    emoji = "🪲", price = "3M"   },
    { name = "Raccoon",          rarity = "Super",     emoji = "🦝", price = "???"  },
    { name = "Unicorn",          rarity = "Secret",    emoji = "🦄", price = "12M"  },
}

local RC = {
    Common    = Color3.fromRGB(160, 210, 130),
    Uncommon  = Color3.fromRGB(70,  160, 230),
    Rare      = Color3.fromRGB(170, 100, 255),
    Legendary = Color3.fromRGB(255, 185,  40),
    Mythic    = Color3.fromRGB(255,  80, 200),
    Super     = Color3.fromRGB(255, 120,  40),
    Secret    = Color3.fromRGB(210, 170, 255),
}
local RD = {
    Common    = Color3.fromRGB(18, 36, 14),
    Uncommon  = Color3.fromRGB(14, 28, 46),
    Rare      = Color3.fromRGB(28, 14, 52),
    Legendary = Color3.fromRGB(46, 34,  8),
    Mythic    = Color3.fromRGB(46,  8, 38),
    Super     = Color3.fromRGB(46, 22,  8),
    Secret    = Color3.fromRGB(28, 16, 48),
}

-------------------------------------------------
-- STATE
-------------------------------------------------
local heldPet       = nil
local inventoryList = {}   -- list of pet data tables

-------------------------------------------------
-- HELPERS
-------------------------------------------------
local function tw(obj, props, t, style)
    TweenService:Create(obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        props):Play()
end

local function corner(p, r)
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or 10); c.Parent = p; return c
end

local function stroke(p, col, th)
    local s = Instance.new("UIStroke")
    s.Color = col or Color3.fromRGB(50,80,50); s.Thickness = th or 1.2
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = p; return s
end

local function lbl(props, parent)
    local o = Instance.new("TextLabel")
    o.BackgroundTransparency = 1
    o.Font = Enum.Font.GothamBold
    o.TextXAlignment = Enum.TextXAlignment.Center
    o.TextYAlignment = Enum.TextYAlignment.Center
    o.TextWrapped = true
    for k,v in pairs(props) do o[k]=v end
    if parent then o.Parent = parent end
    return o
end

-------------------------------------------------
-- SCREEN GUI
-------------------------------------------------
local SG = Instance.new("ScreenGui")
SG.Name = "PetSpawnerGUI"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = PlayerGui

-------------------------------------------------
-- SIZES  (smaller on mobile)
-------------------------------------------------
local isMobile = UserInputService.TouchEnabled
local vp       = workspace.CurrentCamera.ViewportSize
local W = isMobile and math.floor(vp.X * 0.78) or 300
local H = isMobile and math.floor(vp.Y * 0.68) or 430

-------------------------------------------------
-- OPEN BUTTON (always visible, bottom-left)
-------------------------------------------------
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size       = UDim2.new(0, 44, 0, 44)
OpenBtn.Position   = UDim2.new(0, 12, 1, -60)
OpenBtn.BackgroundColor3 = Color3.fromRGB(14, 30, 14)
OpenBtn.Text       = "🌱"
OpenBtn.TextSize   = 22
OpenBtn.Font       = Enum.Font.GothamBold
OpenBtn.TextColor3 = Color3.fromRGB(200, 255, 170)
OpenBtn.BorderSizePixel = 0
OpenBtn.ZIndex     = 5
OpenBtn.Parent     = SG
corner(OpenBtn, 12)
stroke(OpenBtn, Color3.fromRGB(76,175,80), 1.5)

-------------------------------------------------
-- MAIN WINDOW
-------------------------------------------------
local Win = Instance.new("Frame")
Win.Name             = "Window"
Win.Size             = UDim2.new(0, W, 0, 0)   -- collapsed at start
Win.Position         = UDim2.new(0.5, -W/2, 0.5, 0)
Win.BackgroundColor3 = Color3.fromRGB(8, 16, 8)
Win.BorderSizePixel  = 0
Win.ClipsDescendants = true
Win.ZIndex           = 10
Win.Parent           = SG
corner(Win, 14)
stroke(Win, Color3.fromRGB(76,175,80), 2)

local wg = Instance.new("UIGradient")
wg.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(16,32,16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(6,10,6)),
})
wg.Rotation = 135; wg.Parent = Win

local isOpen = false

local function openWin()
    isOpen = true
    Win.Visible = true
    tw(Win, { Size = UDim2.new(0,W,0,H), Position = UDim2.new(0.5,-W/2,0.5,-H/2) }, 0.35, Enum.EasingStyle.Back)
end

local function closeWin()
    isOpen = false
    tw(Win, { Size = UDim2.new(0,W,0,0), Position = UDim2.new(0.5,-W/2,0.5,0) }, 0.25, Enum.EasingStyle.Back)
    task.delay(0.3, function() Win.Visible = false end)
end

Win.Visible = false

OpenBtn.MouseButton1Click:Connect(function()
    if isOpen then closeWin() else openWin() end
end)

-------------------------------------------------
-- TOPBAR
-------------------------------------------------
local TB = Instance.new("Frame")
TB.Size = UDim2.new(1,0,0,40); TB.BackgroundColor3 = Color3.fromRGB(10,22,10)
TB.BorderSizePixel = 0; TB.ZIndex = 11; TB.Parent = Win
corner(TB, 14)

-- square off bottom of topbar
local tbf = Instance.new("Frame")
tbf.Size = UDim2.new(1,0,0,14); tbf.Position = UDim2.new(0,0,1,-14)
tbf.BackgroundColor3 = Color3.fromRGB(10,22,10); tbf.BorderSizePixel = 0
tbf.ZIndex = 11; tbf.Parent = TB

lbl({
    Size = UDim2.new(1,-56,1,0), Position = UDim2.new(0,12,0,0),
    Text = "🌱  GAG2 Pet Spawner",
    TextColor3 = Color3.fromRGB(210,255,190), TextSize = 13,
    Font = Enum.Font.GothamBlack, TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 12,
}, TB)

-- Minimize button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0,24,0,24); MinBtn.Position = UDim2.new(1,-58,0.5,-12)
MinBtn.BackgroundColor3 = Color3.fromRGB(180,130,30)
MinBtn.Text = "—"; MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.TextSize = 14; MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0; MinBtn.ZIndex = 12; MinBtn.Parent = TB
corner(MinBtn, 6)
MinBtn.MouseButton1Click:Connect(closeWin)

-- Close (destroy) button
local XBtn = Instance.new("TextButton")
XBtn.Size = UDim2.new(0,24,0,24); XBtn.Position = UDim2.new(1,-30,0.5,-12)
XBtn.BackgroundColor3 = Color3.fromRGB(200,55,55)
XBtn.Text = "✕"; XBtn.TextColor3 = Color3.fromRGB(255,255,255)
XBtn.TextSize = 11; XBtn.Font = Enum.Font.GothamBold
XBtn.BorderSizePixel = 0; XBtn.ZIndex = 12; XBtn.Parent = TB
corner(XBtn, 6)
XBtn.MouseButton1Click:Connect(function()
    closeWin()
    task.wait(0.3)
    SG:Destroy()
end)

-------------------------------------------------
-- divider helper
-------------------------------------------------
local function mkDiv(y)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1,-20,0,1); d.Position = UDim2.new(0,10,0,y)
    d.BackgroundColor3 = Color3.fromRGB(40,90,40); d.BorderSizePixel = 0
    d.ZIndex = 11; d.Parent = Win
end
mkDiv(40)

-------------------------------------------------
-- HELD PET PANEL
-------------------------------------------------
local HeldPanel = Instance.new("Frame")
HeldPanel.Size = UDim2.new(1,-20,0,52)
HeldPanel.Position = UDim2.new(0,10,0,48)
HeldPanel.BackgroundColor3 = Color3.fromRGB(12,24,12)
HeldPanel.BorderSizePixel = 0; HeldPanel.ZIndex = 11; HeldPanel.Parent = Win
corner(HeldPanel, 10); stroke(HeldPanel, Color3.fromRGB(40,90,40), 1)

local hpl = Instance.new("UIListLayout")
hpl.FillDirection = Enum.FillDirection.Horizontal
hpl.VerticalAlignment = Enum.VerticalAlignment.Center
hpl.Padding = UDim.new(0,8); hpl.Parent = HeldPanel

local hpp = Instance.new("UIPadding")
hpp.PaddingLeft = UDim.new(0,10); hpp.PaddingRight = UDim.new(0,10)
hpp.Parent = HeldPanel

local HeldIcon = Instance.new("Frame")
HeldIcon.Size = UDim2.new(0,36,0,36)
HeldIcon.BackgroundColor3 = Color3.fromRGB(20,40,20)
HeldIcon.BorderSizePixel = 0; HeldIcon.ZIndex = 12; HeldIcon.Parent = HeldPanel
corner(HeldIcon, 9)
local HIS = stroke(HeldIcon, Color3.fromRGB(76,175,80), 1.5)

local HeldEmoji = lbl({ Size = UDim2.fromScale(1,1), Text = "❓", TextSize = 22, ZIndex = 13 }, HeldIcon)

local HeldTF = Instance.new("Frame")
HeldTF.Size = UDim2.new(1,-56,1,0); HeldTF.BackgroundTransparency = 1
HeldTF.ZIndex = 12; HeldTF.Parent = HeldPanel

local htl = Instance.new("UIListLayout")
htl.FillDirection = Enum.FillDirection.Vertical
htl.VerticalAlignment = Enum.VerticalAlignment.Center
htl.Padding = UDim.new(0,1); htl.Parent = HeldTF

local HeldName = lbl({
    Size = UDim2.new(1,0,0,17), Text = "Holding: None",
    TextColor3 = Color3.fromRGB(180,230,160), TextSize = 10,
    Font = Enum.Font.GothamBold, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13,
}, HeldTF)

local HeldRar = lbl({
    Size = UDim2.new(1,0,0,13), Text = "Tap a pet card to equip",
    TextColor3 = Color3.fromRGB(80,130,70), TextSize = 8,
    Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 13,
}, HeldTF)

-- unequip on right-click / second tap
HeldIcon.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton2
    or inp.UserInputType == Enum.UserInputType.Touch then
        heldPet = nil
        HeldEmoji.Text = "❓"; HeldName.Text = "Holding: None"
        HeldRar.Text = "Tap a pet card to equip"
        HeldRar.TextColor3 = Color3.fromRGB(80,130,70)
        HeldIcon.BackgroundColor3 = Color3.fromRGB(20,40,20)
        HIS.Color = Color3.fromRGB(76,175,80)
    end
end)

mkDiv(107)

-------------------------------------------------
-- INVENTORY LABEL + STRIP
-------------------------------------------------
local InvLbl = lbl({
    Size = UDim2.new(1,-20,0,14), Position = UDim2.new(0,10,0,113),
    Text = "Inventory  (0 spawned)",
    TextColor3 = Color3.fromRGB(70,130,60), TextSize = 9,
    Font = Enum.Font.Gotham, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 11,
}, Win)

local InvStrip = Instance.new("ScrollingFrame")
InvStrip.Name = "InvStrip"
InvStrip.Size = UDim2.new(1,-20,0,32)
InvStrip.Position = UDim2.new(0,10,0,129)
InvStrip.BackgroundColor3 = Color3.fromRGB(10,20,10)
InvStrip.BorderSizePixel = 0
InvStrip.ScrollBarThickness = 2
InvStrip.ScrollBarImageColor3 = Color3.fromRGB(76,175,80)
InvStrip.CanvasSize = UDim2.new(0,0,0,0)
InvStrip.AutomaticCanvasSize = Enum.AutomaticSize.X
InvStrip.ScrollingDirection = Enum.ScrollingDirection.X
InvStrip.ClipsDescendants = true
InvStrip.ZIndex = 11; InvStrip.Parent = Win
corner(InvStrip, 7); stroke(InvStrip, Color3.fromRGB(30,70,30), 1)

local invLL = Instance.new("UIListLayout")
invLL.FillDirection = Enum.FillDirection.Horizontal
invLL.VerticalAlignment = Enum.VerticalAlignment.Center
invLL.Padding = UDim.new(0,4); invLL.Parent = InvStrip

local invPad = Instance.new("UIPadding")
invPad.PaddingLeft = UDim.new(0,5); invPad.PaddingTop = UDim.new(0,3)
invPad.Parent = InvStrip

local InvEmpty = lbl({
    Name = "InvEmpty",
    Size = UDim2.new(0,160,1,-6),
    Text = "No pets spawned yet",
    TextColor3 = Color3.fromRGB(50,90,45), TextSize = 9,
    Font = Enum.Font.Gotham, ZIndex = 12,
}, InvStrip)

mkDiv(168)

-------------------------------------------------
-- REFRESH INVENTORY  (key fix: clear by Name tag)
-------------------------------------------------
local function refreshInv()
    InvLbl.Text = "Inventory  (" .. #inventoryList .. " spawned)"
    -- remove old bubbles only (not the layout/padding/empty label)
    for _, ch in ipairs(InvStrip:GetChildren()) do
        if ch.Name == "InvBubble" then ch:Destroy() end
    end
    if #inventoryList == 0 then
        InvEmpty.Visible = true
        return
    end
    InvEmpty.Visible = false
    for _, pd in ipairs(inventoryList) do
        local rc = RC[pd.rarity]
        local b = Instance.new("Frame")
        b.Name = "InvBubble"
        b.Size = UDim2.new(0,24,0,24)
        b.BackgroundColor3 = RD[pd.rarity]
        b.BorderSizePixel = 0; b.ZIndex = 12; b.Parent = InvStrip
        corner(b, 6); stroke(b, rc, 1)
        lbl({ Size = UDim2.fromScale(1,1), Text = pd.emoji, TextSize = 14, ZIndex = 13 }, b)
    end
end

-------------------------------------------------
-- UPDATE HELD PANEL
-------------------------------------------------
local function updateHeld(pet)
    heldPet = pet
    if pet then
        local rc = RC[pet.rarity]
        HeldEmoji.Text = pet.emoji
        HeldName.Text  = "Holding: " .. pet.name
        HeldRar.Text   = pet.rarity .. "  •  " .. pet.price
        HeldRar.TextColor3 = rc
        HeldIcon.BackgroundColor3 = RD[pet.rarity]
        HIS.Color = rc
    else
        HeldEmoji.Text = "❓"; HeldName.Text = "Holding: None"
        HeldRar.Text   = "Tap a pet card to equip"
        HeldRar.TextColor3 = Color3.fromRGB(80,130,70)
        HeldIcon.BackgroundColor3 = Color3.fromRGB(20,40,20)
        HIS.Color = Color3.fromRGB(76,175,80)
    end
end

-------------------------------------------------
-- NOTIFICATION
-------------------------------------------------
local function notif(txt)
    local n = lbl({
        Size = UDim2.new(0,200,0,28), Position = UDim2.new(0.5,-100,1,-40),
        Text = txt, TextColor3 = Color3.fromRGB(200,255,170), TextSize = 10,
        Font = Enum.Font.GothamBold, BackgroundColor3 = Color3.fromRGB(10,26,10),
        BackgroundTransparency = 1, ZIndex = 20,
    }, Win)
    corner(n, 8); stroke(n, Color3.fromRGB(76,175,80), 1)
    n.TextTransparency = 1
    tw(n, { TextTransparency = 0, BackgroundTransparency = 0.05 }, 0.2)
    task.delay(1.6, function()
        tw(n, { TextTransparency = 1, BackgroundTransparency = 1 }, 0.25)
        task.delay(0.3, function() n:Destroy() end)
    end)
end

-------------------------------------------------
-- SCROLL FRAME FOR CARDS
-------------------------------------------------
local SF = Instance.new("ScrollingFrame")
SF.Name = "ScrollFrame"
SF.Size = UDim2.new(1,-12,1,-175)
SF.Position = UDim2.new(0,6,0,172)
SF.BackgroundTransparency = 1
SF.BorderSizePixel = 0
SF.ScrollBarThickness = 3
SF.ScrollBarImageColor3 = Color3.fromRGB(76,175,80)
SF.CanvasSize = UDim2.new(0,0,0,0)
SF.AutomaticCanvasSize = Enum.AutomaticSize.Y
SF.ZIndex = 11; SF.Parent = Win

local cellW = math.floor((W - 34) / 2) - 4

local Grid = Instance.new("UIGridLayout")
Grid.CellSize    = UDim2.new(0, cellW, 0, 88)
Grid.CellPadding = UDim2.new(0, 5, 0, 5)
Grid.SortOrder   = Enum.SortOrder.LayoutOrder
Grid.Parent      = SF

local gp = Instance.new("UIPadding")
gp.PaddingTop = UDim.new(0,5); gp.PaddingLeft = UDim.new(0,6)
gp.PaddingRight = UDim.new(0,6); gp.PaddingBottom = UDim.new(0,6)
gp.Parent = SF

-------------------------------------------------
-- BUILD PET CARDS
-------------------------------------------------
for i, pet in ipairs(PETS) do
    local rc   = RC[pet.rarity]
    local rdim = RD[pet.rarity]

    local card = Instance.new("TextButton")
    card.Name = pet.name; card.LayoutOrder = i
    card.BackgroundColor3 = rdim; card.BorderSizePixel = 0
    card.Text = ""; card.AutoButtonColor = false
    card.ZIndex = 12; card.Parent = SF
    card:SetAttribute("Rarity", pet.rarity)
    corner(card, 10)
    local cs = stroke(card, rc, 1.2)

    local il = Instance.new("UIListLayout")
    il.FillDirection = Enum.FillDirection.Vertical
    il.HorizontalAlignment = Enum.HorizontalAlignment.Center
    il.VerticalAlignment = Enum.VerticalAlignment.Center
    il.Padding = UDim.new(0, 1); il.Parent = card

    lbl({ Size = UDim2.new(1,0,0,28), Text = pet.emoji, TextSize = 22, ZIndex = 13 }, card)
    lbl({ Size = UDim2.new(1,-4,0,14), Text = pet.name,
        TextColor3 = Color3.fromRGB(230,255,215), TextSize = 9,
        Font = Enum.Font.GothamBold, ZIndex = 13, TextWrapped = true }, card)
    lbl({ Size = UDim2.new(1,-4,0,11), Text = "💰 "..pet.price,
        TextColor3 = Color3.fromRGB(180,210,140), TextSize = 8,
        Font = Enum.Font.Gotham, ZIndex = 13 }, card)

    -- rarity badge
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0,0,0,13); bg.AutomaticSize = Enum.AutomaticSize.X
    bg.BackgroundColor3 = rc; bg.BackgroundTransparency = 0.55
    bg.BorderSizePixel = 0; bg.ZIndex = 13; bg.Parent = card
    corner(bg, 4)
    local bgp = Instance.new("UIPadding")
    bgp.PaddingLeft = UDim.new(0,4); bgp.PaddingRight = UDim.new(0,4); bgp.Parent = bg
    lbl({ Size = UDim2.new(0,0,1,0), AutomaticSize = Enum.AutomaticSize.X,
        Text = pet.rarity, TextColor3 = rc, TextSize = 7,
        Font = Enum.Font.GothamBold, ZIndex = 14 }, bg)

    -- hover
    card.MouseEnter:Connect(function()
        tw(card, { BackgroundColor3 = rdim:Lerp(rc, 0.18) }, 0.12)
        tw(cs, { Thickness = 2 }, 0.12)
    end)
    card.MouseLeave:Connect(function()
        tw(card, { BackgroundColor3 = rdim }, 0.12)
        tw(cs, { Thickness = 1.2 }, 0.12)
    end)

    -- click: add to inventory + equip
    card.MouseButton1Click:Connect(function()
        tw(card, { BackgroundColor3 = rc:Lerp(Color3.new(1,1,1), 0.12) }, 0.07)
        task.wait(0.09)
        tw(card, { BackgroundColor3 = rdim }, 0.18)

        table.insert(inventoryList, pet)   -- store pet TABLE not just name
        refreshInv()
        updateHeld(pet)
        notif("✅  Spawned " .. pet.emoji .. " " .. pet.name)
    end)
end

-------------------------------------------------
-- DRAG (topbar)
-------------------------------------------------
local drag, ds, sp = false, nil, nil

TB.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then
        drag = true; ds = inp.Position; sp = Win.Position
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement
    or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - ds
        Win.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
    end
end)
UserInputService.InputEnded:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then drag = false end
end)
