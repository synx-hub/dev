--// Rayfield Initialization
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Paper Auto",
    LoadingTitle = "Paper Auto 🐔",
    LoadingSubtitle = "by Syntax",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
})

local MainTab = Window:CreateTab("Main Features", 4483362458)

--// Services & Remotes
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local PaperRemotes = ReplicatedStorage:WaitForChild("Paper"):WaitForChild("Remotes")
local RemoteFunc = PaperRemotes:WaitForChild("__remotefunction")
local RemoteEvent = PaperRemotes:WaitForChild("__remoteevent")

--// Automation States
local State = {
    AutoMerge = false,
    AutoCollectCash = false,
    AutoDepositEggs = false,
    AutoBuyChickens = false,
    AutoCollectEggs = false,
    AutoUpgradeProcess = false,
    BuyQuantity = 1
}

--// Helper Functions
local function Notify(title, content)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = 3,
        Image = 4483362458
    })
end

--// Automation Loops
task.spawn(function()
    while true do
        task.wait(1)
        if State.AutoMerge then RemoteFunc:InvokeServer("Merge Chickens") end
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if State.AutoCollectCash then RemoteFunc:InvokeServer("Collect Cash") end
    end
end)

task.spawn(function()
    while true do
        task.wait(2)
        if State.AutoDepositEggs then RemoteFunc:InvokeServer("Deposit Eggs") end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if State.AutoBuyChickens then RemoteFunc:InvokeServer("Buy Chickens", State.BuyQuantity) end
    end
end)

task.spawn(function()
    while true do
        task.wait(1)
        if State.AutoUpgradeProcess then RemoteFunc:InvokeServer("Upgrade Process Level") end
    end
end)

--// Egg Collection Listener
local EggsFolder = Workspace:WaitForChild("Eggs")
EggsFolder.ChildAdded:Connect(function(egg)
    if not State.AutoCollectEggs then return end
    
    task.wait(1)
    RemoteEvent:FireServer("Collect Egg", egg.Name)
    task.wait()
    egg:Destroy()
    
    -- Sequential chain from original script
    RemoteFunc:InvokeServer("Deposit Eggs")
    RemoteFunc:InvokeServer("Collect Cash")
    RemoteFunc:InvokeServer("Merge Chickens")
    RemoteFunc:InvokeServer("Buy Chickens", State.BuyQuantity)
    RemoteFunc:InvokeServer("Upgrade Process Level")
end)

--// UI Layout
MainTab:CreateSection("Chicken Automation")

MainTab:CreateToggle({
    Name = "Auto Merge Chickens",
    CurrentValue = false,
    Callback = function(v)
        State.AutoMerge = v
        Notify("Auto Merge", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateToggle({
    Name = "Auto Buy Chickens",
    CurrentValue = false,
    Callback = function(v)
        State.AutoBuyChickens = v
        Notify("Auto Buy Chickens", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateToggle({
    Name = "Auto Upgrade Process Level",
    CurrentValue = false,
    Callback = function(v)
        State.AutoUpgradeProcess = v
        Notify("Auto Upgrade Process", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateSection("Economy & Eggs")

MainTab:CreateToggle({
    Name = "Auto Collect Cash",
    CurrentValue = false,
    Callback = function(v)
        State.AutoCollectCash = v
        Notify("Auto Collect Cash", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateToggle({
    Name = "Auto Deposit Eggs",
    CurrentValue = false,
    Callback = function(v)
        State.AutoDepositEggs = v
        Notify("Auto Deposit Eggs", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateToggle({
    Name = "Auto Collect Eggs (Ground)",
    CurrentValue = false,
    Callback = function(v)
        State.AutoCollectEggs = v
        Notify("Auto Collect Eggs", v and "Enabled" or "Disabled")
    end,
})

MainTab:CreateSection("Settings")

MainTab:CreateInput({
    Name = "Buy Quantity",
    PlaceholderText = "Amount to buy (e.g. 1)",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local n = tonumber(text)
        if n and n >= 1 then
            State.BuyQuantity = math.floor(n)
            Notify("Buy Quantity", "Set to " .. State.BuyQuantity)
        end
    end,
})

MainTab:CreateButton({
    Name = "Destroy GUI",
    Callback = function() Rayfield:Destroy() end,
})

--// Initialization Notification
Notify("Loaded", "Paper Auto loaded successfully!")
