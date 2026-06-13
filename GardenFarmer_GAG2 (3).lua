-- Garden Farmer - Grow a Garden 2
-- Made by Syntax
-- Compact top-bar UI with tabs

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")
local Hum = Char:WaitForChild("Humanoid")

LP.CharacterAdded:Connect(function(c)
    Char = c
    Root = c:WaitForChild("HumanoidRootPart")
    Hum  = c:WaitForChild("Humanoid")
end)

-- ============================================================
--  CONFIG
-- ============================================================
local Cfg = {
    TpDelay      = 0.01,
    HarvestDelay = 0.02,
    SellInterval = 40,
    CollectRadius= 15,
    WalkSpeed    = 60,
    AntiAFK      = true,
    AutoSell     = true,
    AutoCollect  = true,
    SpeedOn      = true,
    WebhookURL   = "",
    WebhookOn    = false,
    PetTarget    = "",
    PetMaxPrice  = 9999,
}

-- ============================================================
--  STATE
-- ============================================================
local St = {
    HarvestOn = false,
    PetOn     = false,
    Harvested = 0,
    Sold      = 0,
    Collected = 0,
    Plants    = 0,
    Status    = "Idle",
    Origin    = nil,
}

local Discovered = { HarvestRemotes={}, SellRemotes={}, BuyRemotes={}, SellParts={} }
local LogLines = {}
local PetNotified = {}

-- ============================================================
--  UTIL
-- ============================================================
local HARVEST_KEYS = {"harvest","collect","pick","gather","crop","fruit"}
local SELL_KEYS    = {"sell","market","vendor","cashier","trader","merchant"}
local BUY_KEYS     = {"buy","purchase","seed","shop"}
local PLANT_KEYS   = {"plant","crop","fruit","flower","tree","bush","seed","sprout","bloom","berry","carrot","tomato","sunflower","pumpkin","mushroom","rose","wheat","corn","potato","apple","orange","grape","watermelon","strawberry","blueberry","mango"}
local SELL_PART_KEYS={"sell","market","shop","vendor","cashier","merchant","trader"}

local function KMatch(name, keys)
    local l = string.lower(name)
    for _,k in ipairs(keys) do if string.find(l,k,1,true) then return true end end
    return false
end

local function Log(msg)
    table.insert(LogLines,1,"["..os.date("%X").."] "..msg)
    if #LogLines>40 then table.remove(LogLines) end
    print("[GF] "..msg)
end

local function TP(cf) if Root then Root.CFrame = cf end end

local function Webhook(title, desc, color)
    if not Cfg.WebhookOn or Cfg.WebhookURL=="" then return end
    pcall(function()
        request({Url=Cfg.WebhookURL,Method="POST",
            Headers={["Content-Type"]="application/json"},
            Body=HttpService:JSONEncode({embeds={{title=title,description=desc,color=color or 5763719,footer={text="GF GAG2 • "..os.date("%X")}}}})
        })
    end)
end

-- ============================================================
--  ANTI-AFK
-- ============================================================
local AfkConn
local function SetAntiAFK(on)
    if AfkConn then AfkConn:Disconnect() AfkConn=nil end
    if on then
        local VU=game:GetService("VirtualUser")
        AfkConn=LP.Idled:Connect(function() VU:CaptureController() VU:ClickButton2(Vector2.zero) end)
    end
end

local function SetSpeed(on)
    if Hum then Hum.WalkSpeed=on and Cfg.WalkSpeed or 16 Hum.JumpPower=on and 70 or 50 end
end

-- ============================================================
--  SCAN
-- ============================================================
local function RunScan()
    Discovered={HarvestRemotes={},SellRemotes={},BuyRemotes={},SellParts={}}
    Log("Scanning...")
    for _,obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            if KMatch(obj.Name,HARVEST_KEYS) then table.insert(Discovered.HarvestRemotes,obj) Log("H-Remote: "..obj:GetFullName()) end
            if KMatch(obj.Name,SELL_KEYS)    then table.insert(Discovered.SellRemotes,obj)    Log("S-Remote: "..obj:GetFullName()) end
            if KMatch(obj.Name,BUY_KEYS)     then table.insert(Discovered.BuyRemotes,obj)     Log("B-Remote: "..obj:GetFullName()) end
        end
    end
    for _,obj in ipairs(workspace:GetDescendants()) do
        if (obj:IsA("BasePart") or obj:IsA("Model")) and KMatch(obj.Name,SELL_PART_KEYS) then
            table.insert(Discovered.SellParts,obj) Log("SellZone: "..obj:GetFullName())
        end
        if obj:IsA("ProximityPrompt") and KMatch(obj.ActionText,HARVEST_KEYS) then
            Log("PP: "..obj.ActionText.." @ "..obj:GetFullName())
        end
    end
    Log("Scan done. H="..#Discovered.HarvestRemotes.." S="..#Discovered.SellRemotes)
end

-- ============================================================
--  HARVEST
-- ============================================================
local function GetPlants()
    local r={}
    -- Priority 1: ProximityPrompts with harvest action
    for _,pp in ipairs(workspace:GetDescendants()) do
        if pp:IsA("ProximityPrompt") and KMatch(pp.ActionText,HARVEST_KEYS) then
            local p=pp.Parent
            local bp=p:IsA("BasePart") and p or (p:IsA("Model") and (p.PrimaryPart or p:FindFirstChildWhichIsA("BasePart",true)))
            if bp then table.insert(r,{part=bp,prompt=pp}) end
        end
    end
    -- Priority 2: named plant parts
    if #r==0 then
        for _,obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and KMatch(obj.Name,PLANT_KEYS) then
                table.insert(r,{part=obj,prompt=nil})
            end
        end
    end
    return r
end

local function FireHarvest(pd)
    if pd.prompt then pcall(fireproximityprompt,pd.prompt) end
    for _,rem in ipairs(Discovered.HarvestRemotes) do
        pcall(function()
            if rem:IsA("RemoteEvent") then rem:FireServer(pd.part)
            else rem:InvokeServer(pd.part) end
        end)
    end
    -- touch method
    pcall(function() TP(pd.part.CFrame) end)
end

local function DoSell()
    for _,rem in ipairs(Discovered.SellRemotes) do
        pcall(function()
            if rem:IsA("RemoteEvent") then rem:FireServer() else rem:InvokeServer() end
        end)
    end
    for _,part in ipairs(Discovered.SellParts) do
        local cf=(part:IsA("BasePart") and part.CFrame) or
                 (part:IsA("Model") and part.PrimaryPart and part.PrimaryPart.CFrame)
        if cf then
            local saved=Root.CFrame
            TP(cf+Vector3.new(0,3,0)) task.wait(0.3)
            for _,pp in ipairs(part:GetDescendants()) do
                if pp:IsA("ProximityPrompt") then pcall(fireproximityprompt,pp) task.wait(0.1) end
            end
            TP(saved)
        end
    end
    St.Sold+=St.Harvested
    Webhook("🌾 Sold!","Harvested: "..St.Harvested.."\nTotal sold: "..St.Sold,3066993)
    Log("Sold. Total: "..St.Sold)
end

-- ============================================================
--  AUTO COLLECT
-- ============================================================
local CollectRunning=false
local function StartCollect()
    if CollectRunning then return end
    CollectRunning=true
    task.spawn(function()
        while CollectRunning do
            if Root then
                for _,obj in ipairs(workspace:GetDescendants()) do
                    if not CollectRunning then break end
                    if obj:IsA("BasePart") and not obj.CanCollide and
                       (Root.Position-obj.Position).Magnitude<=Cfg.CollectRadius then
                        local saved=Root.CFrame
                        pcall(function() TP(obj.CFrame) end)
                        task.wait(0.05)
                        TP(saved)
                        St.Collected+=1
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end
local function StopCollect()
    CollectRunning=false
end

-- ============================================================
--  PET BUYER
-- ============================================================
local PetRunning=false
local function StartPetBuyer()
    if PetRunning then return end
    PetRunning=true
    task.spawn(function()
    while PetRunning do
        task.wait(1)
        if Cfg.PetTarget=="" then continue end
        for _,obj in ipairs(workspace:GetDescendants()) do
            if string.find(string.lower(obj.Name),string.lower(Cfg.PetTarget),1,true) then
                local id=obj:GetFullName()
                if not PetNotified[id] then
                    PetNotified[id]=true
                    local price=obj:GetAttribute("Price") or obj:GetAttribute("Cost") or 0
                    Log("PET FOUND: "..obj.Name.." $"..tostring(price))
                    Webhook("🐾 Pet Spawned: "..obj.Name,
                        "Price: "..tostring(price).."\nBudget: "..Cfg.PetMaxPrice..
                        (price<=Cfg.PetMaxPrice and "\n✅ Buying!" or "\n❌ Too expensive"),15844367)
                    if price<=Cfg.PetMaxPrice or price==0 then
                        local pp=obj:FindFirstChildWhichIsA("ProximityPrompt",true)
                        if pp then pcall(fireproximityprompt,pp) end
                        for _,r in ipairs(Discovered.BuyRemotes) do
                            pcall(function()
                                if r:IsA("RemoteEvent") then r:FireServer(obj) else r:InvokeServer(obj) end
                            end)
                        end
                    end
                end
            end
        end
    end
    end
    end)
end
local function StopPetBuyer()
    PetRunning=false
    PetNotified={}
end

-- ============================================================
--  MAIN HARVEST LOOP  (fast: no delays between plants)
-- ============================================================
local function HarvestLoop()
    St.Origin=Root.CFrame
    if Cfg.SpeedOn then SetSpeed(true) end
    if Cfg.AutoCollect then StartCollect() end
    local sellTimer=0
    Log("Harvest started")
    while St.HarvestOn do
        local t0=tick()
        local plants=GetPlants()
        St.Plants=#plants
        if #plants==0 then
            St.Status="Scanning..."
            task.wait(1)
        else
            St.Status="Farming "..#plants.." plants"
            -- teleport to all plants as fast as possible
            for _,pd in ipairs(plants) do
                if not St.HarvestOn then break end
                TP(pd.part.CFrame+Vector3.new(0,2.5,0))
                FireHarvest(pd)
                task.wait(Cfg.HarvestDelay)
                St.Harvested+=1
            end
            TP(St.Origin)
            task.wait(Cfg.TpDelay)
        end
        sellTimer+=tick()-t0
        if Cfg.AutoSell and sellTimer>=Cfg.SellInterval then
            sellTimer=0
            St.Status="Selling..."
            DoSell()
        end
        task.wait(0.05)
    end
    SetSpeed(false)
    StopCollect()
    St.Status="Idle"
    Log("Harvest stopped. Total: "..St.Harvested)
end

-- ============================================================
--  GUI  — top bar with category dropdowns
-- ============================================================
local function BuildGUI()
    local old=LP.PlayerGui:FindFirstChild("GF_GAG2") if old then old:Destroy() end

    local SG=Instance.new("ScreenGui")
    SG.Name="GF_GAG2" SG.ResetOnSpawn=false
    SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    SG.Parent=LP.PlayerGui

    local GREEN=Color3.fromRGB(39,174,96)
    local RED=Color3.fromRGB(160,40,40)
    local BLUE=Color3.fromRGB(52,100,200)
    local GOLD=Color3.fromRGB(200,168,50)
    local BG=Color3.fromRGB(14,14,14)
    local BG2=Color3.fromRGB(28,28,28)
    local BORDER=Color3.fromRGB(50,50,50)

    local function Corner(p,r) Instance.new("UICorner",p).CornerRadius=UDim.new(0,r or 6) end
    local function Stroke(p,c,t) local s=Instance.new("UIStroke",p) s.Color=c s.Thickness=t or 1 end

    -- ── OPEN PILL ──
    local OpenPill=Instance.new("TextButton",SG)
    OpenPill.Size=UDim2.new(0,100,0,22)
    OpenPill.Position=UDim2.new(0.5,-50,0,4)
    OpenPill.BackgroundColor3=BG
    OpenPill.BorderSizePixel=0
    OpenPill.Text="🌱 GF" OpenPill.TextColor3=Color3.fromRGB(110,217,110)
    OpenPill.TextSize=11 OpenPill.Font=Enum.Font.GothamBold
    OpenPill.Visible=false
    Corner(OpenPill,11) Stroke(OpenPill,GOLD,1)

    -- ── TOP BAR ──
    local Bar=Instance.new("Frame",SG)
    Bar.Size=UDim2.new(0,0,0,28)
    Bar.AutomaticSize=Enum.AutomaticSize.X
    Bar.Position=UDim2.new(0.5,0,0,4)
    Bar.AnchorPoint=Vector2.new(0.5,0)
    Bar.BackgroundColor3=BG
    Bar.BorderSizePixel=0
    Corner(Bar,8) Stroke(Bar,GOLD,1)

    local BarRow=Instance.new("UIListLayout",Bar)
    BarRow.FillDirection=Enum.FillDirection.Horizontal
    BarRow.VerticalAlignment=Enum.VerticalAlignment.Center
    BarRow.Padding=UDim.new(0,4)
    BarRow.SortOrder=Enum.SortOrder.LayoutOrder
    local BP=Instance.new("UIPadding",Bar)
    BP.PaddingLeft=UDim.new(0,6) BP.PaddingRight=UDim.new(0,6)

    -- pill button helper
    local function Pill(parent, text, color, lo)
        local b=Instance.new("TextButton",parent)
        b.AutomaticSize=Enum.AutomaticSize.X
        b.Size=UDim2.new(0,0,0,20)
        b.BackgroundColor3=color or BG2
        b.BorderSizePixel=0
        b.Text=text b.TextColor3=Color3.fromRGB(240,240,240)
        b.TextSize=10 b.Font=Enum.Font.GothamBold
        b.LayoutOrder=lo or 0
        Corner(b,4)
        local p=Instance.new("UIPadding",b)
        p.PaddingLeft=UDim.new(0,6) p.PaddingRight=UDim.new(0,6)
        return b
    end

    local function VSep(lo)
        local f=Instance.new("Frame",Bar)
        f.Size=UDim2.new(0,1,0,16) f.BackgroundColor3=BORDER
        f.BorderSizePixel=0 f.LayoutOrder=lo
    end

    -- bar items
    local titleLbl=Instance.new("TextLabel",Bar)
    titleLbl.BackgroundTransparency=1 titleLbl.BorderSizePixel=0
    titleLbl.AutomaticSize=Enum.AutomaticSize.X
    titleLbl.Size=UDim2.new(0,0,1,0)
    titleLbl.Text="🌱" titleLbl.TextColor3=Color3.fromRGB(110,217,110)
    titleLbl.TextSize=13 titleLbl.Font=Enum.Font.GothamBold titleLbl.LayoutOrder=1
    local tp=Instance.new("UIPadding",titleLbl) tp.PaddingRight=UDim.new(0,2)

    VSep(2)

    local farmTabBtn  = Pill(Bar,"Farm",BG2,3)
    local harvestTabBtn=Pill(Bar,"Harvest",BG2,4)
    local petTabBtn   = Pill(Bar,"Pet",BG2,5)

    VSep(6)

    -- status + stats inline
    local infoLbl=Instance.new("TextLabel",Bar)
    infoLbl.BackgroundTransparency=1 infoLbl.BorderSizePixel=0
    infoLbl.AutomaticSize=Enum.AutomaticSize.X
    infoLbl.Size=UDim2.new(0,0,1,0)
    infoLbl.Text="Idle | H:0 S:0" infoLbl.TextColor3=Color3.fromRGB(140,200,140)
    infoLbl.TextSize=10 infoLbl.Font=Enum.Font.Gotham infoLbl.LayoutOrder=7
    local ip=Instance.new("UIPadding",infoLbl) ip.PaddingLeft=UDim.new(0,2)

    VSep(8)

    local closeBtn=Pill(Bar,"✕",RED,9)

    -- ── DROPDOWN PANEL helper ──
    -- Each dropdown sits just below the bar, anchored to screen center
    local DROP_Y=4+28+3  -- bar top + bar height + gap
    local activeDropName=nil
    local drops={}

    local function MkDrop(name, w)
        local f=Instance.new("Frame",SG)
        f.Size=UDim2.new(0,w,0,0)
        f.AutomaticSize=Enum.AutomaticSize.Y
        f.Position=UDim2.new(0.5,-w/2,0,DROP_Y)
        f.BackgroundColor3=BG
        f.BorderSizePixel=0 f.Visible=false
        Corner(f,8) Stroke(f,BORDER,1)
        local lay=Instance.new("UIListLayout",f)
        lay.FillDirection=Enum.FillDirection.Vertical
        lay.Padding=UDim.new(0,4) lay.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=Instance.new("UIPadding",f)
        pad.PaddingLeft=UDim.new(0,8) pad.PaddingRight=UDim.new(0,8)
        pad.PaddingTop=UDim.new(0,6) pad.PaddingBottom=UDim.new(0,6)
        drops[name]=f
        return f,lay
    end

    local function ToggleDrop(name)
        if activeDropName==name then
            drops[name].Visible=false activeDropName=nil
            return
        end
        for n,d in pairs(drops) do d.Visible=(n==name) end
        activeDropName=name
    end

    -- highlight active tab btn
    local tabBtns={Farm=farmTabBtn,Harvest=harvestTabBtn,Pet=petTabBtn}
    local function SetTabActive(name, on)
        tabBtns[name].BackgroundColor3=on and GOLD or BG2
        tabBtns[name].TextColor3=on and Color3.fromRGB(20,20,20) or Color3.fromRGB(240,240,240)
    end

    farmTabBtn.MouseButton1Click:Connect(function() ToggleDrop("Farm") SetTabActive("Farm",activeDropName=="Farm") end)
    harvestTabBtn.MouseButton1Click:Connect(function() ToggleDrop("Harvest") SetTabActive("Harvest",activeDropName=="Harvest") end)
    petTabBtn.MouseButton1Click:Connect(function() ToggleDrop("Pet") SetTabActive("Pet",activeDropName=="Pet") end)

    -- ── ROW helpers ──
    local function DropRow(parent, text, color, lo)
        local b=Instance.new("TextButton",parent)
        b.Size=UDim2.new(1,0,0,26)
        b.BackgroundColor3=color or BG2
        b.BorderSizePixel=0
        b.Text=text b.TextColor3=Color3.fromRGB(240,240,240)
        b.TextSize=11 b.Font=Enum.Font.GothamBold
        b.LayoutOrder=lo or 0
        Corner(b,5)
        return b
    end

    local function DropToggleRow(parent, label, state, onChange, lo)
        local row=Instance.new("Frame",parent)
        row.Size=UDim2.new(1,0,0,24) row.BackgroundTransparency=1
        row.BorderSizePixel=0 row.LayoutOrder=lo or 0
        local lbl=Instance.new("TextLabel",row)
        lbl.Size=UDim2.new(0.65,0,1,0) lbl.BackgroundTransparency=1
        lbl.Text=label lbl.TextColor3=Color3.fromRGB(170,170,170)
        lbl.TextSize=10 lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
        local btn=Instance.new("TextButton",row)
        btn.Size=UDim2.new(0.33,0,0,20) btn.Position=UDim2.new(0.67,0,0,2)
        btn.BackgroundColor3=state and GREEN or RED btn.BorderSizePixel=0
        btn.Text=state and "ON" or "OFF" btn.TextColor3=Color3.fromRGB(255,255,255)
        btn.TextSize=10 btn.Font=Enum.Font.GothamBold
        Corner(btn,4)
        local on=state
        btn.MouseButton1Click:Connect(function()
            on=not on btn.Text=on and "ON" or "OFF"
            btn.BackgroundColor3=on and GREEN or RED onChange(on)
        end)
        return row
    end

    local function DropInputRow(parent, label, default, lo)
        local row=Instance.new("Frame",parent)
        row.Size=UDim2.new(1,0,0,24) row.BackgroundTransparency=1
        row.BorderSizePixel=0 row.LayoutOrder=lo or 0
        local lbl=Instance.new("TextLabel",row)
        lbl.Size=UDim2.new(0.45,0,1,0) lbl.BackgroundTransparency=1
        lbl.Text=label lbl.TextColor3=Color3.fromRGB(150,150,150)
        lbl.TextSize=10 lbl.Font=Enum.Font.Gotham lbl.TextXAlignment=Enum.TextXAlignment.Left
        local box=Instance.new("TextBox",row)
        box.Size=UDim2.new(0.53,0,0,20) box.Position=UDim2.new(0.47,0,0,2)
        box.BackgroundColor3=Color3.fromRGB(30,30,30) box.BorderSizePixel=0
        box.Text=tostring(default) box.TextColor3=Color3.fromRGB(230,230,230)
        box.TextSize=10 box.Font=Enum.Font.Gotham box.ClearTextOnFocus=false
        Corner(box,4)
        return box
    end

    local function DropSep(parent, lo)
        local f=Instance.new("Frame",parent)
        f.Size=UDim2.new(1,0,0,1) f.BackgroundColor3=BORDER
        f.BorderSizePixel=0 f.LayoutOrder=lo or 0
    end

    -- ── FARM DROPDOWN ──
    local farmDrop=MkDrop("Farm",200)

    local scanBtn=DropRow(farmDrop,"🔍 Scan Remotes",BLUE,1)
    DropSep(farmDrop,2)
    local autoFarmBtn=DropRow(farmDrop,"▶ Auto Farm",BG2,3)
    local autoSellToggle=DropToggleRow(farmDrop,"Auto Sell",Cfg.AutoSell,function(v) Cfg.AutoSell=v end,4)
    local autoCollectToggle=DropToggleRow(farmDrop,"Auto Collect",Cfg.AutoCollect,function(v) Cfg.AutoCollect=v end,5)
    DropSep(farmDrop,6)
    local antAfkToggle=DropToggleRow(farmDrop,"Anti-AFK",Cfg.AntiAFK,function(v) Cfg.AntiAFK=v SetAntiAFK(v) end,7)
    local speedToggle=DropToggleRow(farmDrop,"Speed Boost",Cfg.SpeedOn,function(v) Cfg.SpeedOn=v SetSpeed(v) end,8)

    -- ── HARVEST DROPDOWN ──
    local harvestDrop=MkDrop("Harvest",200)

    local harvestBtn=DropRow(harvestDrop,"⚡ Start Harvest",GREEN,1)
    DropSep(harvestDrop,2)
    local sellIntervalBox=DropInputRow(harvestDrop,"Sell every (s):",Cfg.SellInterval,3)
    local speedBox=DropInputRow(harvestDrop,"Walk speed:",Cfg.WalkSpeed,4)
    local collectRadBox=DropInputRow(harvestDrop,"Collect radius:",Cfg.CollectRadius,5)

    -- ── PET DROPDOWN ──
    local petDrop=MkDrop("Pet",210)

    local petBtn=DropRow(petDrop,"🐾 Start Pet Buyer",BLUE,1)
    DropSep(petDrop,2)
    local petNameBox=DropInputRow(petDrop,"Pet name:",Cfg.PetTarget,3) petNameBox.PlaceholderText="e.g. Black Dragon"
    local priceBox=DropInputRow(petDrop,"Max price:",Cfg.PetMaxPrice,4)

    -- ── BUTTON LOGIC ──
    closeBtn.MouseButton1Click:Connect(function()
        Bar.Visible=false
        for _,d in pairs(drops) do d.Visible=false end
        activeDropName=nil OpenPill.Visible=true
    end)
    OpenPill.MouseButton1Click:Connect(function()
        Bar.Visible=true OpenPill.Visible=false
    end)

    scanBtn.MouseButton1Click:Connect(function()
        scanBtn.Text="⏳ Scanning..."
        task.spawn(function() RunScan() scanBtn.Text="🔍 Scan Remotes" end)
    end)

    autoFarmBtn.MouseButton1Click:Connect(function()
        if not St.HarvestOn then
            St.HarvestOn=true
            autoFarmBtn.BackgroundColor3=RED autoFarmBtn.Text="■ Stop Farm"
            task.spawn(HarvestLoop)
        else
            St.HarvestOn=false
            autoFarmBtn.BackgroundColor3=BG2 autoFarmBtn.Text="▶ Auto Farm"
        end
    end)

    harvestBtn.MouseButton1Click:Connect(function()
        if not St.HarvestOn then
            St.HarvestOn=true
            harvestBtn.BackgroundColor3=RED harvestBtn.Text="■ Stop Harvest"
            task.spawn(HarvestLoop)
        else
            St.HarvestOn=false
            harvestBtn.BackgroundColor3=GREEN harvestBtn.Text="⚡ Start Harvest"
        end
    end)

    petBtn.MouseButton1Click:Connect(function()
        if not St.PetOn then
            St.PetOn=true
            Cfg.PetTarget=petNameBox.Text
            Cfg.PetMaxPrice=tonumber(priceBox.Text) or 9999
            petBtn.BackgroundColor3=RED petBtn.Text="■ Stop Pet Buyer"
            StartPetBuyer()
        else
            St.PetOn=false
            petBtn.BackgroundColor3=BLUE petBtn.Text="🐾 Start Pet Buyer"
            StopPetBuyer()
        end
    end)

    sellIntervalBox.FocusLost:Connect(function() Cfg.SellInterval=tonumber(sellIntervalBox.Text) or 40 end)
    speedBox.FocusLost:Connect(function() Cfg.WalkSpeed=tonumber(speedBox.Text) or 60 end)
    collectRadBox.FocusLost:Connect(function() Cfg.CollectRadius=tonumber(collectRadBox.Text) or 15 end)
    petNameBox.FocusLost:Connect(function() Cfg.PetTarget=petNameBox.Text end)
    priceBox.FocusLost:Connect(function() Cfg.PetMaxPrice=tonumber(priceBox.Text) or 9999 end)

    -- ── LIVE UPDATE ──
    task.spawn(function()
        while SG.Parent do
            infoLbl.Text=St.Status.." | H:"..St.Harvested.." S:"..St.Sold
            if not St.HarvestOn then
                if harvestBtn.Text=="■ Stop Harvest" then
                    harvestBtn.BackgroundColor3=GREEN harvestBtn.Text="⚡ Start Harvest"
                end
                if autoFarmBtn.Text=="■ Stop Farm" then
                    autoFarmBtn.BackgroundColor3=BG2 autoFarmBtn.Text="▶ Auto Farm"
                end
            end
            task.wait(0.5)
        end
    end)
end

-- ============================================================
--  INIT
-- ============================================================
SetAntiAFK(Cfg.AntiAFK)
BuildGUI()
Log("Garden Farmer loaded! Click Farm/Harvest/Pet tabs to expand.")
d.")
