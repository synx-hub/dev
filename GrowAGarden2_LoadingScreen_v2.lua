local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 460, 0, 180)
mainFrame.Position = UDim2.new(0.5, -230, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.12
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(76, 175, 80)
stroke.Thickness = 4
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 28)
titleLabel.Position = UDim2.new(0, 10, 0, 16)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🌱 Grow a Garden 2"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = mainFrame

local subLabel = Instance.new("TextLabel")
subLabel.Size = UDim2.new(1, -30, 0, 18)
subLabel.Position = UDim2.new(0, 15, 0, 54)
subLabel.BackgroundTransparency = 1
subLabel.Text = "Loading Grow a Garden 2 (first execute may be slow)"
subLabel.TextColor3 = Color3.fromRGB(139, 195, 74)
subLabel.Font = Enum.Font.GothamBold
subLabel.TextSize = 12
subLabel.TextXAlignment = Enum.TextXAlignment.Center
subLabel.Parent = mainFrame

-- Status label (fake flavor messages)
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -30, 0, 16)
statusLabel.Position = UDim2.new(0, 15, 0, 78)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Initializing secure connection..."
statusLabel.TextColor3 = Color3.fromRGB(180, 220, 140)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextTransparency = 0.3
statusLabel.Parent = mainFrame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1, -50, 0, 9)
barBg.Position = UDim2.new(0, 25, 0, 108)
barBg.BackgroundColor3 = Color3.fromRGB(10, 28, 10)
barBg.BorderSizePixel = 0
barBg.Parent = mainFrame

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(0, 5)
barBgCorner.Parent = barBg

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
barFill.BorderSizePixel = 0
barFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 5)
fillCorner.Parent = barFill

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(1, 0, 0, 20)
percentLabel.Position = UDim2.new(0, 0, 0, 124)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
percentLabel.Font = Enum.Font.GothamBlack
percentLabel.TextSize = 13
percentLabel.TextXAlignment = Enum.TextXAlignment.Center
percentLabel.Parent = mainFrame

-- Flavor status messages (cosmetic only)
local STATUS_MESSAGES = {
	"Initializing secure connection...",
	"Bypassing anti-cheat layer...",
	"Injecting garden modules...",
	"Spoofing player token...",
	"Patching memory allocation...",
	"Hooking render pipeline...",
	"Decrypting seed database...",
	"Authenticating farmer ID...",
	"Establishing secure plot tunnel...",
	"Flushing detection flags...",
	"Compiling garden runtime...",
	"All systems nominal. Welcome.",
}

local msgIndex = 1
task.spawn(function()
	while statusLabel and statusLabel.Parent do
		task.wait(1.2 + math.random() * 0.8)
		msgIndex = msgIndex % #STATUS_MESSAGES + 1
		statusLabel.TextTransparency = 1
		statusLabel.Text = STATUS_MESSAGES[msgIndex]
		-- fade in
		for i = 1, 10 do
			statusLabel.TextTransparency = 1 - (i / 10) * 0.7
			task.wait(0.02)
		end
	end
end)

-- Progress bar
local targetPercent = 99.8
local duration = 140
local startTime = tick()
local currentPercent = 0

RunService.Heartbeat:Connect(function()
	if currentPercent >= targetPercent then return end
	local t = math.min((tick() - startTime) / duration, 1)
	local eased = 1 - (1 - t) ^ 3
	currentPercent = eased * targetPercent
	barFill.Size = UDim2.new(currentPercent / 100, 0, 1, 0)
	percentLabel.Text = string.format("%.1f%%", currentPercent)
end)
