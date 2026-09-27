local Players
Players = game:GetService("Players")
local RunService
RunService = game:GetService("RunService")
local ReplicatedStorage
ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService
UserInputService = game:GetService("UserInputService")
local TweenService
TweenService = game:GetService("TweenService")
local localPlayer
localPlayer = Players.LocalPlayer
local gameplay
gameplay = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Gameplay")
local CurrentRoundClient
CurrentRoundClient = require(ReplicatedStorage.Modules.CurrentRoundClient)
local request_
local request_2 = http_request or request or syn and syn.request or fluxus and fluxus.request

if request_2 then
	request_ = request_2
else
	request_ = http and http.request
end

local fn

fn = function(arg)
	local ok, result = pcall(function()
		return game:HttpGet(arg)
	end)

	if ok and type(result) == "string" and #result > 0 then
		return result
	end

	if type(request_) ~= "function" then
		warn("HTTP request is not supported")
		return nil
	end
	local ok2, result2 = pcall(request_, { Url = arg, Method = "GET", Headers = { ["User-Agent"] = "Roblox" } })
	if not ok2 then
		warn("HTTP request failed: " .. tostring(result2))
		return nil
	end

	if type(result2) == "string" then
		return result2
	end

	if type(result2) == "table" then
		local num = tonumber(result2.StatusCode or result2.Status)
		local body = result2.Body or result2.body
		if (not num or num >= 200 and num < 400) and type(body) == "string" and #body > 0 then
			return body
		end
	end

	warn("HTTP request returned an invalid response")
	return nil
end

pcall(function()
	if _G.__InRoundGuardConn then
		_G.__InRoundGuardConn:Disconnect()
	end

	if _G.StopRoleFling then
		_G.StopRoleFling()
	end

	if _G.AutoFarmSetEnabled then
		_G.AutoFarmSetEnabled(false)
	end

	if _G.AntiFlingSetEnabled then
		_G.AntiFlingSetEnabled(false)
	end

	if _G.PlayerFlySetEnabled then
		_G.PlayerFlySetEnabled(false)
	end

	if _G.CoinESPConn then
		for _, v in ipairs(_G.CoinESPConn) do
			pcall(function()
				v:Disconnect()
			end)
		end
	end

	if _G.RoleESPConn then
		for _, v in ipairs(_G.RoleESPConn) do
			pcall(function()
				v:Disconnect()
			end)
		end
	end

	_G.__RoleRefreshBurstId = nil
	_G.ESPGlowEnabled = nil
	_G.ESPGlowSetEnabled = nil

	if _G.AutoFarmCharConn then
		_G.AutoFarmCharConn:Disconnect()
	end

	if _G.AutoFarmDiedConn then
		_G.AutoFarmDiedConn:Disconnect()
	end

	if _G.CoinESPFolder then
		_G.CoinESPFolder:Destroy()
	end

	if _G.RoleESPFolder then
		_G.RoleESPFolder:Destroy()
	end

	_G.__DailyQuestLoopId = nil

	if _G.DailyQuestCheckerGui then
		_G.DailyQuestCheckerGui:Destroy()
	end

	_G.__QuickShootLoopId = nil
	_G.__FarmStatsLoopId = nil
	_G.__HomeLoopId = nil

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegQuickShotCameraLock")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegShiftLockAim")
	end)

	if _G.QuickShootGui then
		_G.QuickShootGui:Destroy()
	end

	if _G.QuickRageShootButtonSetEnabled then
		_G.QuickRageShootButtonSetEnabled(false)
	end

	if _G.QuickRageShootGui then
		_G.QuickRageShootGui:Destroy()
	end

	if _G.AutoThrowKnifeSetEnabled then
		_G.AutoThrowKnifeSetEnabled(false)
	end

	_G.__AutoThrowKnifeLoopId = nil
	_G.__KillAllLoopId = nil

	if _G.ThrowAimbotButtonSetEnabled then
		_G.ThrowAimbotButtonSetEnabled(false)
	end

	if _G.ThrowAimbotGui then
		_G.ThrowAimbotGui:Destroy()
	end

	if _G.KillAllButtonSetEnabled then
		_G.KillAllButtonSetEnabled(false)
	end

	if _G.KillAllGui then
		_G.KillAllGui:Destroy()
	end

	if _G.FlingMurdererButtonGui then
		_G.FlingMurdererButtonGui:Destroy()
	end

	if _G.FlingSheriffButtonGui then
		_G.FlingSheriffButtonGui:Destroy()
	end

	if _G.BombBoostButtonGui then
		_G.BombBoostButtonGui:Destroy()
	end

	for _, v in ipairs({ "NoclipButtonGui", "FlyButtonGui", "InfJumpButtonGui", "WallJumpButtonGui" }) do
		if _G[v] then
			_G[v]:Destroy()
		end
	end

	_G.__PlayerButtonLightLoop = nil

	if _G.TriggerFOVGui then
		_G.TriggerFOVGui:Destroy()
		_G.TriggerFOVGui = nil
	end

	if _G.TriggerMarkerGui then
		_G.TriggerMarkerGui:Destroy()
	end

	if _G.ShiftLockCrosshairSetEnabled then
		pcall(function()
			_G.ShiftLockCrosshairSetEnabled(false)
		end)
	end

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegTriggerFOVRing")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegTriggerMarker")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegCrosshair")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegHideShiftLockCursor")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MM2SupportHandPose")
	end)

	pcall(function()
		RunService:UnbindFromRenderStep("MarbegESPOverlay")
	end)

	if _G.ESPOverlayGui then
		_G.ESPOverlayGui:Destroy()
	end

	if _G.InfiniteJumpSetEnabled then
		_G.InfiniteJumpSetEnabled(false)
	end

	if _G.WallJumpSetEnabled then
		_G.WallJumpSetEnabled(false)
	end

	if _G.NoclipSetEnabled then
		_G.NoclipSetEnabled(false)
	end

	if _G.AutoGrabGunSetEnabled then
		_G.AutoGrabGunSetEnabled(false)
	end

	_G.__AutoGrabGunLoopId = nil

	if _G.StretchModeSetEnabled then
		_G.StretchModeSetEnabled(false)
	end

	if _G.StretchClone then
		_G.StretchClone:Destroy()
	end

	if _G.TwoHandHoldSetEnabled then
		_G.TwoHandHoldSetEnabled(false)
	end

	if _G.GripTunerSetEnabled then
		_G.GripTunerSetEnabled(false)
	end

	if _G.BulletTracerSetEnabled then
		_G.BulletTracerSetEnabled(false)
	end

	if _G.BulletTracerFolder then
		_G.BulletTracerFolder:Destroy()
	end

	if _G.GunKillEffectSetEnabled then
		_G.GunKillEffectSetEnabled(false)
	end

	if _G.GunKillFXFolder then
		_G.GunKillFXFolder:Destroy()
	end

	if _G.__KillFxConns then
		for _, killFxConn in ipairs(_G.__KillFxConns) do
			pcall(function()
				killFxConn:Disconnect()
			end)
		end
	end

	if _G.KillFxGui then
		_G.KillFxGui:Destroy()
	end

	if _G.WorldVisualsReset then
		pcall(_G.WorldVisualsReset)
	end

	if _G.CameraSettingsReset then
		pcall(_G.CameraSettingsReset)
	end

	_G.KnifeAuraEnabled = false

	if _G.__GunKillEffectConn then
		_G.__GunKillEffectConn:Disconnect()
	end

	local v = _G
	local v2 = _G
	_G.GunKillEffectSetEnabled = nil
	v.GunKillEffectSetColor = nil
	v2.__PlayGunKillFX = nil
	local v3 = _G
	_G.__GunKillEffectConn = nil
	v3.GunKillFXFolder = nil

	if _G.FpsBoostSetEnabled then
		_G.FpsBoostSetEnabled(false)
	end

	_G.__FarmWebhookLoopId = nil

	if _G.AutoCaseSetEnabled then
		_G.AutoCaseSetEnabled(false)
	end

	_G.__AutoCaseLoopId = nil
	_G.__AutoCaseUiLoopId = nil

	if _G.WindUIWindow and _G.WindUIWindow.Destroy then
		_G.WindUIWindow:Destroy()
	end

	if _G.ObsidianWindow and _G.ObsidianWindow.Unload then
		_G.ObsidianWindow:Unload()
	end
end)

do
	local ok, result = pcall(function()
		return gethui()
	end)

	if ok and result then
		for _, child in ipairs(result:GetChildren()) do
			if child.Name == "ScreenGui" then
				pcall(function()
					child:Destroy()
				end)
			end
		end
	end
end

pcall(function()
	local character = localPlayer.Character

	if character then
		for _, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.CanCollide = true
			end
		end

		local humanoid = character:FindFirstChildWhichIsA("Humanoid")

		if humanoid then
			humanoid.PlatformStand = false
			humanoid.WalkSpeed = 16
		end
	end
end)

_G.ScriptVersion = "v3.7.1"
_G.PerformanceMode = true
_G.LockButtonsEnabled = false
_G.__ActionButtons = {}
_G.__ActionButtonLayouts = {}

_G.LockButtonsSetEnabled = function(arg)
	_G.LockButtonsEnabled = arg and true or false
end

print("Loading " .. _G.ScriptVersion)
local fn2

fn2 = function()
	local ok, result = pcall(function()
		return gethui()
	end)

	if ok and result then
		return result
	end
	return game:GetService("CoreGui")
end

_G.__RealInRound = next(CurrentRoundClient.PlayerData) ~= nil
_G.InRound = _G.__RealInRound
_G.BagFull = false
local bagPollLoopId = {}
_G.__BagPollLoopId = bagPollLoopId

task.spawn(function()
	while _G.__BagPollLoopId == bagPollLoopId do
		task.wait(0.2)
		local bagFull = false

		pcall(function()
			local playerGui = localPlayer:FindFirstChild("PlayerGui")
			local container = playerGui and playerGui:FindFirstChild("MainGUI") and playerGui.MainGUI:FindFirstChild("Game") and playerGui.MainGUI.Game:FindFirstChild("CoinBags") and playerGui.MainGUI.Game.CoinBags:FindFirstChild("Container")

			if container then
				for _, child in ipairs(container:GetChildren()) do
					local fullBagIcon = child:FindFirstChild("FullBagIcon")
					if fullBagIcon and fullBagIcon.Visible then
						bagFull = true
						break
					end
				end
			end
		end)

		_G.BagFull = bagFull
	end
end)

local tbl, fn3

do
	local folder = Instance.new("Folder")
	folder.Name = "MarbegCoinESP"
	folder.Parent = fn2()
	_G.CoinESPFolder = folder
	tbl = {}
	_G.CoinESPEnabled = false

	local function fn4(arg)
		local tbl2 = {}

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Transparency < 1 then
				table.insert(tbl2, descendant)
			end
		end

		if #tbl2 == 0 and arg:IsA("BasePart") and arg.Transparency < 1 then
			table.insert(tbl2, arg)
		end

		return tbl2
	end

	local fn5 = nil

	local function fn6(arg, arg2)
		if not (_G.CoinESPEnabled and _G.InRound) then
			return
		end

		if arg.highlight then
			if arg.highlight.Parent and arg.highlight.Adornee and arg.highlight.Adornee.Parent then
				arg.highlight.Enabled = true
				return
			end
			fn5(arg)
		end

		local visualPart = arg.visualPart

		if not visualPart or not visualPart.Parent or visualPart.Transparency >= 1 then
			visualPart = fn4(arg2)[1]
			arg.visualPart = visualPart
		end

		if not visualPart then
			return
		end
		local highlight = Instance.new("Highlight")
		highlight.FillColor = Color3.fromRGB(255, 200, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 235, 120)
		highlight.FillTransparency = 0
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = visualPart
		highlight.Parent = folder
		arg.highlight = highlight
	end

	fn5 = function(arg)
		if arg.highlight then
			pcall(function()
				arg.highlight:Destroy()
			end)

			arg.highlight = nil
		end
	end

	_G.FarmCoinsCollected = 0
	_G.FarmCoinTimes = {}

	_G.__FarmCountPickup = function(arg)
		local character = localPlayer.Character
		character = character and character:FindFirstChild("HumanoidRootPart")
		if not character or (character.Position - arg).Magnitude > 16 then
			return
		end
		_G.FarmCoinsCollected = _G.FarmCoinsCollected + 1
		local farmCoinTimes = _G.FarmCoinTimes
		table.insert(farmCoinTimes, os.clock())

		while true do
			local flag = #farmCoinTimes > 0

			if flag then
				local v = farmCoinTimes[1]
				flag = os.clock() - v > 600
			end

			if flag then
				table.remove(farmCoinTimes, 1)
				continue
			end
			break
		end
	end

	_G.FarmGetRates = function()
		local farmCoinTimes = _G.FarmCoinTimes
		if #farmCoinTimes < 2 then
			return 0, 0, #farmCoinTimes
		end
		local v = farmCoinTimes[1]
		local n = os.clock() - v
		if n < 5 then
			return 0, 0, #farmCoinTimes
		end
		local n2 = #farmCoinTimes / n * 60
		return n2, n2 * 60, #farmCoinTimes
	end

	_G.FarmResetRates = function()
		_G.FarmCoinsCollected = 0
		_G.FarmCoinTimes = {}
	end

	fn3 = function(arg, arg2)
		if tbl[arg] ~= arg2 then
			return
		end
		pcall(_G.__FarmCountPickup, arg.Position)
		fn5(arg2)
		tbl[arg] = nil

		if arg2.connections then
			for _, connection in ipairs(arg2.connections) do
				pcall(function()
					connection:Disconnect()
				end)
			end

			table.clear(arg2.connections)
		end
	end

	local tbl2 = {
		{ "rareegg", 5 },
		{ "egg", 3 },
		{ "snowtoken", 3 },
		{ "token", 3 },
		{ "candy", 2.5 },
		{ "candie", 2.5 },
		{ "beachball", 2 },
	}

	local function fn7(arg)
		local n = 1

		for _, descendant in ipairs(arg:GetDescendants()) do
			local v = string.lower(descendant.Name)

			for _, v2 in ipairs(tbl2) do
				if string.find(v, v2[1], 1, true) and v2[2] > n then
					n = v2[2]
				end
			end
		end

		return n
	end

	local fn8 = nil

	fn8 = function(arg)
		if tbl[arg] then
			return
		end

		if not (arg.Name == "Coin_Server" and arg:IsA("BasePart")) then
			return
		end

		if not arg.CanTouch then
			return
		end
		local v = fn4(arg)

		if #v == 0 then
			task.delay(0.1, function()
				if arg.Parent and not tbl[arg] then
					fn8(arg)
				end
			end)

			return
		end

		local tbl3 = { part = arg, visualPart = v[1], highlight = nil, connections = {}, weight = fn7(arg) }
		tbl[arg] = tbl3
		fn6(tbl3, arg)

		table.insert(tbl3.connections, arg.AncestryChanged:Connect(function(child, parent)
			if not parent then
				fn3(arg, tbl3)
			end
		end))

		table.insert(tbl3.connections, arg:GetPropertyChangedSignal("CanTouch"):Connect(function()
			if not arg.CanTouch then
				fn3(arg, tbl3)
			end
		end))

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") then
				table.insert(tbl3.connections, descendant:GetPropertyChangedSignal("Transparency"):Connect(function()
					if descendant.Transparency >= 0.5 then
						fn3(arg, tbl3)
					end
				end))
			end
		end
	end

	local function fn9()
		for _, descendant in ipairs(workspace:GetDescendants()) do
			if descendant.Name == "Coin_Server" and descendant:IsA("BasePart") then
				fn8(descendant)
			end
		end
	end

	local function fn10()
		for k, v in pairs(tbl) do
			local visualPart = v.visualPart

			if not k.Parent or not k.CanTouch or not visualPart or not visualPart.Parent or visualPart.Transparency >= 0.5 then
				fn3(k, v)
			end
		end
	end

	fn9()

	_G.CoinESPConn = {
		(workspace.DescendantAdded:Connect(function(descendant)
			if not (descendant.Name == "Coin_Server" and descendant:IsA("BasePart")) then
				local parent = descendant.Parent

				while true do
					local flag = parent and parent ~= workspace
					descendant = nil

					if flag then
						if parent.Name == "Coin_Server" and parent:IsA("BasePart") then
							descendant = parent
							break
						else
							parent = parent.Parent
							continue
						end
					end

					break
				end
			end

			if descendant then
				task.defer(fn8, descendant)
			end
		end)),
	}

	local coinRescanLoopId = {}
	_G.__CoinRescanLoopId = coinRescanLoopId

	task.spawn(function()
		while _G.__CoinRescanLoopId == coinRescanLoopId do
			task.wait(1)
			pcall(fn10)
		end
	end)

	local function refreshCoinVisibility()
		for _, v in pairs(tbl) do
			if _G.CoinESPEnabled and _G.InRound then
				fn6(v, v.part)
			else
				fn5(v)
			end
		end
	end

	_G.RefreshCoinVisibility = refreshCoinVisibility

	_G.CoinESPSetEnabled = function(coinESPEnabled)
		_G.CoinESPEnabled = coinESPEnabled
		refreshCoinVisibility()
	end

	_G.GetNearestCoinPos = function(arg)
		local huge = math.huge
		local position = nil
		local v = nil

		for k in pairs(tbl) do
			if k.Parent then
				local magnitude = (k.Position - arg).Magnitude

				if magnitude < huge then
					position = k.Position
					huge = magnitude
					v = k
				end
			end
		end

		return v, position, huge
	end

	_G.GetAllCoinCandidates = function(arg)
		local tbl3 = {}

		for k, v in pairs(tbl) do
			if k.Parent then
				table.insert(tbl3, {
					part = k,
					pos = k.Position,
					dist = (k.Position - arg).Magnitude,
					weight = v.weight or 1,
				})
			end
		end

		table.sort(tbl3, function(arg2, arg3)
			return arg2.dist < arg3.dist
		end)

		return tbl3
	end

	table.insert(_G.CoinESPConn, gameplay.RoundStart.OnClientEvent:Connect(function()
		_G.__RealInRound = true
	end))

	table.insert(_G.CoinESPConn, gameplay.GameOver.OnClientEvent:Connect(function()
		_G.__RealInRound = false
	end))

	_G.__InRoundGuardConn = RunService.Heartbeat:Connect(function()
		if _G.InRound ~= _G.__RealInRound then
			_G.InRound = _G.__RealInRound
			pcall(refreshCoinVisibility)
		end
	end)
end

table.insert(_G.CoinESPConn, _G.__InRoundGuardConn)
local tbl2, tbl3, fn4, fn5, fn6

do
	local folder = Instance.new("Folder")
	folder.Name = "MarbegRoleESP"
	folder.Parent = fn2()
	_G.RoleESPFolder = folder
	_G.RoleESPEnabled = true
	_G.RoleTogglesEnabled = { Murderer = true, Sheriff = true, Innocent = true, Hero = true }
	_G.RoleNametagsEnabled = true
	_G.SheriffGunESPEnabled = true
	_G.ESPGlowEnabled = true
	tbl2 = {}
	tbl3 = nil
	_G.__HeroOverride = {}
	_G.__HeroTiming = _G.__HeroTiming or {}

	_G.__IsHeroNow = function(arg)
		if _G.__HeroOverride[arg.Name] then
			return true
		end
		local character = arg.Character
		character = character and character:FindFirstChild("Gun")
		return character ~= nil and character:IsA("Tool")
	end

	_G.__CachedDroppedGun = nil
	_G.__DroppedGunScanAt = 0

	_G.__IsDroppedGunInstance = function(arg)
		if not arg then
			return false
		end

		if arg.Name == "GunDrop" or arg.Name == "DroppedGun" then
			return arg:IsA("BasePart") or arg:IsA("Model") or arg:IsA("Tool")
		end
		return arg:IsA("Tool") and arg.Name == "Gun" and arg.Parent == workspace
	end

	local roleColors = {
		Murderer = Color3.fromRGB(255, 0, 25),
		Sheriff = Color3.fromRGB(0, 105, 255),
		Innocent = Color3.fromRGB(0, 255, 75),
		Hero = Color3.fromRGB(255, 215, 0),
		Lobby = Color3.fromRGB(175, 120, 255),
	}

	_G.ESPFillEnabled = false

	local tbl4 = {
		Murderer = Color3.fromRGB(255, 0, 25),
		Sheriff = Color3.fromRGB(0, 105, 255),
		Innocent = Color3.fromRGB(0, 255, 75),
		Hero = Color3.fromRGB(255, 215, 0),
		Lobby = Color3.fromRGB(175, 120, 255),
	}

	fn4 = function(arg)
		local v = tbl2[arg]

		if v then
			if v.highlight then
				pcall(function()
					v.highlight:Destroy()
				end)
			end

			if v.glow then
				pcall(function()
					v.glow:Destroy()
				end)
			end

			if v.billboard then
				pcall(function()
					v.billboard:Destroy()
				end)
			end

			if v.chams then
				pcall(function()
					v.chams.folder:Destroy()
				end)
			end

			if v.aura then
				pcall(function()
					v.aura:Destroy()
				end)
			end

			if v.conn then
				pcall(function()
					v.conn:Disconnect()
				end)
			end

			tbl2[arg] = nil
		end
	end

	fn5 = function()
		if tbl3 then
			if tbl3.highlight then
				pcall(function()
					tbl3.highlight:Destroy()
				end)
			end

			if tbl3.billboard then
				pcall(function()
					tbl3.billboard:Destroy()
				end)
			end

			if tbl3.conn then
				pcall(function()
					tbl3.conn:Disconnect()
				end)
			end

			tbl3 = nil
		end
	end

	fn6 = function()
		local cachedDroppedGun = _G.__CachedDroppedGun
		if cachedDroppedGun and cachedDroppedGun.Parent and cachedDroppedGun:IsDescendantOf(workspace) and (cachedDroppedGun:IsA("BasePart") or cachedDroppedGun:FindFirstChild("Handle") or cachedDroppedGun:FindFirstChildWhichIsA("BasePart", true)) then
			return cachedDroppedGun
		end
		_G.__CachedDroppedGun = nil
		local now = os.clock()
		if now - (_G.__DroppedGunScanAt or 0) < 0.4 then
			return nil
		end
		_G.__DroppedGunScanAt = now

		for _, v in ipairs({ "GunDrop", "DroppedGun" }) do
			local v2 = workspace:FindFirstChild(v, true)
			if v2 and _G.__IsDroppedGunInstance(v2) then
				_G.__CachedDroppedGun = v2
				return v2
			end
		end

		local gun = workspace:FindFirstChild("Gun")
		if gun and _G.__IsDroppedGunInstance(gun) then
			_G.__CachedDroppedGun = gun
			return gun
		end
		return nil
	end

	local function fn7()
		if not _G.SheriffGunESPEnabled then
			fn5()
			return
		end
		local v = fn6()
		if not v then
			fn5()
			return
		end

		if tbl3 and tbl3.adornee == v and tbl3.highlight and tbl3.highlight.Parent == folder and tbl3.billboard and tbl3.billboard.Parent == folder then
			return
		end
		fn5()
		local isBasePart = v:IsA("BasePart") and v or v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart", true)
		if not isBasePart then
			return
		end
		local highlight = Instance.new("Highlight")
		highlight.FillColor = roleColors.Sheriff
		highlight.OutlineColor = Color3.new(1, 1, 1)
		highlight.FillTransparency = 0.1
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = v
		highlight.Parent = folder
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "GunTag"
		billboardGui.Adornee = isBasePart
		billboardGui.Size = UDim2.fromOffset(100, 22)
		billboardGui.StudsOffset = Vector3.new(0, 1.6, 0)
		billboardGui.AlwaysOnTop = true
		billboardGui.AutoLocalize = false
		billboardGui.Parent = folder
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Size = UDim2.fromScale(1, 1)
		textLabel.Text = "Sheriff Gun"
		textLabel.TextColor3 = roleColors.Sheriff
		textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
		textLabel.TextStrokeTransparency = 0.2
		textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
		textLabel.TextScaled = true
		textLabel.AutoLocalize = false
		textLabel.Parent = billboardGui

		tbl3 = {
			highlight = highlight,
			billboard = billboardGui,
			conn = v.AncestryChanged:Connect(function(child, parent)
				if not parent or not v:IsDescendantOf(workspace) then
					fn5()
				end
			end),
			adornee = v,
		}
	end

	_G.ESPStyle = "Classic"
	_G.ESPFillOpacity = 0.88
	_G.__RoleColors = roleColors

	_G.__ESPLook = function(arg)
		local color = roleColors[arg] or Color3.new(1, 1, 1)
		if _G.ESPChams then
			local color2 = Color3.new(1, 1, 1)
			return color:Lerp(color2, 0.55), color:Lerp(color2, 0.85), 0.2
		end
		local espFillEnabled = _G.ESPFillEnabled

		if espFillEnabled then
			espFillEnabled = 1 - (_G.ESPFillOpacity or 0.88)
		end

		espFillEnabled = espFillEnabled or 1
		if _G.ESPStyle == "Neon" then
			local color2 = Color3.new(1, 1, 1)
			return color:Lerp(color2, 0.12), color:Lerp(color2, 0.75), espFillEnabled < 1 and math.max(0, espFillEnabled - 0.1) or 1
		end
		return color, tbl4[arg] or color, espFillEnabled
	end

	_G.ESPSetRoleColor = function(arg, arg2)
		if typeof(arg2) ~= "Color3" then
			return
		end
		roleColors[arg] = arg2
		tbl4[arg] = arg2

		if _G.__RefreshRoleESP then
			_G.__RefreshRoleESP()
		end
	end

	local function createHighlight(adornee, arg, parent)
		local v, v2, v3 = _G.__ESPLook(arg)
		local highlight = Instance.new("Highlight")
		highlight.Name = "RoleHighlight_" .. tostring(arg)
		highlight:SetAttribute("MarbegRoleBase", true)
		highlight:SetAttribute("MarbegRole", arg)
		highlight.FillColor = v
		highlight.OutlineColor = v2
		highlight.FillTransparency = v3
		highlight.OutlineTransparency = 0
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = adornee
		highlight.Parent = parent
		return highlight
	end

	local function createHighlight2(adornee, arg, parent)
		local color = roleColors[arg] or Color3.new(1, 1, 1)
		local highlight = Instance.new("Highlight")
		highlight.Name = "RoleGlow_" .. tostring(arg)
		highlight:SetAttribute("MarbegRoleGlow", true)
		highlight.FillColor = color
		highlight.OutlineColor = color
		highlight.FillTransparency = 0.78
		highlight.OutlineTransparency = 0.28
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Adornee = adornee
		highlight.Parent = parent
		return highlight
	end

	_G.ESPFillSetEnabled = function(arg)
		_G.ESPFillEnabled = arg and true or false

		for _, child in ipairs(folder:GetChildren()) do
			if child:IsA("Highlight") and child:GetAttribute("MarbegRoleBase") then
				child.FillTransparency = select(3, _G.__ESPLook(child:GetAttribute("MarbegRole")))
			end
		end
	end

	_G.ESPFillSetOpacity = function(arg)
		_G.ESPFillOpacity = math.clamp(tonumber(arg) or 0.88, 0, 1)
		_G.ESPFillSetEnabled(_G.ESPFillEnabled)
	end

	local function fn8(arg, arg2)
		if arg == localPlayer then
			return
		end
		local flag = arg2 == "Lobby"
		if not _G.RoleESPEnabled or flag and _G.InRound or not flag and (not _G.InRound or not _G.RoleTogglesEnabled[arg2]) then
			fn4(arg.UserId)
			return
		end
		local character = arg.Character
		if not character then
			fn4(arg.UserId)
			return
		end
		local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
		local head = character:FindFirstChild("Head")
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if not humanoidRootPart or not humanoid then
			fn4(arg.UserId)
			return
		end
		local v = tbl2[arg.UserId]
		local roleNametagsEnabled = flag or _G.RoleNametagsEnabled

		if v and v.role == arg2 and v.character == character and v and v.highlight and v.highlight.Parent == folder and v.highlight.Adornee == character and v and (_G.ESPGlowEnabled and v.glow and v.glow.Parent == folder and v.glow.Adornee == character or not _G.ESPGlowEnabled and v.glow == nil) and v and (roleNametagsEnabled and v.billboard and v.billboard.Parent == folder or not roleNametagsEnabled and v.billboard == nil) then
			v.highlight.Enabled = true

			if v.glow then
				v.glow.Enabled = _G.ESPGlowEnabled
			end

			return
		end

		fn4(arg.UserId)
		local color = roleColors[arg2] or Color3.new(1, 1, 1)
		local v2 = createHighlight(character, arg2, folder)
		local espGlowEnabled = _G.ESPGlowEnabled and createHighlight2(character, arg2, folder) or nil
		local roleNametagsEnabled2 = flag or _G.RoleNametagsEnabled
		local billboardGui = nil

		if roleNametagsEnabled2 then
			billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = "RoleTag_" .. arg.Name
			billboardGui.Adornee = head or humanoidRootPart
			billboardGui.Size = UDim2.fromOffset(170, 22)
			billboardGui.StudsOffsetWorldSpace = Vector3.new(0, 2.15, 0)
			billboardGui.AlwaysOnTop = true
			billboardGui.LightInfluence = 0
			billboardGui.MaxDistance = 1500
			billboardGui.AutoLocalize = false
			billboardGui.Parent = folder
			local textLabel = Instance.new("TextLabel")
			textLabel.Name = "PlayerName"
			textLabel.BackgroundTransparency = 1
			textLabel.Size = UDim2.fromScale(1, 1)
			textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
			textLabel.Text = arg.Name
			textLabel.TextColor3 = flag and Color3.fromRGB(225, 225, 235) or color
			textLabel.TextSize = 14
			textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
			textLabel.TextStrokeTransparency = 0
			textLabel.TextXAlignment = Enum.TextXAlignment.Center
			textLabel.TextTruncate = Enum.TextTruncate.AtEnd
			textLabel.AutoLocalize = false
			textLabel.Parent = billboardGui

			if _G.ESPNametagAvatar and not flag then
				billboardGui.Size = UDim2.fromOffset(220, 26)
				local frame = Instance.new("Frame")
				frame.Name = "Row"
				frame.BackgroundTransparency = 1
				frame.Size = UDim2.fromScale(1, 1)
				frame.Parent = billboardGui
				local uiListLayout = Instance.new("UIListLayout")
				uiListLayout.FillDirection = Enum.FillDirection.Horizontal
				uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
				uiListLayout.Padding = UDim.new(0, 5)
				uiListLayout.Parent = frame
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Name = "Avatar"
				imageLabel.LayoutOrder = 1
				imageLabel.Size = UDim2.fromOffset(22, 22)
				imageLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
				imageLabel.BackgroundTransparency = 0.25
				imageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. arg.UserId .. "&w=48&h=48"
				imageLabel.Parent = frame
				Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(1, 0)
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = color
				uiStroke.Thickness = 1.5
				uiStroke.Parent = imageLabel
				textLabel.LayoutOrder = 2
				textLabel.Size = UDim2.fromScale(0, 1)
				textLabel.AutomaticSize = Enum.AutomaticSize.X
				textLabel.TextTruncate = Enum.TextTruncate.None
				textLabel.Parent = frame
			end
		end

		tbl2[arg.UserId] = {
			highlight = v2,
			glow = espGlowEnabled,
			billboard = billboardGui,
			conn = character.AncestryChanged:Connect(function(child, parent)
				if not parent then
					fn4(arg.UserId)
				end
			end),
			role = arg2,
			character = character,
			player = arg,
		}
	end

	local function fn9()
		if not _G.RoleESPEnabled then
			for k in pairs(tbl2) do
				fn4(k)
			end

			fn5()
			return
		end

		if not _G.InRound then
			fn5()

			for k in pairs(tbl2) do
				fn4(k)
			end

			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			local v = CurrentRoundClient.PlayerData[player.Name]

			if v and v.Role then
				if v.Dead then
					fn4(player.UserId)

					if v.Role == "Sheriff" then
						fn7()
					end
				elseif v.Role == "Murderer" or v.Role == "Sheriff" or v.Role == "Innocent" or v.Role == "Hero" then
					local role = v.Role

					if role == "Innocent" and _G.__IsHeroNow(player) then
						role = "Hero"
					end

					if v.Role == "Hero" then
						local v2 = _G.__HeroTiming[player.Name]

						if v2 and not v2.pd then
							v2.pd = os.clock()
						end
					end

					fn8(player, role)
				end
			else
				fn4(player.UserId)
			end
		end

		fn7()
	end

	_G.RoleESPSetEnabled = function(roleESPEnabled)
		_G.RoleESPEnabled = roleESPEnabled
		fn9()
	end

	_G.RoleESPSetTypeEnabled = function(arg, arg2)
		_G.RoleTogglesEnabled[arg] = arg2
		fn9()
	end

	_G.ESPGlowSetEnabled = function(arg)
		_G.ESPGlowEnabled = arg and true or false

		for k in pairs(tbl2) do
			fn4(k)
		end

		fn9()
	end

	_G.SheriffGunESPSetEnabled = function(sheriffGunESPEnabled)
		_G.SheriffGunESPEnabled = sheriffGunESPEnabled

		if sheriffGunESPEnabled then
			fn7()
		else
			fn5()
		end
	end

	_G.RoleNametagsSetEnabled = function(roleNametagsEnabled)
		_G.RoleNametagsEnabled = roleNametagsEnabled

		for k in pairs(tbl2) do
			fn4(k)
		end

		fn9()
	end

	_G.ESPNametagAvatar = true

	_G.ESPNametagAvatarSetEnabled = function(arg)
		_G.ESPNametagAvatar = arg and true or false

		for k in pairs(tbl2) do
			fn4(k)
		end

		fn9()
	end

	_G.__RefreshRoleESP = function()
		for k in pairs(tbl2) do
			fn4(k)
		end

		fn9()
	end

	_G.ESPSetStyle = function(arg)
		_G.ESPStyle = (arg == "Neon" or arg == "Pulse") and arg or "Classic"
		_G.__RefreshRoleESP()
	end

	_G.ESPChams = true
	_G.ESPBoxes = true
	_G.ESPTracers = false
	_G.ESPTracerOrigin = "Bottom"
	_G.ESPDistance = false
	_G.ESPArrows = true
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegESPOverlay"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 5
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = fn2()
	_G.ESPOverlayGui = screenGui
	local tbl5 = {}
	local color = Color3.new(1, 1, 1)

	local function createBillboardGui(backgroundColor3, adornee)
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Name = "MarbegAura"
		billboardGui.Adornee = adornee
		billboardGui.Size = UDim2.new(5.5, 0, 7.5, 0)
		billboardGui.StudsOffset = Vector3.new(0, 0.3, -0.6)
		billboardGui.LightInfluence = 0
		billboardGui.Brightness = 2
		billboardGui.AlwaysOnTop = false
		billboardGui.AutoLocalize = false

		for i = 1, 10 do
			local frame = Instance.new("Frame")
			local n = 1 - (i - 1) * 0.07
			frame.AnchorPoint = Vector2.new(0.5, 0.5)
			frame.Position = UDim2.fromScale(0.5, 0.5)
			frame.Size = UDim2.fromScale(n, n)
			frame.BackgroundColor3 = backgroundColor3
			frame.BackgroundTransparency = 0.945
			frame.BorderSizePixel = 0
			Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
			frame.Parent = billboardGui
		end

		billboardGui.Parent = folder
		return billboardGui
	end

	local function fn10()
		local frame = Instance.new("Frame")
		frame.Name = "Box"
		frame.BackgroundTransparency = 0.92
		frame.BorderSizePixel = 0
		frame.Visible = false
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 3)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 1.6
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = frame
		local frame2 = Instance.new("Frame")
		frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		frame2.Position = UDim2.fromScale(0.5, 0.5)
		frame2.Size = UDim2.new(1, -3, 1, -3)
		frame2.BackgroundTransparency = 1
		frame2.Parent = frame
		Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 2)
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Thickness = 1
		uiStroke2.Color = Color3.new(0, 0, 0)
		uiStroke2.Transparency = 0.5
		uiStroke2.Parent = frame2
		local frame3 = Instance.new("Frame")
		frame3.Name = "Tracer"
		frame3.AnchorPoint = Vector2.new(0.5, 0.5)
		frame3.BorderSizePixel = 0
		frame3.Visible = false
		frame3.Parent = screenGui
		local uiStroke3 = Instance.new("UIStroke")
		uiStroke3.Thickness = 0.6
		uiStroke3.Color = Color3.new(0, 0, 0)
		uiStroke3.Transparency = 0.6
		uiStroke3.Parent = frame3
		local frame4 = Instance.new("Frame")
		frame4.Name = "Arrow"
		frame4.AnchorPoint = Vector2.new(0.5, 0.5)
		frame4.Size = UDim2.fromOffset(26, 26)
		frame4.BackgroundTransparency = 1
		frame4.Visible = false
		frame4.Parent = screenGui
		local uiScale = Instance.new("UIScale")
		uiScale.Parent = frame4
		local tbl6 = {}

		for _, v in ipairs({ 40, -40 }) do
			local v2 = math.rad(v)
			local sin = math.sin
			local n = Vector2.new(24, 13) - Vector2.new(math.cos(v2), sin(v2)) * 7.5
			local frame5 = Instance.new("Frame")
			frame5.AnchorPoint = Vector2.new(0.5, 0.5)
			frame5.Position = UDim2.fromOffset(n.X, n.Y)
			frame5.Size = UDim2.fromOffset(15, 4)
			frame5.Rotation = v
			frame5.BorderSizePixel = 0
			frame5.Parent = frame4
			Instance.new("UICorner", frame5).CornerRadius = UDim.new(1, 0)
			local uiStroke4 = Instance.new("UIStroke")
			uiStroke4.Color = Color3.new(0, 0, 0)
			uiStroke4.Thickness = 1
			uiStroke4.Transparency = 0.35
			uiStroke4.Parent = frame5
			tbl6[#tbl6 + 1] = frame5
		end

		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "ArrowDistance"
		textLabel.AnchorPoint = Vector2.new(0.5, 0)
		textLabel.Size = UDim2.fromOffset(60, 14)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 11
		textLabel.TextStrokeTransparency = 0.3
		textLabel.Visible = false
		textLabel.Parent = screenGui
		return { box = frame, stroke = uiStroke, line = frame3, arrow = frame4, arrowScale = uiScale, bars = tbl6, tag = textLabel }
	end

	local function fn11(arg)
		local v = tbl5[arg]

		if v then
			pcall(function()
				v.box:Destroy()
			end)

			pcall(function()
				v.line:Destroy()
			end)

			pcall(function()
				v.arrow:Destroy()
			end)

			pcall(function()
				v.tag:Destroy()
			end)

			tbl5[arg] = nil
		end
	end

	local tbl6 = { { scale = 1.14, transparency = 0.6, whiten = 0.12 } }

	local function shellCopy(arg, arg2)
		local archivable = arg.Archivable
		arg.Archivable = true

		local ok, result = pcall(function()
			return arg:Clone()
		end)

		arg.Archivable = archivable
		if not ok or not result then
			return nil
		end
		local v = nil

		for _, child in ipairs(result:GetChildren()) do
			if child:IsA("SpecialMesh") then
				v = child
			else
				child:Destroy()
			end
		end

		result.Name = "MarbegChamsPart"
		result.Material = Enum.Material.Neon
		result.Anchored = true
		result.CanCollide = false
		result.CanQuery = false
		result.CanTouch = false
		result.CastShadow = false
		result.Massless = true

		pcall(function()
			result.TextureID = ""
		end)

		if v then
			v.TextureId = ""

			if v.MeshType == Enum.MeshType.FileMesh then
				v.Scale = v.Scale * arg2
			else
				result.Size = result.Size * arg2
			end
		else
			result.Size = result.Size * arg2
		end

		return result
	end

	_G.__ShellCopy = shellCopy

	local function fn12(arg, arg2)
		local folder2 = Instance.new("Folder")
		folder2.Name = "MarbegChams"
		folder2.Parent = workspace.CurrentCamera
		local tbl7 = {}

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" and descendant.Transparency < 0.9 then
				for _, v in ipairs(tbl6) do
					local v2 = shellCopy(descendant, v.scale)

					if v2 then
						v2.Transparency = v.transparency
						v2.Color = arg2:Lerp(color, v.whiten)
						v2.CFrame = descendant.CFrame
						v2.Parent = folder2
						tbl7[#tbl7 + 1] = { part = descendant, copy = v2, spec = v }
					end
				end
			end
		end

		return {
			folder = folder2,
			shells = tbl7,
			character = arg,
			color = arg2,
			count = #arg:GetDescendants(),
			checkedAt = os.clock(),
		}
	end

	local n = 0

	RunService:BindToRenderStep("MarbegESPOverlay", Enum.RenderPriority.Camera.Value + 1, function()
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return
		end
		local now = os.clock()
		local n2 = (math.sin(now * 3.2) + 1) / 2
		local espStyle = _G.ESPStyle
		local flag = now - n > 0.15

		if flag then
			n = now
		end

		local viewportSize = currentCamera.ViewportSize
		local position = currentCamera.CFrame.Position
		local tbl7 = {}
		local tbl8 = {}
		local tbl9 = {}

		for k, v in pairs(tbl2) do
			local character = v.character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			local highlight = v.highlight

			if humanoidRootPart and highlight and highlight.Parent then
				tbl7[k] = true
				local v2 = roleColors[v.role] or color

				if espStyle ~= "Classic" and _G.ESPFillEnabled and not _G.ESPChams then
					local v3, v4, v5 = _G.__ESPLook(v.role)
					highlight.FillTransparency = math.clamp(v5 + (espStyle == "Neon" and 0.2 or 0.45) * n2, 0, 1)
				end

				if espStyle == "Neon" then
					if not v.aura or v.aura.Parent ~= folder or v.aura.Adornee ~= humanoidRootPart then
						if v.aura then
							pcall(function()
								v.aura:Destroy()
							end)
						end

						v.aura = createBillboardGui(v2, humanoidRootPart)
					end

					local n3 = 1 + 0.1 * n2
					v.aura.Size = UDim2.new(5.5 * n3, 0, 7.5 * n3, 0)
				elseif v.aura then
					pcall(function()
						v.aura:Destroy()
					end)

					v.aura = nil
				end

				if _G.ESPChams then
					local chams = v.chams
					local flag2 = not chams or chams.character ~= character or not chams.folder.Parent

					if chams and not flag2 and now - chams.checkedAt > 1 then
						chams.checkedAt = now
						local count = chams.count
						flag2 = #character:GetDescendants() ~= count
					end

					if flag2 then
						if chams then
							pcall(function()
								chams.folder:Destroy()
							end)
						end

						chams = fn12(character, v2)
						v.chams = chams
					end

					if chams.color ~= v2 then
						chams.color = v2

						for _, shell in ipairs(chams.shells) do
							shell.copy.Color = v2:Lerp(color, shell.spec.whiten)
						end
					end

					for _, shell in ipairs(chams.shells) do
						if shell.part.Parent then
							tbl8[#tbl8 + 1] = shell.copy
							tbl9[#tbl9 + 1] = shell.part.CFrame
						end
					end
				elseif v.chams then
					pcall(function()
						v.chams.folder:Destroy()
					end)

					v.chams = nil
				end

				if flag and v.billboard and v.player then
					local playerName = v.billboard:FindFirstChild("PlayerName", true)

					if playerName then
						playerName.Text = _G.ESPDistance and string.format("%s  %dm", v.player.Name, math.floor((position - humanoidRootPart.Position).Magnitude)) or v.player.Name
					end
				end

				local v3 = tbl5[k]

				if _G.ESPBoxes or _G.ESPTracers or _G.ESPArrows then
					if not v3 then
						v3 = fn10()
						tbl5[k] = v3
					end

					local head = character:FindFirstChild("Head")
					local v4 = currentCamera:WorldToViewportPoint((head and head.Position or humanoidRootPart.Position + Vector3.new(0, 1.5, 0)) + Vector3.new(0, 0.9, 0))
					local v5 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position - Vector3.new(0, 3.1, 0))
					local flag2 = v4.Z > 0 and v5.Z > 0

					if _G.ESPBoxes and flag2 then
						local n3 = math.max(4, v5.Y - v4.Y)
						local n4 = n3 * 0.58
						v3.box.Position = UDim2.fromOffset(v4.X - n4 / 2, v4.Y)
						v3.box.Size = UDim2.fromOffset(n4, n3)
						v3.box.BackgroundColor3 = v2
						v3.stroke.Color = v2
						v3.box.Visible = true
					else
						v3.box.Visible = false
					end

					if _G.ESPTracers and flag2 then
						local vector2 = Vector2.new(viewportSize.X / 2, _G.ESPTracerOrigin == "Center" and viewportSize.Y / 2 or _G.ESPTracerOrigin == "Top" and 0 or viewportSize.Y)
						local vector22 = Vector2.new(v5.X, v5.Y)
						local n3 = vector22 - vector2
						v3.line.Position = UDim2.fromOffset((vector2.X + vector22.X) / 2, (vector2.Y + vector22.Y) / 2)
						v3.line.Size = UDim2.fromOffset(n3.Magnitude, 1.5)
						v3.line.Rotation = math.deg(math.atan2(n3.Y, n3.X))
						v3.line.BackgroundColor3 = v2
						v3.line.BackgroundTransparency = 0.15
						v3.line.Visible = true
					else
						v3.line.Visible = false
					end

					local v6 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

					if _G.ESPArrows and not (v6.Z > 0 and v6.X >= 0 and v6.X <= viewportSize.X and v6.Y >= 0 and v6.Y <= viewportSize.Y) then
						local v7 = currentCamera.CFrame:PointToObjectSpace(humanoidRootPart.Position)
						local vector2 = Vector2.new(v7.X, -v7.Y)
						local unit = vector2.Magnitude > 0.001 and vector2.Unit or Vector2.new(0, 1)
						local n3 = viewportSize / 2
						local max = math.max
						local n4 = n3.Y - 70
						local vector22 = Vector2.new(math.max(n3.X - 70, 40), max(n4, 40))
						local n5 = n3 + Vector2.new(unit.X * vector22.X, unit.Y * vector22.Y)
						local scale = v.role == "Murderer" and 1 + 0.15 * n2 or 1
						v3.arrow.Position = UDim2.fromOffset(n5.X, n5.Y)
						v3.arrow.Rotation = math.deg(math.atan2(unit.Y, unit.X))
						v3.arrowScale.Scale = scale

						for _, bar in ipairs(v3.bars) do
							bar.BackgroundColor3 = v2
						end

						v3.arrow.Visible = true
						v3.tag.Position = UDim2.fromOffset(n5.X, n5.Y + 15)
						v3.tag.TextColor3 = v2
						v3.tag.Text = string.format("%dm", math.floor((position - humanoidRootPart.Position).Magnitude))
						v3.tag.Visible = true
					else
						v3.arrow.Visible = false
						v3.tag.Visible = false
					end
				elseif v3 then
					fn11(k)
				end
			end
		end

		if #tbl8 > 0 then
			workspace:BulkMoveTo(tbl8, tbl9, Enum.BulkMoveMode.FireCFrameChanged)
		end

		for k in pairs(tbl5) do
			if not tbl7[k] then
				fn11(k)
			end
		end
	end)

	_G.ESPChamsSetEnabled = function(arg)
		_G.ESPChams = arg and true or false
		_G.__RefreshRoleESP()
	end

	_G.ESPBoxesSetEnabled = function(arg)
		_G.ESPBoxes = arg and true or false
	end

	_G.ESPTracersSetEnabled = function(arg)
		_G.ESPTracers = arg and true or false
	end

	_G.ESPDistanceSetEnabled = function(arg)
		_G.ESPDistance = arg and true or false
	end

	_G.ESPArrowsSetEnabled = function(arg)
		_G.ESPArrows = arg and true or false
	end

	_G.ESPTracerSetOrigin = function(espTracerOrigin)
		_G.ESPTracerOrigin = espTracerOrigin
	end

	local roleRefreshBurstId = {}
	_G.__RoleRefreshBurstId = roleRefreshBurstId

	local function fn13()
		if _G.__RoleRefreshBurstId ~= roleRefreshBurstId then
			return
		end
		pcall(fn9)

		for _, v in ipairs({ 0.03, 0.1, 0.25 }) do
			task.delay(v, function()
				if _G.__RoleRefreshBurstId == roleRefreshBurstId then
					pcall(fn9)
				end
			end)
		end
	end

	table.insert(_G.CoinESPConn, CurrentRoundClient.PlayerDataChanged.Event:Connect(function()
		for _, v in pairs(CurrentRoundClient.PlayerData) do
			v = v and v.Role

			if v then
				_G.__RealInRound = true
				_G.InRound = true
				break
			end
		end

		fn13()
	end))

	table.insert(_G.CoinESPConn, gameplay.RoundStart.OnClientEvent:Connect(function()
		_G.__HeroOverride = {}
		_G.__HeroTiming = {}
		_G.__RealInRound = true
		_G.InRound = true
		fn13()
	end))

	table.insert(_G.CoinESPConn, gameplay.GameOver.OnClientEvent:Connect(function()
		_G.__HeroOverride = {}
		_G.__RealInRound = false
		_G.InRound = false

		for k in pairs(tbl2) do
			fn4(k)
		end

		fn5()
		fn13()
	end))

	local function fn14(arg)
		table.insert(_G.CoinESPConn, arg.CharacterAdded:Connect(function()
			task.defer(fn9)
		end))

		table.insert(_G.CoinESPConn, arg.CharacterRemoving:Connect(function()
			fn4(arg.UserId)
			task.defer(fn9)
		end))
	end

	for _, player in ipairs(Players:GetPlayers()) do
		fn14(player)
	end

	table.insert(_G.CoinESPConn, Players.PlayerAdded:Connect(function(player)
		fn14(player)
		task.defer(fn9)
	end))

	table.insert(_G.CoinESPConn, Players.PlayerRemoving:Connect(function(player)
		fn4(player.UserId)
		task.defer(fn9)
	end))

	table.insert(_G.CoinESPConn, workspace.DescendantAdded:Connect(function(descendant)
		if _G.__IsDroppedGunInstance(descendant) then
			_G.__CachedDroppedGun = descendant
			task.defer(fn7)
		elseif descendant.Name == "Gun" and descendant:IsA("Tool") and Players:GetPlayerFromCharacter(descendant.Parent) then
			local playerFromCharacter = Players:GetPlayerFromCharacter(descendant.Parent)

			if playerFromCharacter and not _G.__HeroTiming[playerFromCharacter.Name] then
				_G.__HeroTiming[playerFromCharacter.Name] = { seen = os.clock(), how = "equipped" }
			end

			task.defer(fn9)
		end
	end))

	table.insert(_G.CoinESPConn, workspace.DescendantRemoving:Connect(function(descendant)
		if _G.__CachedDroppedGun == descendant and _G.InRound then
			local ok, result = pcall(function()
				return descendant:IsA("BasePart") and descendant.Position or descendant:GetPivot().Position
			end)

			if ok and result then
				local n2 = 10
				local v = nil

				for _, player in ipairs(Players:GetPlayers()) do
					local v2 = CurrentRoundClient.PlayerData[player.Name]
					local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

					if v2 and v2.Role == "Innocent" and not v2.Dead and humanoidRootPart then
						local magnitude = (humanoidRootPart.Position - result).Magnitude

						if magnitude < n2 then
							n2 = magnitude
							v = player
						end
					end
				end

				if v then
					_G.__HeroOverride[v.Name] = true

					if not _G.__HeroTiming[v.Name] then
						_G.__HeroTiming[v.Name] = { seen = os.clock(), how = "picked up" }
					end

					task.defer(fn9)
				end
			end
		end

		if _G.__CachedDroppedGun == descendant then
			_G.__CachedDroppedGun = nil
		end

		if tbl3 and tbl3.adornee == descendant then
			task.defer(fn5)
		end
	end))

	local roleRescanLoopId = {}
	_G.__RoleRescanLoopId = roleRescanLoopId

	task.spawn(function()
		while _G.__RoleRescanLoopId == roleRescanLoopId do
			task.wait(_G.PerformanceMode and _G.AutoFarmEnabled and 0.5 or 0.25)
			pcall(fn9)
		end
	end)
end

print("Core systems (coin registry + role esp) ready")
_G.AutoFarmEnabled = false
_G.AutoFarmSpeed = 25
_G.CollectCoinsUnderground = true
local connection
connection = nil
local v
v = nil
local v2
v2 = nil
local v3
v3 = nil
local n
n = 0.066
local v4
v4 = nil
local hipHeight, alignPosition

do
	local n2 = 350
	local n3 = 2.5
	local n4 = 1.25
	local n5 = 2
	local n6 = 2
	local n7 = 0.25
	hipHeight = nil
	local tbl4 = {}
	local v5 = nil
	local connection2 = nil
	local connection3 = nil
	local attachment = nil
	alignPosition = nil
	local alignOrientation = nil
	local part = nil
	local connection4 = nil
	local v6 = nil
	local v7 = nil
	local n8 = nil
	local size = nil
	local flag = false
	local v8 = nil
	local flag2 = false
	local v9 = nil
	local flag3 = true
	local tbl5 = {}
	local n9 = 0
	local connection5 = nil
	local tbl6 = { "water", "lava", "acid", "poison", "drown", "deadly", "hazard", "void" }

	local function fn7(arg)
		if not arg:IsA("BasePart") then
			return false
		end

		if arg.Material == Enum.Material.Water then
			return true
		end
		local v10 = string.lower(arg.Name)

		for _, v11 in ipairs(tbl6) do
			if string.find(v10, v11, 1, true) then
				return true
			end
		end

		for _, child in ipairs(arg:GetChildren()) do
			local v11 = string.lower(child.Name)
			if v11 == "waterclient" or v11 == "hitwater" or string.find(v11, "damage", 1, true) or string.find(v11, "kill", 1, true) or string.find(v11, "drown", 1, true) then
				return true
			end
		end

		return false
	end

	_G.__FarmInTerrainWater = function(arg)
		local ok, result = pcall(function()
			local v10 = workspace.Terrain:ReadVoxels(Region3.new(arg - Vector3.new(2, 2, 2), arg + Vector3.new(2, 2, 2)):ExpandToGrid(4), 4)
			local size2 = v10.Size

			for i = 1, size2.X do
				for i2 = 1, size2.Y do
					for i3 = 1, size2.Z do
						if v10[i][i2][i3] == Enum.Material.Water then
							return true
						end
					end
				end
			end

			return false
		end)

		return ok and result
	end

	_G.__FarmDangerZones = _G.__FarmDangerZones or {}

	_G.__FarmAddDanger = function(arg)
		if typeof(arg) ~= "Vector3" then
			return
		end
		table.insert(_G.__FarmDangerZones, { position = arg, expires = tick() + 240 })
	end

	_G.__FarmNearDanger = function(arg, arg2)
		local farmDangerZones = _G.__FarmDangerZones
		local now = tick()

		for i = #farmDangerZones, 1, -1 do
			local v10 = farmDangerZones[i]
			if now > v10.expires then
				table.remove(farmDangerZones, i)
				continue
			end

			if not ((v10.position - arg).Magnitude <= (arg2 or 20)) then
				continue
			end
			return true
		end

		return false
	end

	local function fn8(descendant)
		local isBasePart = descendant:IsA("BasePart") and descendant or descendant.Parent
		if not isBasePart or not isBasePart:IsA("BasePart") or not fn7(isBasePart) then
			return
		end

		if tbl5[isBasePart] == nil then
			tbl5[isBasePart] = isBasePart.CanTouch
		end

		pcall(function()
			isBasePart.CanTouch = false
		end)
	end

	local function fn9(arg)
		if not arg and tick() - n9 > 15 then
			arg = true
		end

		if not arg and tick() - n9 < 2 then
			return
		end
		n9 = tick()

		if arg then
			local tbl7 = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player.Character then
					tbl7[player.Character] = true
				end
			end

			local n10 = 0

			for _, child in ipairs(workspace:GetChildren()) do
				if not tbl7[child] and not child:IsA("Terrain") and not child:IsA("Camera") then
					for _, descendant in ipairs(child:GetDescendants()) do
						fn8(descendant)
						n10 += 1

						if n10 % 400 == 0 then
							RunService.Heartbeat:Wait()
						end
					end
				end
			end
		end

		for k in pairs(tbl5) do
			if not k.Parent then
				tbl5[k] = nil
			else
				pcall(function()
					k.CanTouch = false
				end)
			end
		end
	end

	local function fn10()
		for k, v10 in pairs(tbl5) do
			if k.Parent then
				pcall(function()
					k.CanTouch = v10
				end)
			end
		end

		table.clear(tbl5)
	end

	local function fn11(arg, arg2)
		for k in pairs(tbl5) do
			if k.Parent then
				local v10 = k.CFrame:PointToObjectSpace(arg)
				local n10 = k.Size * 0.5 + Vector3.new(arg2, arg2, arg2)
				local x = n10.X
				local flag4 = math.abs(v10.X) <= x

				if flag4 then
					local y = n10.Y
					flag4 = math.abs(v10.Y) <= y
				end

				if flag4 then
					local z = n10.Z
					flag4 = math.abs(v10.Z) <= z
				end

				if flag4 then
					return true
				end
			end
		end

		return false
	end

	local function fn12(arg, arg2)
		local n10 = arg2 - arg
		local n11 = math.clamp(math.ceil(n10.Magnitude / 3), 1, 60)

		for i = 0, n11 do
			if fn11(arg + n10 * i / n11, 3) then
				return true
			end
		end

		for i = 0, 4 do
			if _G.__FarmInTerrainWater(arg + n10 * i / 4) then
				return true
			end
		end

		return false
	end

	local function fn13(arg, arg2)
		local n10 = 3

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") then
				n10 = math.max(n10, descendant.Position.Y + descendant.Size.Y * 0.5 - arg2.Position.Y)
			end
		end

		n8 = math.clamp(n10, 2.5, 4)
	end

	local function fn14(arg)
		return Vector3.new(arg.X, arg.Y - (n8 or 3) - n6, arg.Z)
	end

	local function fn15(arg)
		if _G.CollectCoinsUnderground then
			return fn14(arg)
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		character = character and character:FindFirstChild("HumanoidRootPart")
		return Vector3.new(arg.X, arg.Y + (humanoid and character and math.max(2.5, humanoid.HipHeight + character.Size.Y * 0.5) or 3), arg.Z)
	end

	local function fn16(arg)
		if not size then
			size = arg.Size
		end

		local max = math.max
		local y = size.Y
		local n10 = n8 or 3
		local z = size.Z
		arg.Size = Vector3.new(size.X, max(y, n10 + n6 + 1) * 2, z)
	end

	local function fn17()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart and size then
			pcall(function()
				humanoidRootPart.Size = size
			end)
		end

		size = nil
	end

	local function fn18(arg, arg2, arg3, arg4)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { arg }
		raycastParams.IgnoreWater = false
		local hit = workspace:Raycast(arg2.Position, Vector3.new(0, 50, 0), raycastParams)
		local n10 = math.max(3, arg3.HipHeight + arg2.Size.Y * 0.5)
		if hit and hit.Material ~= Enum.Material.Water and not fn7(hit.Instance) then
			return hit.Position + Vector3.new(0, n10 + 0.25, 0)
		end
		return Vector3.new(arg2.Position.X, (arg4 and arg4.Y or arg2.Position.Y + 8) + n10, arg2.Position.Z)
	end

	local function fn19()
		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end

		if connection3 then
			connection3:Disconnect()
			connection3 = nil
		end

		for k, v10 in pairs(tbl4) do
			if k.Parent then
				pcall(function()
					k.CanCollide = v10
				end)
			end
		end

		table.clear(tbl4)
		v5 = nil
	end

	local function fn20(arg)
		if not arg:IsA("BasePart") then
			return
		end

		if tbl4[arg] == nil then
			tbl4[arg] = arg.CanCollide
		end

		arg.CanCollide = false
	end

	local function fn21(arg, arg2)
		if not arg2 then
			fn19()
			return
		end

		if v5 == arg then
			return
		end
		fn19()
		v5 = arg

		for _, descendant in ipairs(arg:GetDescendants()) do
			fn20(descendant)
		end

		connection2 = arg.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("BasePart") then
				task.defer(fn20, descendant)
			end
		end)

		connection3 = RunService.PreSimulation:Connect(function()
			for k in pairs(tbl4) do
				if k.Parent and k.CanCollide then
					k.CanCollide = false
				end
			end
		end)
	end

	local function fn22(parent)
		if alignPosition and alignPosition.Parent then
			return
		end
		attachment = Instance.new("Attachment")
		attachment.Name = "MarbegFlightAttach"
		attachment.Parent = parent
		alignPosition = Instance.new("AlignPosition")
		alignPosition.Name = "MarbegFlightAlign"
		alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
		alignPosition.Attachment0 = attachment
		alignPosition.ApplyAtCenterOfMass = true
		alignPosition.RigidityEnabled = false
		alignPosition.MaxForce = 500000
		alignPosition.Responsiveness = 18
		alignPosition.MaxVelocity = _G.AutoFarmSpeed
		alignPosition.Position = parent.Position
		alignPosition.Parent = parent
		alignOrientation = Instance.new("AlignOrientation")
		alignOrientation.Name = "MarbegUprightAlign"
		alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		alignOrientation.Attachment0 = attachment
		alignOrientation.CFrame = parent.CFrame - parent.CFrame.Position
		alignOrientation.RigidityEnabled = false
		alignOrientation.MaxTorque = 500000
		alignOrientation.MaxAngularVelocity = 10
		alignOrientation.Responsiveness = 12
		alignOrientation.Parent = parent
	end

	local function fn23()
		if alignPosition then
			pcall(function()
				alignPosition:Destroy()
			end)

			alignPosition = nil
		end

		if alignOrientation then
			pcall(function()
				alignOrientation:Destroy()
			end)

			alignOrientation = nil
		end

		if attachment then
			pcall(function()
				attachment:Destroy()
			end)

			attachment = nil
		end
	end

	local function fn24(cameraSubject)
		if connection4 then
			connection4:Disconnect()
			connection4 = nil
		end

		local currentCamera = workspace.CurrentCamera

		if currentCamera and part and currentCamera.CameraSubject == part and cameraSubject then
			currentCamera.CameraType = Enum.CameraType.Custom
			currentCamera.CameraSubject = cameraSubject
		end

		if part then
			pcall(function()
				part:Destroy()
			end)
		end

		part = nil
		v6 = nil
	end

	local function fn25(arg, arg2)
		if not _G.CollectCoinsUnderground then
			fn24(v2)
			return
		end

		if not part or not part.Parent then
			part = Instance.new("Part")
			part.Name = "MarbegFarmCameraProxy"
			part.Size = Vector3.one
			part.Transparency = 1
			part.Anchored = true
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.Parent = workspace
			v6 = arg2
			part.Position = Vector3.new(arg.Position.X, arg2 + 3.5, arg.Position.Z)

			if connection4 then
				connection4:Disconnect()
			end

			connection4 = RunService.RenderStepped:Connect(function(deltaTime)
				if not part or not part.Parent or not v3 or not v3.Parent then
					return
				end
				local position = part.Position
				local n10 = (v6 or v3.Position.Y) + 3.5
				local n11 = 1 - math.exp(-18 * math.min(deltaTime, 0.1))
				part.Position = Vector3.new(position.X + (v3.Position.X - position.X) * n11, position.Y + (n10 - position.Y) * (1 - math.exp(-7 * math.min(deltaTime, 0.1))), position.Z + (v3.Position.Z - position.Z) * n11)
			end)
		end

		v7 = arg2
		v6 = arg2
		local currentCamera = workspace.CurrentCamera

		if currentCamera then
			currentCamera.CameraType = Enum.CameraType.Custom
			currentCamera.CameraSubject = part
		end
	end

	local function fn26(arg)
		if connection then
			connection:Disconnect()
			connection = nil
		end

		if connection5 then
			connection5:Disconnect()
			connection5 = nil
		end

		local character = v or localPlayer.Character

		if character then
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

			if arg ~= false and humanoidRootPart and part and v7 then
				local n10 = humanoidRootPart.CFrame - humanoidRootPart.CFrame.Position

				pcall(function()
					character:PivotTo(CFrame.new(humanoidRootPart.Position.X, v7 + 3, humanoidRootPart.Position.Z) * n10)
				end)
			end

			pcall(fn21, character, false)
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")

			if humanoid then
				fn24(humanoid)
				humanoid.PlatformStand = false

				if hipHeight then
					humanoid.HipHeight = hipHeight
				end
			end
		end

		fn23()
		fn17()
		fn10()
		flag = false
		v8 = nil
		flag2 = false
		v9 = nil
		idleHoldPosition = nil
		v7 = nil
		v = nil
		v2 = nil
		v3 = nil
	end

	local tbl7 = {}
	local tbl8 = {}
	local tbl9 = {}
	local tbl10 = {}
	local tbl11 = {}
	local v10 = nil
	local position = nil

	local function fn27(arg)
		local now = tick()

		for k, v11 in pairs(tbl7) do
			if now > v11 or not k.Parent then
				tbl7[k] = nil
			end
		end

		if not _G.GetAllCoinCandidates then
			return nil, nil, nil
		end
		local v11 = _G.GetAllCoinCandidates(arg)
		local tbl12 = {}

		for _, v12 in ipairs(v11) do
			local v13 = fn15(v12.pos)

			if not tbl7[v12.part] and v12.dist <= n2 and not fn11(v12.pos, 3) and not fn11(v13, 4) and not fn12(arg, v13) and not _G.__FarmNearDanger(v12.pos, 20) and not _G.__FarmNearDanger(v13, 20) then
				tbl12[#tbl12 + 1] = { part = v12.part, pos = v12.pos, dist = v12.dist, goal = v13, weight = v12.weight or 1 }
			end

			if not (#tbl12 >= 12) then
				continue
			end
			break
		end

		local huge = math.huge
		local v12 = nil

		for _, v13 in ipairs(tbl12) do
			local n10 = 0

			for _, v14 in ipairs(v11) do
				if v14.part ~= v13.part and (v14.pos - v13.pos).Magnitude <= 28 then
					n10 += 1
				end
			end

			local n11 = v13.dist - math.min(n10, 6) * 9 + math.abs(v13.pos.Y - arg.Y) * 0.6

			if v13.part == v10 then
				n11 -= 12
			end

			local n12 = n11 - ((v13.weight or 1) - 1) * 30

			if n12 < huge then
				if not (_G.__FarmInTerrainWater(v13.pos) or _G.__FarmInTerrainWater(v13.goal)) then
					huge = n12
					v12 = v13
				else
					tbl7[v13.part] = now + 30
				end
			end
		end

		if v12 then
			return v12.part, v12.pos, v12.dist
		end
		return nil, nil, nil
	end

	local function fn28(arg)
		if v10 and tbl[v10] and not tbl7[v10] then
			local magnitude = (v10.Position - arg).Magnitude
			if magnitude <= n2 and not fn11(v10.Position, 2) then
				return v10, v10.Position, magnitude
			end
			tbl7[v10] = tick() + 4
		end

		v10 = nil
		local v11, v12, v13 = fn27(arg)
		v10 = v11
		return v11, v12, v13
	end

	local function fn29()
		if connection then
			return
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return
		end
		v = character
		v2 = humanoid
		v3 = humanoidRootPart
		v10 = nil
		position = nil
		n8 = nil
		size = nil
		flag3 = _G.CollectCoinsUnderground
		flag2 = false
		v9 = nil
		table.clear(tbl8)
		table.clear(tbl9)
		table.clear(tbl10)
		table.clear(tbl11)

		if connection5 then
			connection5:Disconnect()
		end

		connection5 = workspace.DescendantAdded:Connect(fn8)
		fn9(true)
		local n10 = 0

		connection = RunService.Heartbeat:Connect(function(deltaTime)
			n10 += deltaTime
			if n10 < n then
				return
			end
			n10 = 0
			if not _G.InRound or not character.Parent or not humanoidRootPart.Parent or not humanoid.Parent or humanoid.Health <= 0 then
				fn26(false)
				return
			end
			fn9(false)
			local flag4 = humanoid.Health < (_G.__FarmLastHealth or humanoid.Health) - 0.01
			_G.__FarmLastHealth = humanoid.Health
			local flag5 = false

			pcall(function()
				local swimming = Enum.HumanoidStateType.Swimming
				flag5 = humanoid:GetState() == swimming
			end)

			if flag4 or flag5 then
				pcall(_G.__FarmAddDanger, humanoidRootPart.Position)

				if v10 then
					pcall(_G.__FarmAddDanger, v10.Position)
					tbl7[v10] = tick() + 120
					v10 = nil
				end

				fn17()
				fn21(character, true)
				humanoid.PlatformStand = true
				fn22(humanoidRootPart)
				alignPosition.MaxVelocity = math.max(_G.AutoFarmSpeed, 24)
				alignPosition.Position = fn18(character, humanoidRootPart, humanoid, nil)
				return
			end

			if not n8 then
				fn13(character, humanoidRootPart)
			end

			if flag3 ~= _G.CollectCoinsUnderground then
				flag3 = _G.CollectCoinsUnderground
				v10 = nil

				if not _G.CollectCoinsUnderground then
					fn17()
					fn21(character, true)
					humanoid.PlatformStand = true
					fn22(humanoidRootPart)
					v9 = fn18(character, humanoidRootPart, humanoid, nil)
					flag2 = true
				else
					flag2 = false
					v9 = nil
				end
			end

			if flag2 and v9 then
				alignPosition.MaxVelocity = math.max(_G.AutoFarmSpeed, 22)
				alignPosition.Position = v9

				if (humanoidRootPart.Position - v9).Magnitude <= 1.35 then
					flag2 = false
					v9 = nil
				end

				return
			end

			if _G.BagFull then
				if _G.ResetCharacterOnBagFull then
					fn17()
					humanoid.PlatformStand = false
					return
				end

				if not flag then
					fn17()
					fn21(character, true)
					humanoid.PlatformStand = true
					fn22(humanoidRootPart)
					v8 = fn18(character, humanoidRootPart, humanoid, v10 and v10.Parent and v10.Position or nil)
					flag = true
				end

				if v8 then
					alignPosition.MaxVelocity = math.max(_G.AutoFarmSpeed, 22)
					alignPosition.Position = v8
					local vector = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)

					if vector.Magnitude < 0.1 then
						vector = Vector3.new(0, 0, -1)
					end

					local unit = vector.Unit
					alignOrientation.CFrame = CFrame.new(Vector3.new(), unit)

					if (humanoidRootPart.Position - v8).Magnitude <= 1.35 then
						fn26(false)
					end
				end

				return
			end

			local v11, v12 = fn28(humanoidRootPart.Position)

			if v11 then
				position = nil
			end

			if not v11 then
				if _G.CollectCoinsUnderground and size then
					fn21(character, true)
					humanoid.PlatformStand = true
					fn22(humanoidRootPart)

					if not position then
						position = humanoidRootPart.Position
					end

					alignPosition.Position = position
					local v13 = fn25
					local v14 = v7
					local n11

					if v7 then
						n11 = v14
					else
						local y = humanoidRootPart.Position.Y
						local v15 = n8
						local n12

						if n8 then
							n12 = v15
						else
							n12 = 3
						end

						n11 = y + n12 + n6
					end

					v13(humanoidRootPart, n11)
					return
				end

				if alignPosition then
					fn23()
				end

				fn17()
				pcall(fn21, character, false)
				fn24(humanoid)
				humanoid.PlatformStand = false
				return
			end

			if hipHeight == nil then
				hipHeight = humanoid.HipHeight
			end

			humanoid.PlatformStand = true
			fn21(character, true)
			fn22(humanoidRootPart)

			if _G.CollectCoinsUnderground then
				fn16(humanoidRootPart)
			else
				fn17()
			end

			alignPosition.MaxVelocity = _G.AutoFarmSpeed
			local v13 = fn15(v12)
			fn25(humanoidRootPart, v12.Y)
			local magnitude = (Vector2.new(humanoidRootPart.Position.X, humanoidRootPart.Position.Z) - Vector2.new(v12.X, v12.Z)).Magnitude
			local position2 = v13 - Vector3.new(0, _G.CollectCoinsUnderground and n7 * math.clamp(magnitude / 6, 0, 1) or 0, 0)
			local magnitude2 = (humanoidRootPart.Position - v13).Magnitude
			alignPosition.Position = position2
			local vector = Vector3.new(v12.X - humanoidRootPart.Position.X, 0, v12.Z - humanoidRootPart.Position.Z)
			local vector2 = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)

			if vector.Magnitude > 0.5 then
				vector2 = vector.Unit
			end

			if vector2.Magnitude < 0.1 then
				vector2 = Vector3.new(0, 0, -1)
			end

			local unit = vector2.Unit
			alignOrientation.CFrame = CFrame.new(Vector3.new(), unit)

			if magnitude2 <= n3 and magnitude <= n3 then
				local now = tick()

				if not tbl8[v11] then
					tbl8[v11] = now
				end

				local flag6 = firetouchinterest

				if flag6 then
					flag6 = now - (tbl9[v11] or 0) >= 0.08
				end

				if flag6 then
					tbl9[v11] = now

					pcall(function()
						firetouchinterest(humanoidRootPart, v11, 0)
						firetouchinterest(humanoidRootPart, v11, 1)
					end)
				end

				local visualPart = tbl[v11]
				visualPart = visualPart and visualPart.visualPart

				if not v11.CanTouch or not visualPart or not visualPart.Parent or visualPart.Transparency >= 0.5 then
					fn3(v11, tbl[v11])
					tbl8[v11] = nil
					tbl9[v11] = nil
					tbl10[v11] = nil
					tbl11[v11] = nil
					v10 = nil
				elseif n4 <= now - tbl8[v11] then
					tbl7[v11] = now + 0.8
					tbl8[v11] = nil
					tbl9[v11] = nil
					tbl10[v11] = nil
					tbl11[v11] = nil
					v10 = nil
				end

				return
			end

			tbl8[v11] = nil
			tbl9[v11] = nil

			if not tbl10[v11] or magnitude2 < tbl10[v11] - 0.5 then
				tbl10[v11] = magnitude2
				tbl11[v11] = tick()
			elseif tick() - (tbl11[v11] or tick()) >= n5 then
				tbl7[v11] = tick() + 2
				tbl10[v11] = nil
				tbl11[v11] = nil
				v10 = nil
			end
		end)
	end

	_G.FlingMurdererAfterBagFullEnabled = false
	_G.ShootMurdererAfterBagFullEnabled = false
	_G.KillAllAfterBagFullEnabled = false
	_G.ResetCharacterOnBagFull = false
	local flag4 = false
	local n10 = 0

	table.insert(_G.CoinESPConn, RunService.Heartbeat:Connect(function(deltaTime)
		n10 += deltaTime
		if n10 < 0.1 then
			return
		end
		n10 = 0
		local flag5 = _G.BagFull and _G.ResetCharacterOnBagFull and _G.InRound and not _G.FlingMurdererAfterBagFullEnabled and not _G.ShootMurdererAfterBagFullEnabled and not _G.KillAllAfterBagFullEnabled

		if flag5 and not flag4 then
			local character = localPlayer.Character
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")

			if character and humanoid and humanoid.Health > 0 then
				pcall(function()
					humanoid.PlatformStand = false
				end)

				pcall(function()
					humanoid.Health = 0
				end)

				if humanoid.Health > 0 then
					pcall(function()
						character:BreakJoints()
					end)
				end
			end
		end

		flag4 = flag5
	end))

	_G.ResetCharacterSetEnabled = function(resetCharacterOnBagFull)
		_G.ResetCharacterOnBagFull = resetCharacterOnBagFull
	end

	_G.FlingMurdererAfterBagFullSetEnabled = function(arg)
		_G.FlingMurdererAfterBagFullEnabled = arg and true or false
	end

	_G.ShootMurdererAfterBagFullSetEnabled = function(arg)
		_G.ShootMurdererAfterBagFullEnabled = arg and true or false
	end

	_G.KillAllAfterBagFullSetEnabled = function(arg)
		_G.KillAllAfterBagFullEnabled = arg and true or false
	end

	_G.AutoFarmSetEnabled = function(autoFarmEnabled)
		_G.AutoFarmEnabled = autoFarmEnabled

		if autoFarmEnabled then
			if _G.InRound then
				fn29()
			else
				fn26()
			end
		else
			fn26()
		end
	end

	_G.AutoFarmSetSpeed = function(arg)
		_G.AutoFarmSpeed = math.clamp(math.floor(arg + 0.5), 15, 25)
	end

	_G.CollectCoinsUndergroundSetEnabled = function(arg)
		_G.CollectCoinsUnderground = arg and true or false
	end

	_G.__SetReflectToggleOff = function(arg)
		v4 = arg
	end

	local function fn30(character)
		hipHeight = nil
		n8 = nil
		size = nil
		local humanoid = character:WaitForChild("Humanoid")

		humanoid.Died:Connect(function()
			if _G.AutoFarmEnabled then
				local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					pcall(_G.__FarmAddDanger, humanoidRootPart.Position)
				end

				if v10 then
					pcall(_G.__FarmAddDanger, v10.Position)
					tbl7[v10] = tick() + 120
				end
			end

			fn26(false)
		end)

		task.defer(function()
			task.wait(0.35)

			if _G.AutoFarmEnabled and _G.InRound and humanoid.Parent and humanoid.Health > 0 then
				fn29()
			end
		end)
	end

	if localPlayer.Character then
		fn30(localPlayer.Character)
	end

	_G.AutoFarmCharConn = localPlayer.CharacterAdded:Connect(fn30)

	table.insert(_G.CoinESPConn, gameplay.RoundStart.OnClientEvent:Connect(function()
		task.wait(0.35)

		if _G.AutoFarmEnabled then
			fn29()
		end
	end))

	table.insert(_G.CoinESPConn, gameplay.GameOver.OnClientEvent:Connect(function()
		fn26(false)
	end))
end

local flag
flag = false
local fn7

fn7 = function()
	for _, player in ipairs(Players:GetPlayers()) do
		local v5 = CurrentRoundClient.PlayerData[player.Name]
		local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
		if v5 and v5.Role == "Murderer" and not v5.Dead and humanoid and humanoid.Health > 0 then
			return player
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character
		local backpack = player:FindFirstChild("Backpack")
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if player ~= localPlayer and humanoid and humanoid.Health > 0 and (character and character:FindFirstChild("Knife") or backpack and backpack:FindFirstChild("Knife")) then
			return player
		end
	end

	return nil
end

local fn8

fn8 = function()
	local character = localPlayer.Character
	local backpack = localPlayer:FindFirstChild("Backpack")
	character = character and character:FindFirstChild("Gun")
	if character and character:IsA("Tool") then
		return character, false
	end
	backpack = backpack and backpack:FindFirstChild("Gun")
	if backpack and backpack:IsA("Tool") then
		return backpack, true
	end
	return nil, false
end

local fn9, fn10

do
	local function fn11(arg)
		local shoot = arg and arg:FindFirstChild("Shoot")
		if shoot and shoot:IsA("RemoteEvent") then
			return shoot, "ModernShootEvent"
		end
		local knifeLocal = arg and arg:FindFirstChild("KnifeLocal")
		knifeLocal = knifeLocal and knifeLocal:FindFirstChild("CreateBeam")
		knifeLocal = knifeLocal and knifeLocal:FindFirstChild("RemoteFunction")
		if knifeLocal and knifeLocal:IsA("RemoteFunction") then
			return knifeLocal, "BeamFunction"
		end
		local knifeServer = arg and arg:FindFirstChild("KnifeServer")
		knifeServer = knifeServer and knifeServer:FindFirstChild("ShootGun")
		if knifeServer and knifeServer:IsA("RemoteFunction") then
			return knifeServer, "ShootFunction"
		end

		if knifeServer and knifeServer:IsA("RemoteEvent") then
			return knifeServer, "ShootEvent"
		end

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant.Name == "ShootGun" and descendant:IsA("RemoteFunction") then
				return descendant, "ShootFunction"
			end

			if descendant.Name == "ShootGun" and descendant:IsA("RemoteEvent") then
				return descendant, "ShootEvent"
			end
		end

		return nil, nil
	end

	local function fn12(arg, arg2, arg3, arg4)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { arg4 }
		raycastParams.IgnoreWater = true
		local hit = workspace:Raycast(arg, arg3 - arg, raycastParams)
		return not hit or hit.Instance:IsDescendantOf(arg2)
	end

	_G.__InnocentInLine = function(arg, arg2, arg3, arg4)
		local filterDescendantsInstances = {}

		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")

			if character and character ~= arg2 and character ~= arg4 and humanoid and humanoid.Health > 0 then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = character
			end
		end

		if #filterDescendantsInstances == 0 then
			return false
		end
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Include
		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		return workspace:Spherecast(arg, 0.8, arg3 - arg, raycastParams) ~= nil
	end

	_G.__ClearGunShot = function(arg, arg2, arg3, arg4)
		return fn12(arg, arg2, arg3, arg4) and not _G.__InnocentInLine(arg, arg2, arg3, arg4)
	end

	fn9 = function(arg, arg2, arg3)
		if not arg or not arg2 then
			return nil, nil
		end

		for _, v5 in ipairs({ "UpperTorso", "Torso", "HumanoidRootPart", "Head" }) do
			local v6 = arg2:FindFirstChild(v5)

			if v6 and v6:IsA("BasePart") then
				local position = v6.Position
				if fn12(arg, arg2, position, arg3) then
					return v6, position
				end
			end
		end

		return nil, nil
	end

	local function fn13(arg)
		arg = arg and arg.AssemblyLinearVelocity or Vector3.zero

		if arg.Magnitude > 72 then
			arg = arg.Unit * 72
		end

		if math.abs(arg.Y) < 1.5 then
			arg = Vector3.new(arg.X, 0, arg.Z)
		end

		return arg
	end

	fn10 = function(arg, arg2, arg3, arg4, arg5)
		local n2 = math.clamp((arg4 - arg).Magnitude / 145, 0.035, 0.26)
		local v5 = fn13(arg3)
		local n3 = arg4 + Vector3.new(v5.X * n2, v5.Y * math.min(n2, 0.2), v5.Z * n2)
		if fn12(arg, arg2, n3, arg5) then
			return n3
		end
		return arg4
	end

	_G.AimPredictionEnabled = true
	_G.AimPredictionStrength = 1
	_G.AimWallResolveEnabled = true

	local tbl4 = {
		"UpperTorso",
		"Head",
		"HumanoidRootPart",
		"Torso",
		"LowerTorso",
		"RightUpperArm",
		"LeftUpperArm",
		"RightHand",
		"LeftHand",
		"RightUpperLeg",
		"LeftUpperLeg",
		"RightLowerLeg",
		"LeftLowerLeg",
	}

	local obj = setmetatable({}, { __mode = "k" })

	table.insert(_G.CoinESPConn, RunService.Heartbeat:Connect(function()
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
					local v5 = obj[humanoidRootPart]

					if v5 then
						v5.v = v5.v:Lerp(assemblyLinearVelocity, 0.35)
					else
						obj[humanoidRootPart] = { v = assemblyLinearVelocity }
					end
				end
			end
		end
	end))

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.IgnoreWater = true

	local function fn14()
		local filterDescendantsInstances = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = player.Character
			end
		end

		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
	end

	local function predictionLeadFor(arg)
		if not _G.AimPredictionEnabled or not arg then
			return Vector3.zero
		end
		local v5 = obj[arg]
		v5 = v5 and v5.v or arg.AssemblyLinearVelocity
		if v5.Magnitude < 3 then
			return Vector3.zero
		end
		local n2 = 0.09

		pcall(function()
			n2 = math.clamp(localPlayer:GetNetworkPing() or 0.09, 0, 0.4)
		end)

		local n3 = math.clamp((n2 * 2 + 0.05) * (_G.AimPredictionStrength or 1), 0.02, 0.5)
		local n4 = Vector3.new(v5.X, 0, v5.Z) * n3

		if n4.Magnitude > 14 then
			n4 = n4.Unit * 14
		end

		local n5 = 0

		if math.abs(v5.Y) > 3 then
			n5 = v5.Y * n3 - 0.5 * workspace.Gravity * n3 * n3
		end

		local n6 = math.clamp(n5, -7, 7)
		fn14()
		local position = arg.Position

		if n4.Magnitude > 0.2 then
			local hit = workspace:Raycast(position, n4, raycastParams)

			if hit then
				n4 = n4.Unit * math.max((hit.Position - position).Magnitude - 1, 0)
			end
		end

		if n6 < 0 then
			local hit = workspace:Raycast(position + n4, Vector3.new(0, n6 - 3.5, 0), raycastParams)

			if hit then
				n6 = math.max(n6, math.min(hit.Position.Y + 3 - position.Y, 0))
			end
		end

		return Vector3.new(n4.X, n6, n4.Z)
	end

	_G.__PredictionLeadFor = predictionLeadFor

	_G.__ResolveVisibleAim = function(arg, arg2, arg3, arg4)
		if not arg or not arg2 then
			return nil, nil, false
		end
		local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart") or arg:FindFirstChild("Torso")
		local vector = arg4 ~= false and predictionLeadFor(humanoidRootPart, arg2) or Vector3.zero
		local flag2 = vector.Magnitude > 0.05
		local n2 = nil

		for _, v5 in ipairs(tbl4) do
			local v6 = arg:FindFirstChild(v5)

			if v6 and v6:IsA("BasePart") then
				local rightVector = v6.CFrame.RightVector
				local upVector = v6.CFrame.UpVector

				for _, v7 in ipairs({
					Vector3.zero,
					upVector * v6.Size.Y * 0.3,
					upVector * -v6.Size.Y * 0.3,
					rightVector * v6.Size.X * 0.32,
					rightVector * -v6.Size.X * 0.32,
				}) do
					local n3 = v6.Position + v7
					n2 = n2 or n3 + vector
					local tbl5 = flag2 and { n3 + vector, n3 } or { n3 }

					for _, v8 in ipairs(tbl5) do
						if fn12(arg2, arg, v8, arg3) then
							flag2 = flag2 and v8 ~= n3
							return v8, v6, flag2
						end
					end
				end
			end
		end

		return n2, nil, flag2
	end

	local function fn15(arg, arg2, arg3, arg4, arg5)
		if arg2 == "ModernShootEvent" then
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			local gunRaycastAttachment = character and (character:FindFirstChild("GunRaycastAttachment") or character:WaitForChild("GunRaycastAttachment", 0.8))
			arg4 = arg4 and arg4:FindFirstChild("Handle")
			local worldCFrame

			if arg5 then
				worldCFrame = arg5
			else
				worldCFrame = gunRaycastAttachment and gunRaycastAttachment.WorldCFrame or arg4 and arg4.CFrame or character and character.CFrame
			end

			if not worldCFrame then
				return false
			end
			local cframe = worldCFrame

			if (arg3 - worldCFrame.Position).Magnitude > 0.05 then
				cframe = CFrame.lookAt(worldCFrame.Position, arg3)
			end

			return pcall(function()
				arg:FireServer(cframe, CFrame.new(arg3))
			end)
		end

		if arg2 == "BeamFunction" then
			return pcall(function()
				arg:InvokeServer(1, arg3, "AH2")
			end)
		end

		if arg2 == "ShootFunction" then
			return pcall(function()
				arg:InvokeServer(0, arg3, "AH")
			end)
		end

		if arg2 == "ShootEvent" then
			return pcall(function()
				arg:FireServer(arg3)
			end)
		end
		return false
	end

	local function fn16(arg, arg2)
		local currentCamera = workspace.CurrentCamera
		local cFrame = currentCamera and currentCamera.CFrame
		local tbl5 = {}
		local clone = nil
		local archivable = arg.Archivable
		arg.Archivable = true

		pcall(function()
			clone = arg:Clone()
		end)

		arg.Archivable = archivable

		if clone then
			clone.Name = "MarbegShotDecoy"

			for _, descendant in ipairs(clone:GetDescendants()) do
				if descendant:IsA("LocalScript") or descendant:IsA("Script") or descendant:IsA("ModuleScript") or descendant:IsA("Tool") then
					descendant:Destroy()
				elseif descendant:IsA("BasePart") then
					descendant.Anchored = true
					descendant.CanCollide = false
					descendant.CanTouch = false
					descendant.CanQuery = false
					descendant.LocalTransparencyModifier = 0
				end
			end

			clone.Parent = currentCamera or workspace
			clone:PivotTo(arg2)
		end

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") then
				tbl5[descendant] = descendant.LocalTransparencyModifier
				descendant.LocalTransparencyModifier = 1
			end
		end

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegQuickShotCameraLock")
		end)

		if currentCamera and cFrame then
			RunService:BindToRenderStep("MarbegQuickShotCameraLock", Enum.RenderPriority.Camera.Value + 10, function()
				if workspace.CurrentCamera then
					workspace.CurrentCamera.CFrame = cFrame
				end
			end)
		end

		return function()
			pcall(function()
				RunService:UnbindFromRenderStep("MarbegQuickShotCameraLock")
			end)

			for k, v5 in pairs(tbl5) do
				if k.Parent then
					pcall(function()
						k.LocalTransparencyModifier = v5
					end)
				end
			end

			if clone then
				pcall(function()
					clone:Destroy()
				end)
			end

			if currentCamera and cFrame then
				pcall(function()
					currentCamera.CFrame = cFrame
				end)
			end
		end
	end

	_G.ShootMurderer = function()
		if flag or not _G.InRound then
			return false
		end
		local v5 = fn7()
		local character = v5 and v5.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local character2 = localPlayer.Character
		local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
		local humanoid = character2 and character2:FindFirstChildWhichIsA("Humanoid")
		local v6, v7 = fn8()
		if not humanoidRootPart or not humanoidRootPart2 or not humanoid or humanoid.Health <= 0 or not v6 then
			return false
		end
		flag = true

		if v7 then
			humanoid:EquipTool(v6)
			task.wait(0.12)
		end

		if v6.Parent ~= character2 then
			flag = false
			return false
		end
		local v8, v9 = fn11(v6)
		if not v8 then
			flag = false
			return false
		end

		local function fn17()
			local gunRaycastAttachment = humanoidRootPart2:FindFirstChild("GunRaycastAttachment")
			if gunRaycastAttachment then
				return gunRaycastAttachment.WorldPosition
			end
			local handle = v6:FindFirstChild("Handle")
			return handle and handle.Position or humanoidRootPart2.Position
		end

		local function fn18(arg)
			local tbl5 = {}
			local v10 = fn17()
			local predictionLeadFor2 = _G.__PredictionLeadFor and _G.__PredictionLeadFor(humanoidRootPart, v10) or Vector3.zero
			local flag2 = predictionLeadFor2.Magnitude > 0.05

			for _, v11 in ipairs({
				"UpperTorso",
				"Head",
				"HumanoidRootPart",
				"Torso",
				"LowerTorso",
				"RightUpperArm",
				"LeftUpperArm",
				"RightHand",
				"LeftHand",
				"RightUpperLeg",
				"LeftUpperLeg",
			}) do
				local v12 = character:FindFirstChild(v11)

				if v12 and v12:IsA("BasePart") then
					local rightVector = v12.CFrame.RightVector
					local v13 = ipairs
					local tbl6 = {}
					local vector = Vector3.new(0, v12.Size.Y * 0.3, 0)
					local n2 = rightVector * v12.Size.X * 0.3
					local n3 = rightVector * -v12.Size.X * 0.3
					tbl6[1] = Vector3.zero
					tbl6[2] = vector
					tbl6[3] = n2
					tbl6[4] = n3

					for _, v14 in v13(tbl6) do
						local n4 = v12.Position + v14
						local tbl7 = flag2 and { n4 + predictionLeadFor2, n4 } or { n4 }
						local exitTo = nil

						for _, v15 in ipairs(tbl7) do
							if _G.__ClearGunShot(v10, character, v15, character2) then
								exitTo = 1
								break
							end
						end

						if exitTo == 1 then
							tbl5[#tbl5 + 1] = t11
							if (arg or 5) <= #tbl5 then
								return tbl5
							end
						end
					end
				end
			end

			return tbl5
		end

		local flag2

		if #fn18(1) > 0 then
			flag2 = false

			for i = 1, 3 do
				local v10 = fn18(5)
				if #v10 == 0 then
					break
				end
				flag2 = fn15(v8, v9, v10[(i - 1) % #v10 + 1], v6) or flag2
				task.wait(0.2)
				local humanoid2 = character:FindFirstChildWhichIsA("Humanoid")
				local v11 = CurrentRoundClient.PlayerData[v5.Name]

				if humanoid2 and humanoid2.Health <= 0 or v11 and v11.Dead then
					flag = false
					_G.ShootMurdererStatus = "Murderer down (" .. i .. " shot)"
					return true
				end
			end
		else
			local flag3 = false

			for _, v10 in ipairs({ "UpperTorso", "Head", "HumanoidRootPart", "Torso" }) do
				local v11 = character:FindFirstChild(v10)
				local v12

				if v11 then
					local position = v11.Position
					v12 = fn12(fn17(), character, position, character2)
				else
					v12 = v11
				end

				if v12 then
					flag3 = true
					break
				end
			end

			_G.ShootMurdererStatus = flag3 and "Innocent in the way, holding fire" or "Murderer is behind a wall"
			flag2 = false
		end

		flag = false

		if flag2 then
			_G.ShootMurdererStatus = "Shot fired"
		end

		return flag2
	end

	_G.ShootMurdererRage = function()
		if flag or not _G.InRound then
			return false
		end
		local v5 = fn7()
		local character = v5 and v5.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		local character2 = localPlayer.Character
		local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
		local humanoid = character2 and character2:FindFirstChildWhichIsA("Humanoid")
		local v6, v7 = fn8()
		if not humanoidRootPart or not humanoidRootPart2 or not humanoid or humanoid.Health <= 0 or not v6 then
			_G.ShootMurdererRageStatus = "Gun or murderer unavailable"
			return false
		end
		flag = true

		if v7 then
			humanoid:EquipTool(v6)
			task.wait(0.12)
		end

		if v6.Parent ~= character2 then
			flag = false
			return false
		end
		local v8, v9 = fn11(v6)
		if not v8 then
			flag = false
			return false
		end

		local function fn17()
			local gunRaycastAttachment = humanoidRootPart2:FindFirstChild("GunRaycastAttachment")
			if gunRaycastAttachment then
				return gunRaycastAttachment.WorldPosition
			end
			local handle = v6:FindFirstChild("Handle")
			return handle and handle.Position or humanoidRootPart2.Position
		end

		local tbl5 = {
			"UpperTorso",
			"HumanoidRootPart",
			"Torso",
			"Head",
			"LowerTorso",
			"RightUpperArm",
			"LeftUpperArm",
			"RightUpperLeg",
			"LeftUpperLeg",
		}

		local function fn18()
			if _G.__PredictionLeadFor then
				return _G.__PredictionLeadFor(humanoidRootPart, fn17())
			end
			local n2 = 0.08

			pcall(function()
				n2 = math.clamp(localPlayer:GetNetworkPing() or 0.08, 0, 0.35)
			end)

			local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
			local vector = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z)
			if vector.Magnitude < 6 then
				return Vector3.zero
			end
			local n3 = vector * n2 * 2

			if n3.Magnitude > 2.5 then
				n3 = n3.Unit * 2.5
			end

			return n3
		end

		local function fn19(arg, arg2)
			local tbl6 = {}
			local v10 = fn18()
			local flag2 = v10.Magnitude > 0.01

			for _, v11 in ipairs(tbl5) do
				local v12 = character:FindFirstChild(v11)

				if v12 and v12:IsA("BasePart") then
					local rightVector = v12.CFrame.RightVector
					local v13 = ipairs
					local tbl7 = {}
					local vector = Vector3.new(0, v12.Size.Y * 0.32, 0)
					local vector2 = Vector3.new(0, -v12.Size.Y * 0.32, 0)
					local n2 = rightVector * v12.Size.X * 0.32
					local n3 = rightVector * -v12.Size.X * 0.32
					tbl7[1] = Vector3.zero
					tbl7[2] = vector
					tbl7[3] = vector2
					tbl7[4] = n2
					tbl7[5] = n3

					for _, v14 in v13(tbl7) do
						local n4 = v12.Position + v14
						local tbl8 = flag2 and { n4 + v10, n4 } or { n4 }
						local exitTo = nil

						for _, v15 in ipairs(tbl8) do
							if _G.__ClearGunShot(arg, character, v15, character2) then
								exitTo = 1
								break
							end
						end

						if exitTo == 1 then
							tbl6[#tbl6 + 1] = t16_1
							if (arg2 or 6) <= #tbl6 then
								return tbl6
							end
						end
					end
				end
			end

			return tbl6
		end

		local function fn20(arg)
			return fn19(arg, 1)[1]
		end

		local function fn21(arg)
			local n2 = arg or 4

			for i = 1, n2 do
				pcall(function()
					humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
					humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
				end)

				RunService.Heartbeat:Wait()
			end
		end

		local function fn22()
			local humanoid2 = character:FindFirstChildWhichIsA("Humanoid")
			if humanoid2 and humanoid2.Health <= 0 then
				return true
			end
			local v10 = CurrentRoundClient.PlayerData[v5.Name]
			return v10 and v10.Dead and true or false
		end

		if #fn19(fn17(), 1) > 0 then
			local flag2 = false

			for i = 1, 4 do
				fn21(2)
				local v10 = fn19(fn17(), 6)
				if #v10 == 0 then
					break
				end
				flag2 = fn15(v8, v9, v10[(i - 1) % #v10 + 1], v6) or flag2
				task.wait(0.22)

				if fn22() then
					flag = false
					_G.ShootMurdererRageStatus = "Murderer down (" .. i .. " shot)"
					return true
				end
			end

			flag = false
			_G.ShootMurdererRageStatus = flag2 and "Shot fired, no confirm" or "Shot failed"
			return flag2
		end

		local pivot = character2:GetPivot()
		local enabled = alignPosition and alignPosition.Parent and alignPosition.Enabled
		local flag2 = _G.AntiFlingEnabled == true

		if alignPosition and alignPosition.Parent then
			alignPosition.Enabled = false
		end

		if flag2 and _G.AntiFlingSetEnabled then
			_G.AntiFlingSetEnabled(false)
		end

		local v10 = fn16(character2, pivot)
		local flag3 = false
		local v11 = nil

		pcall(function()
			local function fn23(arg)
				for _, v12 in ipairs({ "UpperTorso", "HumanoidRootPart", "Head" }) do
					local v13 = character:FindFirstChild(v12)
					if v13 and v13:IsA("BasePart") and _G.__ClearGunShot(arg, character, v13.Position, character2) then
						return v13.Position
					end
				end

				return nil
			end

			local tbl6 = {}

			for _, v12 in ipairs({ 5, 7.5, 10 }) do
				for _, v13 in ipairs({ 1.5, 4, -1 }) do
					for i = 0, 11 do
						local v14 = math.rad(i * 30)
						local n2 = humanoidRootPart.Position + Vector3.new(math.cos(v14) * v12, v13, math.sin(v14) * v12)
						local v15 = fn23(n2)

						if v15 then
							tbl6[#tbl6 + 1] = { position = n2, aim = v15, cost = (n2 - pivot.Position).Magnitude }
						end
					end
				end
			end

			table.sort(tbl6, function(arg, arg2)
				return arg.cost < arg2.cost
			end)

			local n2 = os.clock() + 1.1

			for i = 1, math.min(#tbl6, 3) do
				if not (flag3 or os.clock() > n2) then
					local v12 = tbl6[i]
					character2:PivotTo(CFrame.lookAt(v12.position, v12.aim))
					fn21(3)
					local aim = fn20(fn17()) or v12.aim
					v11 = aim
					flag3 = fn15(v8, v9, aim, v6) or flag3
					task.wait(0.16)

					if fn22() then
						flag3 = true
						break
					else
						continue
					end
				end

				break
			end
		end)

		pcall(function()
			character2:PivotTo(pivot)
		end)

		pcall(function()
			humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
		end)

		if v10 then
			pcall(v10)
		end

		if flag3 and v11 and _G.DrawBulletTracer then
			pcall(_G.DrawBulletTracer, humanoidRootPart2.Position + Vector3.new(0, 1.2, 0), v11, true)
		end

		if alignPosition and alignPosition.Parent then
			alignPosition.Enabled = enabled == true
			alignPosition.Position = humanoidRootPart2.Position
		end

		if flag2 and _G.AntiFlingSetEnabled then
			_G.AntiFlingSetEnabled(true)
		end

		flag = false
		_G.ShootMurdererRageStatus = flag3 and "Wall shot fired" or "Rage shot failed"
		return flag3
	end
end

_G.AutoGrabGunEnabled = true
_G.AutoGrabGunStatus = "Waiting for dropped gun"

do
	local flag2 = false

	local function fn11(arg)
		if not arg or not arg.Parent then
			return nil
		end

		if arg:IsA("BasePart") then
			return arg
		end
		return arg:FindFirstChild("Handle") or arg:FindFirstChildWhichIsA("BasePart", true)
	end

	local function fn12()
		if not _G.InRound or not _G.__RealInRound then
			return false, "Out of round"
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if not character or not humanoid or humanoid.Health <= 0 then
			return false, "Player dead"
		end
		local v5 = CurrentRoundClient.PlayerData[localPlayer.Name]
		if not v5 or not v5.Role or v5.Dead then
			return false, "No active role"
		end

		if v5.Role == "Murderer" then
			return false, "Disabled for Murderer"
		end

		if v5.Role == "Lobby" then
			return false, "Out of round"
		end
		return true
	end

	local function fn13(arg, arg2)
		if type(firetouchinterest) ~= "function" then
			return false
		end
		local tbl4 = {}

		for _, v5 in ipairs({ "HumanoidRootPart", "UpperTorso", "Torso", "Head" }) do
			local v6 = arg:FindFirstChild(v5)

			if v6 and v6:IsA("BasePart") then
				table.insert(tbl4, v6)
			end
		end

		local tbl5 = { arg2 }

		for _, descendant in ipairs(arg2.Parent:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant ~= arg2 then
				table.insert(tbl5, descendant)
			end

			if not (#tbl5 >= 6) then
				continue
			end
			break
		end

		local flag3 = false

		for _, v5 in ipairs(tbl4) do
			for _, v6 in ipairs(tbl5) do
				local ok = pcall(function()
					firetouchinterest(v5, v6, 0)
					task.wait()
					firetouchinterest(v5, v6, 1)
				end)

				flag3 = flag3 or ok
			end
		end

		return flag3
	end

	local function fn14()
		local v5 = flag2
		local flag3

		if flag2 then
			flag3 = v5
		else
			flag3 = not _G.AutoGrabGunEnabled
		end

		if flag3 then
			return false
		end
		local v6, v7 = fn12()
		if not v6 then
			_G.AutoGrabGunStatus = v7
			return false
		end

		if fn8() then
			_G.AutoGrabGunStatus = "Gun already owned"
			return false
		end
		local v8 = fn6()
		local v9 = fn11(v8)
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if not v8 or not v9 or not character or not humanoid or humanoid.Health <= 0 then
			_G.AutoGrabGunStatus = "Waiting for dropped gun"
			return false
		end
		flag2 = true
		_G.AutoGrabGunStatus = "Grabbing gun"
		local flag4 = false

		for i = 1, 3 do
			flag4 = fn13(character, v9) or flag4
			task.wait(0.04)
			if not fn8() then
				continue
			end
			break
		end

		local flag5 = fn8() ~= nil
		_G.AutoGrabGunStatus = flag5 and "Gun collected without teleport" or flag4 and "No-teleport pickup retrying" or "firetouchinterest unavailable"
		flag2 = false
		return flag5
	end

	_G.AutoGrabGunSetEnabled = function(arg)
		_G.AutoGrabGunEnabled = arg and true or false
		_G.AutoGrabGunStatus = _G.AutoGrabGunEnabled and "Waiting for dropped gun" or "Disabled"
	end

	local autoGrabGunLoopId = {}
	_G.__AutoGrabGunLoopId = autoGrabGunLoopId

	task.spawn(function()
		while _G.__AutoGrabGunLoopId == autoGrabGunLoopId do
			task.wait(0.08)

			if _G.AutoGrabGunEnabled and not flag2 then
				pcall(fn14)
			end
		end
	end)
end

_G.PlayerWalkSpeed = 16
_G.PlayerJumpPower = 50
_G.PlayerFlyEnabled = false
_G.PlayerFlySpeed = 50

do
	local function fn11()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildWhichIsA("Humanoid")

		if humanoidRootPart then
			local marbegPlayerFlyVelocity = humanoidRootPart:FindFirstChild("MarbegPlayerFlyVelocity")
			local marbegPlayerFlyGyro = humanoidRootPart:FindFirstChild("MarbegPlayerFlyGyro")

			if marbegPlayerFlyVelocity then
				marbegPlayerFlyVelocity:Destroy()
			end

			if marbegPlayerFlyGyro then
				marbegPlayerFlyGyro:Destroy()
			end
		end

		if character then
			character.PlatformStand = false
			character.AutoRotate = true
		end
	end

	_G.PlayerWalkSpeedSet = function(arg)
		_G.PlayerWalkSpeed = math.clamp(tonumber(arg) or 16, 16, 80)
	end

	_G.PlayerJumpPowerSet = function(arg)
		_G.PlayerJumpPower = math.clamp(tonumber(arg) or 50, 50, 200)
	end

	_G.PlayerFlySpeedSet = function(arg)
		_G.PlayerFlySpeed = math.clamp(tonumber(arg) or 50, 10, 200)
	end

	_G.PlayerFlySetEnabled = function(arg)
		_G.PlayerFlyEnabled = arg and true or false

		if not _G.PlayerFlyEnabled then
			fn11()
		end
	end

	_G.NoclipEnabled = false
	local tbl4 = {}
	local v5 = nil

	local function fn12()
		for k, v6 in pairs(tbl4) do
			if k.Parent then
				pcall(function()
					k.CanCollide = v6
				end)
			end
		end

		table.clear(tbl4)
		v5 = nil
	end

	_G.NoclipSetEnabled = function(arg)
		_G.NoclipEnabled = arg and true or false

		if not _G.NoclipEnabled then
			fn12()
		end
	end

	table.insert(_G.CoinESPConn, RunService.PreSimulation:Connect(function()
		if not _G.NoclipEnabled or _G.AutoFarmEnabled then
			if not _G.NoclipEnabled and next(tbl4) then
				fn12()
			end

			return
		end

		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoidRootPart then
			return
		end

		if v5 ~= character then
			fn12()
			v5 = character
		end

		for _, descendant in ipairs(character:GetDescendants()) do
			if descendant:IsA("BasePart") then
				if tbl4[descendant] == nil then
					tbl4[descendant] = descendant.CanCollide
				end

				if descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		end

		local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity

		if assemblyLinearVelocity.Y < 0 then
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")
			local n2 = (humanoid and humanoid.HipHeight or 2) + humanoidRootPart.Size.Y * 0.5
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			raycastParams.FilterDescendantsInstances = { character }
			raycastParams.IgnoreWater = true

			if workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -(n2 + 1.5), 0), raycastParams) then
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z)
			end
		end
	end))

	_G.InfiniteJumpEnabled = false
	_G.WallJumpEnabled = false

	_G.InfiniteJumpSetEnabled = function(arg)
		_G.InfiniteJumpEnabled = arg and true or false
	end

	_G.WallJumpSetEnabled = function(arg)
		_G.WallJumpEnabled = arg and true or false
	end

	local tbl5 = {}

	for i = 0, 7 do
		local v6 = math.rad(i * 45)
		local n2 = #tbl5 + 1
		local sin = math.sin
		tbl5[n2] = Vector3.new(math.cos(v6), 0, sin(v6))
	end

	local function fn13(arg, arg2)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { arg }
		raycastParams.IgnoreWater = true

		for _, v6 in ipairs(tbl5) do
			local hit = workspace:Raycast(arg2.Position, v6 * 3.5, raycastParams)
			if hit and hit.Instance and hit.Instance.CanCollide then
				return true
			end
		end

		return false
	end

	table.insert(_G.CoinESPConn, UserInputService.JumpRequest:Connect(function()
		if _G.AutoFarmEnabled or _G.PlayerFlyEnabled then
			return
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return
		end

		if humanoid.FloorMaterial ~= Enum.Material.Air then
			return
		end

		if os.clock() - (_G.__LastAirJump or 0) < 0.2 then
			return
		end

		if not (_G.InfiniteJumpEnabled or _G.WallJumpEnabled and fn13(character, humanoidRootPart)) then
			return
		end
		_G.__LastAirJump = os.clock()
		local jumpPower = humanoid.UseJumpPower and humanoid.JumpPower or math.sqrt(2 * workspace.Gravity * humanoid.JumpHeight)
		local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
		humanoidRootPart.AssemblyLinearVelocity = Vector3.new(assemblyLinearVelocity.X, jumpPower, assemblyLinearVelocity.Z)
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end))

	_G.BombBoostPower = 120

	_G.BombBoostSetPower = function(arg)
		_G.BombBoostPower = math.clamp(tonumber(arg) or 120, 40, 300)
	end

	local flag2 = false

	local function fn14()
		local character = localPlayer.Character
		local backpack = localPlayer:FindFirstChild("Backpack")

		for _, v6 in ipairs({ character, backpack }) do
			if v6 then
				for _, child in ipairs(v6:GetChildren()) do
					if child:IsA("Tool") and string.find(string.lower(child.Name), "bomb", 1, true) then
						return child
					end
				end
			end
		end

		return nil
	end

	_G.BombBoost = function()
		if flag2 then
			return false, "Already boosting"
		end
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoid or not humanoidRootPart or humanoid.Health <= 0 then
			return false, "No character"
		end
		local v6 = fn14()
		if not v6 then
			return false, "No bomb in inventory"
		end
		flag2 = true
		local flag3 = false

		local function fn15()
			if flag3 then
				return
			end
			flag3 = true

			pcall(function()
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(humanoidRootPart.AssemblyLinearVelocity.X, _G.BombBoostPower, humanoidRootPart.AssemblyLinearVelocity.Z)
			end)
		end

		local connection2 = workspace.DescendantAdded:Connect(function(descendant)
			if descendant:IsA("Explosion") and humanoidRootPart.Parent then
				if (descendant.Position - humanoidRootPart.Position).Magnitude <= 30 then
					fn15()
				end
			end
		end)

		pcall(function()
			if v6.Parent ~= character then
				humanoid:EquipTool(v6)
				task.wait(0.15)
			end

			v6:Activate()
		end)

		task.delay(0.35, function()
			fn15()

			if connection2 then
				connection2:Disconnect()
				connection2 = nil
			end

			task.wait(0.4)
			flag2 = false
		end)

		return true, "Boosting"
	end

	local connection2 = RunService.Heartbeat:Connect(function()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildWhichIsA("Humanoid")
		if not humanoidRootPart or not character or character.Health <= 0 then
			return
		end

		if not _G.AutoFarmEnabled and not _G.PlayerFlyEnabled then
			character.UseJumpPower = true
			character.WalkSpeed = _G.PlayerWalkSpeed
			character.JumpPower = _G.PlayerJumpPower
		end

		if not _G.PlayerFlyEnabled or _G.AutoFarmEnabled then
			fn11()
			return
		end
		local marbegPlayerFlyVelocity = humanoidRootPart:FindFirstChild("MarbegPlayerFlyVelocity")

		if not marbegPlayerFlyVelocity then
			marbegPlayerFlyVelocity = Instance.new("BodyVelocity")
			marbegPlayerFlyVelocity.Name = "MarbegPlayerFlyVelocity"
			marbegPlayerFlyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			marbegPlayerFlyVelocity.P = 12000
			marbegPlayerFlyVelocity.Parent = humanoidRootPart
		end

		local marbegPlayerFlyGyro = humanoidRootPart:FindFirstChild("MarbegPlayerFlyGyro")

		if not marbegPlayerFlyGyro then
			marbegPlayerFlyGyro = Instance.new("BodyGyro")
			marbegPlayerFlyGyro.Name = "MarbegPlayerFlyGyro"
			marbegPlayerFlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
			marbegPlayerFlyGyro.P = 9000
			marbegPlayerFlyGyro.D = 500
			marbegPlayerFlyGyro.Parent = humanoidRootPart
		end

		character.PlatformStand = true
		character.AutoRotate = false
		local currentCamera = workspace.CurrentCamera
		local vector = Vector3.zero

		if currentCamera then
			local vector2 = Vector3.new(currentCamera.CFrame.LookVector.X, 0, currentCamera.CFrame.LookVector.Z)
			local vector3 = Vector3.new(currentCamera.CFrame.RightVector.X, 0, currentCamera.CFrame.RightVector.Z)

			if vector2.Magnitude > 0 then
				vector2 = vector2.Unit
			end

			if vector3.Magnitude > 0 then
				vector3 = vector3.Unit
			end

			vector = Vector3.zero

			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				vector = Vector3.zero + vector2
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				vector -= vector2
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				vector += vector3
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				vector -= vector3
			end

			if vector.Magnitude == 0 then
				vector = character.MoveDirection

				if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
					vector += Vector3.new(0, currentCamera.CFrame.LookVector.Y * vector:Dot(vector2), 0)

					if character.Jump then
						vector += Vector3.new(0, 1, 0)
					end
				end
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.Space) or UserInputService:IsKeyDown(Enum.KeyCode.E) then
				vector += Vector3.new(0, 1, 0)
			end

			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.Q) then
				vector -= Vector3.new(0, 1, 0)
			end

			local vector4 = Vector3.new(currentCamera.CFrame.LookVector.X, 0, currentCamera.CFrame.LookVector.Z)

			if vector4.Magnitude > 0 then
				marbegPlayerFlyGyro.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + vector4.Unit)
			end
		end

		if vector.Magnitude > 1 then
			vector = vector.Unit
		end

		marbegPlayerFlyVelocity.Velocity = vector * _G.PlayerFlySpeed
	end)

	table.insert(_G.CoinESPConn, connection2)
end

_G.RoleFlingBusy = false
_G.RoleFlingStatus = "Ready"

_G.StopRoleFling = function()
	_G.__RoleFlingLoopId = nil
end

local function fn11(arg)
	for _, v5 in ipairs(arg) do
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local v6 = CurrentRoundClient.PlayerData[player.Name]
				local character = player.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				character = character and character:FindFirstChild("HumanoidRootPart")
				if v6 and v6.Role == v5 and not v6.Dead and humanoid and humanoid.Health > 0 and character then
					return player
				end
			end
		end
	end

	return nil
end

_G.FlingPlayerTarget = function(arg)
	if _G.RoleFlingBusy then
		return false, "Another fling is already running"
	end

	if _G.AutoFarmEnabled then
		return false, "Turn off Auto Farm first"
	end

	if not arg or arg == localPlayer or arg.Parent ~= Players then
		return false, "Player not found"
	end
	local character = localPlayer.Character
	local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
	local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
	local character2 = arg.Character
	local humanoid2 = character2 and character2:FindFirstChildWhichIsA("Humanoid")
	local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
	if not character or not humanoid or humanoid.Health <= 0 or not humanoidRootPart then
		return false, "Your character is unavailable"
	end

	if not character2 or not humanoid2 or humanoid2.Health <= 0 or not humanoidRootPart2 then
		return false, "Target is unavailable"
	end
	local roleFlingLoopId = {}
	_G.__RoleFlingLoopId = roleFlingLoopId
	_G.RoleFlingBusy = true
	_G.RoleFlingStatus = "Flinging " .. arg.Name

	task.spawn(function()
		local pivot = character:GetPivot()
		local flag2 = _G.AntiFlingEnabled == true
		local flag3 = _G.PlayerFlyEnabled == true
		local platformStand = humanoid.PlatformStand
		local autoRotate = humanoid.AutoRotate
		local stateEnabled = humanoid:GetStateEnabled(Enum.HumanoidStateType.Seated)
		local primaryPart = character.PrimaryPart
		local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
		local bodyVelocity = nil
		local flag4 = false

		if flag3 and _G.PlayerFlySetEnabled then
			_G.PlayerFlySetEnabled(false)
		end

		if flag2 and _G.AntiFlingSetEnabled then
			_G.AntiFlingSetEnabled(false)
		end

		pcall(function()
			if type(setsimulationradius) == "function" then
				setsimulationradius(math.huge, math.huge)
			end

			if type(sethiddenproperty) == "function" then
				sethiddenproperty(localPlayer, "SimulationRadius", math.huge)
			end
		end)

		task.wait(0.05)

		local ok, result = pcall(function()
			character.PrimaryPart = humanoidRootPart
			workspace.FallenPartsDestroyHeight = (0/0)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Name = "MarbegFlingVelocity"
			bodyVelocity.Velocity = Vector3.new(900000000, 900000000, 900000000)
			bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			bodyVelocity.Parent = humanoidRootPart
			local now = os.clock()
			local n2 = 0

			local function fn12(arg2, arg3)
				n2 += 100
				local cFrame = CFrame.new(humanoidRootPart2.Position) * arg2 * arg3
				humanoidRootPart.CFrame = cFrame
				character:SetPrimaryPartCFrame(cFrame)
				humanoidRootPart.Velocity = Vector3.new(90000000, 900000000, 90000000)
				humanoidRootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
				task.wait()
			end

			while true do
				if _G.__RoleFlingLoopId == roleFlingLoopId and os.clock() - now < 2.4 then
					character2 = arg.Character
					humanoid2 = character2 and character2:FindFirstChildWhichIsA("Humanoid")
					humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

					if not (not humanoidRootPart2 or not humanoid2 or humanoid2.Health <= 0) then
						if humanoidRootPart2.Velocity.Magnitude > 500 then
							flag4 = true
							break
						else
							local n3 = humanoid2.MoveDirection * humanoidRootPart2.Velocity.Magnitude / 1.25
							local cframe = CFrame.Angles(math.rad(n2), 0, 0)
							fn12(CFrame.new(0, 1.5, 0) + n3, cframe)
							fn12(CFrame.new(0, -1.5, 0) + n3, cframe)
							fn12(CFrame.new(2.25, 1.5, -2.25) + n3, cframe)
							fn12(CFrame.new(-2.25, -1.5, 2.25) + n3, cframe)
							local moveDirection = humanoid2.MoveDirection
							fn12(CFrame.new(0, 1.5, 0) + moveDirection, cframe)
							local moveDirection2 = humanoid2.MoveDirection
							fn12(CFrame.new(0, -1.5, 0) + moveDirection2, cframe)
							continue
						end
					end
				end

				break
			end

			if humanoidRootPart2 and humanoidRootPart2.Velocity.Magnitude > 500 then
				flag4 = true
			end
		end)

		if bodyVelocity and bodyVelocity.Parent then
			bodyVelocity:Destroy()
		end

		workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight
		humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, stateEnabled)

		pcall(function()
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			humanoidRootPart.Velocity = Vector3.zero
			humanoidRootPart.RotVelocity = Vector3.zero
			character:PivotTo(pivot + Vector3.new(0, 0.5, 0))
			character.PrimaryPart = primaryPart
			humanoid.PlatformStand = platformStand
			humanoid.AutoRotate = autoRotate
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)

		if flag2 and _G.AntiFlingSetEnabled then
			_G.AntiFlingSetEnabled(true)
		end

		if flag3 and _G.PlayerFlySetEnabled then
			_G.PlayerFlySetEnabled(true)
		end

		if _G.__RoleFlingLoopId == roleFlingLoopId then
			_G.__RoleFlingLoopId = nil
		end

		_G.RoleFlingBusy = false

		if not ok then
			_G.RoleFlingStatus = "Fling failed: " .. tostring(result)
		elseif flag4 then
			_G.RoleFlingStatus = "Fling worked: " .. arg.Name
		else
			_G.RoleFlingStatus = "Server blocked fling: " .. arg.Name
		end

		if _G.WindNotify then
			_G.WindNotify("Fling Result", _G.RoleFlingStatus, flag4 and "circle-check" or "shield-x")
		end
	end)

	return true, "Targeting " .. arg.Name
end

_G.RoleFlingTarget = function(arg)
	if not _G.InRound or not _G.__RealInRound then
		return false, "No active round"
	end
	local v5 = fn11(arg)
	if not v5 then
		return false, "Role target not found"
	end
	return _G.FlingPlayerTarget(v5)
end

_G.AntiFlingEnabled = true
_G.AntiFlingStatus = "Protected"

do
	local obj = setmetatable({}, { __mode = "k" })
	local cFrame = nil
	local v5 = nil
	local n2 = 0

	local function fn12()
		for k, v6 in pairs(obj) do
			if k and k.Parent then
				pcall(function()
					k.CanCollide = v6
				end)
			end

			obj[k] = nil
		end
	end

	_G.AntiFlingSetEnabled = function(arg)
		_G.AntiFlingEnabled = arg and true or false
		_G.AntiFlingStatus = _G.AntiFlingEnabled and "Protected" or "Disabled"

		if not _G.AntiFlingEnabled then
			fn12()
			cFrame = nil
			v5 = nil
			n2 = 0
		end
	end

	local n3 = 0

	local connection2 = RunService.Heartbeat:Connect(function(deltaTime)
		if not _G.AntiFlingEnabled then
			return
		end
		n3 += deltaTime
		if n3 < 0.03 then
			return
		end
		n3 = 0
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoid or humanoid.Health <= 0 or not humanoidRootPart then
			return
		end

		if v5 ~= character then
			v5 = character
			cFrame = humanoidRootPart.CFrame
		end

		local antiFlingParts = _G.__AntiFlingParts

		if not antiFlingParts then
			antiFlingParts = setmetatable({}, { __mode = "k" })
			_G.__AntiFlingParts = antiFlingParts
		end

		for _, player in ipairs(Players:GetPlayers()) do
			local character2 = player ~= localPlayer and player.Character

			if character2 then
				local tbl4 = antiFlingParts[character2]

				if not tbl4 or tbl4.dirty then
					if tbl4 and tbl4.conns then
						for _, conn in ipairs(tbl4.conns) do
							conn:Disconnect()
						end
					end

					tbl4 = { parts = {}, dirty = false }

					for _, descendant in ipairs(character2:GetDescendants()) do
						if descendant:IsA("BasePart") then
							tbl4.parts[#tbl4.parts + 1] = descendant
						end
					end

					local function fn13(descendant)
						if descendant:IsA("BasePart") then
							tbl4.dirty = true
						end
					end

					local descendantRemoving = character2.DescendantRemoving
					local connect = descendantRemoving.Connect
					tbl4.conns = { character2.DescendantAdded:Connect(fn13), connect(descendantRemoving, fn13) }
					antiFlingParts[character2] = tbl4
				end

				for _, part in ipairs(tbl4.parts) do
					if part.CanCollide then
						if obj[part] == nil then
							obj[part] = true
						end

						part.CanCollide = false
					end
				end
			end
		end

		local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
		local magnitude = Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude
		local magnitude2 = humanoidRootPart.AssemblyAngularVelocity.Magnitude
		local flag2 = not _G.PlayerFlyEnabled

		if flag2 then
			flag2 = magnitude > 95 or magnitude2 > 55 or assemblyLinearVelocity.Y > 120
		end

		local now = os.clock()

		if flag2 and now >= n2 then
			n2 = now + 0.85
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.AssemblyAngularVelocity = Vector3.zero

			if cFrame then
				character:PivotTo(cFrame)
			end

			humanoid.PlatformStand = false
			humanoid.Sit = false
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			_G.AntiFlingStatus = "Fling blocked"
		else
			if humanoid.FloorMaterial ~= Enum.Material.Air and magnitude < 45 and magnitude2 < 18 then
				cFrame = humanoidRootPart.CFrame
			end

			if n2 <= now then
				_G.AntiFlingStatus = "Protected"
			end
		end
	end)

	table.insert(_G.CoinESPConn, connection2)
end

_G.AutoThrowKnifeEnabled = false
_G.AutoThrowKnifeStatus = "Disabled"

do
	local n2 = 0

	local function fn12(arg)
		if not arg or not arg:IsA("Tool") then
			return nil
		end
		local events = arg:FindFirstChild("Events")
		events = events and events:FindFirstChild("KnifeThrown")
		local handle = arg:FindFirstChild("Handle")
		if events and events:IsA("RemoteEvent") and handle and handle:IsA("BasePart") then
			return arg, handle, events
		end
		return nil
	end

	local function fn13(arg)
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, child in ipairs(character:GetChildren()) do
			local v5, v6, v7 = fn12(child)
			if v5 then
				return v5, v6, v7
			end
		end

		if arg then
			local backpack = localPlayer:FindFirstChild("Backpack")
			local humanoid = character:FindFirstChildWhichIsA("Humanoid")

			if backpack and humanoid then
				for _, child in ipairs(backpack:GetChildren()) do
					if fn12(child) then
						humanoid:EquipTool(child)
						task.wait(0.12)
						return fn12(child)
					end
				end
			end
		end

		return nil
	end

	local function fn14(arg)
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart or not arg then
			return nil
		end
		local huge = math.huge
		local v5 = nil
		local v6 = nil
		local v7 = nil

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local character2 = player.Character
				local humanoid = character2 and character2:FindFirstChildWhichIsA("Humanoid")
				local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
				local v8 = nil

				if humanoidRootPart2 then
					local v9
					v9, v8 = fn9(arg, character2, character)
				end

				if humanoid and humanoid.Health > 0 and humanoidRootPart2 and v8 then
					local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v5 = player
						v6 = humanoidRootPart2
						v7 = v8
					end
				end
			end
		end

		return v5, v6, huge, v7
	end

	_G.ThrowAimbotOnce = function()
		if not _G.InRound then
			return false, "Not in round"
		end
		local v5, v6, v7 = fn13(true)
		if not v5 then
			return false, "No knife in inventory"
		end
		local v8, v9, v10, v11 = fn14(v6.Position)
		local character = v8 and v8.Character
		if not v8 or not v9 or not character or not v11 then
			return false, "No visible target"
		end
		local v12 = fn10(v6.Position, character, v9, v11, localPlayer.Character)
		local n3 = math.max(0.85, (tonumber(v5:GetAttribute("ThrowSpeed")) or 0.5) * 2)
		if os.clock() - n2 < n3 then
			return false, "Knife cooling down"
		end

		if not pcall(function()
			v7:FireServer(v6.CFrame, CFrame.new(v12))
		end) then
			return false, "Remote error"
		end
		n2 = os.clock()
		return true, v8.Name .. " @ " .. math.floor(v10) .. " studs"
	end

	_G.AutoThrowKnifeSetEnabled = function(arg)
		_G.AutoThrowKnifeEnabled = arg and true or false
		_G.AutoThrowKnifeStatus = _G.AutoThrowKnifeEnabled and "Waiting for equipped knife" or "Disabled"
	end

	local autoThrowKnifeLoopId = {}
	_G.__AutoThrowKnifeLoopId = autoThrowKnifeLoopId

	task.spawn(function()
		while _G.__AutoThrowKnifeLoopId == autoThrowKnifeLoopId do
			task.wait(0.04)

			if not (not _G.AutoThrowKnifeEnabled or not _G.InRound) then
				local v5, v6, v7 = fn13()

				if not v5 then
					_G.AutoThrowKnifeStatus = "Equip the knife"
				else
					local v8, v9, v10, v11 = fn14(v6.Position)
					local character = v8 and v8.Character

					if not v8 or not v9 or not character or not v11 then
						_G.AutoThrowKnifeStatus = "No visible target"
					else
						local v12 = fn10(v6.Position, character, v9, v11, localPlayer.Character)
						local n3 = math.max(0.85, (tonumber(v5:GetAttribute("ThrowSpeed")) or 0.5) * 2)

						if not (os.clock() - n2 < n3) then
							if pcall(function()
								v7:FireServer(v6.CFrame, CFrame.new(v12))
							end) then
								n2 = os.clock()
								_G.AutoThrowKnifeStatus = v8.Name .. " @ " .. math.floor(v10) .. " studs"
							else
								_G.AutoThrowKnifeStatus = "Remote error"
							end
						end
					end
				end
			end
		end
	end)

	_G.KillAllBusy = false
	_G.KillAllStatus = "Ready"

	_G.KillAllMurderer = function()
		if _G.KillAllBusy then
			return false, "Already running"
		end

		if not _G.InRound then
			return false, "Not in round"
		end
		local v5 = CurrentRoundClient.PlayerData[localPlayer.Name]
		if not v5 or v5.Role ~= "Murderer" or v5.Dead then
			return false, "Murderer role required"
		end
		local v6 = fn13(true)
		if not v6 then
			return false, "Knife unavailable"
		end
		local events = v6:FindFirstChild("Events")
		local knifeStabbed = events and events:FindFirstChild("KnifeStabbed")
		local handleTouched = events and events:FindFirstChild("HandleTouched")
		if not knifeStabbed or not knifeStabbed:IsA("RemoteEvent") or not handleTouched or not handleTouched:IsA("RemoteEvent") then
			return false, "Stab remotes unavailable"
		end
		_G.KillAllBusy = true
		_G.KillAllStatus = "Running"
		local killAllLoopId = {}
		_G.__KillAllLoopId = killAllLoopId

		task.spawn(function()
			local tbl4 = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if not (_G.__KillAllLoopId ~= killAllLoopId or not _G.InRound) then
					if player ~= localPlayer then
						local v7 = CurrentRoundClient.PlayerData[player.Name]
						local character = player.Character
						local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")

						if character then
							character = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso") or character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
						end

						if v7 and not v7.Dead and humanoid and humanoid.Health > 0 and character and character:IsA("BasePart") then
							table.insert(tbl4, character)
						end
					end

					continue
				end

				break
			end

			local flag2 = _G.__KillAllLoopId == killAllLoopId and #tbl4 > 0
			local n3 = 0

			if flag2 then
				if pcall(function()
					knifeStabbed:FireServer()
				end) then
					task.wait(0.035)

					for _, v7 in ipairs(tbl4) do
						if _G.__KillAllLoopId == killAllLoopId then
							if pcall(function()
								handleTouched:FireServer(v7)
							end) then
								n3 += 1
							end

							continue
						end

						break
					end
				end
			end

			_G.KillAllBusy = false
			_G.KillAllStatus = "Finished: " .. n3 .. " stabs"
		end)

		return true, "Started"
	end

	_G.KnifeAuraEnabled = false
	_G.KnifeAuraRange = 12
	_G.KnifeAuraVisibleOnly = true
	local n3 = 0
	local n4 = 0
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.IgnoreWater = true

	table.insert(_G.CoinESPConn, RunService.Heartbeat:Connect(function(deltaTime)
		n4 += deltaTime
		if n4 < 0.1 then
			return
		end
		n4 = 0
		if not _G.KnifeAuraEnabled or not _G.InRound or _G.KillAllBusy then
			return
		end

		if os.clock() - n3 < 0.45 then
			return
		end
		local v5 = CurrentRoundClient.PlayerData[localPlayer.Name]
		if not v5 or v5.Role ~= "Murderer" or v5.Dead then
			return
		end
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local v6 = fn13(false)
		if not v6 then
			return
		end
		local events = v6:FindFirstChild("Events")
		local knifeStabbed = events and events:FindFirstChild("KnifeStabbed")
		local handleTouched = events and events:FindFirstChild("HandleTouched")
		if not knifeStabbed or not handleTouched then
			return
		end
		local tbl4 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local v7 = CurrentRoundClient.PlayerData[player.Name]
				local character2 = player.Character
				local humanoid = character2 and character2:FindFirstChildWhichIsA("Humanoid")
				local upperTorso = character2 and (character2:FindFirstChild("UpperTorso") or character2:FindFirstChild("Torso") or character2:FindFirstChild("HumanoidRootPart"))

				if v7 and not v7.Dead and humanoid and humanoid.Health > 0 and upperTorso and (upperTorso.Position - humanoidRootPart.Position).Magnitude <= _G.KnifeAuraRange then
					local flag2 = true

					if _G.KnifeAuraVisibleOnly then
						raycastParams.FilterDescendantsInstances = { character, character2 }
						flag2 = workspace:Raycast(humanoidRootPart.Position, upperTorso.Position - humanoidRootPart.Position, raycastParams) == nil
					end

					if flag2 then
						tbl4[#tbl4 + 1] = upperTorso
					end
				end
			end
		end

		if #tbl4 == 0 then
			return
		end
		n3 = os.clock()

		task.spawn(function()
			if not pcall(function()
				knifeStabbed:FireServer()
			end) then
				return
			end
			task.wait(0.035)

			for _, v7 in ipairs(tbl4) do
				pcall(function()
					handleTouched:FireServer(v7)
				end)
			end
		end)
	end))
end

_G.KnifeAuraSetEnabled = function(arg)
	_G.KnifeAuraEnabled = arg and true or false
end

_G.KnifeAuraSetRange = function(arg)
	_G.KnifeAuraRange = math.clamp(tonumber(arg) or 12, 4, 40)
end

_G.KnifeAuraSetVisibleOnly = function(arg)
	_G.KnifeAuraVisibleOnly = arg and true or false
end

do
	local flag2 = false
	local n2 = 0

	table.insert(_G.CoinESPConn, RunService.Heartbeat:Connect(function(deltaTime)
		n2 += deltaTime
		if n2 < 0.08 then
			return
		end
		n2 = 0
		if not ((_G.FlingMurdererAfterBagFullEnabled or _G.ShootMurdererAfterBagFullEnabled or _G.KillAllAfterBagFullEnabled) and _G.BagFull and _G.InRound and _G.__RealInRound) then
			flag2 = false
			return
		end

		if flag2 then
			return
		end
		flag2 = true

		task.spawn(function()
			local v5 = CurrentRoundClient.PlayerData[localPlayer.Name]
			local flag3 = v5 and v5.Role == "Murderer" and not v5.Dead

			local function fn12()
				for _, v6 in pairs(CurrentRoundClient.PlayerData) do
					if v6 and v6.Role == "Murderer" and not v6.Dead then
						return true
					end
				end

				return false
			end

			if _G.ShootMurdererAfterBagFullEnabled and not flag3 then
				local flag4 = _G.AutoFarmEnabled == true

				if flag4 then
					_G.AutoFarmSetEnabled(false)
					task.wait(0.08)
				end

				local n3 = os.clock() + 25
				local n4 = 0
				local n5 = 0
				local flag5

				while true do
					local realInRound = os.clock() < n3 and _G.InRound and _G.__RealInRound
					flag5 = false

					if realInRound then
						if not fn12() then
							flag5 = true
							break
						else
							local v6 = CurrentRoundClient.PlayerData[localPlayer.Name]

							if not (not v6 or v6.Dead) then
								n4 += 1

								if not (n4 > 20) then
									n5 = _G.ShootMurdererRage() and 0 or n5 + 1
									if not (n5 >= 5) then
										task.wait(0.3)
										continue
									end
								end
							end
						end
					end

					break
				end

				flag5 = flag5 or not fn12()

				if _G.WindNotify then
					local windNotify = _G.WindNotify
					local str = flag5 and "Murderer down after " .. n4 .. " shot(s)"

					if not str then
						str = tostring(_G.ShootMurdererRageStatus or "Could not land a shot")
					end

					windNotify("Bag Full: Shoot Murderer", str, flag5 and "crosshair" or "circle-x")
				end

				if flag4 then
					_G.AutoFarmSetEnabled(true)
				end
			end

			if _G.FlingMurdererAfterBagFullEnabled and not flag3 and fn12() then
				local flag4 = _G.AutoFarmEnabled == true

				if flag4 then
					_G.AutoFarmSetEnabled(false)
					task.wait(0.08)
				end

				local v6, v7 = _G.RoleFlingTarget({ "Murderer" })

				if _G.WindNotify then
					_G.WindNotify("Bag Full: Fling Murderer", tostring(v7), v6 and "skull" or "circle-x")
				end

				if v6 then
					while true do
						task.wait(0.05)
						if not (not _G.RoleFlingBusy or not _G.InRound) then
							continue
						end
						break
					end
				end

				if flag4 then
					_G.AutoFarmSetEnabled(true)
				end
			end

			if _G.KillAllAfterBagFullEnabled and flag3 then
				local v6, v7 = _G.KillAllMurderer()

				if _G.WindNotify then
					_G.WindNotify("Bag Full: Kill All", tostring(v7), v6 and "skull" or "circle-x")
				end
			end
		end)
	end))
end

print("Auto Farm core ready (velocity-based fly, no CFrame teleports)")
_G.DailyQuestCheckerEnabled = false

do
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegDailyQuestChecker"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 90
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.DailyQuestCheckerGui = screenGui
	local frame = Instance.new("Frame")
	frame.Name = "Holder"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.new(0.5, 0, 0.22, 0)
	frame.Size = UDim2.fromOffset(360, 150)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = true
	frame.Parent = screenGui
	local v5 = nil
	local v6 = nil

	local function fn12()
		local playerGui = localPlayer:FindFirstChild("PlayerGui")
		if not playerGui then
			return nil
		end

		for _, descendant in ipairs(playerGui:GetDescendants()) do
			if descendant:IsA("Frame") and descendant.Name == "DailyCoins" then
				local title = descendant:FindFirstChild("Title", true)
				title = title and title:FindFirstChild("TitleLabel", true)
				if title and title:IsA("TextLabel") and string.find(string.upper(title.Text), "DAILY QUEST", 1, true) then
					return descendant
				end
			end
		end

		return nil
	end

	local function fn13(arg, arg2, arg3)
		if arg3 == arg then
			return arg2
		end
		local tbl4 = {}

		while arg3 and arg3 ~= arg do
			table.insert(tbl4, 1, arg3.Name)
			arg3 = arg3.Parent
		end

		if arg3 ~= arg then
			return nil
		end

		for _, v7 in ipairs(tbl4) do
			arg2 = arg2 and arg2:FindFirstChild(v7)
		end

		return arg2
	end

	local function fn14(arg)
		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("LocalScript") or descendant:IsA("Script") or descendant:IsA("ModuleScript") then
				descendant:Destroy()
			elseif descendant:IsA("GuiButton") then
				descendant.Active = false
				descendant.Selectable = false
				descendant.AutoButtonColor = false
			elseif descendant:IsA("ScrollingFrame") then
				descendant.ScrollingEnabled = false
				descendant.ScrollBarThickness = 0
				descendant.ScrollBarImageTransparency = 1
				descendant.TopImage = ""
				descendant.MidImage = ""
				descendant.BottomImage = ""
				descendant.HorizontalScrollBarInset = Enum.ScrollBarInset.None
			end
		end
	end

	local function fn15(arg)
		local title = arg and arg:FindFirstChild("Title")

		if title and title:IsA("GuiObject") then
			title.Visible = false
		end

		arg = arg and arg:FindFirstChild("RefreshLabel", true)

		if arg and arg:IsA("GuiObject") then
			arg.Visible = false
		end
	end

	local function fn16(arg, parent)
		if not arg or not parent then
			return
		end
		local absoluteSize = arg.AbsoluteSize
		local n2 = math.max(absoluteSize.X, 1)
		local n3 = math.max(absoluteSize.Y, 1)
		local x = frame.AbsoluteSize.X > 0 and frame.AbsoluteSize.X or 360
		local y = frame.AbsoluteSize.Y > 0 and frame.AbsoluteSize.Y or 150
		local scale = math.min(x / n2, y / n3)
		parent.Size = UDim2.fromOffset(n2, n3)
		parent.Position = UDim2.fromOffset(math.floor((x - n2 * scale) * 0.5), math.floor((y - n3 * scale) * 0.5))
		local marbegCompactScale = parent:FindFirstChild("MarbegCompactScale")

		if not marbegCompactScale then
			marbegCompactScale = Instance.new("UIScale")
			marbegCompactScale.Name = "MarbegCompactScale"
			marbegCompactScale.Parent = parent
		end

		marbegCompactScale.Scale = scale
	end

	local function fn17(arg)
		arg = arg and arg:FindFirstChildWhichIsA("ScrollingFrame", true)
		if not arg then
			return
		end
		local amountLabel = arg:FindFirstChild("AmountLabel", true)
		if not amountLabel or not amountLabel:IsA("TextLabel") then
			return
		end
		local n2 = arg.AbsolutePosition.X + arg.AbsoluteSize.X * 0.5
		local n3 = amountLabel.AbsolutePosition.X + amountLabel.AbsoluteSize.X * 0.5
		local n4 = math.max(arg.AbsoluteCanvasSize.X - arg.AbsoluteSize.X, 0)
		arg.CanvasPosition = Vector2.new(math.clamp(arg.CanvasPosition.X + n3 - n2, 0, n4), arg.CanvasPosition.Y)
	end

	local function fn18(arg)
		if v6 then
			pcall(function()
				v6:Destroy()
			end)
		end

		v5 = arg
		v6 = nil
		if not arg then
			return
		end

		local ok, result = pcall(function()
			return arg:Clone()
		end)

		if not ok or not result then
			return
		end
		v6 = result
		result.Name = "DailyQuestPanel"
		result.AnchorPoint = Vector2.new(0, 0)
		result.Position = UDim2.fromOffset(0, 0)
		result.Visible = true
		result.Parent = frame
		fn14(result)
		fn16(arg, result)
		fn15(result)

		task.defer(function()
			if v6 == result and result.Parent then
				fn17(result)
			end
		end)
	end

	local function fn19()
		local v7 = fn12()

		if v7 ~= v5 or not v6 or not v6.Parent then
			fn18(v7)
		end

		if not v7 or not v6 then
			return
		end

		for _, descendant in ipairs(v7:GetDescendants()) do
			local v8 = fn13(v7, v6, descendant)

			if v8 then
				pcall(function()
					if descendant:IsA("GuiObject") and v8:IsA("GuiObject") then
						v8.Visible = descendant.Visible
						v8.Position = descendant.Position
						v8.Size = descendant.Size
						v8.LayoutOrder = descendant.LayoutOrder
						v8.BackgroundColor3 = descendant.BackgroundColor3
						v8.BackgroundTransparency = descendant.BackgroundTransparency
					end

					if (descendant:IsA("TextLabel") or descendant:IsA("TextButton")) and (v8:IsA("TextLabel") or v8:IsA("TextButton")) then
						v8.Text = descendant.Text
						v8.TextColor3 = descendant.TextColor3
						v8.TextTransparency = descendant.TextTransparency
					end

					if (descendant:IsA("ImageLabel") or descendant:IsA("ImageButton")) and (v8:IsA("ImageLabel") or v8:IsA("ImageButton")) then
						v8.Image = descendant.Image
						v8.ImageColor3 = descendant.ImageColor3
						v8.ImageTransparency = descendant.ImageTransparency
					end

					if descendant:IsA("ScrollingFrame") and v8:IsA("ScrollingFrame") then
						v8.CanvasPosition = descendant.CanvasPosition
						v8.CanvasSize = descendant.CanvasSize
						v8.ScrollingEnabled = false
						v8.ScrollBarThickness = 0
						v8.ScrollBarImageTransparency = 1
						v8.TopImage = ""
						v8.MidImage = ""
						v8.BottomImage = ""
						v8.HorizontalScrollBarInset = Enum.ScrollBarInset.None
					end
				end)
			end
		end

		fn16(v7, v6)
		fn15(v6)
		fn17(v6)
	end

	_G.DailyQuestCheckerSetEnabled = function(dailyQuestCheckerEnabled)
		_G.DailyQuestCheckerEnabled = dailyQuestCheckerEnabled
		screenGui.Enabled = dailyQuestCheckerEnabled

		if dailyQuestCheckerEnabled then
			pcall(fn19)
		end
	end

	local dailyQuestLoopId = {}
	_G.__DailyQuestLoopId = dailyQuestLoopId

	task.spawn(function()
		while _G.__DailyQuestLoopId == dailyQuestLoopId do
			task.wait(0.25)

			if _G.DailyQuestCheckerEnabled then
				pcall(fn19)
			end
		end
	end)
end

_G.ActionButtonTextColor = Color3.fromRGB(255, 255, 255)
_G.__ActionButtons = _G.__ActionButtons or {}
_G.__ActionButtonLayouts = _G.__ActionButtonLayouts or {}
_G.ActionButtonSize = tonumber(_G.ActionButtonSize) or 72

do
	local HttpService = game:GetService("HttpService")
	local tbl4 = {}
	local n2 = 72
	local n3 = 0

	pcall(function()
		if isfile and readfile and isfile("mm2_button_positions.json") then
			local data = HttpService:JSONDecode(readfile("mm2_button_positions.json"))

			if type(data) == "table" then
				if type(data.Positions) == "table" then
					tbl4 = data.Positions
					n2 = tonumber(data.Size) or n2
				else
					tbl4 = data
					n2 = tonumber(data.__Size) or n2
					tbl4.__Size = nil
				end
			end
		end
	end)

	_G.ActionButtonSize = math.clamp(n2, 48, 120)

	local function saveActionButtonLayout()
		n3 += 1
		local v5 = n3

		task.delay(0.6, function()
			if v5 ~= n3 or not writefile then
				return
			end

			pcall(function()
				writefile("mm2_button_positions.json", HttpService:JSONEncode({ Positions = tbl4, Size = _G.ActionButtonSize }))
			end)
		end)
	end

	_G.__SaveActionButtonLayout = saveActionButtonLayout

	_G.__TrackButtonPosition = function(arg, arg2)
		_G.__ActionButtonLayouts[arg] = { button = arg2, defaultPosition = arg2.Position }
		local v5 = tbl4[arg]

		if type(v5) == "table" and #v5 == 4 then
			arg2.Position = UDim2.new(v5[1], v5[2], v5[3], v5[4])
		end

		arg2:GetPropertyChangedSignal("Position"):Connect(function()
			local position = arg2.Position
			tbl4[arg] = { position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset }
			saveActionButtonLayout()
		end)
	end

	_G.__ResetActionButtonPositions = function()
		for k, actionButtonLayout in pairs(_G.__ActionButtonLayouts) do
			local button = actionButtonLayout.button

			if button and button.Parent and actionButtonLayout.defaultPosition then
				button.Position = actionButtonLayout.defaultPosition
				local position = button.Position
				tbl4[k] = { position.X.Scale, position.X.Offset, position.Y.Scale, position.Y.Offset }
			end
		end

		saveActionButtonLayout()
		return true
	end
end

_G.__StyleSquareButton = function(parent, arg, text, backgroundColor3)
	local n2 = math.clamp(tonumber(_G.ActionButtonSize) or 72, 48, 120)
	parent.Size = UDim2.fromOffset(n2, n2)
	parent.BackgroundTransparency = 1
	parent.BorderSizePixel = 0
	parent.AutoButtonColor = false
	parent.Text = ""
	parent.ClipsDescendants = false

	local function createUICorner(parent2, cornerRadius)
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = cornerRadius
		uiCorner.Parent = parent2
		return uiCorner
	end

	local tbl4 = {}

	for i, v5 in ipairs({ { grow = 6, alpha = 0.86 }, { grow = 14, alpha = 0.94 } }) do
		local frame = Instance.new("Frame")
		frame.Name = "Halo" .. i
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.BackgroundColor3 = backgroundColor3
		frame.BackgroundTransparency = v5.alpha
		frame.BorderSizePixel = 0
		frame.ZIndex = 1
		frame.Parent = parent
		tbl4[i] = { frame = frame, grow = v5.grow, corner = createUICorner(frame, UDim.new(0, 18)) }
	end

	local frame = Instance.new("Frame")
	frame.Name = "Plate"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.5, 0.5)
	frame.Size = UDim2.fromScale(1, 1)
	frame.BackgroundColor3 = Color3.new(1, 1, 1)
	frame.BackgroundTransparency = 0.08
	frame.BorderSizePixel = 0
	frame.ZIndex = 2
	frame.Parent = parent
	local v5 = createUICorner(frame, UDim.new(0, 16))
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Rotation = 90
	local colorSequence = ColorSequence.new
	local tbl5 = {}
	local v6 = ColorSequenceKeypoint.new(0, backgroundColor3:Lerp(Color3.fromRGB(24, 26, 34), 0.72))
	local v7 = ColorSequenceKeypoint.new(0.55, Color3.fromRGB(20, 22, 29))
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromRGB
	tbl5[1] = v6
	tbl5[2] = v7

	do
		local values = table.pack(new(1, color(12, 13, 18)))
		table.move(values, 1, values.n, 3, tbl5)
	end

	uiGradient.Color = colorSequence(tbl5)
	uiGradient.Parent = frame
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = backgroundColor3
	uiStroke.Thickness = 1.6
	uiStroke.Transparency = 0.1
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.LineJoinMode = Enum.LineJoinMode.Round
	uiStroke.Parent = frame
	local uiGradient2 = Instance.new("UIGradient")
	uiGradient2.Rotation = 90
	local color2 = Color3.fromRGB
	uiGradient2.Color = ColorSequence.new(Color3.new(1, 1, 1), color2(120, 120, 120))
	local new2 = NumberSequenceKeypoint.new
	uiGradient2.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new2(1, 0.45) })
	uiGradient2.Parent = uiStroke
	local frame2 = Instance.new("Frame")
	frame2.Name = "Badge"
	frame2.AnchorPoint = Vector2.new(0.5, 0)
	frame2.BackgroundColor3 = backgroundColor3
	frame2.BackgroundTransparency = 0.72
	frame2.BorderSizePixel = 0
	frame2.ZIndex = 3
	frame2.Parent = frame
	createUICorner(frame2, UDim.new(1, 0))
	local uiGradient3 = Instance.new("UIGradient")
	uiGradient3.Rotation = 90
	local new3 = NumberSequenceKeypoint.new
	uiGradient3.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new3(1, 0.5) })
	uiGradient3.Parent = frame2
	local uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = parent
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "Icon"
	imageLabel.BackgroundTransparency = 1
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.ImageColor3 = _G.ActionButtonTextColor
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.ZIndex = 4
	imageLabel.Parent = frame
	imageLabel:SetAttribute("IconName", arg)
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Caption"
	textLabel.BackgroundTransparency = 1
	textLabel.Text = text
	textLabel.TextColor3 = _G.ActionButtonTextColor
	textLabel.TextWrapped = false
	textLabel.RichText = false
	textLabel.LineHeight = 0.95
	textLabel.TextYAlignment = Enum.TextYAlignment.Top
	textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	textLabel.TextStrokeTransparency = 0.75
	textLabel.AutoLocalize = false
	textLabel.ZIndex = 4
	textLabel.Parent = frame
	local tbl6 = { button = parent, icon = imageLabel, caption = textLabel, pressScale = uiScale }
	table.insert(_G.__ActionButtons, tbl6)

	local function applySize(arg2)
		local n3 = math.clamp(tonumber(arg2) or 72, 48, 120)
		parent.Size = UDim2.fromOffset(n3, n3)
		local n4 = math.floor(n3 * 0.26)
		v5.CornerRadius = UDim.new(0, n4)

		for _, v8 in ipairs(tbl4) do
			v8.frame.Size = UDim2.new(1, v8.grow, 1, v8.grow)
			v8.corner.CornerRadius = UDim.new(0, n4 + math.floor(v8.grow / 2))
		end

		local n5 = math.floor(n3 * 0.46)
		frame2.Size = UDim2.fromOffset(n5, n5)
		frame2.Position = UDim2.new(0.5, 0, 0, math.floor(n3 * 0.1))
		local floor = math.floor
		imageLabel.Size = UDim2.fromOffset(math.floor(n3 * 0.3), floor(n3 * 0.3))
		imageLabel.Position = UDim2.new(0.5, 0, 0, math.floor(n3 * 0.1 + n5 / 2))
		local floor2 = math.floor
		textLabel.Position = UDim2.new(0, math.floor(n3 * 0.05), 0, floor2(n3 * 0.6))
		local floor3 = math.floor
		textLabel.Size = UDim2.new(1, -math.floor(n3 * 0.1), 0, floor3(n3 * 0.34))
		textLabel.TextSize = math.clamp(math.floor(n3 * 0.13), 8, 17)
	end

	tbl6.applySize = applySize
	applySize(n2)

	parent.MouseButton1Down:Connect(function()
		TweenService:Create(uiScale, TweenInfo.new(0.08), { Scale = 0.93 }):Play()
	end)

	local function fn12()
		TweenService:Create(uiScale, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()

		for i, v8 in ipairs(tbl4) do
			TweenService:Create(v8.frame, TweenInfo.new(0.15), { BackgroundTransparency = i == 1 and 0.86 or 0.94 }):Play()
		end
	end

	parent.MouseButton1Up:Connect(fn12)
	parent.MouseLeave:Connect(fn12)

	parent.MouseEnter:Connect(function()
		TweenService:Create(uiScale, TweenInfo.new(0.12), { Scale = 1.06 }):Play()

		for i, v8 in ipairs(tbl4) do
			TweenService:Create(v8.frame, TweenInfo.new(0.15), { BackgroundTransparency = i == 1 and 0.72 or 0.86 }):Play()
		end
	end)

	return uiStroke, imageLabel, textLabel
end

_G.__SetActionButtonSize = function(arg)
	local actionButtonSize = math.clamp(tonumber(arg) or 72, 48, 120)
	_G.ActionButtonSize = actionButtonSize

	for _, actionButton in ipairs(_G.__ActionButtons) do
		if actionButton.applySize then
			pcall(actionButton.applySize, actionButtonSize)
		end
	end

	return actionButtonSize
end

local tbl4 = {
	__mm2_default_knife = "rbxassetid://148256623",
	__mm2_throw_knife = "rbxassetid://444186601",
	__mm2_default_gun = "rbxassetid://197518111",
}

_G.__ApplyActionButtonIcons = function()
	local windUI = _G.WindUI

	for _, actionButton in ipairs(_G.__ActionButtons) do
		local attribute = actionButton.icon and actionButton.icon:GetAttribute("IconName")

		if attribute and actionButton.icon.Parent then
			local v5 = tbl4[attribute]

			if v5 then
				actionButton.icon.Image = v5
			elseif windUI and windUI.Creator and windUI.Creator.Icon then
				local ok, result = pcall(windUI.Creator.Icon, attribute)

				if ok and type(result) == "table" and result[1] then
					actionButton.icon.Image = result[1]
				end
			end
		end
	end
end

_G.SetActionButtonTextColor = function(actionButtonTextColor)
	if typeof(actionButtonTextColor) ~= "Color3" then
		return
	end
	_G.ActionButtonTextColor = actionButtonTextColor

	for _, actionButton in ipairs(_G.__ActionButtons) do
		if actionButton.icon and actionButton.icon.Parent then
			actionButton.icon.ImageColor3 = actionButtonTextColor
		end

		if actionButton.caption and actionButton.caption.Parent then
			actionButton.caption.TextColor3 = actionButtonTextColor
		end
	end
end

do
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegQuickShoot"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 95
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.QuickShootGui = screenGui
	local textButton = Instance.new("TextButton")
	textButton.Name = "ShootMurderer"
	textButton.AnchorPoint = Vector2.new(0, 0.5)
	textButton.Position = UDim2.new(0, 500, 0.38, 0)
	_G.__TrackButtonPosition("QuickShoot", textButton)
	textButton.AutoLocalize = false
	textButton.Parent = screenGui
	local v5 = _G.__StyleSquareButton(textButton, "__mm2_default_gun", "SHOOT", Color3.fromRGB(48, 145, 255))
	_G.QuickShootButtonRequested = false

	_G.QuickShootButtonSetEnabled = function(arg)
		_G.QuickShootButtonRequested = arg and true or false
		screenGui.Enabled = _G.QuickShootButtonRequested
	end

	textButton.MouseEnter:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(120, 195, 255), Transparency = 0 }):Play()
	end)

	textButton.MouseLeave:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(48, 145, 255), Transparency = 0.15 }):Play()
	end)

	local flag2 = false
	local flag3 = false
	local position = nil
	local position2 = nil
	local v6 = nil

	textButton.InputBegan:Connect(function(input)
		if _G.LockButtonsEnabled then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = true
			flag3 = false
			position = input.Position
			position2 = textButton.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag2 = false
				end
			end)
		end
	end)

	textButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v6 = input
		end
	end)

	table.insert(_G.CoinESPConn, UserInputService.InputChanged:Connect(function(input)
		if flag2 and input == v6 then
			local n2 = input.Position - position

			if n2.Magnitude > 6 then
				flag3 = true
			end

			textButton.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n2.X, position2.Y.Scale, position2.Y.Offset + n2.Y)
		end
	end))

	textButton.Activated:Connect(function()
		if flag3 or flag then
			return
		end

		if not _G.InRound or not _G.__RealInRound then
			if _G.WindNotify then
				_G.WindNotify("Shoot Murderer (LEGIT)", "You are not in an active round.", "circle-x")
			end

			return
		end

		if not fn8() then
			if _G.WindNotify then
				_G.WindNotify("Shoot Murderer (LEGIT)", "Sheriff gun required.", "circle-x")
			end

			return
		end

		if not fn7() then
			if _G.WindNotify then
				_G.WindNotify("Shoot Murderer (LEGIT)", "No living murderer found.", "circle-x")
			end

			return
		end

		task.spawn(function()
			local v7 = _G.ShootMurderer()

			if _G.WindNotify then
				if v7 then
					_G.WindNotify("Shoot Murderer (LEGIT)", "Shot fired.", "circle-check")
				else
					_G.WindNotify("Shoot Murderer (LEGIT)", _G.ShootMurdererStatus or "Shot could not be fired.", "circle-x")
				end
			end
		end)
	end)

	local quickShootLoopId = {}
	_G.__QuickShootLoopId = quickShootLoopId

	task.spawn(function()
		while _G.__QuickShootLoopId == quickShootLoopId and textButton.Parent do
			task.wait(0.2)
			screenGui.Enabled = _G.QuickShootButtonRequested
		end
	end)
end

do
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegQuickRageShoot"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 96
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.QuickRageShootGui = screenGui
	local textButton = Instance.new("TextButton")
	textButton.Name = "ShootMurdererRage"
	textButton.AnchorPoint = Vector2.new(0, 0.5)
	textButton.Position = UDim2.new(0, 584, 0.38, 0)
	_G.__TrackButtonPosition("RageShoot", textButton)
	textButton.Active = true
	textButton.AutoLocalize = false
	textButton.Parent = screenGui
	local v5 = _G.__StyleSquareButton(textButton, "__mm2_default_gun", "RAGE\nSHOOT", Color3.fromRGB(64, 178, 255))
	_G.QuickRageShootButtonRequested = false

	_G.QuickRageShootButtonSetEnabled = function(arg)
		_G.QuickRageShootButtonRequested = arg and true or false
		screenGui.Enabled = _G.QuickRageShootButtonRequested
	end

	textButton.MouseEnter:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(140, 210, 255), Transparency = 0 }):Play()
	end)

	textButton.MouseLeave:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(64, 178, 255), Transparency = 0.1 }):Play()
	end)

	local flag2 = false
	local flag3 = false
	local position = nil
	local position2 = nil
	local v6 = nil

	textButton.InputBegan:Connect(function(input)
		if _G.LockButtonsEnabled then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = true
			flag3 = false
			position = input.Position
			position2 = textButton.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag2 = false
				end
			end)
		end
	end)

	textButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v6 = input
		end
	end)

	table.insert(_G.CoinESPConn, UserInputService.InputChanged:Connect(function(input)
		if flag2 and input == v6 then
			local n2 = input.Position - position

			if n2.Magnitude > 6 then
				flag3 = true
			end

			textButton.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n2.X, position2.Y.Scale, position2.Y.Offset + n2.Y)
		end
	end))

	textButton.Activated:Connect(function()
		if flag3 or flag then
			return
		end

		task.spawn(function()
			local v7 = _G.ShootMurdererRage()

			if _G.WindNotify then
				_G.WindNotify("Shoot Murderer (RAGE)", v7 and "Shot fired." or _G.ShootMurdererRageStatus or "Shot failed.", v7 and "crosshair" or "circle-x")
			end
		end)
	end)
end

_G.BulletTracerEnabled = true
_G.BulletTracerDuration = 0.8
_G.BulletTracerOnlyMine = true

do
	local Debris = game:GetService("Debris")

	if _G.__BulletTracerConn then
		pcall(function()
			_G.__BulletTracerConn:Disconnect()
		end)
	end

	local marbegBulletTracers = workspace:FindFirstChild("MarbegBulletTracers")

	if marbegBulletTracers then
		pcall(function()
			marbegBulletTracers:Destroy()
		end)
	end

	local folder = Instance.new("Folder")
	folder.Name = "MarbegBulletTracers"
	folder.Parent = workspace
	_G.BulletTracerFolder = folder
	_G.BulletTracerWidth = 0.25
	_G.BulletTracerSelfColor = _G.BulletTracerSelfColor or Color3.fromRGB(45, 155, 255)

	if typeof(_G.BulletTracerSelfColor) == "Color3" and math.abs(_G.BulletTracerSelfColor.R - 0.70588235294117652) < 0.001 and math.abs(_G.BulletTracerSelfColor.G - 0.23529411764705882) < 0.001 and math.abs(_G.BulletTracerSelfColor.B - 1) < 0.001 then
		_G.BulletTracerSelfColor = Color3.fromRGB(45, 155, 255)
	end

	_G.BulletTracerOtherColor = Color3.fromRGB(255, 70, 70)

	if _G.BulletTracerGlow == nil then
		_G.BulletTracerGlow = true
	end

	local function fn12(arg)
		if typeof(arg) == "Vector3" then
			return arg
		end

		if typeof(arg) ~= "Instance" then
			return nil
		end

		if arg:IsA("BasePart") then
			return arg.Position
		end

		if arg:IsA("Attachment") then
			return arg.WorldPosition
		end
		return nil
	end

	local function fn13(arg, arg2)
		if typeof(arg) == "Instance" then
			local model = arg:FindFirstAncestorWhichIsA("Model")
			local playerFromCharacter = model and Players:GetPlayerFromCharacter(model)
			if playerFromCharacter then
				return playerFromCharacter
			end
		end

		if typeof(arg2) ~= "Vector3" then
			return nil
		end
		local n2 = 14
		local v5 = nil

		for _, player in ipairs(Players:GetPlayers()) do
			local character = player.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if character then
				local magnitude = (character.Position - arg2).Magnitude

				if magnitude < n2 then
					n2 = magnitude
					v5 = player
				end
			end
		end

		return v5
	end

	local function tracerMuzzleOf(arg, arg2, arg3)
		arg = arg and arg.Character
		if not arg then
			return arg2
		end
		local v5 = nil

		for _, child in ipairs(arg:GetChildren()) do
			if child:IsA("Tool") and child:FindFirstChild("Handle") then
				v5 = child
				break
			else
				v5 = nil
			end
		end

		if not v5 then
			return arg2
		end

		for _, descendant in ipairs(v5:GetDescendants()) do
			if descendant:IsA("Attachment") then
				local v6 = string.lower(descendant.Name)
				if v6:find("muzzle") or v6:find("barrel") or v6:find("fire") or v6:find("tip") or v6:find("shoot") then
					return descendant.WorldPosition
				end
			end
		end

		local handle = v5:FindFirstChild("Handle")
		if not handle or not handle:IsA("BasePart") then
			return arg2
		end
		local n2 = arg3 - arg2
		if n2.Magnitude < 0.05 then
			return handle.Position
		end
		local unit = n2.Unit
		local cFrame = handle.CFrame
		local n3 = handle.Size * 0.5
		local x = n3.X
		local upVector = cFrame.UpVector
		local y = n3.Y
		local n4 = math.abs(cFrame.RightVector:Dot(unit)) * x + math.abs(upVector:Dot(unit)) * y
		local lookVector = cFrame.LookVector
		local z = n3.Z
		return handle.Position + unit * (n4 + math.abs(lookVector:Dot(unit)) * z)
	end

	_G.__TracerMuzzleOf = tracerMuzzleOf

	local function createPart(color, arg, arg2, transparency)
		local part = Instance.new("Part")
		part.Shape = Enum.PartType.Ball
		part.Material = Enum.Material.Neon
		part.Color = color
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.CastShadow = false
		part.Size = Vector3.new(arg, arg, arg)
		part.CFrame = CFrame.new(arg2)
		part.Transparency = transparency
		part.Parent = folder
		return part
	end

	local function fn14(parent, color, brightness, range, arg)
		local pointLight = Instance.new("PointLight")
		pointLight.Color = color
		pointLight.Brightness = brightness
		pointLight.Range = range
		pointLight.Shadows = false
		pointLight.Parent = parent

		pcall(function()
			TweenService:Create(pointLight, TweenInfo.new(arg), { Brightness = 0 }):Play()
		end)

		Debris:AddItem(pointLight, arg + 0.05)
	end

	local texture = "rbxasset://textures/particles/sparkles_main.dds"

	local function fn15(arg, arg2)
		local v5 = createPart(arg2, 0.1, arg, 1)
		local particleEmitter = Instance.new("ParticleEmitter")
		particleEmitter.Texture = texture
		particleEmitter.Color = ColorSequence.new(Color3.new(1, 1, 1), arg2)
		particleEmitter.LightEmission = 1
		particleEmitter.LightInfluence = 0
		local new = NumberSequenceKeypoint.new
		particleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.14), new(1, 0) })
		local new2 = NumberSequenceKeypoint.new
		particleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.2), new2(1, 1) })
		particleEmitter.Lifetime = NumberRange.new(0.08, 0.22)
		particleEmitter.Speed = NumberRange.new(9, 20)
		particleEmitter.SpreadAngle = Vector2.new(180, 180)
		particleEmitter.Acceleration = Vector3.new(0, -55, 0)
		particleEmitter.Drag = 8
		particleEmitter.Rate = 0
		particleEmitter.Rotation = NumberRange.new(0, 360)
		particleEmitter.Parent = v5
		particleEmitter:Emit(7)
		Debris:AddItem(v5, 0.5)
	end

	local function createAttachment(worldPosition)
		local attachment = Instance.new("Attachment")
		attachment.WorldPosition = worldPosition
		attachment.Parent = workspace.Terrain
		return attachment
	end

	local function createBeam(attachment0, attachment1, arg, width0, lightEmission)
		local beam = Instance.new("Beam")
		beam.Attachment0 = attachment0
		beam.Attachment1 = attachment1
		beam.Color = typeof(arg) == "ColorSequence" and arg or ColorSequence.new(arg)
		beam.Width0 = width0
		beam.Width1 = width0
		beam.FaceCamera = true
		beam.LightEmission = lightEmission
		beam.LightInfluence = 0
		beam.Segments = 1
		beam.Transparency = NumberSequence.new(0)
		beam.Parent = workspace.Terrain
		return beam
	end

	local function fn16(arg, arg2)
		local n2 = math.clamp(arg, 0, 0.98)
		local n3 = math.min(n2 + 0.08, 0.999)
		if n2 <= 0.001 then
			local new = NumberSequenceKeypoint.new
			return NumberSequence.new({ NumberSequenceKeypoint.new(0, arg2), new(1, arg2) })
		end
		local numberSequence = NumberSequence.new
		local tbl5 = {}
		local v5 = NumberSequenceKeypoint.new(0, 1)
		local v6 = NumberSequenceKeypoint.new(n2, 1)
		local v7 = NumberSequenceKeypoint.new(n3, arg2)
		local new = NumberSequenceKeypoint.new
		tbl5[1] = v5
		tbl5[2] = v6
		tbl5[3] = v7

		do
			local values = table.pack(new(1, arg2))
			table.move(values, 1, values.n, 4, tbl5)
		end

		return numberSequence(tbl5)
	end

	local function fn17(arg, worldPosition, arg2)
		local n2 = math.clamp(tonumber(_G.BulletTracerDuration) or 0.8, 0.15, 4)
		local n3 = math.clamp(tonumber(_G.BulletTracerWidth) or 0.25, 0.03, 1.5)
		local n4 = worldPosition - arg
		local magnitude = n4.Magnitude
		if magnitude < 0.2 then
			return
		end
		local flag2 = _G.BulletTracerGlow ~= false
		local color = Color3.new(1, 1, 1)
		local v5 = arg2:Lerp(color, 0.8)
		local v6 = arg2:Lerp(color, 0.35)
		local colorSequence = ColorSequence.new(v6, arg2)
		local v7 = createAttachment(arg)
		local v8 = createAttachment(arg)
		local v9 = createAttachment(arg)
		local tbl5 = { { beam = createBeam(v7, v8, v5, n3 * 0.22, 1), alpha = 0, width = n3 * 0.22 } }

		if flag2 then
			tbl5[#tbl5 + 1] = { beam = createBeam(v7, v8, colorSequence, n3 * 0.9, 1), alpha = 0.4, width = n3 * 0.9 }
			tbl5[#tbl5 + 1] = { beam = createBeam(v7, v8, colorSequence, n3 * 2.4, 1), alpha = 0.84, width = n3 * 2.4 }
			local v10 = createBeam(v7, v8, ColorSequence.new(color, arg2), n3 * 1.6, 1)
			v10.Texture = "rbxasset://textures/particles/sparkles_main.dds"
			v10.TextureMode = Enum.TextureMode.Static
			v10.TextureLength = math.max(n3 * 7, 1)
			v10.TextureSpeed = 3
			tbl5[#tbl5 + 1] = { beam = v10, alpha = 0.15, width = n3 * 1.6 }
		end

		local v10 = createBeam(v9, v8, color, n3 * 0.8, 1)
		v10.Width0 = n3 * 0.15
		local v11 = flag2 and createBeam(v9, v8, arg2, n3 * 2.6, 1) or nil

		if v11 then
			v11.Width0 = n3 * 0.4
			v11.Transparency = NumberSequence.new(0.35)
		end

		for _, v12 in ipairs(tbl5) do
			v12.beam.Transparency = NumberSequence.new(v12.alpha)
		end

		local tbl6 = {}
		local unit = n4.Unit
		local unit2 = unit:Cross(math.abs(unit.Y) > 0.95 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit
		local unit3 = unit2:Cross(unit).Unit
		local n5 = n3 * 0.45

		if flag2 then
			local n6 = math.clamp(math.floor(magnitude / 0.125), 12, 180)
			local n7 = math.min(magnitude / 1.5, n6 / 12)
			local tbl7 = {}
			local tbl8 = { offset = 3.1415926535897931, from = color, to = arg2:Lerp(color, 0.45) }
			tbl7[1] = { offset = 0, from = v6, to = arg2 }
			tbl7[2] = tbl8

			for _, v12 in ipairs(tbl7) do
				local v13 = nil

				for i = 0, n6 do
					local n8 = i / n6
					local v14 = createAttachment(arg + n4 * n8)

					local tbl9 = {
						a = v14,
						along = n8,
						angle = n8 * n7 * 3.1415926535897931 * 2 + v12.offset,
						edge = math.clamp(math.min(n8, 1 - n8) / 0.1, 0, 1),
					}

					if v13 then
						local v15 = createBeam(v13.a, v14, v12.from:Lerp(v12.to, n8), n3 * 0.045, 1)
						v15.Enabled = false
						tbl9.beam = v15
					end

					tbl6[#tbl6 + 1] = tbl9
					v13 = tbl9
				end
			end
		end

		local function fn18(arg3, arg4, arg5, arg6)
			for _, v12 in ipairs(tbl6) do
				local n6 = v12.angle + arg4
				local v13 = unit3
				v12.a.WorldPosition = arg + n4 * v12.along + (unit2 * math.cos(n6) + v13 * math.sin(n6)) * arg3

				if v12.beam then
					v12.beam.Enabled = v12.along <= arg5
					v12.beam.Transparency = NumberSequence.new(1 - (1 - arg6) * v12.edge)
				end
			end
		end

		local n6 = math.clamp(magnitude / 700, 0.035, 0.1)
		local n7 = math.min(magnitude * 0.25, 4)
		local now = os.clock()
		local flag3 = false
		local connection2 = nil

		local function fn19()
			if connection2 and connection2.Connected then
				connection2:Disconnect()
			end

			for _, v12 in ipairs(tbl5) do
				pcall(function()
					v12.beam:Destroy()
				end)
			end

			pcall(function()
				v10:Destroy()
			end)

			if v11 then
				pcall(function()
					v11:Destroy()
				end)
			end

			for _, v12 in ipairs(tbl6) do
				if v12.beam then
					pcall(function()
						v12.beam:Destroy()
					end)
				end

				pcall(function()
					v12.a:Destroy()
				end)
			end

			for _, v12 in ipairs({ v7, v8, v9 }) do
				pcall(function()
					v12:Destroy()
				end)
			end
		end

		connection2 = RunService.RenderStepped:Connect(function()
			local n8 = os.clock() - now

			if n8 < n6 then
				local n9 = n8 / n6
				v8.WorldPosition = arg + n4 * n9
				v9.WorldPosition = arg + n4 * math.max(0, n9 - n7 / magnitude)

				if #tbl6 > 0 then
					fn18(n5, n8 * 10, n9, 0.1)
				end

				return
			end

			v8.WorldPosition = worldPosition

			if not flag3 then
				flag3 = true

				pcall(function()
					v10:Destroy()
				end)

				if v11 then
					pcall(function()
						v11:Destroy()
					end)
				end

				if flag2 then
					local n9 = n3 * 2.2
					local v12 = createPart(arg2:Lerp(color, 0.5), n9, worldPosition, 0.35)
					fn14(v12, arg2, 2.5, 9, 0.15)

					pcall(function()
						local tbl7 = { Transparency = 1, Size = Vector3.one * n3 * 4 }
						TweenService:Create(v12, TweenInfo.new(0.14), tbl7):Play()
					end)

					Debris:AddItem(v12, 0.3)
					local v13 = createPart(arg2, 0.1, worldPosition, 1)
					local particleEmitter = Instance.new("ParticleEmitter")
					particleEmitter.Texture = "rbxasset://textures/particles/explosion01_shockwave_main.dds"
					particleEmitter.Color = ColorSequence.new(v5, arg2)
					particleEmitter.LightEmission = 1
					particleEmitter.LightInfluence = 0
					local new = NumberSequenceKeypoint.new
					local n10 = n3 * 9
					particleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, n3 * 1.5), new(1, n10) })
					local new2 = NumberSequenceKeypoint.new
					particleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.15), new2(1, 1) })
					particleEmitter.Lifetime = NumberRange.new(0.22)
					particleEmitter.Speed = NumberRange.new(0)
					particleEmitter.Rate = 0
					particleEmitter.Parent = v13
					particleEmitter:Emit(1)
					Debris:AddItem(v13, 0.4)
					pcall(fn15, worldPosition, arg2)
				end
			end

			local n9 = math.clamp((n8 - n6) / n2, 0, 1)
			local n10 = n9 ^ 0.8
			local n11 = n9 ^ 2

			for _, v12 in ipairs(tbl5) do
				v12.beam.Transparency = fn16(n10, v12.alpha + (1 - v12.alpha) * n11)
				local width1 = v12.width * (1 - 0.6 * n9)
				local beam = v12.beam
				v12.beam.Width0 = width1 * 0.6
				beam.Width1 = width1
			end

			if #tbl6 > 0 then
				fn18(n5 * (1 + 0.8 * (1 - (1 - n9) ^ 3)), n8 * 10, 1, math.min(1, 0.1 + n9 * 1.3))
			end

			if n9 >= 1 then
				fn19()
			end
		end)

		task.delay(n6 + n2 + 1, fn19)

		if flag2 then
			local v12 = createPart(v6, n3 * 2.4, arg, 0.3)
			local v13 = createPart(v5, n3 * 1.2, arg, 0)
			fn14(v12, arg2, 3, 10, 0.08)

			pcall(function()
				local tbl7 = { Transparency = 1, Size = Vector3.one * n3 * 4 }
				TweenService:Create(v12, TweenInfo.new(0.09), tbl7):Play()
				TweenService:Create(v13, TweenInfo.new(0.07), { Transparency = 1 }):Play()
			end)

			Debris:AddItem(v12, 0.2)
			Debris:AddItem(v13, 0.2)
		end
	end

	local ok, result = pcall(function()
		return require(ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("WeaponService"))
	end)

	if ok and result and result.GunFired then
		_G.__BulletTracerConn = result.GunFired.OnClientEvent:Connect(function(arg, arg2, arg3)
			if not _G.BulletTracerEnabled then
				return
			end
			local v5 = fn12(arg2)
			local v6 = fn12(arg3)
			if not v5 or not v6 then
				return
			end
			local v7 = fn13(arg, v5)
			if _G.BulletTracerOnlyMine and v7 ~= localPlayer then
				return
			end
			pcall(fn17, tracerMuzzleOf(v7, v5, v6), v6, v7 == localPlayer and (_G.BulletTracerSelfColor or Color3.fromRGB(45, 155, 255)) or _G.BulletTracerOtherColor or Color3.fromRGB(255, 70, 70))
		end)

		if type(_G.CoinESPConn) == "table" then
			table.insert(_G.CoinESPConn, _G.__BulletTracerConn)
		end
	else
		warn("Bullet tracer: WeaponService.GunFired unavailable")
	end

	_G.BulletTracerSetEnabled = function(arg)
		_G.BulletTracerEnabled = arg and true or false

		if not _G.BulletTracerEnabled then
			for _, child in ipairs(folder:GetChildren()) do
				pcall(function()
					child:Destroy()
				end)
			end
		end
	end

	_G.BulletTracerSetDuration = function(arg)
		_G.BulletTracerDuration = math.clamp(tonumber(arg) or 0.8, 0.15, 4)
	end

	_G.DrawBulletTracer = function(arg, arg2, arg3)
		if not _G.BulletTracerEnabled then
			return
		end

		if typeof(arg) ~= "Vector3" or typeof(arg2) ~= "Vector3" then
			return
		end
		local bulletTracerSelfColor = arg3 ~= false and (_G.BulletTracerSelfColor or Color3.fromRGB(45, 155, 255)) or _G.BulletTracerOtherColor or Color3.fromRGB(255, 70, 70)
		local v5

		if arg3 ~= false then
			v5 = tracerMuzzleOf(localPlayer, arg, arg2)
		else
			v5 = arg
		end

		pcall(fn17, v5, arg2, bulletTracerSelfColor)
	end
end

_G.BulletTracerSetOnlyMine = function(arg)
	_G.BulletTracerOnlyMine = arg and true or false
end

_G.BulletTracerSetWidth = function(arg)
	_G.BulletTracerWidth = math.clamp(tonumber(arg) or 0.25, 0.03, 1.5)
end

_G.BulletTracerSetSelfColor = function(bulletTracerSelfColor)
	if typeof(bulletTracerSelfColor) == "Color3" then
		_G.BulletTracerSelfColor = bulletTracerSelfColor
	end
end

_G.BulletTracerSetOtherColor = function(bulletTracerOtherColor)
	if typeof(bulletTracerOtherColor) == "Color3" then
		_G.BulletTracerOtherColor = bulletTracerOtherColor
	end
end

_G.BulletTracerSetGlow = function(arg)
	_G.BulletTracerGlow = arg and true or false
end

_G.DeathDissolveEnabled = true

if _G.__KillFxConns then
	for _, killFxConn in ipairs(_G.__KillFxConns) do
		pcall(function()
			killFxConn:Disconnect()
		end)
	end
end

do
	local killFxConns = {}
	_G.__KillFxConns = killFxConns
	local Debris = game:GetService("Debris")
	local color = Color3.new(1, 1, 1)

	local function fn12(arg)
		local roleColors = _G.__RoleColors
		return roleColors and roleColors[arg] or color
	end

	local tbl5 = {
		spark = "rbxasset://textures/particles/fire_sparks_main.dds",
		ember = "rbxasset://textures/particles/sparkles_main.dds",
		glow = "rbxasset://textures/particles/forcefield_glow_main.dds",
		ring = "rbxasset://textures/particles/explosion01_shockwave_main.dds",
	}

	local function fn13(arg, arg2)
		local new = NumberSequenceKeypoint.new
		return NumberSequence.new({ NumberSequenceKeypoint.new(0, arg), new(1, arg2) })
	end

	local function createParticleEmitter(parent, arg, arg2)
		local particleEmitter = Instance.new("ParticleEmitter")
		particleEmitter.LightEmission = 1
		particleEmitter.LightInfluence = 0
		particleEmitter.Rate = 0

		for k, v5 in pairs(arg) do
			particleEmitter[k] = v5
		end

		particleEmitter.Parent = parent

		if arg2 then
			particleEmitter:Emit(arg2)
		end

		return particleEmitter
	end

	local function createPart(parent, cFrame, size)
		local part = Instance.new("Part")
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.Transparency = 1
		part.Size = size or Vector3.new(0.2, 0.2, 0.2)
		part.CFrame = cFrame
		part.Parent = parent
		return part
	end

	local function playDeathDissolve(arg, color2)
		local tbl6 = {}
		local huge = math.huge
		local n2 = -math.huge

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" and descendant.Transparency < 0.9 then
				tbl6[#tbl6 + 1] = descendant
				huge = math.min(huge, descendant.Position.Y)
				n2 = math.max(n2, descendant.Position.Y)
			elseif descendant:IsA("Decal") then
				descendant.LocalTransparencyModifier = 1
			end
		end

		if #tbl6 == 0 then
			return
		end
		local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
		humanoidRootPart = humanoidRootPart and humanoidRootPart.Position or tbl6[1].Position
		local vector = Vector3.new(humanoidRootPart.X, huge - 0.4, humanoidRootPart.Z)
		local v5 = color2:Lerp(color, 0.75)
		local folder = Instance.new("Folder")
		folder.Name = "MarbegDissolve"
		folder.Parent = workspace
		Debris:AddItem(folder, 3.5)
		local v6 = createPart(folder, CFrame.new(humanoidRootPart))
		local pointLight = Instance.new("PointLight")
		pointLight.Color = color2
		pointLight.Range = 11
		pointLight.Brightness = 3.5
		pointLight.Parent = v6
		TweenService:Create(pointLight, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Brightness = 0 }):Play()

		createParticleEmitter(v6, {
			Texture = tbl5.glow,
			Color = ColorSequence.new(v5, color2),
			Size = fn13(1.2, 4.5),
			Transparency = fn13(0.4, 1),
			Lifetime = NumberRange.new(0.45),
			Speed = NumberRange.new(0),
		}, 2)

		createParticleEmitter(createPart(folder, CFrame.new(vector)), {
			Texture = tbl5.ring,
			Color = ColorSequence.new(v5, color2),
			Orientation = Enum.ParticleOrientation.VelocityPerpendicular,
			EmissionDirection = Enum.NormalId.Top,
			Speed = NumberRange.new(0.01),
			Size = fn13(1, 16),
			Transparency = fn13(0.1, 1),
			Lifetime = NumberRange.new(0.6),
		}, 1)

		local part = Instance.new("Part")
		part.Anchored = true
		part.CanCollide = false
		part.CanQuery = false
		part.CanTouch = false
		part.CastShadow = false
		part.Material = Enum.Material.Neon
		part.Color = v5
		part.Transparency = 0.15
		part.Size = Vector3.new(0.35, 0.1, 0.35)
		part.CFrame = CFrame.new(vector)
		part.Parent = folder

		TweenService:Create(part, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = Vector3.new(0.12, 30, 0.12),
			CFrame = CFrame.new(vector + Vector3.new(0, 15, 0)),
			Transparency = 1,
			Color = color2,
		}):Play()

		local n3 = math.max(n2 - huge, 0.5)
		local tweenInfo = TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		local shellCopy = _G.__ShellCopy

		for _, v7 in ipairs(tbl6) do
			v7.LocalTransparencyModifier = 1
			local v8 = shellCopy and shellCopy(v7, 1.03)

			if v8 then
				v8.Color = v5
				v8.Transparency = 0
				v8.CFrame = v7.CFrame
				v8.Parent = folder
			end

			local cFrame = v7.CFrame
			local size = v7.Size

			task.delay(0.05 + (v7.Position.Y - huge) / n3 * 0.5, function()
				if not folder.Parent then
					return
				end

				if v8 then
					TweenService:Create(v8, tweenInfo, { Color = color2, Transparency = 1, Size = v8.Size * 0.55 }):Play()
				end

				local v9 = createPart(folder, cFrame, size)

				createParticleEmitter(v9, {
					Texture = tbl5.spark,
					Color = ColorSequence.new(v5, color2),
					Size = fn13(0.3, 0),
					Transparency = fn13(0, 1),
					Lifetime = NumberRange.new(0.35, 0.7),
					Speed = NumberRange.new(5, 11),
					SpreadAngle = Vector2.new(180, 180),
					Drag = 4,
					Acceleration = Vector3.new(0, -6, 0),
					Shape = Enum.ParticleEmitterShape.Box,
					ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
				}, 10)

				createParticleEmitter(v9, {
					Texture = tbl5.ember,
					Color = ColorSequence.new(color2:Lerp(color, 0.4), color2),
					Size = fn13(0.55, 0),
					Transparency = fn13(0.15, 1),
					Lifetime = NumberRange.new(1, 2),
					Speed = NumberRange.new(0.5, 2.5),
					SpreadAngle = Vector2.new(180, 180),
					Drag = 1.5,
					Acceleration = Vector3.new(0, 6, 0),
					RotSpeed = NumberRange.new(-90, 90),
					Shape = Enum.ParticleEmitterShape.Box,
					ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume,
				}, 5)
			end)
		end
	end

	_G.__PlayDeathDissolve = playDeathDissolve
	local tbl6 = {}
	local role = nil
	local n2 = 0

	local function fn14()
		local playerData = CurrentRoundClient.PlayerData
		if type(playerData) ~= "table" then
			return
		end
		local flag2 = false

		for k, v5 in pairs(playerData) do
			if type(v5) == "table" and v5.Role and v5.Role ~= "Lobby" then
				if not v5.Dead then
					tbl6[k] = v5.Role
				end

				local flag3 = k == localPlayer.Name and not v5.Dead
				flag2 = true

				if flag3 then
					role = v5.Role
				end
			end
		end

		if not flag2 and not _G.__RealInRound then
			role = nil
		end
	end

	table.insert(killFxConns, CurrentRoundClient.PlayerDataChanged.Event:Connect(function()
		pcall(fn14)
	end))

	local n3 = 0

	table.insert(killFxConns, RunService.Heartbeat:Connect(function()
		local now = os.clock()
		if now - n3 < 0.25 then
			return
		end
		n3 = now
		pcall(fn14)
	end))

	local tbl7 = {}

	table.insert(killFxConns, workspace.DescendantAdded:Connect(function(descendant)
		if descendant.Name == "Raggy" and descendant:IsA("Model") then
			tbl7[#tbl7 + 1] = { model = descendant, at = os.clock() }

			if #tbl7 > 20 then
				table.remove(tbl7, 1)
			end
		end
	end))

	local function fn15(arg, arg2)
		local n4 = 10
		local model = nil

		for _, v5 in ipairs(tbl7) do
			if v5.at >= arg2 - 0.5 and v5.model.Parent then
				local ok, result = pcall(function()
					return v5.model:GetPivot().Position
				end)

				local magnitude = ok and (result - arg).Magnitude

				if magnitude and magnitude < n4 then
					model = v5.model
					n4 = magnitude
				end
			end
		end

		return model
	end

	local function fn16(arg, arg2)
		if arg == localPlayer then
			return
		end
		local v5 = tbl6[arg.Name]
		if not role or not v5 then
			return
		end

		if not (role == "Murderer" or (role == "Sheriff" or role == "Hero") and (v5 == "Murderer" or os.clock() - n2 < 1)) and not _G.__DissolveAllDeaths then
			return
		end
		local humanoidRootPart = arg2:FindFirstChild("HumanoidRootPart")
		local position = humanoidRootPart and humanoidRootPart.Position
		local v6 = pairs
		local myKillListeners = _G.__MyKillListeners or {}

		for _, myKillListener in v6(myKillListeners) do
			pcall(myKillListener, { name = arg.Name, role = v5, position = position, character = arg2 })
		end

		if not _G.DeathDissolveEnabled then
			return
		end
		local now = os.clock()
		local v7 = fn12(v5)

		task.spawn(function()
			local v8

			while true do
				if position and os.clock() - now < 0.4 then
					v8 = fn15(position, now)
					if not v8 then
						task.wait()
						continue
					end
				end

				break
			end

			_G.__LastDissolveTarget = v8 and v8:GetFullName() or "character (no ragdoll found)"
			pcall(playDeathDissolve, v8 or arg2, v7)
		end)
	end

	local function fn17(arg, arg2)
		local humanoid = arg2:FindFirstChildWhichIsA("Humanoid") or arg2:WaitForChild("Humanoid", 10)
		if not humanoid then
			return
		end
		local flag2 = false

		table.insert(killFxConns, humanoid.Died:Connect(function()
			if flag2 then
				return
			end
			flag2 = true
			fn16(arg, arg2)
		end))
	end

	local function fn18(player)
		if player == localPlayer then
			return
		end

		if player.Character then
			task.spawn(fn17, player, player.Character)
		end

		table.insert(killFxConns, player.CharacterAdded:Connect(function(character)
			fn17(player, character)
		end))
	end

	for _, player in ipairs(Players:GetPlayers()) do
		fn18(player)
	end

	table.insert(killFxConns, Players.PlayerAdded:Connect(fn18))

	local ok, result = pcall(function()
		return require(ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("WeaponService"))
	end)

	if ok and result and result.GunFired then
		table.insert(killFxConns, result.GunFired.OnClientEvent:Connect(function(arg, arg2)
			local position = typeof(arg2) == "Vector3" and arg2 or typeof(arg2) == "Instance" and arg2:IsA("BasePart") and arg2.Position

			if not position then
				position = typeof(arg2) == "Instance" and arg2:IsA("Attachment") and arg2.WorldPosition
			end

			local character = localPlayer.Character
			local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
			local flag2 = typeof(arg) == "Instance" and character and arg:IsDescendantOf(character)

			if not flag2 and position and humanoidRootPart then
				flag2 = (humanoidRootPart.Position - position).Magnitude < 14
			end

			if flag2 then
				n2 = os.clock()
			end
		end))
	end

	for _, killFxConn in ipairs(killFxConns) do
		table.insert(_G.CoinESPConn, killFxConn)
	end

	_G.DeathDissolveSetEnabled = function(arg)
		_G.DeathDissolveEnabled = arg and true or false
	end

	_G.DeathDissolvePreview = function()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return false, "No character"
		end
		local archivable = character.Archivable
		character.Archivable = true
		local clone = character:Clone()
		character.Archivable = archivable
		if not clone then
			return false, "Could not copy your character"
		end

		for _, descendant in ipairs(clone:GetDescendants()) do
			if descendant:IsA("BaseScript") or descendant:IsA("Tool") then
				descendant:Destroy()
			elseif descendant:IsA("BasePart") then
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanQuery = false
			end
		end

		local humanoid = clone:FindFirstChildWhichIsA("Humanoid")

		if humanoid then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		end

		local n4 = workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)
		local unit = n4.Magnitude > 0.01 and n4.Unit or Vector3.new(0, 0, -1)
		local n5 = humanoidRootPart.Position + unit * 8
		clone:PivotTo(CFrame.lookAt(n5, n5 - unit))
		clone.Parent = workspace
		Debris:AddItem(clone, 4)
		task.wait(0.35)
		playDeathDissolve(clone, fn12("Murderer"))
		return true, "Playing"
	end

	_G.__DeathDissolveState = function()
		return role, tbl6, n2
	end
end

_G.WorldTime = "Default"
_G.WorldFullbright = false
_G.WorldNoFog = false
_G.WorldSky = "Default"
_G.WorldColor = false
_G.WorldSaturation = 0.15
_G.WorldContrast = 0.1
_G.WorldBrightness = 0
_G.WorldTint = Color3.new(1, 1, 1)
_G.WorldBloom = false
_G.WorldBloomIntensity = 1.2
_G.WorldTimeList = { "Default", "Day", "Sunset", "Night" }
_G.WorldSkyList = { "Default", "Purple Haze", "Blood Moon", "Ocean", "Toxic", "Golden Hour" }

do
	local Lighting = game:GetService("Lighting")

	if _G.WorldVisualsReset then
		pcall(_G.WorldVisualsReset)
	end

	local color = Color3.fromRGB

	local tbl5 = {
		["Purple Haze"] = { Color = color(185, 130, 255), Decay = color(95, 45, 170), Haze = 2, Glare = 0.4 },
		["Blood Moon"] = { Color = color(255, 95, 85), Decay = color(125, 20, 25), Haze = 2.2, Glare = 0.3 },
		Ocean = { Color = color(125, 205, 255), Decay = color(40, 110, 205), Haze = 1.6, Glare = 0.3 },
		Toxic = { Color = color(160, 255, 125), Decay = color(40, 145, 55), Haze = 2, Glare = 0.25 },
		["Golden Hour"] = { Color = color(255, 205, 125), Decay = color(205, 115, 50), Haze = 1.8, Glare = 0.6 },
	}

	local tbl6 = {}

	local function fn12(arg, arg2)
		if typeof(arg) == "number" and typeof(arg2) == "number" then
			return math.abs(arg - arg2) < 0.001
		end

		if typeof(arg) == "Color3" and typeof(arg2) == "Color3" then
			return math.abs(arg.R - arg2.R) < 0.005 and math.abs(arg.G - arg2.G) < 0.005 and math.abs(arg.B - arg2.B) < 0.005
		end
		return arg == arg2
	end

	local function fn13(arg, arg2, value)
		local v5 = tbl6[arg]
		local tbl7 = v5 and v5[arg2]

		if value == nil then
			if tbl7 then
				tbl7.conn:Disconnect()
				v5[arg2] = nil

				pcall(function()
					arg[arg2] = tbl7.original
				end)
			end

			return
		end

		if not tbl7 then
			local ok, result = pcall(function()
				return arg[arg2]
			end)

			if not ok then
				return
			end
			tbl7 = { original = result, value = value }

			tbl7.conn = arg:GetPropertyChangedSignal(arg2):Connect(function()
				local v6 = arg[arg2]

				if not fn12(v6, tbl7.value) then
					tbl7.original = v6
					arg[arg2] = tbl7.value
				end
			end)

			tbl6[arg] = v5 or {}
			tbl6[arg][arg2] = tbl7
		end

		tbl7.value = value

		if not fn12(arg[arg2], value) then
			pcall(function()
				arg[arg2] = value
			end)
		end
	end

	local function fn14(arg)
		local v5 = tbl6[arg]
		if not v5 then
			return
		end

		for k in pairs(v5) do
			fn13(arg, k, nil)
		end

		tbl6[arg] = nil
	end

	local function fn15(arg, name)
		local v5 = Lighting:FindFirstChild(name)

		if not v5 then
			local instance = Instance.new(arg)
			instance.Name = name
			instance:SetAttribute("MarbegKeep", true)
			instance.Parent = Lighting
			v5 = instance
		end

		return v5
	end

	local function fn16(arg)
		local v5 = Lighting:FindFirstChild(arg)

		if v5 then
			fn14(v5)
			v5:Destroy()
		end
	end

	local tbl7 = {
		"ClockTime",
		"Brightness",
		"Ambient",
		"OutdoorAmbient",
		"GlobalShadows",
		"FogEnd",
		"FogStart",
	}

	local tbl8 = { "Density", "Color", "Decay", "Haze", "Glare" }

	local function fn17()
		local tbl9 = {}
		local worldTime = _G.WorldTime

		if worldTime == "Day" then
			tbl9.ClockTime = 14
		elseif worldTime == "Sunset" then
			tbl9.ClockTime = 17.7
		elseif worldTime == "Night" then
			tbl9.ClockTime = 0
			tbl9.Brightness = 0.6
			tbl9.Ambient = color(35, 35, 60)
			tbl9.OutdoorAmbient = color(45, 45, 85)
		end

		if _G.WorldFullbright then
			tbl9.Ambient = color(170, 170, 170)
			tbl9.OutdoorAmbient = color(170, 170, 170)
			tbl9.GlobalShadows = false

			if worldTime ~= "Night" then
				tbl9.Brightness = 2.5
			end
		end

		if _G.WorldNoFog then
			tbl9.FogStart = 1000000
			tbl9.FogEnd = 1000000
		end

		for _, v5 in ipairs(tbl7) do
			fn13(Lighting, v5, tbl9[v5])
		end

		local v5 = tbl5[_G.WorldSky]
		local tbl10 = {}

		for _, child in ipairs(Lighting:GetChildren()) do
			if child:IsA("Atmosphere") and not child:GetAttribute("MarbegKeep") then
				tbl10[#tbl10 + 1] = child
			end
		end

		if v5 and #tbl10 == 0 then
			local Atmosphere = fn15("Atmosphere", "MarbegAtmosphere")
			Atmosphere.Offset = 0.2
			tbl10[1] = Atmosphere
		else
			fn16("MarbegAtmosphere")
		end

		for _, v6 in ipairs(tbl10) do
			local tbl11 = {}

			if v5 then
				for k, v7 in pairs(v5) do
					tbl11[k] = v7
				end

				tbl11.Density = (_G.WorldNoFog or _G.WorldTime == "Night") and 0.12 or 0.22
			elseif _G.WorldNoFog then
				tbl11.Density = 0
				tbl11.Haze = 0
			end

			for _, v7 in ipairs(tbl8) do
				fn13(v6, v7, tbl11[v7])
			end
		end

		if _G.WorldColor then
			local ColorCorrectionEffect = fn15("ColorCorrectionEffect", "MarbegColor")
			ColorCorrectionEffect.Saturation = _G.WorldSaturation
			ColorCorrectionEffect.Contrast = _G.WorldContrast
			ColorCorrectionEffect.Brightness = _G.WorldBrightness
			ColorCorrectionEffect.TintColor = _G.WorldTint
			ColorCorrectionEffect.Enabled = true
		else
			fn16("MarbegColor")
		end

		if _G.WorldBloom then
			local BloomEffect = fn15("BloomEffect", "MarbegBloom")
			BloomEffect.Intensity = _G.WorldBloomIntensity
			BloomEffect.Size = 28
			BloomEffect.Threshold = 0.9
			BloomEffect.Enabled = true
		else
			fn16("MarbegBloom")
		end
	end

	_G.WorldVisualsApply = function()
		pcall(fn17)
	end

	local connection2 = Lighting.ChildAdded:Connect(function(child)
		if child:IsA("Atmosphere") then
			task.defer(_G.WorldVisualsApply)
		end
	end)

	table.insert(_G.CoinESPConn, connection2)

	_G.WorldVisualsReset = function()
		connection2:Disconnect()

		for k in pairs(tbl6) do
			fn14(k)
		end

		fn16("MarbegAtmosphere")
		fn16("MarbegColor")
		fn16("MarbegBloom")
	end
end

do
	local function fn12(arg, arg2)
		return function(arg3)
			_G[arg] = arg2 and arg2(arg3) or arg3
			_G.WorldVisualsApply()
		end
	end

	local function fn13(arg)
		return arg and true or false
	end

	_G.WorldSetTime = fn12("WorldTime")
	_G.WorldSetFullbright = fn12("WorldFullbright", fn13)
	_G.WorldSetNoFog = fn12("WorldNoFog", fn13)
	_G.WorldSetSky = fn12("WorldSky")
	_G.WorldSetColor = fn12("WorldColor", fn13)
	_G.WorldSetSaturation = fn12("WorldSaturation", tonumber)
	_G.WorldSetContrast = fn12("WorldContrast", tonumber)
	_G.WorldSetBrightness = fn12("WorldBrightness", tonumber)
	_G.WorldSetTint = fn12("WorldTint")
	_G.WorldSetBloom = fn12("WorldBloom", fn13)
	_G.WorldSetBloomIntensity = fn12("WorldBloomIntensity", tonumber)
end

do
	local ok, result = pcall(function()
		return require(ReplicatedStorage.Database.Sync)
	end)

	local emoteList = {}

	if ok and type(result) == "table" and type(result.Emotes) == "table" then
		for k, emote in pairs(result.Emotes) do
			if type(emote) == "table" and emote.AnimationID then
				emoteList[#emoteList + 1] = k
			end
		end
	end

	table.sort(emoteList)
	_G.EmoteList = emoteList

	_G.PlayEmote = function(arg)
		local playEmote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Misc") and ReplicatedStorage.Remotes.Misc:FindFirstChild("PlayEmote")
		if not playEmote then
			return false, "Emote event unavailable"
		end
		playEmote:Fire(arg)
		return true, arg
	end

	_G.StopEmotes = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChildWhichIsA("Humanoid")
		character = character and character:FindFirstChildWhichIsA("Animator")
		if not character then
			return false, "No character"
		end
		local tbl5 = {}

		for _, v5 in ipairs(emoteList) do
			tbl5[v5] = true
		end

		local n2 = 0

		for _, v5 in ipairs(character:GetPlayingAnimationTracks()) do
			if tbl5[v5.Name] then
				v5:Stop(0.2)
				n2 += 1
			end
		end

		return true, n2 > 0 and "Stopped" or "Nothing playing"
	end
end

_G.CameraFOVEnabled = false
_G.CameraFOV = 80
_G.CameraZoomEnabled = false
_G.CameraMaxZoom = 40

do
	local fieldOfView = nil
	local cameraMaxZoomDistance = nil

	local function fn12()
		pcall(function()
			RunService:UnbindFromRenderStep("MarbegCameraFOV")
		end)

		local currentCamera = workspace.CurrentCamera

		if _G.CameraFOVEnabled then
			if fieldOfView == nil and currentCamera then
				fieldOfView = currentCamera.FieldOfView
			end

			RunService:BindToRenderStep("MarbegCameraFOV", Enum.RenderPriority.Camera.Value + 4, function()
				local currentCamera2 = workspace.CurrentCamera

				if currentCamera2 and not _G.__KillCamActive and not _G.StretchModeEnabled then
					currentCamera2.FieldOfView = _G.CameraFOV
				end
			end)
		elseif fieldOfView ~= nil then
			if currentCamera then
				pcall(function()
					currentCamera.FieldOfView = fieldOfView
				end)
			end

			fieldOfView = nil
		end
	end

	local connection2 = nil

	local function fn13()
		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end

		if _G.CameraZoomEnabled then
			if cameraMaxZoomDistance == nil then
				cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance
			end

			localPlayer.CameraMaxZoomDistance = _G.CameraMaxZoom

			connection2 = localPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
				if math.abs(localPlayer.CameraMaxZoomDistance - _G.CameraMaxZoom) > 0.01 then
					cameraMaxZoomDistance = localPlayer.CameraMaxZoomDistance
					localPlayer.CameraMaxZoomDistance = _G.CameraMaxZoom
				end
			end)

			table.insert(_G.CoinESPConn, connection2)
		elseif cameraMaxZoomDistance ~= nil then
			pcall(function()
				localPlayer.CameraMaxZoomDistance = cameraMaxZoomDistance
			end)

			cameraMaxZoomDistance = nil
		end
	end

	_G.CameraSetFOVEnabled = function(arg)
		_G.CameraFOVEnabled = arg and true or false
		fn12()
	end

	_G.CameraSetFOV = function(arg)
		_G.CameraFOV = math.clamp(tonumber(arg) or 80, 30, 120)
	end

	_G.CameraSetZoomEnabled = function(arg)
		_G.CameraZoomEnabled = arg and true or false
		fn13()
	end

	_G.CameraSetMaxZoom = function(arg)
		_G.CameraMaxZoom = math.clamp(tonumber(arg) or 40, 15, 400)

		if _G.CameraZoomEnabled then
			fn13()
		end
	end

	_G.CameraSettingsReset = function()
		local v5 = _G
		_G.CameraFOVEnabled = false
		v5.CameraZoomEnabled = false
		fn12()
		fn13()
	end
end

_G.KillCamEnabled = false
_G.KillCamDuration = 1.4

do
	local n2 = 0
	_G.__KillCamActive = false

	local function fn12(arg)
		if _G.__KillCamActive or _G.KillAllBusy or os.clock() - n2 < 3 then
			return
		end
		local position = arg.position
		local currentCamera = workspace.CurrentCamera
		if not position or not currentCamera then
			return
		end
		_G.__KillCamActive = true
		n2 = os.clock()
		local cameraType = currentCamera.CameraType
		local fieldOfView = currentCamera.FieldOfView
		local killCamDuration = _G.KillCamDuration or 1.4
		local roleColors = _G.__RoleColors and _G.__RoleColors[arg.role] or Color3.new(1, 1, 1)
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "MarbegKillCam"
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 30
		screenGui.Parent = fn2()
		local tbl5 = {}

		for _, v5 in ipairs({ true, false }) do
			local frame = Instance.new("Frame")
			frame.AnchorPoint = Vector2.new(0, v5 and 1 or 0)
			frame.Position = UDim2.fromScale(0, v5 and 0 or 1)
			frame.Size = UDim2.new(1, 0, 0.11, 0)
			frame.BackgroundColor3 = Color3.new(0, 0, 0)
			frame.BorderSizePixel = 0
			frame.Parent = screenGui
			tbl5[#tbl5 + 1] = { frame = frame, top = v5 }
			local v6 = TweenService
			local create = v6.Create
			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
			local tbl6 = {}
			local vector2 = Vector2.new
			v5 = v5 and 0 or 1
			tbl6.AnchorPoint = vector2(0, v5)
			create(v6, frame, tweenInfo, tbl6):Play()
		end

		local textLabel = Instance.new("TextLabel")
		textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		textLabel.Position = UDim2.fromScale(0.5, 0.945)
		textLabel.Size = UDim2.fromOffset(500, 30)
		textLabel.BackgroundTransparency = 1
		textLabel.Font = Enum.Font.GothamBlack
		textLabel.TextSize = 20
		textLabel.TextColor3 = roleColors
		textLabel.TextStrokeTransparency = 0.4
		textLabel.Text = string.upper(arg.name or "")
		textLabel.Parent = screenGui
		local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
		colorCorrectionEffect.Name = "MarbegKillCamGrade"
		colorCorrectionEffect.Saturation = 0
		colorCorrectionEffect.Parent = game:GetService("Lighting")
		TweenService:Create(colorCorrectionEffect, TweenInfo.new(0.3), { Saturation = -0.45, Contrast = 0.2 }):Play()
		local n3 = (currentCamera.CFrame.Position - position) * Vector3.new(1, 0, 1)
		local n4 = n3.Magnitude > 0.1 and math.atan2(n3.Z, n3.X) or 0
		currentCamera.CameraType = Enum.CameraType.Scriptable
		local now = os.clock()
		local flag2 = false
		local connection2 = nil

		connection2 = RunService.RenderStepped:Connect(function()
			local n5 = math.clamp((os.clock() - now) / killCamDuration, 0, 1)
			local n6 = 1 - (1 - n5) ^ 3
			local n7 = n4 + 1.2217304763960306 * n6
			local n8 = 11 - 4 * n6
			currentCamera.CFrame = CFrame.lookAt(position + Vector3.new(math.cos(n7) * n8, 2.5 + 1.5 * (1 - n6), math.sin(n7) * n8), position + Vector3.new(0, 0.5, 0))
			currentCamera.FieldOfView = fieldOfView - 18 * n6

			if n5 >= 1 and not flag2 then
				flag2 = true
				connection2:Disconnect()
			end
		end)

		task.delay(killCamDuration, function()
			if connection2.Connected then
				connection2:Disconnect()
			end

			pcall(function()
				currentCamera.CameraType = cameraType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or cameraType
				currentCamera.FieldOfView = fieldOfView
				local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildWhichIsA("Humanoid")

				if humanoid then
					currentCamera.CameraSubject = humanoid
				end
			end)

			TweenService:Create(colorCorrectionEffect, TweenInfo.new(0.3), { Saturation = 0, Contrast = 0 }):Play()

			for _, v5 in ipairs(tbl5) do
				TweenService:Create(v5.frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { AnchorPoint = Vector2.new(0, v5.top and 1 or 0) }):Play()
			end

			TweenService:Create(textLabel, TweenInfo.new(0.25), { TextTransparency = 1, TextStrokeTransparency = 1 }):Play()

			task.delay(0.35, function()
				pcall(function()
					screenGui:Destroy()
				end)

				pcall(function()
					colorCorrectionEffect:Destroy()
				end)

				_G.__KillCamActive = false
			end)
		end)
	end

	_G.__MyKillListeners = _G.__MyKillListeners or {}

	_G.__MyKillListeners.KillCam = function(arg)
		if _G.KillCamEnabled then
			task.spawn(fn12, arg)
		end
	end
end

_G.KillCamSetEnabled = function(arg)
	_G.KillCamEnabled = arg and true or false
end

_G.KillCamSetDuration = function(arg)
	_G.KillCamDuration = math.clamp(tonumber(arg) or 1.4, 0.6, 3)
end

_G.StretchModeEnabled = false
_G.StretchAspect = 1.3333333333333333

do
	local fieldOfView = nil

	local function fn12()
		pcall(function()
			RunService:UnbindFromRenderStep("MarbegStretchFOV")
		end)

		local currentCamera = workspace.CurrentCamera

		if currentCamera and fieldOfView then
			pcall(function()
				currentCamera.FieldOfView = fieldOfView
			end)
		end

		fieldOfView = nil
	end

	_G.StretchModeSetEnabled = function(arg)
		_G.StretchModeEnabled = arg and true or false
		fn12()
		if not _G.StretchModeEnabled then
			return
		end
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return
		end
		fieldOfView = currentCamera.FieldOfView

		RunService:BindToRenderStep("MarbegStretchFOV", Enum.RenderPriority.Camera.Value + 5, function()
			local currentCamera2 = workspace.CurrentCamera
			local cameraFOV = _G.CameraFOVEnabled and _G.CameraFOV or fieldOfView
			if not currentCamera2 or not cameraFOV or _G.__KillCamActive then
				return
			end
			local viewportSize = currentCamera2.ViewportSize
			if viewportSize.Y <= 0 then
				return
			end
			local n2 = viewportSize.X / viewportSize.Y
			local n3 = math.clamp(tonumber(_G.StretchAspect) or 1.3333333333333333, 1, n2)
			currentCamera2.FieldOfView = math.clamp(math.deg(2 * math.atan(math.tan(2 * math.atan(math.tan(math.rad(cameraFOV) / 2) * n3) / 2) / n2)), 1, 120)
		end)
	end
end

_G.StretchModeSetAspect = function(arg)
	_G.StretchAspect = math.clamp(tonumber(arg) or 1.3333333333333333, 1, 2.4)
end

_G.AntiAfkEnabled = true

_G.AntiAfkSetEnabled = function(arg)
	_G.AntiAfkEnabled = arg and true or false
end

if not _G.__AntiAfkHooked then
	_G.__AntiAfkHooked = true
	local VirtualUser = game:GetService("VirtualUser")

	localPlayer.Idled:Connect(function()
		if not _G.AntiAfkEnabled then
			return
		end

		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end)
end

do
	local Lighting = game:GetService("Lighting")
	local obj = setmetatable({}, { __mode = "k" })
	local connection2 = nil
	_G.FpsBoostEnabled = false
	_G.FpsCapValue = 0

	local function fn12(arg, arg2)
		local tbl5 = obj[arg]

		if not tbl5 then
			tbl5 = {}
			obj[arg] = tbl5
		end

		if tbl5[arg2] == nil then
			local ok, result = pcall(function()
				return arg[arg2]
			end)

			if ok then
				tbl5[arg2] = result
			end
		end
	end

	local function fn13(arg)
		if arg:GetAttribute("MarbegKeep") then
			return
		end

		if arg:IsA("ParticleEmitter") or arg:IsA("Trail") or arg:IsA("Beam") or arg:IsA("Smoke") or arg:IsA("Fire") or arg:IsA("Sparkles") then
			fn12(arg, "Enabled")
			arg.Enabled = false
		elseif arg:IsA("PostEffect") then
			fn12(arg, "Enabled")
			arg.Enabled = false
		elseif arg:IsA("Decal") or arg:IsA("Texture") then
			fn12(arg, "Transparency")
			arg.Transparency = 1
		elseif arg:IsA("MeshPart") and arg.TextureID ~= "" then
			fn12(arg, "TextureID")
			arg.TextureID = ""
		end
	end

	local function fn14()
		pcall(function()
			fn12(Lighting, "GlobalShadows")
			Lighting.GlobalShadows = false
			fn12(Lighting, "FogEnd")
			Lighting.FogEnd = 1e9
		end)

		pcall(function()
			local terrain = workspace.Terrain

			if terrain then
				fn12(terrain, "WaterWaveSize")
				terrain.WaterWaveSize = 0
				fn12(terrain, "WaterWaveSpeed")
				terrain.WaterWaveSpeed = 0
				fn12(terrain, "WaterReflectance")
				terrain.WaterReflectance = 0
				fn12(terrain, "WaterTransparency")
				terrain.WaterTransparency = 0
			end
		end)

		pcall(function()
			local level01 = Enum.QualityLevel.Level01
			settings().Rendering.QualityLevel = level01
		end)

		for _, descendant in ipairs(Lighting:GetDescendants()) do
			pcall(fn13, descendant)
		end

		local n2 = 0

		for _, descendant in ipairs(workspace:GetDescendants()) do
			if not _G.FpsBoostEnabled then
				return
			end
			pcall(fn13, descendant)
			n2 += 1

			if n2 % 600 == 0 then
				RunService.Heartbeat:Wait()
			end
		end

		if connection2 then
			connection2:Disconnect()
		end

		connection2 = workspace.DescendantAdded:Connect(function(descendant)
			if _G.FpsBoostEnabled then
				task.defer(function()
					pcall(fn13, descendant)
				end)
			end
		end)
	end

	local function fn15()
		if connection2 then
			connection2:Disconnect()
			connection2 = nil
		end

		for k, v5 in pairs(obj) do
			for k2, v6 in pairs(v5) do
				pcall(function()
					k[k2] = v6
				end)
			end
		end

		table.clear(obj)

		pcall(function()
			local automatic = Enum.QualityLevel.Automatic
			settings().Rendering.QualityLevel = automatic
		end)
	end

	_G.FpsBoostSetEnabled = function(arg)
		local fpsBoostEnabled = arg and true or false
		if fpsBoostEnabled == _G.FpsBoostEnabled then
			return
		end
		_G.FpsBoostEnabled = fpsBoostEnabled

		if fpsBoostEnabled then
			task.spawn(fn14)
		else
			fn15()
		end
	end
end

_G.FpsBoostSetCap = function(arg)
	local fpsCapValue = tonumber(arg) or 0
	_G.FpsCapValue = fpsCapValue

	pcall(function()
		if setfpscap then
			setfpscap(fpsCapValue)
		end
	end)
end

do
	local HttpService = game:GetService("HttpService")
	local flag2 = false
	local flag3 = false
	local now = os.clock()
	local n2 = 0
	local tbl5 = {}
	local flag4 = false
	local now2 = os.clock()
	local value = nil
	_G.FarmWebhookEnabled = false
	_G.FarmWebhookUrl = ""
	_G.FarmWebhookBagFull = true
	_G.FarmWebhookPeriodic = true
	_G.FarmWebhookInterval = 10

	local function fn12(arg, arg2)
		if type(request_) ~= "function" then
			return false, "HTTP request is not supported"
		end
		local v5 = arg2

		if type(arg2) ~= "string" then
			local ok, result = pcall(function()
				return HttpService:JSONEncode(arg2)
			end)

			if not ok then
				return false, "encode failed"
			end
			v5 = result
		end

		local ok, result = pcall(request_, {
			Url = arg,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json", ["User-Agent"] = "Roblox" },
			Body = v5,
		})

		if not ok then
			return false, tostring(result)
		end

		if type(result) == "table" then
			local num = tonumber(result.StatusCode or result.Status)
			if num and (num < 200 or num >= 300) then
				return false, "HTTP " .. tostring(num)
			end
		end

		return true, "ok"
	end

	local function fn13()
		local farmWebhookUrl = _G.FarmWebhookUrl
		return type(farmWebhookUrl) == "string" and farmWebhookUrl:match("^https?://[^%s]+$") ~= nil
	end

	local function fn14()
		if flag4 then
			return
		end
		flag4 = true

		task.spawn(function()
			while #tbl5 > 0 do
				local n3 = 2 - os.clock() - n2

				if n3 > 0 then
					task.wait(n3)
				end

				local v5 = table.remove(tbl5, 1)
				n2 = os.clock()
				pcall(fn12, _G.FarmWebhookUrl, v5)
			end

			flag4 = false
		end)
	end

	local function fn15(arg)
		local n3 = math.floor((tonumber(arg) or 0) + 0.5)
		return (n3 < 0 and "-" or "") .. tostring(math.abs(n3)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end

	local function fn16()
		local n3 = math.max(0, os.clock() - now2)
		local n4 = math.floor(n3 / 3600)
		local n5 = math.floor(n3 % 3600 / 60)
		if n4 > 0 then
			return string.format("%dh %dm", n4, n5)
		end

		if n5 > 0 then
			return string.format("%dm %ds", n5, math.floor(n3 % 60))
		end
		return string.format("%ds", math.floor(n3 % 60))
	end

	local function farmAccountStats()
		local n3 = nil
		local n4 = nil
		local v5 = nil

		pcall(function()
			local ProfileData = require(ReplicatedStorage.Modules.ProfileData)
			local owned = ProfileData.Materials and ProfileData.Materials.Owned or {}
			n3 = tonumber(owned.Coins) or 0
			n4 = tonumber(owned.Gems) or 0
			local LevelModule = require(ReplicatedStorage.Modules.LevelModule)

			if LevelModule and LevelModule.GetLevel then
				v5 = LevelModule.GetLevel(ProfileData.NewXP or 0)
			end
		end)

		return n3, n4, v5
	end

	_G.__FarmAccountCoins = function()
		return (select(1, farmAccountStats()))
	end

	_G.__FarmAccountStats = farmAccountStats

	local function fn17(arg, arg2, arg3)
		local v5, v6, v7 = farmAccountStats()

		if value == nil then
			value = v5
		end

		local n3 = 0

		pcall(function()
			local v8
			v8, v8 = _G.FarmGetRates()
			n3 = v8
		end)

		local farmCoinsCollected = _G.FarmCoinsCollected or 0
		local n4 = v5 and value and v5 > value and v5 - value or nil
		local tbl6 = {}
		local tbl7 = { name = "👤 Player", value = "`" .. tostring(localPlayer.Name) .. "`", inline = true }
		local tbl8 = { name = "⭐ Level", value = "`" .. tostring(v7 or "?") .. "`", inline = true }
		local tbl9 = { name = "🎟 Cases opened", value = "`" .. fn15(_G.AutoCaseOpened or 0) .. "`", inline = true }
		local tbl10 = { name = "🪙 Coins", value = v5 and "**" .. fn15(v5) .. "**" or "`?`", inline = true }
		local tbl11 = { name = "💎 Gems", value = "`" .. fn15(v6 or 0) .. "`", inline = true }
		local tbl12 = { name = "📈 Coins / hour", value = "`" .. fn15(n3) .. "`", inline = true }

		local tbl13 = {
			name = "🌾 Farmed this session",
			value = "`" .. fn15(farmCoinsCollected) .. "`" .. (n4 and "  ( `+" .. fn15(n4) .. "` to balance )" or ""),
			inline = false,
		}

		local tbl14 = { name = "⏳ Runtime", value = "`" .. fn16() .. "`", inline = true }
		tbl6[1] = tbl7
		tbl6[2] = tbl8
		tbl6[3] = tbl9
		tbl6[4] = tbl10
		tbl6[5] = tbl11
		tbl6[6] = tbl12
		tbl6[7] = tbl13
		tbl6[8] = tbl14

		local tbl15 = {
			author = { name = "Star Hub • MM2" },
			title = arg,
			description = arg2,
			color = arg3 or 16758338,
			fields = tbl6,
		}

		tbl15.footer = { text = "Star Hub MM2  •  " .. tostring(_G.ScriptVersion) }

		pcall(function()
			tbl15.timestamp = DateTime.now():ToIsoDate()
		end)

		return tbl15
	end

	local function farmWebhookSend(arg, arg2, arg3)
		if not _G.FarmWebhookEnabled or not fn13() then
			return
		end
		tbl5[#tbl5 + 1] = { username = "Star Hub MM2", embeds = { fn17(arg, arg2, arg3) } }

		while #tbl5 > 12 do
			table.remove(tbl5, 1)
		end

		fn14()
	end

	_G.FarmWebhookSend = farmWebhookSend

	_G.FarmWebhookSetEnabled = function(arg)
		_G.FarmWebhookEnabled = arg and true or false
	end

	_G.FarmWebhookSetUrl = function(arg)
		_G.FarmWebhookUrl = type(arg) == "string" and arg or ""
	end

	_G.FarmWebhookTest = function()
		if not fn13() then
			return false, "Paste a valid https:// webhook URL first."
		end
		local farmWebhookEnabled = _G.FarmWebhookEnabled
		_G.FarmWebhookEnabled = true
		farmWebhookSend("✅ Webhook test", "If this lands in your channel, the Star Hub farm webhook is wired up.", 5763719)
		_G.FarmWebhookEnabled = farmWebhookEnabled
		return true, "Test embed queued."
	end

	local farmWebhookLoopId = {}
	_G.__FarmWebhookLoopId = farmWebhookLoopId

	task.spawn(function()
		while _G.__FarmWebhookLoopId == farmWebhookLoopId do
			task.wait(1)

			if not _G.FarmWebhookEnabled then
				flag2 = _G.AutoFarmEnabled and true or false
				flag3 = _G.BagFull and true or false
			else
				local flag5 = _G.AutoFarmEnabled and true or false

				if flag5 ~= flag2 then
					flag2 = flag5

					if flag5 then
						now = os.clock()
						now2 = os.clock()
						value = select(1, farmAccountStats())
						farmWebhookSend("🟢 Farm started", "The coin farm is now running.", 3066993)
					else
						farmWebhookSend("🔴 Farm stopped", "The coin farm was switched off.", 15158332)
					end
				end

				if flag5 then
					local flag6 = _G.BagFull and true or false

					if flag6 and not flag3 and _G.FarmWebhookBagFull then
						farmWebhookSend("💰 Coin bag full", "Bag filled up -- cashing in.", 16766720)
					end

					flag3 = flag6

					if _G.FarmWebhookPeriodic then
						local n3 = math.max(1, tonumber(_G.FarmWebhookInterval) or 10)

						if n3 * 60 <= os.clock() - now then
							now = os.clock()
							farmWebhookSend("⏱ Farm checkpoint", string.format("Still farming -- %d min checkpoint.", n3), 16758338)
						end
					end
				else
					flag3 = false
				end
			end
		end
	end)
end

_G.AutoCaseEnabled = false
_G.AutoCaseBox = "MysteryBox1"
_G.AutoCaseReserve = 0
_G.AutoCaseOnlyWhileFarming = true
_G.AutoCaseOpened = 0
_G.AutoCaseLastReward = nil
_G.AutoCaseStatus = "idle"
_G.FarmWebhookCaseReport = true
_G.AutoCaseBoxList = { "MysteryBox1", "MysteryBox2", "KnifeBox3", "KnifeBox4", "GunBox3" }

do
	local function fn12()
		local num = nil

		pcall(function()
			local ProfileData = require(ReplicatedStorage.Modules.ProfileData)
			num = tonumber(ProfileData.Materials and ProfileData.Materials.Owned and ProfileData.Materials.Owned.Coins)
		end)

		return num
	end

	local function fn13(arg)
		local n2 = 1000

		pcall(function()
			local NewShop = require(ReplicatedStorage.Database.Sync.NewShop)
			local coins = NewShop[arg] and NewShop[arg].Price and NewShop[arg].Price.Coins

			if tonumber(coins) then
				n2 = tonumber(coins)
			end
		end)

		return n2
	end

	local function autoCaseOpenOnce()
		local autoCaseBox = _G.AutoCaseBox

		if type(autoCaseBox) ~= "string" or autoCaseBox == "" then
			autoCaseBox = "MysteryBox1"
		end

		local ok, result = pcall(function()
			return ReplicatedStorage.Remotes.Shop.OpenCrate:InvokeServer(autoCaseBox, "MysteryBox", "Coins")
		end)

		if not ok then
			_G.AutoCaseStatus = "error: " .. tostring(result):sub(1, 48)
			return false
		end

		if not result then
			_G.AutoCaseStatus = "server refused the open"
			return false
		end

		pcall(function()
			ReplicatedStorage.Remotes.Shop.CrateComplete:FireServer(result)
		end)

		_G.AutoCaseOpened = (_G.AutoCaseOpened or 0) + 1
		_G.AutoCaseLastReward = tostring(result)
		_G.AutoCaseStatus = "opened #" .. tostring(result) .. "  (x" .. tostring(_G.AutoCaseOpened) .. ")"

		if _G.FarmWebhookCaseReport and _G.FarmWebhookSend then
			pcall(_G.FarmWebhookSend, "🎁 Case opened", string.format("Unboxed `#%s` from **%s**.", tostring(result), autoCaseBox), 10181046)
		end

		return true
	end

	_G.AutoCaseOpenOnce = autoCaseOpenOnce
	local autoCaseLoopId = {}
	_G.__AutoCaseLoopId = autoCaseLoopId

	task.spawn(function()
		while _G.__AutoCaseLoopId == autoCaseLoopId do
			task.wait(3)

			if _G.AutoCaseEnabled and (not _G.AutoCaseOnlyWhileFarming or _G.AutoFarmEnabled) then
				local v5 = fn12()
				local n2 = math.max(0, tonumber(_G.AutoCaseReserve) or 0)
				local v6 = fn13(_G.AutoCaseBox)

				if v5 and v5 - v6 >= n2 then
					_G.AutoCaseStatus = "opening " .. tostring(_G.AutoCaseBox) .. "..."
					autoCaseOpenOnce()
					task.wait(2)
				elseif v5 then
					_G.AutoCaseStatus = string.format("waiting: %d / %d coins", v5, v6 + n2)
				else
					_G.AutoCaseStatus = "coin balance unavailable"
				end
			end
		end
	end)
end

_G.AutoCaseSetEnabled = function(arg)
	_G.AutoCaseEnabled = arg and true or false

	if not _G.AutoCaseEnabled then
		_G.AutoCaseStatus = "idle"
	end
end

_G.AutoCaseSetBox = function(autoCaseBox)
	if type(autoCaseBox) == "string" and autoCaseBox ~= "" then
		_G.AutoCaseBox = autoCaseBox
	end
end

_G.AutoCaseSetReserve = function(arg)
	_G.AutoCaseReserve = math.max(0, tonumber(arg) or 0)
end

_G.AutoCaseSetOnlyWhileFarming = function(arg)
	_G.AutoCaseOnlyWhileFarming = arg and true or false
end

_G.AutoCaseSetWebhookReport = function(arg)
	_G.FarmWebhookCaseReport = arg and true or false
end

_G.ShiftLockAimbotEnabled = false
_G.SilentAimEnabled = false
_G.SilentThrowEnabled = false

do
	local ok, result = pcall(function()
		return require(ReplicatedStorage:WaitForChild("ClientServices"):WaitForChild("WeaponService"))
	end)

	local tbl5 = { "UpperTorso", "HumanoidRootPart", "Torso", "LowerTorso", "Head" }

	local function fn12(arg)
		for _, v5 in ipairs(tbl5) do
			local v6 = arg:FindFirstChild(v5)
			if v6 and v6:IsA("BasePart") then
				return v6
			end
		end

		return nil
	end

	local function aimEnemyHead()
		local v5 = CurrentRoundClient.PlayerData[localPlayer.Name]
		if not v5 or not v5.Role or v5.Dead then
			return nil
		end
		local tbl6

		if v5.Role == "Murderer" then
			tbl6 = { Sheriff = true, Hero = true }
		else
			tbl6 = { Murderer = true }
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player == localPlayer then
				continue
			end
			local v6 = CurrentRoundClient.PlayerData[player.Name]

			if v6 and v6.Role and tbl6[v6.Role] and not v6.Dead then
				local character = player.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				character = character and fn12(character)
				if character and humanoid and humanoid.Health > 0 then
					return character
				end
			end
		end

		return nil
	end

	_G.__AimEnemyHead = aimEnemyHead

	local function fn13()
		local character = localPlayer.Character
		if not character then
			return nil
		end

		for _, child in ipairs(character:GetChildren()) do
			if child:IsA("Tool") then
				local v5 = string.lower(child.Name)
				if string.find(v5, "knife", 1, true) then
					return "Knife"
				end

				if string.find(v5, "gun", 1, true) or string.find(v5, "revolver", 1, true) then
					return "Gun"
				end
				return "Other"
			end
		end

		return nil
	end

	local function silentThrowTarget()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		local huge = math.huge
		local v5 = nil
		local huge2 = math.huge
		local v6 = nil

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				local character2 = player.Character
				local humanoid = character2 and character2:FindFirstChildWhichIsA("Humanoid")
				local v7 = character2 and fn12(character2)

				if v7 and humanoid and humanoid.Health > 0 then
					local magnitude = (v7.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v5 = v7
					end

					local raycastParams = RaycastParams.new()
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					raycastParams.FilterDescendantsInstances = { character, character2 }
					raycastParams.IgnoreWater = true
					local hit = workspace:Raycast(humanoidRootPart.Position, v7.Position - humanoidRootPart.Position, raycastParams)

					if not (hit and hit.Instance and hit.Instance.CanCollide) then
						if magnitude < huge2 then
							huge2 = magnitude
							v6 = v7
						end
					end
				end
			end
		end

		return v6 or v5
	end

	_G.__SilentThrowTarget = silentThrowTarget

	local function fn14()
		if ok and result and result.IsMouseLockEnabled then
			local ok2, result2 = pcall(result.IsMouseLockEnabled)
			if ok2 and result2 then
				return true
			end
		end

		return UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
	end

	local function fn15()
		if fn14() then
			return true
		end

		if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
			return fn13() ~= nil
		end
		return false
	end

	RunService:BindToRenderStep("MarbegShiftLockAim", Enum.RenderPriority.Camera.Value + 20, function()
		if not _G.ShiftLockAimbotEnabled or not _G.InRound then
			return
		end

		if not fn15() then
			return
		end
		local v5 = aimEnemyHead()
		if not v5 then
			return
		end
		local currentCamera = workspace.CurrentCamera
		if not currentCamera then
			return
		end
		local position = v5.Position

		if _G.__PredictionLeadFor then
			position += _G.__PredictionLeadFor(v5.Parent and v5.Parent:FindFirstChild("HumanoidRootPart"), currentCamera.CFrame.Position)
		end

		currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.lookAt(currentCamera.CFrame.Position, position), 0.4)
	end)

	if ok and result and type(result.GetMouseTargetCFrame) == "function" then
		_G.__RealGetMouseTarget = _G.__RealGetMouseTarget or result.GetMouseTargetCFrame
		_G.__SilentAimHooked = true
		local realGetMouseTarget = _G.__RealGetMouseTarget

		local function fn16()
			if not (_G.SilentAimEnabled and fn13() ~= "Knife") then
				return nil
			end
			local ok2, result2 = pcall(aimEnemyHead)
			local parent = result2 and result2.Parent

			if ok2 and result2 and parent then
				local character = localPlayer.Character
				local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
				local gunRaycastAttachment = humanoidRootPart and humanoidRootPart:FindFirstChild("GunRaycastAttachment")
				local worldPosition = gunRaycastAttachment and gunRaycastAttachment.WorldPosition or humanoidRootPart and humanoidRootPart.Position or result2.Position
				local value = nil

				if _G.AimWallResolveEnabled and _G.__ResolveVisibleAim then
					value = select(1, _G.__ResolveVisibleAim(parent, worldPosition, character, true))
				end

				if not value then
					value = result2.Position + (_G.__PredictionLeadFor and _G.__PredictionLeadFor(parent:FindFirstChild("HumanoidRootPart"), worldPosition) or Vector3.zero)
				end

				pcall(function()
					if gunRaycastAttachment then
						gunRaycastAttachment.WorldCFrame = CFrame.lookAt(gunRaycastAttachment.WorldPosition, value)
					end
				end)

				return CFrame.new(value)
			end

			return nil
		end

		result.GetMouseTargetCFrame = function(...)
			if _G.SilentThrowEnabled and fn13() == "Knife" then
				local ok2, result2 = pcall(silentThrowTarget)
				if ok2 and result2 then
					return CFrame.new(result2.Position)
				end
			end

			local v5 = fn16()
			if v5 then
				return v5
			end
			return realGetMouseTarget(...)
		end

		if type(result.GetTargetPosition) == "function" then
			_G.__RealGetTargetPosition = _G.__RealGetTargetPosition or result.GetTargetPosition
			local realGetTargetPosition = _G.__RealGetTargetPosition

			result.GetTargetPosition = function(...)
				local v5 = fn16()
				if v5 then
					return v5
				end
				return realGetTargetPosition(...)
			end
		end
	end

	_G.TriggerbotEnabled = false
	_G.TriggerbotDelay = 0.05
	_G.TriggerbotFOV = 5
	_G.TriggerbotShowFOV = false

	_G.TriggerbotSetEnabled = function(arg)
		_G.TriggerbotEnabled = arg and true or false
	end

	_G.TriggerbotSetFOV = function(arg)
		_G.TriggerbotFOV = math.clamp(tonumber(arg) or 5, 1, 30)
	end

	_G.TriggerbotReady = false
	_G.CrosshairEnabled = false
	_G.CrosshairDecalId = "1827745864"
	_G.CrosshairSize = 64
	_G.CrosshairSpinEnabled = false
	_G.CrosshairSpinSpeed = 180
	local HttpService = game:GetService("HttpService")

	pcall(function()
		if isfile and readfile and isfile("mm2_crosshair.json") then
			local data = HttpService:JSONDecode(readfile("mm2_crosshair.json"))
			local crosshairDecalId = type(data) == "table"

			if crosshairDecalId then
				crosshairDecalId = tostring(data.DecalId or ""):match("%d+")
			end

			if crosshairDecalId then
				_G.CrosshairDecalId = crosshairDecalId
			end

			if type(data) == "table" and data.Size then
				_G.CrosshairSize = math.clamp(tonumber(data.Size) or 64, 24, 160)
			end
		end
	end)

	if _G.CrosshairDecalId == "2596541801" or _G.CrosshairDecalId == "86241006" or _G.CrosshairDecalId == "11721776729" or _G.CrosshairDecalId == "2400846053" or _G.CrosshairDecalId == "311756276" then
		_G.CrosshairDecalId = "1827745864"
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegCrosshair"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 160
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.TriggerMarkerGui = screenGui
	_G.CrosshairGui = screenGui
	local frame = Instance.new("Frame")
	frame.Name = "CrosshairRoot"
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Size = UDim2.fromOffset(1, 1)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.Parent = screenGui
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Name = "SelectedCrosshair"
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.Position = UDim2.fromScale(0.5, 0.5)
	imageLabel.Size = UDim2.fromOffset(_G.CrosshairSize, _G.CrosshairSize)
	imageLabel.BackgroundTransparency = 1
	imageLabel.BorderSizePixel = 0
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.Image = "rbxthumb://type=Asset&id=" .. tostring(_G.CrosshairDecalId) .. "&w=150&h=150"
	imageLabel.Parent = frame

	_G.CrosshairSetEnabled = function(arg)
		_G.CrosshairEnabled = arg and true or false
		screenGui.Enabled = _G.CrosshairEnabled

		if not _G.CrosshairEnabled then
			frame.Rotation = 0
		end

		if _G.ShiftLockCrosshairSetEnabled and _G.__ShiftLockCrosshairRequested ~= nil then
			pcall(function()
				_G.ShiftLockCrosshairSetEnabled(_G.__ShiftLockCrosshairRequested)
			end)
		end
	end

	_G.TriggerbotShowFOVSetEnabled = _G.CrosshairSetEnabled

	_G.CrosshairSetDecal = function(arg)
		local match = tostring(arg or ""):match("%d+")
		if not match then
			return
		end
		_G.CrosshairDecalId = match
		imageLabel.Image = "rbxthumb://type=Asset&id=" .. match .. "&w=150&h=150"

		pcall(function()
			if writefile then
				writefile("mm2_crosshair.json", HttpService:JSONEncode({ DecalId = match, Size = _G.CrosshairSize }))
			end
		end)
	end

	_G.CrosshairSetSize = function(arg)
		_G.CrosshairSize = math.clamp(tonumber(arg) or 64, 24, 160)
		imageLabel.Size = UDim2.fromOffset(_G.CrosshairSize, _G.CrosshairSize)

		pcall(function()
			if writefile then
				writefile("mm2_crosshair.json", HttpService:JSONEncode({ DecalId = _G.CrosshairDecalId, Size = _G.CrosshairSize }))
			end
		end)
	end

	_G.CrosshairSetSpin = function(arg)
		_G.CrosshairSpinEnabled = arg and true or false

		if not _G.CrosshairSpinEnabled then
			frame.Rotation = 0
		end
	end

	_G.CrosshairSetSpinSpeed = function(arg)
		_G.CrosshairSpinSpeed = math.clamp(tonumber(arg) or 180, 0, 720)
	end

	RunService:BindToRenderStep("MarbegCrosshair", Enum.RenderPriority.Last.Value, function(arg)
		if not _G.CrosshairEnabled then
			return
		end
		local mouseLocation = UserInputService:GetMouseLocation()

		if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
			local currentCamera = workspace.CurrentCamera
			mouseLocation = currentCamera and currentCamera.ViewportSize / 2 or mouseLocation
		end

		frame.Position = UDim2.fromOffset(mouseLocation.X, mouseLocation.Y)

		if _G.CrosshairSpinEnabled then
			frame.Rotation = (frame.Rotation + _G.CrosshairSpinSpeed * arg) % 360
		else
			frame.Rotation = 0
		end
	end)

	_G.HideShiftLockCrosshair = false
	_G.__ShiftLockHiddenInstances = {}
	_G.__ShiftLockIconConns = {}
	_G.__ShiftLockCursorHidden = false
	_G.__ShiftLockSavedCursorIcon = nil
	_G.__ShiftLockSavedCursorEnabled = nil
	_G.__ShiftLockCrosshairRequested = false

	_G.ShiftLockCrosshairSetEnabled = function(arg)
		local shiftLockHiddenInstances = _G.__ShiftLockHiddenInstances

		for k, shiftLockHiddenInstance in pairs(shiftLockHiddenInstances) do
			if k and k.Parent then
				pcall(function()
					k.Visible = shiftLockHiddenInstance
				end)
			end

			shiftLockHiddenInstances[k] = nil
		end

		for _, shiftLockIconConn in ipairs(_G.__ShiftLockIconConns) do
			pcall(function()
				shiftLockIconConn:Disconnect()
			end)
		end

		_G.__ShiftLockIconConns = {}

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegHideShiftLockCursor")
		end)

		if _G.__ShiftLockCursorHidden then
			local v5 = localPlayer
			local mouse

			if localPlayer then
				mouse = localPlayer:GetMouse()
			else
				mouse = v5
			end

			if mouse then
				pcall(function()
					mouse.Icon = _G.__ShiftLockSavedCursorIcon or ""
				end)
			end

			if _G.__ShiftLockSavedCursorEnabled ~= nil then
				pcall(function()
					UserInputService.MouseIconEnabled = _G.__ShiftLockSavedCursorEnabled
				end)
			end

			_G.__ShiftLockCursorHidden = false
		end

		_G.HideShiftLockCrosshair = arg and true or false
		_G.__ShiftLockCrosshairRequested = _G.HideShiftLockCrosshair
		if not _G.HideShiftLockCrosshair or not _G.CrosshairEnabled then
			return
		end
		local v5 = localPlayer
		local mouse

		if localPlayer then
			mouse = localPlayer:GetMouse()
		else
			mouse = v5
		end

		_G.__ShiftLockSavedCursorIcon = mouse and mouse.Icon or ""
		_G.__ShiftLockSavedCursorEnabled = UserInputService.MouseIconEnabled
		_G.__ShiftLockCursorHidden = true

		local function fn16()
			if mouse then
				pcall(function()
					mouse.Icon = ""
				end)
			end

			pcall(function()
				UserInputService.MouseIconEnabled = false
			end)
		end

		fn16()
		RunService:BindToRenderStep("MarbegHideShiftLockCursor", Enum.RenderPriority.Last.Value + 10, fn16)

		local function fn17(arg2)
			if not (arg2:IsA("ImageLabel") or arg2:IsA("ImageButton")) then
				return
			end
			local v6 = string.lower(arg2.Name or "")
			local str = ""

			pcall(function()
				str = string.lower(arg2.Image or "")
			end)

			if string.find(v6, "shiftlock", 1, true) or string.find(v6, "mouselock", 1, true) or string.find(v6, "mouse_lock", 1, true) or string.find(v6, "cursorimage", 1, true) or string.find(str, "mouselock", 1, true) or string.find(str, "shiftlock", 1, true) or string.find(str, "mouselockedcursor", 1, true) then
				shiftLockHiddenInstances[arg2] = arg2.Visible
				arg2.Visible = false
			end
		end

		local tbl6 = {}

		local ok2, result2 = pcall(function()
			return game:GetService("CoreGui")
		end)

		if ok2 and result2 then
			table.insert(tbl6, result2)
		end

		local playerGui = localPlayer and localPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui then
			table.insert(tbl6, playerGui)
		end

		local ok3, result3 = pcall(fn2)

		if ok3 and result3 then
			table.insert(tbl6, result3)
		end

		for _, v6 in ipairs(tbl6) do
			for _, descendant in ipairs(v6:GetDescendants()) do
				pcall(fn17, descendant)
			end

			table.insert(_G.__ShiftLockIconConns, v6.DescendantAdded:Connect(function(descendant)
				task.defer(function()
					pcall(fn17, descendant)
				end)
			end))
		end
	end

	_G.TriggerbotSetDelay = function(arg)
		_G.TriggerbotDelay = math.clamp(tonumber(arg) or 0.05, 0, 0.6)
	end

	local function fn16(arg, arg2, arg3)
		for _, v5 in ipairs({ "Head", "HumanoidRootPart" }) do
			local v6 = arg2:FindFirstChild(v5)
			if v6 and _G.__InnocentInLine(arg, arg2, v6.Position, arg3) then
				return true
			end
		end

		return false
	end

	local flag2 = false
	local triggerLoopId = {}
	_G.__TriggerLoopId = triggerLoopId

	task.spawn(function()
		while _G.__TriggerLoopId == triggerLoopId do
			task.wait(0.05)

			if _G.TriggerbotEnabled and _G.InRound and not flag2 then
				if not pcall(function()
					local v5 = aimEnemyHead()
					local character = localPlayer.Character
					if not v5 or not character then
						_G.TriggerbotReady = false
						return
					end
					local raycastParams = RaycastParams.new()
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					raycastParams.FilterDescendantsInstances = { character, v5.Parent }
					raycastParams.IgnoreWater = true
					local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
					humanoidRootPart = humanoidRootPart and humanoidRootPart.Position or v5.Position
					local hit = workspace:Raycast(humanoidRootPart, v5.Position - humanoidRootPart, raycastParams)
					if hit and hit.Instance and hit.Instance.CanCollide then
						_G.TriggerbotReady = false
						return
					end

					if fn16(humanoidRootPart, v5.Parent, character) then
						_G.TriggerbotReady = false
						return
					end
					_G.TriggerbotReady = true
					flag2 = true

					if _G.TriggerbotDelay > 0 then
						task.wait(_G.TriggerbotDelay)
					end

					local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")
					local parent = v5.Parent
					local v6

					if parent then
						v6 = fn16(humanoidRootPart2 and humanoidRootPart2.Position or humanoidRootPart, v5.Parent, character)
					else
						v6 = parent
					end

					if v6 then
						_G.TriggerbotReady = false
						flag2 = false
						return
					end

					_G.ShootMurderer()
					task.wait(0.25)
					flag2 = false
				end) then
					flag2 = false
				end
			end
		end
	end)
end

_G.ShiftLockAimbotSetEnabled = function(arg)
	_G.ShiftLockAimbotEnabled = arg and true or false
end

_G.SilentAimSetEnabled = function(arg)
	_G.SilentAimEnabled = arg and true or false
end

_G.SilentThrowSetEnabled = function(arg)
	_G.SilentThrowEnabled = arg and true or false
end

do
	local function createTextButton(name, arg, arg2, arg3, arg4, arg5, arg6)
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = name
		screenGui.ResetOnSpawn = false
		screenGui.IgnoreGuiInset = true
		screenGui.DisplayOrder = 98
		screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		screenGui.Enabled = false
		screenGui.Parent = fn2()
		_G[arg .. "Gui"] = screenGui
		local textButton = Instance.new("TextButton")
		textButton.Name = name
		textButton.AnchorPoint = Vector2.new(0, 0.5)
		textButton.Active = true
		textButton.AutoLocalize = false
		textButton.Parent = screenGui
		local v5 = _G.__StyleSquareButton(textButton, arg2, arg3, arg4)

		_G[arg .. "SetEnabled"] = function(arg7)
			screenGui.Enabled = arg7 and true or false
		end

		textButton.MouseEnter:Connect(function()
			local tbl5 = { Color = arg5, Transparency = 0 }
			TweenService:Create(v5, TweenInfo.new(0.13), tbl5):Play()
		end)

		textButton.MouseLeave:Connect(function()
			local tbl5 = { Color = arg4, Transparency = 0.1 }
			TweenService:Create(v5, TweenInfo.new(0.13), tbl5):Play()
		end)

		local flag2 = false
		local flag3 = false
		local position = nil
		local v6 = nil
		local v7 = nil

		textButton.InputBegan:Connect(function(input)
			if _G.LockButtonsEnabled then
				return
			end

			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				flag2 = true
				flag3 = false
				local position2 = textButton.Position
				position = input.Position
				v6 = position2
				v7 = input

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						flag2 = false
					end
				end)
			end
		end)

		textButton.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				v7 = input
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if flag2 and input == v7 and position then
				local n2 = input.Position - position

				if n2.Magnitude > 4 then
					flag3 = true
				end

				textButton.Position = UDim2.new(v6.X.Scale, v6.X.Offset + n2.X, v6.Y.Scale, v6.Y.Offset + n2.Y)
			end
		end)

		textButton.Activated:Connect(function()
			if flag3 then
				flag3 = false
				return
			end
			arg6()
		end)

		return textButton
	end

	local MarbegFlingMurderer = createTextButton("MarbegFlingMurderer", "FlingMurdererButton", "skull", "FLING\nMURDERER", Color3.fromRGB(255, 60, 70), Color3.fromRGB(255, 130, 140), function()
		local v5, v6 = _G.RoleFlingTarget({ "Murderer" })

		if _G.WindNotify then
			_G.WindNotify("Fling Murderer", tostring(v6), v5 and "skull" or "circle-x")
		end
	end)

	MarbegFlingMurderer.Position = UDim2.new(0, 500, 0.38, 168)
	_G.__TrackButtonPosition("FlingMurderer", MarbegFlingMurderer)

	local MarbegBombBoost = createTextButton("MarbegBombBoost", "BombBoostButton", "bomb", "BOMB\nBOOST", Color3.fromRGB(240, 140, 40), Color3.fromRGB(255, 195, 120), function()
		local v5, v6 = _G.BombBoost()

		if _G.WindNotify then
			_G.WindNotify("Bomb Boost", tostring(v6), v5 and "bomb" or "circle-x")
		end
	end)

	MarbegBombBoost.Position = UDim2.new(0, 500, 0.38, 252)
	_G.__TrackButtonPosition("BombBoost", MarbegBombBoost)

	local MarbegFlingSheriff = createTextButton("MarbegFlingSheriff", "FlingSheriffButton", "shield", "FLING\nSHERIFF", Color3.fromRGB(55, 145, 255), Color3.fromRGB(140, 200, 255), function()
		local v5, v6 = _G.RoleFlingTarget({ "Hero", "Sheriff" })

		if _G.WindNotify then
			_G.WindNotify("Fling Hero / Sheriff", tostring(v6), v5 and "shield" or "circle-x")
		end
	end)

	MarbegFlingSheriff.Position = UDim2.new(0, 584, 0.38, 168)
	_G.__TrackButtonPosition("FlingSheriff", MarbegFlingSheriff)
	local tbl5 = {}

	local tbl6 = {
		gui = "MarbegNoclipButton",
		global = "NoclipButton",
		flag = "Noclip",
		state = "NoclipEnabled",
		icon = "ghost",
		caption = "NOCLIP",
		accent = Color3.fromRGB(150, 110, 255),
		y = 84,
	}

	local tbl7 = {
		gui = "MarbegFlyButton",
		global = "FlyButton",
		flag = "Fly",
		state = "PlayerFlyEnabled",
		icon = "plane",
		caption = "FLY",
		accent = Color3.fromRGB(60, 200, 255),
		y = 168,
	}

	local tbl8 = {
		gui = "MarbegInfJumpButton",
		global = "InfJumpButton",
		flag = "InfiniteJump",
		state = "InfiniteJumpEnabled",
		icon = "chevrons-up",
		caption = "INF\nJUMP",
		accent = Color3.fromRGB(80, 230, 140),
		y = 252,
	}

	local tbl9 = {
		gui = "MarbegWallJumpButton",
		global = "WallJumpButton",
		flag = "WallJump",
		state = "WallJumpEnabled",
		icon = "move-up",
		caption = "WALL\nJUMP",
		accent = Color3.fromRGB(255, 200, 70),
		y = 336,
	}

	tbl5[1] = tbl6
	tbl5[2] = tbl7
	tbl5[3] = tbl8
	tbl5[4] = tbl9

	for _, v5 in ipairs(tbl5) do
		local v6 = createTextButton(v5.gui, v5.global, v5.icon, v5.caption, v5.accent, v5.accent:Lerp(Color3.new(1, 1, 1), 0.4), function()
			local elements = _G.MM2ScriptConfig and _G.MM2ScriptConfig.Elements and _G.MM2ScriptConfig.Elements[v5.flag]
			local flag2 = not _G[v5.state]

			if elements then
				pcall(function()
					elements:Set(flag2)
				end)
			end
		end)

		v6.Position = UDim2.new(0, 668, 0.38, v5.y)
		_G.__TrackButtonPosition(v5.global, v6)
		v5.stroke = v6:FindFirstChildWhichIsA("UIStroke", true)
		v5.baseThickness = v5.stroke and v5.stroke.Thickness or 2
	end

	local playerButtonLightLoop = {}
	_G.__PlayerButtonLightLoop = playerButtonLightLoop

	task.spawn(function()
		while _G.__PlayerButtonLightLoop == playerButtonLightLoop do
			for _, v5 in ipairs(tbl5) do
				if v5.stroke then
					v5.stroke.Thickness = _G[v5.state] == true and v5.baseThickness + 1.5 or v5.baseThickness
				end
			end

			task.wait(0.25)
		end
	end)
end

do
	local tbl5 = {
		Ancient = Color3.fromRGB(100, 10, 255),
		Godly = Color3.fromRGB(255, 0, 255),
		Unique = Color3.fromRGB(255, 140, 0),
		Legendary = Color3.fromRGB(255, 0, 0),
		Rare = Color3.fromRGB(0, 255, 0),
		Uncommon = Color3.fromRGB(0, 255, 255),
		Classic = Color3.fromRGB(255, 255, 0),
		Common = Color3.fromRGB(255, 255, 255),
	}

	local function fn12()
		if type(_G.MM2SkinData) == "table" then
			return _G.MM2SkinData
		end
		local meshid = fn("https://raw.githubusercontent.com/meeqscripts/mm2/refs/heads/main/meshid")
		if not meshid then
			return nil, "Skin list could not be downloaded."
		end
		local chunk, v5 = loadstring(meshid, "@mm2_skins_data.lua")
		if not chunk then
			return nil, "Skin list is invalid: " .. tostring(v5)
		end
		local ok, mM2SkinData = pcall(chunk)
		if not ok or type(mM2SkinData) ~= "table" then
			return nil, "Skin list failed to load."
		end
		_G.MM2SkinData = mM2SkinData
		return mM2SkinData
	end

	local function fn13(arg, arg2)
		local n2 = arg - arg.Position
		return CFrame.new(arg.Position * arg2) * n2
	end

	local function fn14(arg)
		local props = arg.Props or {}
		if arg.Class == "MeshPart" then
			return { MeshId = props.MeshId, TextureId = props.TextureID, Size = props.Size, FromMeshPart = true }
		end
		local v5 = ipairs
		local children = arg.Children or {}

		for _, child in v5(children) do
			if child.Class == "SpecialMesh" or child.Class == "FileMesh" then
				local props2 = child.Props or {}

				return {
					MeshId = props2.MeshId,
					TextureId = props2.TextureId,
					Scale = props2.Scale,
					Offset = props2.Offset,
					VertexColor = props2.VertexColor,
					Size = props.Size,
					MeshNode = child,
				}
			end
		end

		return { Size = props.Size }
	end

	local tbl6 = {}

	local function fn15(arg)
		if not arg or arg == "" then
			return nil
		end

		if tbl6[arg] then
			return tbl6[arg]
		end

		local ok, result = pcall(function()
			return game:GetService("InsertService"):CreateMeshPartAsync(arg, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Performance)
		end)

		if ok and typeof(result) == "Instance" then
			local size = result.Size

			if size.X > 0 and size.Y > 0 and size.Z > 0 then
				tbl6[arg] = size
			end

			result:Destroy()
		end

		return tbl6[arg]
	end

	local function fn16(arg, arg2)
		if arg == "MeshPart" and arg2 and arg2 ~= "" then
			local ok, result = pcall(function()
				return game:GetService("InsertService"):CreateMeshPartAsync(arg2, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Performance)
			end)

			if ok and typeof(result) == "Instance" then
				return result
			end
		end

		return Instance.new(arg)
	end

	local fn17 = nil

	fn17 = function(arg, parent, arg2, part1, arg3)
		local n2 = arg3 or 1
		arg2 = arg2 or CFrame.new()
		local v5 = fn16(arg.Class, arg.Props and arg.Props.MeshId)
		v5.Name = arg.Name or arg.Class
		v5:SetAttribute("MM2SkinExtra", true)
		local v6 = pairs
		local props = arg.Props or {}

		for k, prop in v6(props) do
			if k ~= "RelCF" and k ~= "Size" then
				pcall(function()
					v5[k] = prop
				end)
			end
		end

		if v5:IsA("BasePart") then
			local n3 = arg2 * fn13(arg.Props and arg.Props.RelCF or CFrame.new(), n2)

			pcall(function()
				v5.Anchored = false
				v5.Massless = true
				v5.CanQuery = false
			end)

			v5.CFrame = (part1 and part1.CFrame or CFrame.new()) * n3
			v5.Parent = parent
			local size = arg.Props and arg.Props.Size
			local size2 = size and size * n2

			if size2 then
				pcall(function()
					v5.Size = size2
				end)

				task.spawn(function()
					task.wait(0.1)

					if v5.Parent then
						pcall(function()
							v5.Size = size2
						end)
					end
				end)
			end

			part1 = part1 or v5
			local v7 = ipairs
			local children = arg.Children or {}

			for _, child in v7(children) do
				fn17(child, v5, part1 == v5 and CFrame.new() or n3, part1, n2)
			end
		elseif v5:IsA("Attachment") then
			v5.CFrame = fn13(arg.Props and arg.Props.RelCF or CFrame.new(), n2)
			v5.Parent = parent
		elseif v5.ClassName == "WeldConstraint" then
			v5.Part0 = parent
			v5.Part1 = part1
			v5.Parent = parent
		elseif v5:IsA("SurfaceAppearance") then
			if parent and parent:IsA("MeshPart") then
				pcall(function()
					v5.Parent = parent
				end)
			else
				v5:Destroy()
			end
		elseif pcall(function()
					v5.Parent = parent
				end) then
			local v7 = ipairs
			local children = arg.Children or {}

			for _, child in v7(children) do
				fn17(child, parent, arg2, part1, n2)
			end
		else
			v5:Destroy()
		end

		return v5
	end

	local tbl7 = {
		Attachment = true,
		RigidConstraint = true,
		WeldConstraint = true,
		Weld = true,
		Motor6D = true,
		Script = true,
		LocalScript = true,
		ModuleScript = true,
	}

	local function fn18(arg, arg2)
		local relCF = nil
		local v5 = ipairs
		local children = arg2.Children or {}

		for _, child in v5(children) do
			if child.Class == "Attachment" and child.Props and child.Props.RelCF then
				relCF = child.Props.RelCF
				break
			end
		end

		if not relCF then
			return
		end

		for _, child in ipairs(arg:GetChildren()) do
			if child:IsA("RigidConstraint") then
				local attachment1 = child.Attachment1

				if attachment1 and attachment1.Parent == arg then
					pcall(function()
						attachment1.CFrame = relCF
					end)
				end
			end
		end
	end

	_G.__MM2ClearChromaArtifacts = function(arg)
		if not arg then
			return
		end
		_G.MM2ChromaGroups[arg] = nil

		for _, descendant in ipairs(arg:GetDescendants()) do
			_G.MM2ChromaGroups[descendant] = nil
		end

		local tbl8 = {}

		for _, descendant in ipairs(arg:GetDescendants()) do
			local v5 = string.lower(descendant.Name)

			if v5 == "chroma" or v5 == "chromascript" or v5 == "chromapart" or v5 == "chromafire" then
				if not descendant:GetAttribute("MM2SkinExtra") then
					tbl8[#tbl8 + 1] = descendant
				end
			end
		end

		for _, v5 in ipairs(tbl8) do
			pcall(function()
				v5:Destroy()
			end)
		end
	end

	local function fn19(arg)
		if not arg then
			return
		end
		local CollectionService = game:GetService("CollectionService")
		local tbl8 = { arg }

		for _, descendant in ipairs(arg:GetDescendants()) do
			tbl8[#tbl8 + 1] = descendant
		end

		for _, v5 in ipairs(tbl8) do
			for _, v6 in ipairs({ "ChromaPart", "ChromaDecal", "ChromaFire" }) do
				pcall(function()
					CollectionService:RemoveTag(v5, v6)
				end)
			end
		end
	end

	_G.MM2ChromaGroups = {}

	local function fn20(arg)
		local v5, v6, v7 = arg:ToHSV()
		return v6 > 0.83 and v7 > 0.6 and (v5 < 0.05 or v5 > 0.95)
	end

	local function fn21(arg)
		local tbl8 = { Parts = {}, Decals = {}, FX = {} }
		local decals = {}

		if arg:IsA("BasePart") and fn20(arg.Color) then
			tbl8.Parts[#tbl8.Parts + 1] = arg
		end

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant ~= arg then
				if descendant:IsA("BasePart") then
					if descendant.Material == Enum.Material.Neon or fn20(descendant.Color) then
						tbl8.Parts[#tbl8.Parts + 1] = descendant
					end
				elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
					decals[#decals + 1] = descendant
				elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") or descendant:IsA("Trail") or descendant:IsA("Fire") or descendant:IsA("Sparkles") then
					tbl8.FX[#tbl8.FX + 1] = descendant
				end
			end
		end

		if #tbl8.Parts > 0 then
			for _, decal in ipairs(decals) do
				if decal.Transparency > 0.3 then
					tbl8.Decals[#tbl8.Decals + 1] = decal
				end
			end
		else
			tbl8.Decals = decals
		end

		if #tbl8.Parts == 0 and #tbl8.Decals == 0 and #tbl8.FX == 0 then
			return
		end
		_G.MM2ChromaGroups[arg] = tbl8
	end

	local tbl8 = {
		Gun = { Rot = CFrame.Angles(-1.5707963267948966, 0, 0), Pos = Vector3.new(0, -0.1, 0.2), Len = 0 },
		Knife = { Rot = CFrame.Angles(0, 0, 0), Pos = Vector3.new(0, 0.1, 0.1), Len = 0 },
	}

	local tbl9 = {
		Blizzard = { Pos = Vector3.new(0, 0.55, 0) },
		Gingerscope = {
			Pos = Vector3.new(0, -0.1, 0.2),
			Rot = CFrame.Angles(-0.1308996938995747, 0.087266462599716474, 0),
		},
	}

	_G.MM2HeldFitOverride = _G.MM2HeldFitOverride or {}

	local function fn22(arg)
		if type(arg) ~= "table" then
			return tbl8.Gun.Rot
		end
		local size = fn14(arg)
		size = size and size.Size
		if typeof(size) ~= "Vector3" then
			return tbl8.Gun.Rot
		end
		local n2 = math.abs(size.X)
		local n3 = math.abs(size.Y)
		local n4 = math.abs(size.Z)
		if n3 >= n2 and n3 >= n4 then
			return tbl8.Gun.Rot
		end
		return CFrame.Angles(-0.1308996938995747, 0, 0)
	end

	local function fn23(arg, arg2)
		local str = arg and arg.ItemType == "Knife" and "Knife" or "Gun"
		local v5 = tbl8[str]
		local rot = str == "Gun" and arg2 and fn22(arg2) or v5.Rot
		local pos = v5.Pos
		local len = v5.Len

		local function fn24(arg3)
			if type(arg3) ~= "table" then
				return
			end
			rot = arg3.Rot or rot
			pos = arg3.Pos or pos
			len = arg3.Len or len
		end

		local itemName = arg and arg.ItemName

		if itemName then
			fn24(tbl9[itemName])
			fn24(_G.MM2HeldFitOverride[itemName])
		end

		return { Rot = rot, Pos = pos, Len = len }
	end

	local function fn24(parent, arg, arg2, arg3, arg4)
		if not parent or not parent:IsA("BasePart") or type(arg) ~= "table" then
			return false
		end
		_G.__MM2ClearChromaArtifacts(parent)

		for _, child in ipairs(parent:GetChildren()) do
			if child:GetAttribute("MM2SkinExtra") or child:GetAttribute("GingerscopeExtra") or child:IsA("SurfaceAppearance") then
				child:Destroy()
			end
		end

		fn19(parent)

		if parent:GetAttribute("MM2OriginalSize") == nil then
			parent:SetAttribute("MM2OriginalSize", parent.Size)
		end

		local props = arg.Props or {}
		local v5 = fn14(arg)
		local vector = typeof(arg3) == "Vector3" and arg3 or Vector3.one

		for k, prop in pairs(props) do
			if k ~= "RelCF" and k ~= "Size" and k ~= "MeshId" and k ~= "TextureID" then
				pcall(function()
					parent[k] = prop
				end)
			end
		end

		local part = nil

		if parent:IsA("MeshPart") and v5.MeshId then
			pcall(function()
				parent.Transparency = 1
			end)

			if props.Size then
				pcall(function()
					parent.Size = props.Size
				end)
			end

			if v5.FromMeshPart then
				local ok, result = pcall(function()
					return game:GetService("InsertService"):CreateMeshPartAsync(v5.MeshId, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise)
				end)

				if ok and typeof(result) == "Instance" then
					part = result

					pcall(function()
						part.TextureID = v5.TextureId or ""
					end)

					if v5.Size then
						pcall(function()
							part.Size = v5.Size * vector
						end)
					end
				end
			else
				part = Instance.new("Part")
				part.Size = (props.Size or parent.Size) * vector
				local specialMesh = Instance.new("SpecialMesh")
				specialMesh.MeshType = Enum.MeshType.FileMesh
				specialMesh.MeshId = v5.MeshId
				specialMesh.TextureId = v5.TextureId or ""

				if v5.Scale then
					specialMesh.Scale = v5.Scale * vector
				end

				if v5.Offset then
					specialMesh.Offset = v5.Offset
				end

				if v5.VertexColor then
					specialMesh.VertexColor = v5.VertexColor
				end

				specialMesh.Parent = part
			end

			if part then
				part.Name = "SkinMesh"
				part.CFrame = parent.CFrame
				part.Anchored = false
				part.CanCollide = false
				part.CanQuery = false
				part.Massless = true
				part.Transparency = props.Transparency or 0

				if props.Color then
					part.Color = props.Color
				end

				if props.Material then
					part.Material = props.Material
				end

				if props.Reflectance then
					part.Reflectance = props.Reflectance
				end

				part:SetAttribute("MM2SkinExtra", true)
				part.Parent = parent
				local weldConstraint = Instance.new("WeldConstraint")
				weldConstraint.Part0 = part
				weldConstraint.Part1 = parent
				weldConstraint:SetAttribute("MM2SkinExtra", true)
				weldConstraint.Parent = part
			else
				pcall(function()
					parent.Transparency = props.Transparency or 0
				end)
			end
		else
			local specialMesh = parent:FindFirstChildOfClass("SpecialMesh")

			if not specialMesh then
				specialMesh = Instance.new("SpecialMesh")
				specialMesh.Name = "Mesh"
				specialMesh:SetAttribute("MM2SkinExtra", true)
				specialMesh.Parent = parent
			end

			pcall(function()
				specialMesh.MeshType = Enum.MeshType.FileMesh
			end)

			if v5.MeshId then
				pcall(function()
					specialMesh.MeshId = v5.MeshId
				end)
			end

			pcall(function()
				specialMesh.TextureId = v5.TextureId or ""
			end)

			local offset = v5.Offset or Vector3.new()

			if v5.VertexColor then
				pcall(function()
					specialMesh.VertexColor = v5.VertexColor
				end)
			end

			if v5.Scale then
				pcall(function()
					specialMesh.Scale = v5.Scale
				end)
			elseif v5.FromMeshPart and v5.Size then
				local v6 = fn15(v5.MeshId)

				if v6 then
					pcall(function()
						specialMesh.Scale = v5.Size / v6
					end)
				end
			end

			if arg4 and typeof(v5.Size) == "Vector3" then
				offset += Vector3.new(0, 0, v5.Size.Z * fn23(arg2).Len)
			end

			pcall(function()
				specialMesh.Offset = offset
			end)

			if props.Size and not arg4 then
				pcall(function()
					parent.Size = props.Size
				end)
			end
		end

		fn18(parent, arg)
		local v6 = part or parent
		arg2 = arg2 and arg2.Chroma == true

		local tbl10 = {
			Decal = true,
			Texture = true,
			Beam = true,
			Sound = true,
			ParticleEmitter = true,
			Trail = true,
			Fire = true,
			Sparkles = true,
		}

		local v7 = ipairs
		local children = arg.Children or {}

		for _, child in v7(children) do
			if child ~= v5.MeshNode and not tbl7[child.Class] and (not arg4 or tbl10[child.Class]) then
				fn17(child, v6, CFrame.new(), v6, 1):SetAttribute("MM2SkinExtra", true)
			end
		end

		if arg2 then
			fn21(v6)
		else
			_G.MM2ChromaGroups[parent] = nil

			if part then
				_G.MM2ChromaGroups[part] = nil
			end
		end

		return true
	end

	_G.__HeldGunBaseGrip = function(arg, arg2, arg3)
		if arg2 and arg2.ItemType == "Knife" then
			return arg3
		end
		local handle = arg:FindFirstChild("Handle")
		if not handle then
			return arg3
		end
		local attribute = handle:GetAttribute("MM2OriginalSize")

		if typeof(attribute) ~= "Vector3" then
			attribute = handle.Size
		end

		if attribute.Y > attribute.X and attribute.Y > attribute.Z then
			return CFrame.new(0, -0.21, 0.47)
		end
		return arg3
	end

	local function fn25(arg, arg2, arg3)
		if not arg or not arg:IsA("Tool") then
			return
		end

		if arg:GetAttribute("MM2OriginalGrip") == nil then
			arg:SetAttribute("MM2OriginalGrip", arg.Grip)
		end

		local attribute = arg:GetAttribute("MM2OriginalGrip")
		if typeof(attribute) ~= "CFrame" then
			return
		end
		local v5 = _G.__HeldGunBaseGrip(arg, arg2, attribute)
		local v6 = fn23(arg2, arg3)

		pcall(function()
			arg.Grip = v5 * v6.Rot + v6.Pos
		end)
	end

	local function fn26(arg)
		local character = localPlayer.Character
		local weaponDisplays = character and workspace:FindFirstChild("WeaponDisplays")
		if not weaponDisplays then
			return nil
		end
		local str = arg == "Knife" and "KnifeDisplay" or "GunDisplay"

		for _, child in ipairs(weaponDisplays:GetChildren()) do
			if child.Name == str then
				local rigidConstraint = child:FindFirstChildOfClass("RigidConstraint")
				rigidConstraint = rigidConstraint and rigidConstraint.Attachment0
				if rigidConstraint and rigidConstraint:IsDescendantOf(character) then
					return child
				end
			end
		end

		return nil
	end

	local function fn27(arg)
		local character = localPlayer.Character
		character = character and character:FindFirstChild(arg)
		if character and character:IsA("Tool") then
			return character
		end
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		backpack = backpack and backpack:FindFirstChild(arg)
		if backpack and backpack:IsA("Tool") then
			return backpack
		end
		return nil
	end

	local function fn28(arg, textureId)
		if not arg or not arg:IsA("Tool") or not textureId or textureId == "" then
			return false
		end
		local textureId2 = arg.TextureId
		if textureId2 == textureId then
			return true
		end

		pcall(function()
			arg.TextureId = textureId
		end)

		pcall(function()
			for _, child in ipairs(localPlayer.PlayerGui.BackpackUI.BackpackFrame:GetChildren()) do
				local container = child:IsA("GuiObject") and child:FindFirstChild("Container")
				local toolIcon = container and container:FindFirstChild("ToolIcon")

				if toolIcon and toolIcon.Image == textureId2 then
					toolIcon.Image = textureId
					local nameLabel = container:FindFirstChild("NameLabel")

					if nameLabel then
						nameLabel.Text = ""
					end
				end
			end
		end)

		return true
	end

	local tbl10 = {
		{ "CrossPlatform", "ItemFrameTest", "ItemFrame", "Tags", "FX" },
		{ "MainGUI", "Inventory2", "EquipContainer", "ItemFrame", "Tags", "FX" },
		{ "TradeGUI", "Container", "Trade", "YourOffer", "Container", "NewItem1", "Tags", "FX" },
	}

	local function fn29()
		for _, v5 in ipairs(tbl10) do
			local playerGui = localPlayer:FindFirstChild("PlayerGui")

			for _, v6 in ipairs(v5) do
				playerGui = playerGui and playerGui:FindFirstChild(v6)
				if playerGui then
					continue
				end
				break
			end

			if playerGui then
				return playerGui
			end
		end

		return nil
	end

	local function fn30(arg)
		local parent = arg.Parent
		if not parent then
			return
		end
		local n2 = 0

		for _, child in ipairs(parent:GetChildren()) do
			if child ~= arg and child:IsA("GuiObject") then
				n2 = math.max(n2, child.ZIndex)
			end
		end

		if arg.ZIndex <= n2 then
			arg.ZIndex = n2 + 1
		end
	end

	local function fn31(parent)
		local fx = parent:FindFirstChild("FX")

		if not fx then
			local v5 = fn29()
			if not v5 then
				return nil
			end
			fx = v5:Clone()
			fx.Name = "FX"
			fx.LayoutOrder = 1
			fx:SetAttribute("MM2SkinExtra", true)
			fx.Parent = parent
		end

		return fx
	end

	local tbl11 = { "FX", "Chroma", "Evo", "Christmas", "Halloween", "Unique" }

	local function fn32(arg, arg2)
		if not arg then
			return
		end

		for _, v5 in ipairs(tbl11) do
			local v6 = arg:FindFirstChild(v5)

			if v6 and v6:IsA("GuiObject") then
				v6.Visible = false
			end
		end

		if arg2.FX then
			local v5 = fn31(arg)

			if v5 then
				v5.Visible = true
			end
		end

		if arg2.Chroma then
			local chroma = arg:FindFirstChild("Chroma")

			if chroma then
				chroma.Visible = true
			end
		end

		if arg2.Event == "Christmas" or arg2.Event == "Halloween" then
			local v5 = arg:FindFirstChild(arg2.Event)

			if v5 then
				v5.Visible = true
				local text = tostring(arg2.Year or "")

				pcall(function()
					v5.Year.Text = text
				end)

				pcall(function()
					v5.Year2.Text = text
				end)
			end
		end

		fn30(arg)
	end

	local function fn33(arg)
		local str = arg.ItemType == "Knife" and "Knife" or "Gun"
		local common = tbl5[arg.Rarity] or tbl5.Common

		pcall(function()
			local container = localPlayer.PlayerGui.MainGUI.Game.Inventory.Main.Weapons.Equipped.Container[str].Container
			container.ItemName.Label.Text = arg.ItemName
			container.ItemName.BackgroundColor3 = common
			container.Container.Icon.Image = arg.Image
			container.Container.Amount.Text = ""
			fn32(container:FindFirstChild("Tags"), arg)
		end)

		pcall(function()
			local itemFrame = localPlayer.PlayerGui.MainGUI.Inventory2.EquipContainer.ItemFrame
			itemFrame.ItemName.Label.Text = arg.ItemName
			itemFrame.ItemName.BackgroundColor3 = common
			itemFrame.Container.Icon.Image = arg.Image
			fn32(itemFrame:FindFirstChild("Tags"), arg)
		end)
	end

	_G.MM2SkinChoice = _G.MM2SkinChoice or {}
	local tbl12 = { Harvester = Vector3.new(1, 1.6, 1), Icepiercer = Vector3.new(1, 1.6, 1) }
	_G.MM2SkinApplied = _G.MM2SkinApplied or {}

	local function fn34(arg)
		local v5 = _G.MM2SkinChoice[arg]
		if not v5 then
			return false
		end
		local v6 = fn12()
		v6 = v6 and v6[v5]
		if not v6 or type(v6.Model) ~= "table" then
			return false
		end
		local v7 = fn26(arg)
		local flag2 = false

		if v7 then
			fn24(v7, v6.Model, v6.Meta, tbl12[v5])
			flag2 = true
		end

		local v8 = fn27(arg)

		if v8 then
			fn28(v8, v6.Meta and v6.Meta.Image)
			local handle = v8:FindFirstChild("Handle")

			if handle then
				fn24(handle, v6.Model, v6.Meta, tbl12[v5], true)
				fn25(v8, v6.Meta, v6.Model)
				flag2 = true
			end
		end

		if v6.Meta then
			fn33(v6.Meta)
		end

		if flag2 then
			_G.MM2SkinApplied[arg] = v5
		end

		return flag2
	end

	local function fn35()
		local flag2 = false

		for _, v5 in ipairs({ "Gun", "Knife" }) do
			if fn34(v5) then
				flag2 = true
			end
		end

		return flag2
	end

	local function fn36(character)
		if not character then
			return
		end

		table.insert(_G.CoinESPConn, character.ChildAdded:Connect(function(child)
			if child:IsA("Tool") and _G.MM2SkinChoice[child.Name] then
				task.defer(function()
					fn34(child.Name)
				end)
			end
		end))

		local backpack = localPlayer:FindFirstChildOfClass("Backpack")

		if backpack then
			table.insert(_G.CoinESPConn, backpack.ChildAdded:Connect(function(child)
				if child:IsA("Tool") and _G.MM2SkinChoice[child.Name] then
					task.defer(function()
						fn34(child.Name)
					end)
				end
			end))
		end

		task.spawn(function()
			for i = 1, 20 do
				if localPlayer.Character ~= character then
					return
				end

				if next(_G.MM2SkinChoice) and fn35() then
					return
				end
				task.wait(0.25)
			end
		end)
	end

	if localPlayer.Character then
		fn36(localPlayer.Character)
	end

	table.insert(_G.CoinESPConn, localPlayer.CharacterAdded:Connect(fn36))

	_G.__MM2RescanChroma = function()
		for k in pairs(_G.MM2ChromaGroups) do
			if not k.Parent then
				_G.MM2ChromaGroups[k] = nil
			end
		end

		for _, v5 in ipairs({ "Gun", "Knife" }) do
			local v6 = fn26(v5)

			if v6 and _G.MM2SkinChoice[v5] and v6:GetAttribute("MM2OriginalSize") == nil then
				pcall(fn34, v5)
				v6 = fn26(v5)
			end

			local v7 = _G.MM2SkinApplied[v5]

			if v7 then
				v7 = (_G.MM2SkinData or {})[v7]
			end

			if v7 and v7.Meta and v7.Meta.Chroma == true then
				if v6 and not _G.MM2ChromaGroups[v6] then
					fn21(v6)
				end

				local handle = fn27(v5)
				handle = handle and handle:FindFirstChild("Handle")

				if handle and not _G.MM2ChromaGroups[handle] then
					fn21(handle)
				end
			elseif v7 then
				if v6 then
					_G.__MM2ClearChromaArtifacts(v6)
				end

				local handle = fn27(v5)
				handle = handle and handle:FindFirstChild("Handle")

				if handle then
					_G.__MM2ClearChromaArtifacts(handle)
				end
			end
		end
	end

	_G.__MM2ChromaState = { hue = 0, since = 1 }

	table.insert(_G.CoinESPConn, RunService.Heartbeat:Connect(function(deltaTime)
		local n2 = math.clamp(tonumber(deltaTime) or 0.016, 0, 0.1)
		local mM2ChromaState = _G.__MM2ChromaState
		mM2ChromaState.since = mM2ChromaState.since + n2

		if mM2ChromaState.since >= 2 then
			mM2ChromaState.since = 0
			pcall(_G.__MM2RescanChroma)
		end

		if not next(_G.MM2ChromaGroups) then
			return
		end
		mM2ChromaState.hue = (mM2ChromaState.hue + n2 * 0.32) % 1
		local color = Color3.fromHSV(mM2ChromaState.hue, 1, 1)
		local colorSequence = ColorSequence.new(color)

		for k, mM2ChromaGroup in pairs(_G.MM2ChromaGroups) do
			if not k.Parent then
				_G.MM2ChromaGroups[k] = nil
			else
				for _, part in ipairs(mM2ChromaGroup.Parts) do
					if part.Parent then
						part.Color = color
					end
				end

				local v5 = ipairs
				local decals = mM2ChromaGroup.Decals or {}

				for _, decal in v5(decals) do
					if decal.Parent then
						pcall(function()
							decal.Color3 = color
						end)
					end
				end

				for _, v6 in ipairs(mM2ChromaGroup.FX) do
					if v6.Parent then
						pcall(function()
							if v6:IsA("ParticleEmitter") or v6:IsA("Beam") or v6:IsA("Trail") then
								v6.Color = colorSequence
							elseif v6:IsA("Fire") then
								v6.Color = color
								v6.SecondaryColor = color
							elseif v6:IsA("Sparkles") then
								v6.SparkleColor = color
							end
						end)
					end
				end
			end
		end
	end))

	_G.SkinChanger = {
		LoadData = fn12,
		RarityColor = tbl5,
		ListSkins = function(arg)
			local v5, v6 = fn12()
			if not v5 then
				return nil, v6
			end
			local tbl13 = {}

			for k, v7 in pairs(v5) do
				local meta = v7.Meta

				if type(meta) == "table" and meta.ItemType == arg then
					tbl13[#tbl13 + 1] = {
						Key = k,
						Name = tostring(meta.ItemName or k),
						Rarity = tostring(meta.Rarity or ""),
						Chroma = meta.Chroma == true,
					}
				end
			end

			local function fn37(arg2)
				if arg2.Rarity == "Ancient" then
					return 1
				end

				if arg2.Chroma then
					return 2
				end
				return 3
			end

			table.sort(tbl13, function(arg2, arg3)
				local v7 = fn37(arg2)
				local v8 = fn37(arg3)
				if v7 ~= v8 then
					return v7 < v8
				end

				if arg2.Name ~= arg3.Name then
					return arg2.Name < arg3.Name
				end
				return arg2.Key < arg3.Key
			end)

			return tbl13
		end,
		Select = function(arg, arg2)
			_G.MM2SkinChoice[arg] = arg2
		end,
		Apply = function(arg)
			if not localPlayer.Character then
				return false, "Character not found."
			end

			if not _G.MM2SkinChoice[arg] then
				return false, "Pick a skin first."
			end

			if fn34(arg) then
				return true, "Skin Changed"
			end
			return false, arg .. " not found, try again in a moment."
		end,
		Clear = function(arg)
			_G.MM2SkinChoice[arg] = nil
		end,
		TuneHeld = function(arg, arg2)
			local tbl13 = arg2 or {}
			local v5 = _G.MM2SkinApplied[arg] or _G.MM2SkinChoice[arg]
			local v6 = fn12()
			local v7 = v5 and v6 and v6[v5]
			local itemName = v7 and v7.Meta and v7.Meta.ItemName
			if not itemName then
				return false, "no skin applied to " .. tostring(arg)
			end
			local tbl14 = _G.MM2HeldFitOverride[itemName] or {}

			if tbl13.RotX or tbl13.RotY or tbl13.RotZ then
				tbl14.Rot = CFrame.Angles(tbl13.RotX or 0, tbl13.RotY or 0, tbl13.RotZ or 0)
			end

			if tbl13.Pos ~= nil then
				tbl14.Pos = tbl13.Pos
			end

			if tbl13.Len ~= nil then
				tbl14.Len = tbl13.Len
			end

			_G.MM2HeldFitOverride[itemName] = tbl14
			fn34(arg)
			local v8, v9, v10 = (tbl14.Rot or CFrame.new()):ToEulerAnglesXYZ()
			print(("[HELD_FIT_SKIN] %s = { Rot = CFrame.Angles(%.4f, %.4f, %.4f), Pos = %s, Len = %s },"):format(itemName, v8, v9, v10, tostring(tbl14.Pos or Vector3.new()), tostring(tbl14.Len or 0)))
			return true, "tuned"
		end,
	}
end

if _G.__SupportHandConn then
	pcall(function()
		_G.__SupportHandConn:Disconnect()
	end)
end

pcall(function()
	RunService:UnbindFromRenderStep("MM2SupportHandPose")
end)

if _G.__SupportHandShoulderRestore then
	local supportHandShoulderRestore = _G.__SupportHandShoulderRestore

	pcall(function()
		supportHandShoulderRestore.object[supportHandShoulderRestore.property] = supportHandShoulderRestore.value
	end)

	_G.__SupportHandShoulderRestore = nil
end

if _G.__ShoulderProbeOrig then
	pcall(function()
		localPlayer.Character.LeftUpperArm.LeftShoulder.Attachment0.CFrame = _G.__ShoulderProbeOrig
	end)

	_G.__ShoulderProbeOrig = nil
end

if _G.__SupportHandIK then
	pcall(function()
		_G.__SupportHandIK:Destroy()
	end)
end

if _G.__SupportHandTarget then
	pcall(function()
		_G.__SupportHandTarget:Destroy()
	end)
end

if _G.__SupportHandPole then
	pcall(function()
		_G.__SupportHandPole:Destroy()
	end)
end

if _G.__SupportHandPalm then
	pcall(function()
		_G.__SupportHandPalm:Destroy()
	end)
end

if _G.__IKPoleProbe then
	pcall(function()
		_G.__IKPoleProbe:Destroy()
	end)

	_G.__IKPoleProbe = nil
end

if _G.__PalmProbe then
	pcall(function()
		_G.__PalmProbe:Destroy()
	end)

	_G.__PalmProbe = nil
end

if _G.__IKProbe then
	pcall(function()
		_G.__IKProbe.ik:Destroy()
	end)

	pcall(function()
		_G.__IKProbe.target:Destroy()
	end)

	_G.__IKProbe = nil
end

_G.__SupportHandCfg = { Pos = Vector3.new(-0.2, -0.27, 0.7), Palm = Vector3.new(-0.07, -0.29, 0.24) }

do
	local supportHandCfg = _G.__SupportHandCfg
	local flag2 = false
	local v5 = nil
	local v6 = nil

	local function fn12()
		if _G.__SupportHandIK then
			_G.__SupportHandIK:Destroy()
			_G.__SupportHandIK = nil
		end

		if _G.__SupportHandTarget then
			_G.__SupportHandTarget:Destroy()
			_G.__SupportHandTarget = nil
		end

		if _G.__SupportHandPole then
			_G.__SupportHandPole:Destroy()
			_G.__SupportHandPole = nil
		end

		if _G.__SupportHandPalm then
			_G.__SupportHandPalm:Destroy()
			_G.__SupportHandPalm = nil
		end

		if _G.__SupportHandShoulderRestore then
			local supportHandShoulderRestore = _G.__SupportHandShoulderRestore

			pcall(function()
				supportHandShoulderRestore.object[supportHandShoulderRestore.property] = supportHandShoulderRestore.value
			end)

			_G.__SupportHandShoulderRestore = nil
		end

		v5 = nil
		v6 = nil
	end

	local function fn13()
		local gun = _G.MM2SkinApplied and _G.MM2SkinApplied.Gun
		if gun == "Gingerscope" then
			return true
		end
		local mM2SkinData = _G.MM2SkinData
		local flag3 = gun and type(mM2SkinData) == "table" and mM2SkinData[gun]
		return flag3 and flag3.Meta and flag3.Meta.ItemName == "Gingerscope" or false
	end

	local function fn14()
		local character = localPlayer.Character
		local gun = character and character:FindFirstChild("Gun")
		local handle = gun and gun:IsA("Tool") and gun:FindFirstChild("Handle")
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")

		if not (flag2 or fn13()) or not handle or not handle:IsA("BasePart") or not humanoid or not character:FindFirstChild("UpperTorso") or not character:FindFirstChild("LeftUpperArm") or not character:FindFirstChild("LeftHand") then
			if v6 then
				fn12()
			end

			_G.__SupportHandState = "inactive"
			return
		end

		if v5 == character and v6 == handle and _G.__SupportHandIK and _G.__SupportHandIK.Parent == humanoid then
			return
		end
		fn12()
		local n2 = character.LeftUpperArm.Size.Y + character.LeftLowerArm.Size.Y + character.LeftHand.Size.Y

		if math.abs(n2 / 2.38 - 1) > 0.15 then
			v5 = character
			v6 = handle
			_G.__SupportHandState = "off: arm length " .. string.format("%.2f", n2)
			return
		end

		local leftShoulder = character.LeftUpperArm:FindFirstChild("LeftShoulder")

		if leftShoulder and leftShoulder:IsA("AnimationConstraint") and leftShoulder.Attachment0 then
			local attachment0 = leftShoulder.Attachment0
			_G.__SupportHandShoulderRestore = { object = attachment0, property = "CFrame", value = attachment0.CFrame }
			attachment0.CFrame = attachment0.CFrame + Vector3.new(0.38, 0, -0.42)
		elseif leftShoulder and leftShoulder:IsA("Motor6D") then
			_G.__SupportHandShoulderRestore = { object = leftShoulder, property = "C0", value = leftShoulder.C0 }
			leftShoulder.C0 = leftShoulder.C0 + Vector3.new(0.38, 0, -0.42)
		end

		local attachment = Instance.new("Attachment")
		attachment.Name = "MM2SupportHandTarget"
		attachment.Position = supportHandCfg.Pos
		attachment.Parent = handle
		local attachment2 = Instance.new("Attachment")
		attachment2.Name = "MM2SupportHandPole"
		attachment2.Position = Vector3.new(-1.4, -0.6, -0.8)
		attachment2.Parent = character.UpperTorso
		local attachment3 = Instance.new("Attachment")
		attachment3.Name = "MM2SupportPalm"
		attachment3.Position = supportHandCfg.Palm
		attachment3.Parent = character.LeftHand
		local ikControl = Instance.new("IKControl")
		ikControl.Name = "MM2SupportHandIK"
		ikControl.Type = Enum.IKControlType.Position
		ikControl.ChainRoot = character.LeftUpperArm
		ikControl.EndEffector = attachment3
		ikControl.Target = attachment
		ikControl.Pole = attachment2
		ikControl.Weight = 1
		ikControl.SmoothTime = 0.12
		ikControl.Parent = humanoid
		local v7 = _G
		_G.__SupportHandTarget = attachment
		v7.__SupportHandPole = attachment2
		local v8 = _G
		_G.__SupportHandPalm = attachment3
		v8.__SupportHandIK = ikControl
		v5 = character
		v6 = handle
		_G.__SupportHandState = "IK active"
	end

	_G.TwoHandHoldSetEnabled = function(arg)
		flag2 = arg and true or false
		fn14()
	end

	_G.TwoHandHoldEnabled = function()
		return flag2 or fn13()
	end

	_G.SupportHandTune = function(arg)
		if type(arg) == "table" and typeof(arg.Pos) == "Vector3" then
			supportHandCfg.Pos = arg.Pos

			if _G.__SupportHandTarget then
				_G.__SupportHandTarget.Position = supportHandCfg.Pos
			end
		end

		if type(arg) == "table" and typeof(arg.Palm) == "Vector3" then
			supportHandCfg.Palm = arg.Palm

			if _G.__SupportHandPalm then
				_G.__SupportHandPalm.Position = supportHandCfg.Palm
			end
		end

		return true
	end

	_G.__SupportHandConn = RunService.Heartbeat:Connect(fn14)
	fn14()
end

do
	local str = "Gun"
	local tbl5 = { pos = Vector3.zero, len = 0, rx = -1.5707963267948966, ry = 0, rz = 0 }
	local flag2 = false
	local flag3 = false
	local connection2 = nil

	local function fn12()
		local mM2SkinApplied = _G.MM2SkinApplied and _G.MM2SkinApplied[str] or _G.MM2SkinChoice and _G.MM2SkinChoice[str]
		local mM2SkinData = _G.MM2SkinData
		local flag4 = mM2SkinApplied and type(mM2SkinData) == "table" and mM2SkinData[mM2SkinApplied]
		return flag4 and flag4.Meta and flag4.Meta.ItemName or nil
	end

	local function fn13()
		local v5 = tbl5
		local v6 = tbl5
		local v7 = tbl5
		local v8 = tbl5
		tbl5.pos = Vector3.new()
		v5.len = 0
		v6.rx = -1.5707963267948966
		v7.ry = 0
		v8.rz = 0
		local v9 = fn12()
		local mM2HeldFitOverride = v9 and _G.MM2HeldFitOverride and _G.MM2HeldFitOverride[v9]

		if type(mM2HeldFitOverride) == "table" then
			if typeof(mM2HeldFitOverride.Pos) == "Vector3" then
				tbl5.pos = mM2HeldFitOverride.Pos
			end

			if type(mM2HeldFitOverride.Len) == "number" then
				tbl5.len = mM2HeldFitOverride.Len
			end

			if typeof(mM2HeldFitOverride.Rot) == "CFrame" then
				local v10 = tbl5
				local v11 = tbl5
				local v12 = tbl5
				local v13, v14, v15 = mM2HeldFitOverride.Rot:ToEulerAnglesXYZ()
				v10.rx = v13
				v11.ry = v14
				v12.rz = v15
			end
		end

		flag2 = true
	end

	local function fn14()
		if not (_G.SkinChanger and _G.SkinChanger.TuneHeld) then
			return
		end
		local str2, v5 = _G.SkinChanger.TuneHeld(str, { Pos = tbl5.pos, Len = tbl5.len, RotX = tbl5.rx, RotY = tbl5.ry, RotZ = tbl5.rz })

		if _G.WindNotify then
			local windNotify = _G.WindNotify
			local str3 = "Grip Tuner (" .. str .. ")"
			str2 = str2 and ("Pos %.2f, %.2f, %.2f   Len %.2f"):format(tbl5.pos.X, tbl5.pos.Y, tbl5.pos.Z, tbl5.len)

			if not str2 then
				str2 = tostring(v5 or "no " .. str .. " skin applied")
			end

			windNotify(str3, str2, "wrench")
		end
	end

	local tbl6 = {
		[Enum.KeyCode.KeypadEight] = function(arg)
			tbl5.pos = tbl5.pos - Vector3.new(0, arg, 0)
		end,
		[Enum.KeyCode.KeypadTwo] = function(arg)
			tbl5.pos = tbl5.pos + Vector3.new(0, arg, 0)
		end,
		[Enum.KeyCode.KeypadFour] = function(arg)
			tbl5.pos = tbl5.pos - Vector3.new(0, 0, arg)
		end,
		[Enum.KeyCode.KeypadSix] = function(arg)
			tbl5.pos = tbl5.pos + Vector3.new(0, 0, arg)
		end,
		[Enum.KeyCode.KeypadOne] = function(arg)
			tbl5.pos = tbl5.pos - Vector3.new(arg, 0, 0)
		end,
		[Enum.KeyCode.KeypadThree] = function(arg)
			tbl5.pos = tbl5.pos + Vector3.new(arg, 0, 0)
		end,
		[Enum.KeyCode.KeypadSeven] = function(arg)
			tbl5.len = tbl5.len - arg * 0.3
		end,
		[Enum.KeyCode.KeypadNine] = function(arg)
			tbl5.len = tbl5.len + arg * 0.3
		end,
		[Enum.KeyCode.KeypadMinus] = function(arg)
			tbl5.rx = tbl5.rx - arg * 0.35
		end,
		[Enum.KeyCode.KeypadPlus] = function(arg)
			tbl5.rx = tbl5.rx + arg * 0.35
		end,
		[Enum.KeyCode.KeypadFive] = function()
		end,
	}

	_G.GripTunerSetEnabled = function(arg)
		flag3 = arg and true or false

		if flag3 and not connection2 then
			connection2 = UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed or not flag3 then
					return
				end
				local keyCode = input.KeyCode

				if keyCode == Enum.KeyCode.KeypadMultiply then
					str = str == "Gun" and "Knife" or "Gun"
					flag2 = false

					if _G.WindNotify then
						_G.WindNotify("Grip Tuner", "target -> " .. str, "repeat")
					end

					return
				end

				if keyCode == Enum.KeyCode.KeypadPeriod then
					local v5 = fn12()

					if v5 and _G.MM2HeldFitOverride then
						_G.MM2HeldFitOverride[v5] = nil
					end

					flag2 = false

					if _G.SkinChanger and _G.SkinChanger.TuneHeld then
						pcall(_G.SkinChanger.TuneHeld, str, {})
					end

					if _G.WindNotify then
						_G.WindNotify("Grip Tuner", str .. " override cleared", "undo-2")
					end

					return
				end

				local v5 = tbl6[keyCode]
				if not v5 then
					return
				end

				if not flag2 then
					fn13()
				end

				v5((UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) and 0.025 or 0.1)
				fn14()
			end)

			table.insert(_G.CoinESPConn, connection2)
		elseif not flag3 and connection2 then
			connection2:Disconnect()
			connection2 = nil
		end
	end
end

local function fn12()
	local Players2 = game:GetService("Players")
	local TweenService2 = game:GetService("TweenService")
	local UserInputService2 = game:GetService("UserInputService")
	local HttpService = game:GetService("HttpService")
	local RunService2 = game:GetService("RunService")
	local localPlayer2 = Players2.LocalPlayer

	local tbl5 = {
		backpack = 140420225386018,
		badge = 116620312917084,
		barrel = 130647115622774,
		bomb = 139223800924636,
		bot = 80451686744860,
		candy = 107812129154678,
		["chart-line"] = 101833156055618,
		check = 93898873302694,
		["chevron-down"] = 134243273101015,
		["chevron-right"] = 92473583511724,
		["chevron-up"] = 122444883127455,
		["chevrons-up"] = 100467452364672,
		["circle-check"] = 85262178816537,
		["circle-dot"] = 82947033619201,
		["circle-off"] = 97923456918886,
		["circle-user"] = 136220511671311,
		["circle-x"] = 76821953846248,
		["clipboard-check"] = 92649798577170,
		["cloud-off"] = 131907154501444,
		cloud = 121226497050352,
		coffee = 106864403231093,
		coins = 116510979641930,
		copy = 78979572434545,
		crosshair = 134242818164054,
		egg = 117851493400222,
		["eye-off"] = 135928786788378,
		eye = 100033680381365,
		["folder-open"] = 76018996254888,
		footprints = 139192589041315,
		gauge = 110273524101447,
		gem = 112904952151156,
		ghost = 113822048130017,
		gift = 109855212076373,
		["git-commit-horizontal"] = 133646041800147,
		globe = 114238209622913,
		["grip-vertical"] = 137183678565296,
		hand = 130703864968637,
		hourglass = 86160434939203,
		house = 98755624629571,
		info = 124560466474914,
		keyboard = 121474456068237,
		layers = 81973586053257,
		["layout-grid"] = 81344910161871,
		link = 131607023382430,
		["list-checks"] = 99809353635593,
		["locate-fixed"] = 137367361548433,
		lock = 134724289526879,
		["maximize-2"] = 73085922906397,
		minus = 118026365011536,
		["minimize-2"] = 116269596042539,
		maximize = 76045941763188,
		monitor = 72664649203050,
		["mouse-pointer-click"] = 107150227368485,
		["move-down"] = 70510115135583,
		["move-up"] = 84505444262658,
		move = 116138709011735,
		navigation = 79308213542922,
		["package-open"] = 132890233237818,
		["paint-bucket"] = 124275586663284,
		palette = 86350350950064,
		["panel-top"] = 75838479462875,
		pipette = 133167932934404,
		plane = 126985561580989,
		play = 135609604299893,
		power = 96479131758775,
		["refresh-ccw"] = 117913330389477,
		["refresh-cw"] = 138133190015277,
		["repeat"] = 121886242955173,
		["rotate-ccw"] = 110116685948665,
		ruler = 81432445547423,
		save = 126116963775616,
		["scan-eye"] = 99244790601968,
		scan = 123104789658180,
		search = 121018724060431,
		send = 127751956873796,
		server = 92188766517878,
		settings = 80758916183665,
		["shield-check"] = 87354736164608,
		["shield-x"] = 73370117343811,
		shield = 110987169760162,
		["shopping-bag"] = 71885477293226,
		shuffle = 132382786975101,
		skull = 137726256442333,
		["sliders-horizontal"] = 85538382643347,
		smile = 105880397565283,
		sparkles = 138635884129147,
		square = 86304921356806,
		star = 136141469398409,
		sun = 110150589884127,
		sword = 124448418211665,
		swords = 81872698913435,
		table = 109109148250737,
		tag = 129104970103940,
		target = 87563802520297,
		["triangle-alert"] = 125920361880643,
		["undo-2"] = 113885292059932,
		["user-round-x"] = 122367980560930,
		["user-x"] = 139748155894754,
		user = 81589895647169,
		users = 115398113982385,
		video = 107587444636945,
		webhook = 112812457747322,
		wind = 114551690399915,
		wrench = 112148279212860,
		x = 110786993356448,
		zap = 130551565616516,
		["zoom-out"] = 108334162607319,
	}

	local color = Color3.fromRGB
	local color2 = Color3.new(1, 1, 1)

	local tbl6 = {
		ink = color(12, 12, 14),
		inkRaised = color(22, 22, 26),
		inkLine = color(34, 34, 39),
		inkText = color(244, 244, 246),
		inkSub = color(138, 138, 146),
		inkDim = color(90, 90, 98),
		side = color(15, 15, 18),
		page = color(9, 9, 11),
		pageTop = color(13, 13, 16),
		pageBottom = color(6, 6, 8),
		card = color(17, 17, 20),
		cardLine = color(33, 33, 38),
		divider = color(26, 26, 30),
		field = color(24, 24, 28),
		hover = color(23, 23, 27),
		track = color(44, 44, 51),
		text = color(243, 243, 245),
		sub = color(142, 142, 151),
		dim = color(92, 92, 100),
		accent = color2,
		danger = color(239, 68, 68),
		tile = color(24, 24, 29),
	}

	local fontWeight = Enum.FontWeight

	local function fn13(arg)
		return Font.new("rbxasset://fonts/families/BuilderSans.json", arg or fontWeight.Regular)
	end

	local tbl7

	tbl7 = {
		Palette = tbl6,
		Theme = {
			Text = tbl6.text,
			Placeholder = tbl6.sub,
			Primary = tbl6.accent,
			Icon = tbl6.sub,
			ElementBackground = tbl6.field,
			Button = tbl6.cardLine,
			Outline = tbl6.cardLine,
			Background = tbl6.page,
			Accent = tbl6.card,
			Dialog = tbl6.card,
			ToggleBar = color2,
			Toggle = tbl6.accent,
			Tile = tbl6.tile,
		},
		Icon = function(arg)
			if type(arg) ~= "string" or arg == "" then
				return ""
			end

			if arg:find("rbxasset") then
				return arg
			end
			local v5 = tbl5[arg]
			return v5 and "rbxassetid://" .. v5 or ""
		end,
		Creator = { Icon = function(arg)
			local v5 = tbl7.Icon(arg)
			if v5 == "" then
				return nil
			end
			return { v5, { ImageRectPosition = Vector2.zero, ImageRectSize = Vector2.zero } }
		end },
	}

	local function fn14(arg, arg2)
		local instance = Instance.new(arg)
		local v5 = nil

		for k, v6 in pairs(arg2) do
			if k == "Parent" then
				v5 = v6
			else
				instance[k] = v6
			end
		end

		if instance:IsA("GuiObject") and arg2.BorderSizePixel == nil then
			instance.BorderSizePixel = 0
		end

		if v5 then
			instance.Parent = v5
		end

		return instance
	end

	local function fn15(arg, arg2)
		return fn14("UICorner", { CornerRadius = UDim.new(0, arg2), Parent = arg })
	end

	local function fn16(arg, arg2, arg3)
		return fn14("UIStroke", {
			Color = arg2,
			Transparency = arg3 or 0,
			Thickness = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Parent = arg,
		})
	end

	local function fn17(arg, arg2)
		local TextLabel = fn14("TextLabel", {
			BackgroundTransparency = 1,
			FontFace = fn13(arg2.Weight),
			TextSize = arg2.Size or 14,
			TextColor3 = arg2.Color or tbl6.text,
			Text = arg2.Text or "",
			TextXAlignment = arg2.AlignX or Enum.TextXAlignment.Left,
			TextYAlignment = arg2.AlignY or Enum.TextYAlignment.Center,
			TextTruncate = arg2.Wrap and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd,
			TextWrapped = arg2.Wrap == true,
			AutoLocalize = false,
			Position = arg2.Position or UDim2.new(),
			Size = arg2.Box or UDim2.fromScale(1, 1),
			AnchorPoint = arg2.Anchor or Vector2.zero,
			ZIndex = arg2.Z or 1,
			Parent = arg,
		})

		if arg2.AutoX then
			TextLabel.AutomaticSize = Enum.AutomaticSize.X
		end

		if arg2.AutoY then
			TextLabel.AutomaticSize = Enum.AutomaticSize.Y
		end

		return TextLabel
	end

	local function fn18(arg, arg2, arg3, arg4, arg5)
		local tbl8 = arg5 or {}

		return fn14("ImageLabel", {
			BackgroundTransparency = 1,
			Image = tbl7.Icon(arg2),
			ImageColor3 = arg4 or tbl6.sub,
			Size = UDim2.fromOffset(arg3, arg3),
			AnchorPoint = tbl8.Anchor or Vector2.new(0, 0.5),
			Position = tbl8.Position or UDim2.new(0, 0, 0.5, 0),
			ZIndex = tbl8.Z or 1,
			Parent = arg,
		})
	end

	local tbl8 = { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5) }

	local function fn19(arg, arg2, arg3)
		local tween = TweenService2:Create(arg, TweenInfo.new(arg2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), arg3)
		tween:Play()
		return tween
	end

	local function fn20(arg, ...)
		if type(arg) ~= "function" then
			return
		end
		local v5 = pcall
		local v6 = table.pack(...)
		v6.n = 2 + v6.n - 1
		table.move(v6, 1, v6.n, 2, v6)
		v6[1] = arg
		local v7, v8 = v5(table.unpack(v6, 1, v6.n))

		if not v7 then
			warn("[Star UI] callback error: " .. tostring(v8))
		end
	end

	local function fn21(arg)
		return arg.UserInputType == Enum.UserInputType.MouseButton1 or arg.UserInputType == Enum.UserInputType.Touch
	end

	local function fn22(arg)
		return arg.UserInputType == Enum.UserInputType.MouseMovement or arg.UserInputType == Enum.UserInputType.Touch
	end

	local function fn23(arg, arg2, arg3, arg4)
		local flag2 = false
		local v5 = nil

		local function fn24()
			if not flag2 then
				return
			end
			flag2 = false

			if arg4 then
				arg4()
			end
		end

		arg.InputBegan:Connect(function(input)
			if not fn21(input) then
				return
			end
			flag2 = true
			v5 = input

			if arg2 then
				arg2(input.Position)
			end

			local connection2 = nil

			connection2 = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					connection2:Disconnect()
					fn24()
				end
			end)
		end)

		local connection2 = UserInputService2.InputChanged:Connect(function(input)
			if not flag2 or not fn22(input) then
				return
			end

			if v5.UserInputType == Enum.UserInputType.MouseButton1 and not UserInputService2:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
				fn24()
				return
			end

			if input.UserInputType == Enum.UserInputType.Touch and input ~= v5 then
				return
			end

			if v5.UserInputType == Enum.UserInputType.Touch and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			arg3(input.Position)
		end)

		local connection3 = UserInputService2.InputEnded:Connect(function(input)
			if not (flag2 and v5) then
				return
			end

			if v5.UserInputType == Enum.UserInputType.Touch then
				if input == v5 then
					fn24()
				end
			elseif input.UserInputType == v5.UserInputType then
				fn24()
			end
		end)

		arg.Destroying:Connect(function()
			connection3:Disconnect()
		end)

		return connection2
	end

	local function fn24()
		local ok, result = pcall(function()
			return gethui()
		end)

		if ok and result then
			return result
		end
		return game:GetService("CoreGui")
	end

	local function fn25(arg, arg2)
		local v5 = fn24():FindFirstChild(arg)

		if v5 then
			v5:Destroy()
		end

		return fn14("ScreenGui", {
			Name = arg,
			DisplayOrder = arg2,
			ResetOnSpawn = false,
			IgnoreGuiInset = true,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			Parent = fn24(),
		})
	end

	local robotoMono = Enum.Font.RobotoMono
	local n2 = game:GetService("TextService"):GetTextSize(string.rep("· ", 10), 100, robotoMono, Vector2.new(100000, 100000)).X / 1000

	local function fn26(arg, arg2, arg3, arg4, arg5, arg6)
		local Frame = fn14("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ClipsDescendants = true,
			ZIndex = arg6,
			Parent = arg,
		})

		local n3 = (arg2 == "tr" or arg2 == "br") and 1 or 0
		local n4 = (arg2 == "bl" or arg2 == "br") and 1 or 0

		if UserInputService2.TouchEnabled and not UserInputService2.KeyboardEnabled then
			arg4 *= 1.4
			arg3 *= 0.85
		end

		local n5 = arg4 / n2

		for i = 0, math.floor(arg3 / arg4) do
			local n6 = i * arg4
			local n7 = math.floor(math.sqrt(math.max(arg3 * arg3 - n6 * n6, 0)) / arg4) + 1

			if 1 - n6 / arg3 > 0.06 and n7 > 0 then
				local n8 = n7 * arg4
				local tbl9 = {}

				for i2 = 0, 7 do
					local n9 = i2 / 7

					tbl9[#tbl9 + 1] = {
						n3 == 1 and 1 - n9 or n9,
						1 - arg5 * math.max(1 - math.sqrt((n9 * n8) ^ 2 + n6 * n6) / arg3, 0) ^ 1.3,
					}
				end

				table.sort(tbl9, function(arg7, arg8)
					return arg7[1] < arg8[1]
				end)

				local tbl10 = {}

				for _, v5 in ipairs(tbl9) do
					tbl10[#tbl10 + 1] = NumberSequenceKeypoint.new(v5[1], v5[2])
				end

				local n9 = 11 + n6 - arg4 / 2

				local TextLabel = fn14("TextLabel", {
					BackgroundTransparency = 1,
					Font = robotoMono,
					TextSize = n5,
					TextColor3 = color2,
					Text = string.rep("· ", n7),
					AutoLocalize = false,
					TextXAlignment = n3 == 1 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left,
					AnchorPoint = Vector2.new(n3, n4),
					Position = UDim2.new(n3, n3 == 1 and -6 or 6, n4, n4 == 1 and -n9 or n9),
					Size = UDim2.fromOffset(n8 + arg4, arg4),
					ZIndex = arg6,
					Parent = Frame,
				})

				fn14("UIGradient", { Transparency = NumberSequence.new(tbl10), Parent = TextLabel })
			end
		end

		return Frame
	end

	local function fn27(arg, arg2)
		local str = tostring(arg2 or 1)
		local pos = str:find("%.")
		local n3 = 0

		if pos then
			n3 = math.min(#str - pos, 3)
		end

		if n3 == 0 then
			return tostring(math.floor(arg + 0.5))
		end
		return string.format("%." .. n3 .. "f", arg)
	end

	local Frame = nil
	local n3 = 0

	tbl7.Notify = function(arg, arg2)
		local tbl9 = arg2 or {}

		if not (Frame and Frame.Parent) then
			local StarUI_Notify = fn25("StarUI_Notify", 153)

			Frame = fn14("Frame", {
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(1, 1),
				Position = UDim2.new(1, -16, 1, -16),
				Size = UDim2.fromOffset(300, 480),
				Parent = StarUI_Notify,
			})

			fn14("UIListLayout", {
				Padding = UDim.new(0, 8),
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Parent = Frame,
			})
		end

		n3 += 1

		local Frame2 = fn14("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			LayoutOrder = n3,
			Parent = Frame,
		})

		local Frame3 = fn14("Frame", {
			BackgroundColor3 = tbl6.ink,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Position = UDim2.fromOffset(330, 0),
			Parent = Frame2,
		})

		fn15(Frame3, 12)
		fn16(Frame3, tbl6.inkLine)

		fn14("UIPadding", {
			PaddingTop = UDim.new(0, 12),
			PaddingBottom = UDim.new(0, 14),
			PaddingLeft = UDim.new(0, 12),
			PaddingRight = UDim.new(0, 14),
			Parent = Frame3,
		})

		local Frame4 = fn14("Frame", { BackgroundColor3 = color2, Size = UDim2.fromOffset(32, 32), Parent = Frame3 })
		fn15(Frame4, 16)
		fn18(Frame4, tbl9.Icon or "info", 16, tbl6.ink, tbl8)

		local Frame5 = fn14("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(44, 0),
			Size = UDim2.new(1, -44, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Parent = Frame3,
		})

		fn14("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame5 })

		fn17(Frame5, {
			Text = tostring(tbl9.Title or ""),
			Size = 15,
			Weight = fontWeight.Bold,
			Color = tbl6.inkText,
			Box = UDim2.new(1, 0, 0, 17),
		}).LayoutOrder = 1

		if tbl9.Content and tbl9.Content ~= "" then
			fn17(Frame5, {
				Text = tostring(tbl9.Content),
				Size = 13,
				Color = tbl6.inkSub,
				Wrap = true,
				Box = UDim2.new(1, 0, 0, 0),
				AutoY = true,
				AlignY = Enum.TextYAlignment.Top,
			}).LayoutOrder = 2
		end

		local Frame6 = fn14("Frame", {
			BackgroundColor3 = color2,
			BackgroundTransparency = 0.5,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, -12, 1, 14),
			Size = UDim2.new(1, 26, 0, 2),
			Parent = Frame3,
		})

		local n4 = tonumber(tbl9.Duration) or 3
		fn19(Frame3, 0.35, { Position = UDim2.fromOffset(0, 0) })
		TweenService2:Create(Frame6, TweenInfo.new(n4, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 2) }):Play()

		task.delay(n4, function()
			if not Frame2.Parent then
				return
			end
			fn19(Frame3, 0.3, { Position = UDim2.fromOffset(330, 0) })
			task.wait(0.3)
			Frame2:Destroy()
		end)
	end

	tbl7.CreateWindow = function(arg, arg2)
		local tbl9 = arg2 or {}
		local tbl10 = { Tabs = {}, Flags = {}, Opened = true }
		local size = tbl9.Size or UDim2.fromOffset(680, 500)
		local minSize = tbl9.MinSize or Vector2.new(520, 360)
		local sideBarWidth = tbl9.SideBarWidth or 200
		local StarUI = fn25("StarUI", 150)
		local StarUI_Overlay = fn25("StarUI_Overlay", 152)
		tbl10.Gui = StarUI
		tbl10.OverlayGui = StarUI_Overlay
		local tbl11 = {}

		local Frame2 = fn14("Frame", {
			Name = "Window",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(size.X.Offset, size.Y.Offset),
			BackgroundColor3 = color2,
			Parent = StarUI,
		})

		fn15(Frame2, 16)
		fn14("UIGradient", { Rotation = 90, Color = ColorSequence.new(tbl6.pageTop, tbl6.pageBottom), Parent = Frame2 })
		local v5 = fn16(Frame2, color2)
		fn14("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(0.78, 0.93), Parent = v5 })
		local UIScale = fn14("UIScale", { Parent = Frame2 })

		local Frame3 = fn14("Frame", {
			BackgroundColor3 = tbl6.page,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 50,
			Visible = false,
			Parent = Frame2,
		})

		fn15(Frame3, 16)
		local position = Frame2.Position
		local n4 = 0
		tbl10.Root = Frame2

		local function fn28()
			local currentCamera = workspace.CurrentCamera
			currentCamera = currentCamera and currentCamera.ViewportSize or Vector2.new(1920, 1080)
			return math.clamp(math.min((currentCamera.X - 24) / Frame2.Size.X.Offset, (currentCamera.Y - 24) / Frame2.Size.Y.Offset), 0.45, 1)
		end

		local flag2 = false

		local function fn29()
			local currentCamera = workspace.CurrentCamera
			local viewportSize = currentCamera and currentCamera.ViewportSize or Vector2.new(1920, 1080)
			return UDim2.fromOffset(math.max(minSize.X, viewportSize.X - 24), math.max(minSize.Y, viewportSize.Y - 24))
		end

		local function fn30()
			if flag2 then
				Frame2.Size = fn29()
			end

			UIScale.Scale = fn28()
		end

		task.defer(fn30)

		if workspace.CurrentCamera then
			table.insert(tbl11, workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn30))
		end

		local Frame4 = fn14("Frame", { Name = "Sidebar", BackgroundColor3 = tbl6.side, Size = UDim2.new(0, sideBarWidth, 1, 0), Parent = Frame2 })
		fn15(Frame4, 16)

		fn14("Frame", {
			BackgroundColor3 = tbl6.side,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.new(0, 16, 1, 0),
			Parent = Frame4,
		})

		fn14("Frame", {
			BackgroundColor3 = tbl6.cardLine,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, 0, 0, 0),
			Size = UDim2.new(0, 1, 1, 0),
			ZIndex = 2,
			Parent = Frame4,
		})

		fn26(Frame4, "tl", 250, 13, 0.2, 1)

		local Frame5 = fn14("Frame", {
			BackgroundTransparency = 1,
			Active = true,
			Size = UDim2.new(1, 0, 0, 70),
			ZIndex = 2,
			Parent = Frame4,
		})

		local Frame6 = fn14("Frame", {
			BackgroundColor3 = color2,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 14, 1, 0),
			Size = UDim2.new(1, -28, 0, 1),
			ZIndex = 2,
			Parent = Frame5,
		})

		local v6 = fn14
		local tbl12 = {}
		local numberSequence = NumberSequence.new
		local tbl13 = {}
		local v7 = NumberSequenceKeypoint.new(0, 1)
		local v8 = NumberSequenceKeypoint.new(0.3, 0.8)
		local v9 = NumberSequenceKeypoint.new(0.7, 0.8)
		local new = NumberSequenceKeypoint.new
		tbl13[1] = v7
		tbl13[2] = v8
		tbl13[3] = v9

		do
			local values = table.pack(new(1, 1))
			table.move(values, 1, values.n, 4, tbl13)
		end

		tbl12.Transparency = numberSequence(tbl13)
		tbl12.Parent = Frame6
		v6("UIGradient", tbl12)

		local Frame7 = fn14("Frame", {
			BackgroundColor3 = color2,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 16, 0.5, 0),
			Size = UDim2.fromOffset(36, 36),
			ZIndex = 2,
			Parent = Frame5,
		})

		fn15(Frame7, 11)

		if tbl9.Logo then
			Frame7.BackgroundTransparency = 1

			fn14("ImageLabel", {
				BackgroundTransparency = 1,
				Image = tbl9.Logo,
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(38, 38),
				ZIndex = 3,
				Parent = Frame7,
			})
		else
			fn18(Frame7, tbl9.Icon or "star", 18, tbl6.ink, { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Z = 2 })
		end

		local Frame8 = fn14("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(62, 16),
			Size = UDim2.new(1, -70, 0, 20),
			ZIndex = 2,
			Parent = Frame5,
		})

		fn14("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = Frame8,
		})

		fn17(Frame8, {
			Text = tbl9.Title or "Star Hub",
			Size = 17,
			Weight = fontWeight.Bold,
			Color = tbl6.inkText,
			Box = UDim2.fromOffset(0, 20),
			AutoX = true,
			Z = 2,
		}).LayoutOrder = 1

		local v10 = fn17(Frame5, {
			Text = "",
			Size = 12,
			Weight = fontWeight.Medium,
			Color = tbl6.inkSub,
			Position = UDim2.fromOffset(62, 38),
			Box = UDim2.new(1, -70, 0, 15),
			Z = 2,
		})

		v10.RichText = true

		local Frame9 = fn14("Frame", {
			BackgroundColor3 = tbl6.inkRaised,
			Position = UDim2.fromOffset(12, 76),
			Size = UDim2.new(1, -24, 0, 34),
			ZIndex = 2,
			Parent = Frame4,
		})

		fn15(Frame9, 10)
		local v11 = fn16(Frame9, tbl6.inkLine)
		fn18(Frame9, "search", 15, tbl6.inkSub, { Position = UDim2.new(0, 10, 0.5, 0), Z = 2 })

		local TextBox = fn14("TextBox", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(32, 0),
			Size = UDim2.new(1, -62, 1, 0),
			ClearTextOnFocus = false,
			Text = "",
			PlaceholderText = "Search settings",
			PlaceholderColor3 = tbl6.inkDim,
			FontFace = fn13(fontWeight.Medium),
			TextSize = 14,
			TextColor3 = tbl6.inkText,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 2,
			Parent = Frame9,
		})

		local TextButton = fn14("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = tbl6.inkLine,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -7, 0.5, 0),
			Size = UDim2.fromOffset(20, 20),
			Visible = false,
			ZIndex = 2,
			Parent = Frame9,
		})

		fn15(TextButton, 10)
		fn18(TextButton, "x", 12, tbl6.inkText, { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Z = 2 })

		TextButton.Activated:Connect(function()
			TextBox.Text = ""
		end)

		TextBox.Focused:Connect(function()
			fn19(v11, 0.15, { Color = tbl6.inkSub })
		end)

		TextBox.FocusLost:Connect(function()
			fn19(v11, 0.15, { Color = tbl6.inkLine })
		end)

		local ScrollingFrame = fn14("ScrollingFrame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 116),
			Size = UDim2.new(1, 0, 1, -188),
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 0,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ZIndex = 2,
			Parent = Frame4,
		})

		fn14("UIPadding", {
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 10),
			PaddingLeft = UDim.new(0, 12),
			PaddingRight = UDim.new(0, 12),
			Parent = ScrollingFrame,
		})

		fn14("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrollingFrame })
		local n5 = 0

		local function fn31()
			n5 += 1
			return n5
		end

		local Frame10 = fn14("Frame", {
			BackgroundColor3 = tbl6.inkRaised,
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 12, 1, -12),
			Size = UDim2.new(1, -24, 0, 54),
			ZIndex = 2,
			Parent = Frame4,
		})

		fn15(Frame10, 12)
		fn16(Frame10, tbl6.inkLine)

		local ImageLabel = fn14("ImageLabel", {
			BackgroundColor3 = tbl6.inkLine,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 10, 0.5, 0),
			Size = UDim2.fromOffset(34, 34),
			ZIndex = 2,
			Parent = Frame10,
		})

		fn15(ImageLabel, 17)
		fn16(ImageLabel, color2, 0.6)

		local Frame11 = fn14("Frame", {
			BackgroundColor3 = color(34, 197, 94),
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, 1, 1, 1),
			Size = UDim2.fromOffset(10, 10),
			ZIndex = 3,
			Parent = ImageLabel,
		})

		fn15(Frame11, 5)
		fn16(Frame11, tbl6.inkRaised).Thickness = 2

		local v12 = fn17(Frame10, {
			Size = 14,
			Weight = fontWeight.SemiBold,
			Color = tbl6.inkText,
			Position = UDim2.fromOffset(54, 10),
			Box = UDim2.new(1, -62, 0, 17),
			Z = 2,
		})

		local v13 = fn17(Frame10, {
			Size = 12,
			Color = tbl6.inkSub,
			Position = UDim2.fromOffset(54, 27),
			Box = UDim2.new(1, -62, 0, 15),
			Z = 2,
		})

		tbl10.User = {}

		tbl10.User.SetAnonymous = function(arg3, arg4)
			local anonymous = arg4 == true
			arg3.Anonymous = anonymous
			ImageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. (anonymous and 1 or localPlayer2.UserId) .. "&w=150&h=150"
			v12.Text = anonymous and "Anonymous" or localPlayer2.DisplayName
			v13.Text = anonymous and "@anonymous" or "@" .. localPlayer2.Name
		end

		tbl10.User:SetAnonymous(tbl9.User and tbl9.User.Anonymous)
		Frame10.Visible = not (tbl9.User and tbl9.User.Enabled == false)

		local Frame12 = fn14("Frame", {
			Name = "Content",
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(sideBarWidth, 0),
			Size = UDim2.new(1, -sideBarWidth, 1, 0),
			ClipsDescendants = true,
			Parent = Frame2,
		})

		fn26(Frame12, "tr", 330, 14, 0.18, 0)
		fn26(Frame12, "bl", 230, 14, 0.13, 0)
		local Frame13 = fn14("Frame", { BackgroundColor3 = color2, Size = UDim2.new(1, 0, 0, 160), Parent = Frame12 })
		fn14("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(0.965, 1), Parent = Frame13 })
		local Frame14 = fn14("Frame", { BackgroundTransparency = 1, Active = true, Size = UDim2.new(1, 0, 0, 64), Parent = Frame12 })

		local Frame15 = fn14("Frame", {
			BackgroundColor3 = color2,
			Position = UDim2.fromOffset(22, 13),
			Size = UDim2.fromOffset(38, 38),
			Parent = Frame14,
		})

		fn15(Frame15, 11)
		local UIScale2 = fn14("UIScale", { Parent = Frame15 })
		local v14 = fn18(Frame15, "house", 18, tbl6.ink, tbl8)

		local v15 = fn17(Frame14, {
			Size = 11,
			Weight = fontWeight.Bold,
			Color = tbl6.dim,
			Position = UDim2.fromOffset(72, 14),
			Box = UDim2.new(1, -170, 0, 13),
		})

		local v16 = fn17(Frame14, {
			Size = 22,
			Weight = fontWeight.Bold,
			Color = tbl6.text,
			Position = UDim2.fromOffset(72, 27),
			Box = UDim2.new(1, -170, 0, 26),
		})

		local Frame16 = fn14("Frame", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Position = UDim2.new(1, -16, 0, 16),
			Size = UDim2.fromOffset(110, 30),
			Parent = Frame14,
		})

		fn14("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = Frame16,
		})

		local function fn32(arg3, arg4, arg5)
			local TextButton2 = fn14("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundColor3 = tbl6.field,
				Size = UDim2.fromOffset(30, 30),
				LayoutOrder = arg4,
				Parent = Frame16,
			})

			fn15(TextButton2, 15)
			local v17 = fn16(TextButton2, tbl6.cardLine)
			local v18 = fn18(TextButton2, arg3, 15, tbl6.sub, tbl8)

			TextButton2.MouseEnter:Connect(function()
				fn19(TextButton2, 0.15, { BackgroundColor3 = color2 })
				fn19(v18, 0.15, { ImageColor3 = tbl6.ink })
				fn19(v17, 0.15, { Color = color2 })
			end)

			TextButton2.MouseLeave:Connect(function()
				fn19(TextButton2, 0.15, { BackgroundColor3 = tbl6.field })
				fn19(v18, 0.15, { ImageColor3 = tbl6.sub })
				fn19(v17, 0.15, { Color = tbl6.cardLine })
			end)

			TextButton2.Activated:Connect(arg5)
			return TextButton2
		end

		local Frame17 = fn14("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(0, 64),
			Size = UDim2.new(1, 0, 1, -64),
			Parent = Frame12,
		})

		local Frame18 = fn14("Frame", {
			BackgroundColor3 = tbl6.pageTop,
			Position = UDim2.fromOffset(0, 64),
			Size = UDim2.new(1, 0, 0, 18),
			ZIndex = 5,
			Parent = Frame12,
		})

		fn14("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(0, 1), Parent = Frame18 })

		local Frame19 = fn14("Frame", {
			BackgroundColor3 = tbl6.pageTop,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 6,
			Parent = Frame17,
		})

		local ScrollingFrame2 = fn14("ScrollingFrame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Visible = false,
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = tbl6.dim,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			Parent = Frame17,
		})

		fn14("UIPadding", {
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 22),
			PaddingLeft = UDim.new(0, 22),
			PaddingRight = UDim.new(0, 22),
			Parent = ScrollingFrame2,
		})

		fn14("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrollingFrame2 })
		local tbl14 = {}

		local TextButton2 = fn14("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 1),
			Position = UDim2.new(1, 0, 1, 0),
			Size = UDim2.fromOffset(18, 18),
			ZIndex = 20,
			Parent = Frame2,
		})

		for i = 0, 1 do
			fn14("Frame", {
				BackgroundColor3 = tbl6.dim,
				AnchorPoint = Vector2.new(1, 1),
				Rotation = -45,
				Position = UDim2.new(1, -4 - i * 4, 1, -5),
				Size = UDim2.fromOffset(8 - i * 4, 1),
				ZIndex = 20,
				Parent = TextButton2,
			})
		end

		local position2 = nil
		local v17 = nil

		local function fn33(arg3)
			position2 = Frame2.Position
			v17 = arg3
		end

		local function fn34(arg3)
			local n6 = arg3 - v17
			Frame2.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n6.X, position2.Y.Scale, position2.Y.Offset + n6.Y)
			position = Frame2.Position
		end

		table.insert(tbl11, fn23(Frame5, fn33, fn34))
		table.insert(tbl11, fn23(Frame14, fn33, fn34))
		local size2 = nil
		local v18 = nil
		local v19 = nil

		table.insert(tbl11, fn23(TextButton2, function(arg3)
			local position3 = Frame2.Position
			size2 = Frame2.Size
			v18 = arg3
			v19 = position3
		end, function(arg3)
			local n6 = (arg3 - v18) / UIScale.Scale
			local n7 = math.max(minSize.X, size2.X.Offset + n6.X)
			local n8 = math.max(minSize.Y, size2.Y.Offset + n6.Y)
			local scale = UIScale.Scale
			local n9 = Vector2.new(n7 - size2.X.Offset, n8 - size2.Y.Offset) * scale / 2
			Frame2.Size = UDim2.fromOffset(n7, n8)
			Frame2.Position = UDim2.new(v19.X.Scale, v19.X.Offset + n9.X, v19.Y.Scale, v19.Y.Offset + n9.Y)
			position = Frame2.Position
		end))

		local StarUI_Toggle = fn25("StarUI_Toggle", 155)
		tbl10.ToggleGui = StarUI_Toggle

		local Frame20 = fn14("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 282, 0, 8),
			Size = UDim2.fromOffset(0, 50),
			AutomaticSize = Enum.AutomaticSize.X,
			Visible = not (tbl9.OpenButton and tbl9.OpenButton.Enabled == false),
			Parent = StarUI_Toggle,
		})

		local TextButton3 = fn14("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = color2,
			ClipsDescendants = true,
			Size = UDim2.fromOffset(0, 50),
			AutomaticSize = Enum.AutomaticSize.X,
			ZIndex = 2,
			Parent = Frame20,
		})

		fn15(TextButton3, 25)
		fn14("UIGradient", { Rotation = 90, Color = ColorSequence.new(color(30, 30, 37), color(9, 9, 12)), Parent = TextButton3 })
		local v20 = fn16(TextButton3, color2)
		v20.Thickness = 1.5
		local v21 = fn14
		local tbl15 = {}
		local numberSequence2 = NumberSequence.new
		local tbl16 = {}
		local v22 = NumberSequenceKeypoint.new(0, 0.3)
		local v23 = NumberSequenceKeypoint.new(0.3, 0.88)
		local v24 = NumberSequenceKeypoint.new(0.7, 0.88)
		local new2 = NumberSequenceKeypoint.new
		tbl16[1] = v22
		tbl16[2] = v23
		tbl16[3] = v24

		do
			local values = table.pack(new2(1, 0.3))
			table.move(values, 1, values.n, 4, tbl16)
		end

		tbl15.Transparency = numberSequence2(tbl16)
		tbl15.Parent = v20
		local UIGradient = v21("UIGradient", tbl15)

		local Frame21 = fn14("Frame", {
			BackgroundColor3 = color2,
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.new(0.5, 0, 0, 1),
			Size = UDim2.new(1, -44, 0, 1),
			ZIndex = 3,
			Parent = TextButton3,
		})

		local v25 = fn14
		local tbl17 = {}
		local numberSequence3 = NumberSequence.new
		local tbl18 = {}
		local v26 = NumberSequenceKeypoint.new(0, 1)
		local v27 = NumberSequenceKeypoint.new(0.5, 0.55)
		local new3 = NumberSequenceKeypoint.new
		tbl18[1] = v26
		tbl18[2] = v27

		do
			local values = table.pack(new3(1, 1))
			table.move(values, 1, values.n, 3, tbl18)
		end

		tbl17.Transparency = numberSequence3(tbl18)
		tbl17.Parent = Frame21
		v25("UIGradient", tbl17)

		local Frame22 = fn14("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(0, 50),
			AutomaticSize = Enum.AutomaticSize.X,
			ZIndex = 3,
			Parent = TextButton3,
		})

		fn14("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 20), Parent = Frame22 })

		fn14("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = Frame22,
		})

		local v28 = fn18(fn14("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(34, 34),
			LayoutOrder = 1,
			ZIndex = 3,
			Parent = Frame22,
		}), tbl9.Icon or "star", 18, color2, { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Z = 3 })

		if tbl9.Logo then
			v28.Image = tbl9.Logo
			v28.Size = UDim2.fromOffset(34, 34)
		end

		local Frame23 = fn14("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(0, 34),
			AutomaticSize = Enum.AutomaticSize.X,
			LayoutOrder = 2,
			ZIndex = 3,
			Parent = Frame22,
		})

		local v29 = fn17(Frame23, {
			Text = tbl9.Title or "Star Hub",
			Size = 16,
			Weight = fontWeight.Bold,
			Color = tbl6.inkText,
			Box = UDim2.fromOffset(0, 19),
			AutoX = true,
			Z = 3,
		})

		local v30 = fn17(Frame23, {
			Text = "",
			Size = 11,
			Weight = fontWeight.Medium,
			Color = tbl6.inkDim,
			Position = UDim2.fromOffset(0, 19),
			Box = UDim2.fromOffset(0, 13),
			AutoX = true,
			Z = 3,
		})

		v30.RichText = true
		local n6 = 0

		table.insert(tbl11, RunService2.RenderStepped:Connect(function(deltaTime)
			n6 += 1
			UIGradient.Rotation = (UIGradient.Rotation + deltaTime * 45) % 360
		end))

		local function fn35(arg3, arg4, arg5, arg6)
			return (arg6 and arg3 <= arg4 or not arg6 and arg3 >= arg4) and "#22C55E" or (arg6 and arg3 <= arg5 or not arg6 and arg3 >= arg5) and "#EAB308" or "#EF4444"
		end

		local function fn36()
			local ok, result = pcall(function()
				return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
			end)

			if ok and result then
				return result
			end

			local ok2, result2 = pcall(function()
				return localPlayer2:GetNetworkPing()
			end)

			return ok2 and result2 * 2000 or 0
		end

		local flag3 = true

		tbl10._stopStats = function()
			flag3 = false
		end

		task.spawn(function()
			local now = os.clock()

			while flag3 do
				task.wait(0.5)
				local now2 = os.clock()
				local n7 = math.floor(n6 / math.max(now2 - now, 0.001) + 0.5)
				n6 = 0
				local n8 = math.floor(fn36() + 0.5)
				local text = string.format("<font color=\"%s\">●</font> <font color=\"#F4F4F6\">%d</font> fps   <font color=\"%s\">●</font> <font color=\"#F4F4F6\">%d</font> ms", fn35(n7, 55, 30, false), n7, fn35(n8, 100, 200, true), n8)
				v10.Text = text
				v30.Text = text
				now = now2
			end
		end)

		TextButton3.MouseEnter:Connect(function()
			fn19(TextButton3, 0.18, { Position = UDim2.fromOffset(0, -2) })
			fn19(v20, 0.18, { Thickness = 2 })
		end)

		TextButton3.MouseLeave:Connect(function()
			fn19(TextButton3, 0.18, { Position = UDim2.fromOffset(0, 0) })
			fn19(v20, 0.18, { Thickness = 1.5 })
		end)

		local function fn37(arg3)
			local n7 = arg3 - TextButton3.AbsolutePosition
			local n8 = math.max(TextButton3.AbsoluteSize.X, TextButton3.AbsoluteSize.Y) * 2.2

			local Frame24 = fn14("Frame", {
				BackgroundColor3 = color2,
				BackgroundTransparency = 0.8,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromOffset(n7.X, n7.Y),
				Size = UDim2.fromOffset(0, 0),
				ZIndex = 2,
				Parent = TextButton3,
			})

			fn15(Frame24, 999)
			fn19(Frame24, 0.55, { Size = UDim2.fromOffset(n8, n8), BackgroundTransparency = 1 })

			task.delay(0.6, function()
				Frame24:Destroy()
			end)
		end

		local str = (tbl9.Folder or "StarHub") .. "/toggle_button.txt"

		pcall(function()
			local match, v31, v32, v33 = readfile(str):match("([%-%d%.]+),([%-%d%.]+),([%-%d%.]+),([%-%d%.]+)")

			if match then
				local v34 = Frame20
				local udim2 = UDim2.new
				local num = tonumber(match)
				local num2 = tonumber(v31)
				local v35 = tonumber
				v34.Position = udim2(num, num2, tonumber(v32), v35(v33))
			end
		end)

		local flag4 = false
		local v31 = nil
		local v32 = nil
		local n7 = UserInputService2.TouchEnabled and not UserInputService2.KeyboardEnabled and 12 or 6

		table.insert(tbl11, fn23(TextButton3, function(arg3)
			local position3 = Frame20.Position
			flag4 = false
			v31 = position3
			v32 = arg3
			fn37(arg3)
		end, function(arg3)
			local n8 = arg3 - v32

			if n7 < n8.Magnitude then
				flag4 = true
			end

			if flag4 then
				Frame20.Position = UDim2.new(v31.X.Scale, v31.X.Offset + n8.X, v31.Y.Scale, v31.Y.Offset + n8.Y)
			end
		end, function()
			if flag4 then
				local position3 = Frame20.Position

				pcall(function()
					if not isfolder(tbl9.Folder or "StarHub") then
						makefolder(tbl9.Folder or "StarHub")
					end

					writefile(str, table.concat({ position3.X.Scale, position3.X.Offset, position3.Y.Scale, position3.Y.Offset }, ","))
				end)
			end
		end))

		TextButton3.Activated:Connect(function()
			if not flag4 then
				tbl10:Toggle()
			end
		end)

		local transparency = UIGradient.Transparency
		local numberSequence4 = NumberSequence.new
		local tbl19 = {}
		local v33 = NumberSequenceKeypoint.new(0, 0)
		local v34 = NumberSequenceKeypoint.new(0.35, 0.6)
		local v35 = NumberSequenceKeypoint.new(0.65, 0.6)
		local new4 = NumberSequenceKeypoint.new
		tbl19[1] = v33
		tbl19[2] = v34
		tbl19[3] = v35

		do
			local values = table.pack(new4(1, 0))
			table.move(values, 1, values.n, 4, tbl19)
		end

		local v36 = numberSequence4(tbl19)

		local function fn38()
			local opened = tbl10.Opened
			UIGradient.Transparency = opened and v36 or transparency
			fn19(v29, 0.25, { TextColor3 = opened and tbl6.inkText or color(200, 200, 208) })
			fn19(v30, 0.25, { TextColor3 = opened and tbl6.inkSub or tbl6.inkDim })
			v28.Rotation = 0
			fn19(v28, 0.6, { Rotation = opened and 360 or -360 })
		end

		tbl10.Open = function()
			tbl10.Opened = true
			n4 += 1
			local v37 = n4
			UIScale.Scale = fn28()
			Frame2.Visible = true
			Frame2.Position = position + UDim2.fromOffset(0, 18)
			fn19(Frame2, 0.4, { Position = position })
			Frame3.Visible = true
			Frame3.BackgroundTransparency = 0
			fn19(Frame3, 0.35, { BackgroundTransparency = 1 })

			task.delay(0.36, function()
				if v37 == n4 then
					Frame3.Visible = false
				end
			end)

			fn38()
		end

		tbl10.Close = function()
			tbl10.Opened = false
			n4 += 1
			local v37 = n4
			StarUI_Overlay:ClearAllChildren()
			Frame3.Visible = true
			fn19(Frame3, 0.18, { BackgroundTransparency = 0 })
			fn19(Frame2, 0.2, { Position = position + UDim2.fromOffset(0, 12) })

			task.delay(0.2, function()
				if v37 ~= n4 then
					return
				end
				Frame2.Visible = false
				Frame2.Position = position
			end)

			fn38()
		end

		tbl10.Toggle = function()
			if tbl10.Opened then
				tbl10:Close()
			else
				tbl10:Open()
			end
		end

		tbl10.Destroy = function()
			for _, v37 in ipairs(tbl11) do
				pcall(function()
					v37:Disconnect()
				end)
			end

			pcall(function()
				StarUI:Destroy()
			end)

			pcall(function()
				StarUI_Overlay:Destroy()
			end)

			pcall(function()
				StarUI_Toggle:Destroy()
			end)

			if tbl10._stopStats then
				tbl10._stopStats()
			end
		end

		fn32("minus", 1, function()
			tbl10:Close()
		end)

		local size3 = nil
		local v37 = nil
		local maximize = nil

		maximize = fn32("maximize", 2, function()
			flag2 = not flag2
			local imageLabel = maximize and maximize:FindFirstChildWhichIsA("ImageLabel")

			if imageLabel then
				imageLabel.Image = tbl7.Icon(flag2 and "minimize-2" or "maximize")
			end

			if flag2 then
				local v38 = position
				size3 = Frame2.Size
				v37 = v38
				UIScale.Scale = 1
				position = UDim2.fromScale(0.5, 0.5)
				fn19(Frame2, 0.35, { Size = fn29(), Position = position })
			else
				position = v37 or UDim2.fromScale(0.5, 0.5)
				fn19(Frame2, 0.35, { Size = size3 or size, Position = position })

				task.delay(0.36, function()
					if not flag2 then
						UIScale.Scale = fn28()
					end
				end)
			end
		end)

		fn32("x", 3, function()
			tbl10:Close()
		end)

		fn38()

		tbl10.Tag = function(arg3, arg4)
			local Frame24 = fn14("Frame", {
				BackgroundColor3 = tbl6.inkRaised,
				Size = UDim2.fromOffset(0, 16),
				AutomaticSize = Enum.AutomaticSize.X,
				LayoutOrder = 2,
				ZIndex = 2,
				Parent = Frame8,
			})

			fn15(Frame24, 8)
			fn14("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), Parent = Frame24 })

			fn17(Frame24, {
				Text = tostring(arg4.Title or ""),
				Size = 11,
				Weight = fontWeight.SemiBold,
				Color = tbl6.inkSub,
				Box = UDim2.fromOffset(0, 16),
				AutoX = true,
				Z = 2,
			})

			return Frame24
		end

		local v38 = nil

		local function closePopup()
			if v38 then
				pcall(function()
					v38:Destroy()
				end)

				v38 = nil
			end
		end

		local function fn39(arg3, arg4, arg5)
			closePopup()

			local TextButton4 = fn14("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Parent = StarUI_Overlay,
			})

			TextButton4.Activated:Connect(closePopup)
			v38 = TextButton4
			local scale = UIScale.Scale
			local absolutePosition = arg3.AbsolutePosition
			local absoluteSize = arg3.AbsoluteSize
			local absoluteSize2 = StarUI_Overlay.AbsoluteSize
			local n8 = arg4 * scale
			local n9 = arg5 * scale
			local n10 = math.clamp(absolutePosition.X + absoluteSize.X - n8, 8, absoluteSize2.X - n8 - 8)
			local n11 = absolutePosition.Y + absoluteSize.Y + 6

			if n11 + n9 > absoluteSize2.Y - 8 then
				n11 = math.max(8, absolutePosition.Y - n9 - 6)
			end

			local TextButton5 = fn14("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundColor3 = tbl6.card,
				Position = UDim2.fromOffset(n10, n11),
				Size = UDim2.fromOffset(arg4, arg5),
				Parent = TextButton4,
			})

			fn14("UIScale", { Scale = scale, Parent = TextButton5 })
			fn15(TextButton5, 12)
			fn16(TextButton5, tbl6.cardLine)
			return TextButton5
		end

		tbl10.ClosePopup = closePopup
		local v39 = nil
		local fn40 = nil

		local function fn41(text, text2, arg3)
			v16.Text = text
			v15.Text = text2
			local v40 = v15
			v16.TextTransparency = 1
			v40.TextTransparency = 1
			v16.Position = UDim2.fromOffset(84, 27)
			fn19(v16, 0.35, { TextTransparency = 0, Position = UDim2.fromOffset(72, 27) })
			fn19(v15, 0.35, { TextTransparency = 0 })
			v14.Image = tbl7.Icon(arg3 or "house")
			UIScale2.Scale = 0.8
			fn19(UIScale2, 0.35, { Scale = 1 })
		end

		local function fn42(arg3)
			local Frame24 = fn14("Frame", {
				BackgroundColor3 = color2,
				BackgroundTransparency = 0.8,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 4,
				Parent = arg3,
			})

			fn15(Frame24, 10)
			fn19(Frame24, 1.4, { BackgroundTransparency = 1 })

			task.delay(1.45, function()
				Frame24:Destroy()
			end)
		end

		local function fn43(arg3)
			TextBox.Text = ""
			fn40(arg3.Tab)

			if arg3.Section and arg3.Section.Reveal then
				arg3.Section.Reveal()
			end

			local row = arg3.Row
			if not row then
				return
			end

			task.delay(0.08, function()
				local canvas = arg3.Tab.Canvas
				local y = canvas.CanvasPosition.Y

				fn19(canvas, 0.45, {
					CanvasPosition = Vector2.new(0, math.max(0, (row.AbsolutePosition.Y - canvas.AbsolutePosition.Y) / math.max(UIScale.Scale, 0.01) + y - 40)),
				})

				fn42(row)
			end)
		end

		local function fn44(arg3)
			for _, child in ipairs(ScrollingFrame2:GetChildren()) do
				if child:IsA("GuiObject") then
					child:Destroy()
				end
			end

			local v40 = string.lower(arg3)
			local tbl20 = {}

			for _, v41 in ipairs(tbl14) do
				local v42 = string.lower(v41.Title)
				local v43 = string.lower((v41.Tab.GroupTitle or "") .. " " .. v41.Tab.Title .. " " .. (v41.SectionTitle or ""))
				local n8 = v42:sub(1, #v40) == v40 and 0 or v42:find(v40, 1, true) and 1 or v43:find(v40, 1, true) and 2 or nil

				if n8 then
					tbl20[#tbl20 + 1] = { entry = v41, score = n8 }
				end
			end

			table.sort(tbl20, function(arg4, arg5)
				if arg4.score ~= arg5.score then
					return arg4.score < arg5.score
				end
				return arg4.entry.Title < arg5.entry.Title
			end)

			fn41("Search", string.format("%d RESULT%s", #tbl20, #tbl20 == 1 and "" or "S"), "search")

			if #tbl20 == 0 then
				fn17(ScrollingFrame2, {
					Text = "Nothing matches \"" .. arg3 .. "\".",
					Size = 14,
					Color = tbl6.sub,
					Box = UDim2.new(1, 0, 0, 40),
					AlignX = Enum.TextXAlignment.Center,
				})

				return
			end

			for i = 1, math.min(#tbl20, 60) do
				local entry = tbl20[i].entry

				local TextButton4 = fn14("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundColor3 = tbl6.card,
					Size = UDim2.new(1, 0, 0, 54),
					LayoutOrder = i,
					Parent = ScrollingFrame2,
				})

				fn15(TextButton4, 12)
				local v41 = fn16(TextButton4, tbl6.cardLine)

				local Frame24 = fn14("Frame", {
					BackgroundColor3 = color2,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 12, 0.5, 0),
					Size = UDim2.fromOffset(30, 30),
					Parent = TextButton4,
				})

				fn15(Frame24, 9)
				fn18(Frame24, entry.Tab.Icon, 15, tbl6.ink, tbl8)

				fn17(TextButton4, {
					Text = entry.Title,
					Size = 15,
					Weight = fontWeight.SemiBold,
					Position = UDim2.fromOffset(54, 9),
					Box = UDim2.new(1, -96, 0, 18),
				})

				local tbl21 = {}

				for _, v42 in ipairs({ entry.Tab.GroupTitle, entry.Tab.Title, entry.SectionTitle }) do
					if v42 and v42 ~= "" then
						tbl21[#tbl21 + 1] = v42
					end
				end

				fn17(TextButton4, {
					Text = table.concat(tbl21, "  ›  "),
					Size = 12,
					Color = tbl6.sub,
					Position = UDim2.fromOffset(54, 28),
					Box = UDim2.new(1, -96, 0, 15),
				})

				fn18(TextButton4, "chevron-right", 16, tbl6.dim, { Anchor = Vector2.new(1, 0.5), Position = UDim2.new(1, -14, 0.5, 0) })

				TextButton4.MouseEnter:Connect(function()
					fn19(TextButton4, 0.15, { BackgroundColor3 = tbl6.hover })
					fn19(v41, 0.15, { Color = tbl6.sub })
				end)

				TextButton4.MouseLeave:Connect(function()
					fn19(TextButton4, 0.15, { BackgroundColor3 = tbl6.card })
					fn19(v41, 0.15, { Color = tbl6.cardLine })
				end)

				TextButton4.Activated:Connect(function()
					fn43(entry)
				end)
			end
		end

		local flag5 = false

		TextBox:GetPropertyChangedSignal("Text"):Connect(function()
			local str2 = TextBox.Text:gsub("^%s+", ""):gsub("%s+$", "")
			TextButton.Visible = TextBox.Text ~= ""
			closePopup()

			if str2 == "" then
				if not flag5 then
					return
				end
				flag5 = false
				ScrollingFrame2.Visible = false

				if v39 then
					v39.Page.Visible = true
					local v40 = fn41
					local title = v39.Title
					local upper = string.upper
					local groupTitle = v39.GroupTitle or "Overview"
					local icon = v39.Icon
					v40(title, upper(groupTitle), icon)
				end

				return
			end

			flag5 = true

			if v39 then
				v39.Page.Visible = false
			end

			ScrollingFrame2.Visible = true
			ScrollingFrame2.CanvasPosition = Vector2.zero
			fn44(str2)
		end)

		fn40 = function(arg3)
			if flag5 then
				TextBox.Text = ""
			end

			if v39 == arg3 then
				return
			end
			closePopup()

			if v39 then
				v39.Page.Visible = false
				v39:_paint(false)
			end

			v39 = arg3
			arg3.Page.Visible = true
			arg3:_paint(true)
			local v40 = fn41
			local title = arg3.Title
			local upper = string.upper
			local groupTitle = arg3.GroupTitle or "Overview"
			local icon = arg3.Icon
			v40(title, upper(groupTitle), icon)
			Frame19.BackgroundTransparency = 0.1
			fn19(Frame19, 0.3, { BackgroundTransparency = 1 })
			local canvas = arg3.Canvas
			canvas.Position = UDim2.fromOffset(0, 12)
			fn19(canvas, 0.3, { Position = UDim2.fromOffset(0, 0) })
		end

		tbl10.SelectTab = function(arg3, arg4)
			local v40 = tbl10.Tabs[arg4]

			if v40 then
				fn40(v40)
			end
		end

		local fn45 = nil

		local function fn46(arg3, arg4, arg5)
			local tbl20 = { Title = arg4.Title or "Tab", GroupTitle = arg5, Icon = arg4.Icon, Window = tbl10 }

			local TextButton4 = fn14("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundColor3 = tbl6.inkRaised,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 38),
				LayoutOrder = fn31(),
				ZIndex = 2,
				Parent = arg3,
			})

			fn15(TextButton4, 10)

			local Frame24 = fn14("Frame", {
				BackgroundColor3 = tbl6.inkRaised,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 5, 0.5, 0),
				Size = UDim2.fromOffset(26, 26),
				ZIndex = 2,
				Parent = TextButton4,
			})

			fn15(Frame24, 8)
			local v40 = fn18(Frame24, arg4.Icon, 15, tbl6.inkSub, { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Z = 2 })

			local v41 = fn17(TextButton4, {
				Text = tbl20.Title,
				Size = 15,
				Weight = fontWeight.Medium,
				Color = tbl6.inkSub,
				Position = UDim2.fromOffset(40, 0),
				Box = UDim2.new(1, -46, 1, 0),
				Z = 2,
			})

			local flag6 = false

			tbl20._paint = function(arg6, arg7)
				flag6 = arg7
				fn19(TextButton4, 0.2, { BackgroundTransparency = arg7 and 0 or 1, BackgroundColor3 = arg7 and color2 or tbl6.inkRaised })
				fn19(Frame24, 0.2, { BackgroundColor3 = arg7 and tbl6.ink or tbl6.inkRaised })
				fn19(v40, 0.2, { ImageColor3 = arg7 and color2 or tbl6.inkSub })
				fn19(v41, 0.2, { TextColor3 = arg7 and tbl6.ink or tbl6.inkSub })
				v41.FontFace = fn13(arg7 and fontWeight.SemiBold or fontWeight.Medium)
			end

			TextButton4.MouseEnter:Connect(function()
				if flag6 then
					return
				end
				fn19(TextButton4, 0.15, { BackgroundTransparency = 0.4 })
				fn19(Frame24, 0.15, { BackgroundColor3 = tbl6.inkLine })
				fn19(v41, 0.15, { TextColor3 = tbl6.inkText })
				fn19(v40, 0.15, { ImageColor3 = tbl6.inkText })
			end)

			TextButton4.MouseLeave:Connect(function()
				if flag6 then
					return
				end
				fn19(TextButton4, 0.15, { BackgroundTransparency = 1 })
				fn19(Frame24, 0.15, { BackgroundColor3 = tbl6.inkRaised })
				fn19(v41, 0.15, { TextColor3 = tbl6.inkSub })
				fn19(v40, 0.15, { ImageColor3 = tbl6.inkSub })
			end)

			TextButton4.Activated:Connect(function()
				fn40(tbl20)
			end)

			local Frame25 = fn14("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = Frame17 })

			local ScrollingFrame3 = fn14("ScrollingFrame", {
				Name = "ScrollingFrame",
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				CanvasSize = UDim2.new(),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = tbl6.dim,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				Parent = Frame25,
			})

			fn14("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 22),
				PaddingLeft = UDim.new(0, 22),
				PaddingRight = UDim.new(0, 22),
				Parent = ScrollingFrame3,
			})

			fn14("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrollingFrame3 })
			local layoutOrder = 0

			ScrollingFrame3.ChildAdded:Connect(function(child)
				if child:IsA("GuiObject") and child.LayoutOrder == 0 then
					layoutOrder += 1
					child.LayoutOrder = layoutOrder
				end
			end)

			tbl20.Page = Frame25
			tbl20.Canvas = ScrollingFrame3
			tbl20.Button = TextButton4
			tbl20.ContainerFrame = Frame25

			tbl20.Select = function()
				fn40(tbl20)
			end

			tbl20.Section = function(arg6, arg7)
				return fn45(tbl20, arg7 or {})
			end

			tbl20.Paragraph = function(arg6, arg7)
				return fn45(tbl20, {}):Paragraph(arg7)
			end

			table.insert(tbl10.Tabs, tbl20)

			if not v39 then
				fn40(tbl20)
			end

			return tbl20
		end

		tbl10.Tab = function(arg3, arg4)
			return fn46(ScrollingFrame, arg4 or {}, nil)
		end

		tbl10.Divider = function()
			local Frame24 = fn14("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 13),
				LayoutOrder = fn31(),
				ZIndex = 2,
				Parent = ScrollingFrame,
			})

			fn14("Frame", {
				BackgroundColor3 = tbl6.inkLine,
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 6, 0.5, 0),
				Size = UDim2.new(1, -12, 0, 1),
				ZIndex = 2,
				Parent = Frame24,
			})
		end

		tbl10.Section = function(arg3, arg4)
			local tbl20 = arg4 or {}

			local Frame24 = fn14("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = fn31(),
				ZIndex = 2,
				Parent = ScrollingFrame,
			})

			fn14("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame24 })

			local TextButton4 = fn14("TextButton", {
				Text = "",
				AutoButtonColor = false,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				LayoutOrder = 0,
				ZIndex = 2,
				Parent = Frame24,
			})

			fn18(TextButton4, tbl20.Icon, 13, tbl6.inkDim, { Position = UDim2.new(0, 11, 0.5, 3), Z = 2 })

			fn17(TextButton4, {
				Text = string.upper(tbl20.Title or ""),
				Size = 11,
				Weight = fontWeight.Bold,
				Color = tbl6.inkDim,
				Position = UDim2.fromOffset(tbl20.Icon and 30 or 12, 5),
				Box = UDim2.new(1, -56, 1, -5),
				Z = 2,
			})

			local v40 = fn18(TextButton4, "chevron-down", 14, tbl6.inkDim, { Anchor = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 3), Z = 2 })

			local Frame25 = fn14("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 1,
				ZIndex = 2,
				Parent = Frame24,
			})

			fn14("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame25 })
			local visible = tbl20.Opened ~= false

			local function fn47()
				Frame25.Visible = visible
				fn19(v40, 0.2, { Rotation = visible and 0 or -90 })
			end

			fn47()

			TextButton4.Activated:Connect(function()
				visible = not visible
				fn47()
			end)

			return { Tab = function(arg5, arg6)
				return fn46(Frame25, arg6 or {}, tbl20.Title)
			end }
		end

		local function fn47(arg3, arg4)
			if arg4 then
				tbl10.Flags[arg4] = arg3
			end

			return arg3
		end

		fn45 = function(arg3, arg4)
			local tbl20 = { Tab = arg3 }

			local Frame24 = fn14("Frame", {
				BackgroundColor3 = tbl6.card,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				Parent = arg3.Canvas,
			})

			fn15(Frame24, 14)
			fn16(Frame24, tbl6.cardLine)
			fn14("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame24 })

			local Frame25 = fn14("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				LayoutOrder = 2,
				Parent = Frame24,
			})

			fn14("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame25 })
			fn14("UIPadding", { PaddingBottom = UDim.new(0, 6), PaddingTop = UDim.new(0, arg4.Title and 0 or 6), Parent = Frame25 })
			local n8 = 0

			if arg4.Title then
				local TextButton4 = fn14("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 52),
					LayoutOrder = 1,
					Parent = Frame24,
				})

				local Frame26 = fn14("Frame", {
					BackgroundColor3 = color2,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 16, 0.5, 0),
					Size = UDim2.fromOffset(30, 30),
					Parent = TextButton4,
				})

				fn15(Frame26, 9)
				fn18(Frame26, arg4.Icon, 15, tbl6.ink, tbl8)

				fn17(TextButton4, {
					Text = arg4.Title,
					Size = 16,
					Weight = fontWeight.Bold,
					Position = UDim2.fromOffset(56, 0),
					Box = UDim2.new(1, -150, 1, 0),
				})

				local Frame27 = fn14("Frame", {
					BackgroundColor3 = tbl6.field,
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -48, 0.5, 0),
					Size = UDim2.fromOffset(0, 22),
					AutomaticSize = Enum.AutomaticSize.X,
					Parent = TextButton4,
				})

				fn15(Frame27, 11)
				fn16(Frame27, tbl6.cardLine)
				fn14("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9), Parent = Frame27 })

				tbl20.CountLabel = fn17(Frame27, {
					Text = "0",
					Size = 12,
					Weight = fontWeight.SemiBold,
					Color = tbl6.sub,
					Box = UDim2.fromOffset(0, 22),
					AutoX = true,
				})

				local Frame28 = fn14("Frame", {
					BackgroundColor3 = tbl6.field,
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -14, 0.5, 0),
					Size = UDim2.fromOffset(26, 26),
					Parent = TextButton4,
				})

				fn15(Frame28, 13)
				local v40 = fn18(Frame28, "chevron-down", 14, tbl6.sub, tbl8)
				local visible = arg4.Opened ~= false

				local function fn48()
					Frame25.Visible = visible
					fn19(v40, 0.2, { Rotation = visible and 0 or -90 })
				end

				fn48()

				TextButton4.Activated:Connect(function()
					visible = not visible
					fn48()
				end)

				tbl20.Reveal = function()
					if not visible then
						visible = true
						fn48()
					end
				end

				n8 = 1
			end

			tbl20.Frame = Frame24
			tbl20.Body = Frame25
			local n9 = 0

			local function fn48(arg5)
				n8 += 1
				n9 += 1

				if tbl20.CountLabel then
					tbl20.CountLabel.Text = tostring(n9)
				end

				local Frame26 = fn14("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, arg5), LayoutOrder = n8, Parent = Frame25 })

				if n8 > 1 then
					fn14("Frame", {
						BackgroundColor3 = tbl6.divider,
						Position = UDim2.fromOffset(16, 0),
						Size = UDim2.new(1, -32, 0, 1),
						Parent = Frame26,
					})
				end

				return Frame26
			end

			local function fn49(arg5)
				local Frame26 = fn14("Frame", {
					BackgroundColor3 = tbl6.hover,
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(8, 3),
					Size = UDim2.new(1, -16, 1, -6),
					Parent = arg5,
				})

				fn15(Frame26, 10)

				local TextButton4 = fn14("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					ZIndex = 3,
					Parent = arg5,
				})

				TextButton4.MouseEnter:Connect(function()
					fn19(Frame26, 0.15, { BackgroundTransparency = 0 })
				end)

				TextButton4.MouseLeave:Connect(function()
					fn19(Frame26, 0.15, { BackgroundTransparency = 1 })
				end)

				return TextButton4, Frame26
			end

			local function fn50(arg5, arg6, arg7)
				if arg6 and arg6 ~= "" then
					tbl14[#tbl14 + 1] = { Title = arg6, Tab = arg3, Section = tbl20, SectionTitle = arg4.Title, Row = arg5 }
				end

				return fn17(arg5, {
					Text = arg6 or "",
					Size = 15,
					Weight = fontWeight.Medium,
					Position = UDim2.fromOffset(18, 0),
					Box = UDim2.new(1, -18 - (arg7 or 18), 1, 0),
				})
			end

			local function fn51(arg5, arg6)
				local v40 = fn14(arg6.Class or "TextButton", {
					BackgroundColor3 = tbl6.field,
					AnchorPoint = arg6.Anchor or Vector2.new(1, 0.5),
					Position = arg6.Position or UDim2.new(1, -16, 0.5, 0),
					Size = arg6.Size or UDim2.fromOffset(0, 30),
					AutomaticSize = arg6.Auto or Enum.AutomaticSize.X,
					Parent = arg5,
				})

				if v40:IsA("TextButton") then
					v40.Text = ""
					v40.AutoButtonColor = false
				end

				fn15(v40, arg6.Radius or 9)
				fn16(v40, tbl6.cardLine)
				return v40
			end

			tbl20.Toggle = function(arg5, arg6)
				local v40 = fn48(48)
				local v41 = fn49(v40)
				local v42 = fn50(v40, arg6.Title, 74)

				local Frame26 = fn14("Frame", {
					BackgroundColor3 = tbl6.track,
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -18, 0.5, 0),
					Size = UDim2.fromOffset(44, 24),
					ZIndex = 2,
					Parent = v40,
				})

				fn15(Frame26, 12)

				local Frame27 = fn14("Frame", {
					BackgroundColor3 = tbl6.sub,
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 3, 0.5, 0),
					Size = UDim2.fromOffset(18, 18),
					ZIndex = 2,
					Parent = Frame26,
				})

				fn15(Frame27, 9)
				local v43 = fn16(Frame27, tbl6.cardLine)
				local tbl21 = { Type = "Toggle", Flag = arg6.Flag, Value = arg6.Value == true, ElementFrame = v40, Locked = false }

				local function fn52(arg7)
					local value = tbl21.Value
					local tbl22 = {}
					tbl22[Frame26] = { BackgroundColor3 = value and tbl6.accent or tbl6.track }

					tbl22[Frame27] = {
						BackgroundColor3 = value and tbl6.ink or tbl6.sub,
						Position = value and UDim2.new(0, 23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
					}

					tbl22[v43] = { Transparency = 1 }
					tbl22[v42] = { TextColor3 = value and tbl6.text or tbl6.sub }

					for k, v44 in pairs(tbl22) do
						if arg7 then
							fn19(k, 0.22, v44)
						else
							for k2, v45 in pairs(v44) do
								k[k2] = v45
							end
						end
					end
				end

				fn52(false)

				tbl21.Set = function(arg7, arg8)
					tbl21.Value = arg8 == true
					fn52(true)
					fn20(arg6.Callback, tbl21.Value)
				end

				tbl21._load = function(arg7, arg8)
					tbl21:Set(arg8)
				end

				tbl21._save = function()
					return tbl21.Value
				end

				v41.Activated:Connect(function()
					if tbl21.Locked then
						return
					end
					tbl21:Set(not tbl21.Value)
				end)

				return fn47(tbl21, arg6.Flag)
			end

			tbl20.Slider = function(arg5, arg6)
				local tbl21 = arg6.Value or {}
				local n10 = tonumber(tbl21.Min) or 0
				local n11 = tonumber(tbl21.Max) or 100
				local n12 = tonumber(arg6.Step) or 1
				local v40 = fn48(64)
				fn50(v40, arg6.Title, 90).Size = UDim2.new(1, -110, 0, 38)

				local v41 = fn51(v40, {
					Class = "TextBox",
					Anchor = Vector2.new(1, 0),
					Position = UDim2.new(1, -16, 0, 8),
					Size = UDim2.fromOffset(0, 24),
					Radius = 7,
				})

				v41.ClearTextOnFocus = false
				v41.FontFace = fn13(fontWeight.SemiBold)
				v41.TextSize = 13
				v41.TextColor3 = tbl6.text
				v41.Text = ""
				fn14("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9), Parent = v41 })

				local Frame26 = fn14("Frame", {
					BackgroundColor3 = tbl6.track,
					Position = UDim2.new(0, 18, 0, 45),
					Size = UDim2.new(1, -36, 0, 6),
					Parent = v40,
				})

				fn15(Frame26, 3)
				local Frame27 = fn14("Frame", { BackgroundColor3 = tbl6.accent, Size = UDim2.fromScale(0, 1), Parent = Frame26 })
				fn15(Frame27, 3)

				local Frame28 = fn14("Frame", {
					BackgroundColor3 = color2,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromOffset(16, 16),
					ZIndex = 2,
					Parent = Frame26,
				})

				fn15(Frame28, 8)
				fn16(Frame28, tbl6.card).Thickness = 3

				local TextButton4 = fn14("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 34),
					Size = UDim2.new(1, -16, 0, 26),
					ZIndex = 3,
					Parent = v40,
				})

				local tbl22 = { Type = "Slider", Flag = arg6.Flag, ElementFrame = v40 }

				local function fn52(arg7)
					local n13 = math.clamp(n10 + math.floor((math.clamp(tonumber(arg7) or n10, n10, n11) - n10) / n12 + 0.5) * n12, n10, n11)
					return tonumber(fn27(n13, n12)) or n13
				end

				tbl22.Value = fn52(tbl21.Default or n10)

				local function fn53(arg7)
					local n13 = n11 > n10 and (tbl22.Value - n10) / (n11 - n10) or 0

					if arg7 then
						fn19(Frame27, 0.12, { Size = UDim2.fromScale(n13, 1) })
						fn19(Frame28, 0.12, { Position = UDim2.fromScale(n13, 0.5) })
					else
						local v42 = Frame27
						local v43 = Frame28
						local udim2 = UDim2.fromScale(n13, 1)
						local udim22 = UDim2.fromScale(n13, 0.5)
						v42.Size = udim2
						v43.Position = udim22
					end

					v41.Text = fn27(tbl22.Value, n12)
				end

				fn53(false)

				tbl22.Set = function(arg7, arg8, arg9)
					local v42 = fn52(arg8)
					local flag6 = v42 ~= tbl22.Value
					tbl22.Value = v42
					fn53(true)

					if not arg9 or flag6 then
						fn20(arg6.Callback, tbl22.Value)
					end
				end

				tbl22._load = function(arg7, arg8)
					tbl22:Set(arg8)
				end

				tbl22._save = function()
					return tbl22.Value
				end

				local function fn54(arg7)
					local v42 = fn52(n10 + (n11 - n10) * math.clamp((arg7 - Frame26.AbsolutePosition.X) / math.max(Frame26.AbsoluteSize.X, 1), 0, 1))

					if v42 ~= tbl22.Value then
						tbl22:Set(v42)
					end
				end

				fn23(TextButton4, function(arg7)
					fn54(arg7.X)
					fn19(Frame28, 0.12, { Size = UDim2.fromOffset(20, 20) })
				end, function(arg7)
					fn54(arg7.X)
				end, function()
					fn19(Frame28, 0.12, { Size = UDim2.fromOffset(16, 16) })
				end)

				v41.FocusLost:Connect(function()
					local num = tonumber(v41.Text)

					if num then
						tbl22:Set(num)
					else
						fn53(false)
					end
				end)

				return fn47(tbl22, arg6.Flag)
			end

			tbl20.Button = function(arg5, arg6)
				local v40 = fn48(48)
				local v41 = fn49(v40)
				local color3 = typeof(arg6.Color) == "Color3" and arg6.Color or nil
				local v42 = fn50(v40, arg6.Title, 50)

				if color3 then
					v42.TextColor3 = color3
				end

				local v43 = fn14
				local tbl21 = { BackgroundColor3 = color3 or color2 }
				tbl21.AnchorPoint = Vector2.new(1, 0.5)
				tbl21.Position = UDim2.new(1, -16, 0.5, 0)
				tbl21.Size = UDim2.fromOffset(30, 30)
				tbl21.ZIndex = 2
				tbl21.Parent = v40
				local Frame26 = v43("Frame", tbl21)
				fn15(Frame26, 15)
				fn18(Frame26, arg6.Icon or "chevron-right", 15, color3 and color2 or tbl6.ink, { Anchor = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Z = 2 })
				local UIScale3 = fn14("UIScale", { Parent = Frame26 })

				v41.MouseEnter:Connect(function()
					fn19(UIScale3, 0.15, { Scale = 1.08 })
				end)

				v41.MouseLeave:Connect(function()
					fn19(UIScale3, 0.15, { Scale = 1 })
				end)

				v41.Activated:Connect(function()
					UIScale3.Scale = 0.85
					fn19(UIScale3, 0.3, { Scale = 1 })
					fn20(arg6.Callback)
				end)

				return { Type = "Button", ElementFrame = v40 }
			end

			tbl20.Paragraph = function(arg5, arg6)
				local v40 = fn48(0)
				v40.AutomaticSize = Enum.AutomaticSize.Y

				local Frame26 = fn14("Frame", {
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					Parent = v40,
				})

				fn14("UIPadding", {
					PaddingTop = UDim.new(0, 13),
					PaddingBottom = UDim.new(0, 13),
					PaddingLeft = UDim.new(0, 18),
					PaddingRight = UDim.new(0, 18),
					Parent = Frame26,
				})

				fn14("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame26 })

				local v41 = fn17(Frame26, {
					Text = arg6.Title or "",
					Size = 15,
					Weight = fontWeight.SemiBold,
					Box = UDim2.new(1, 0, 0, 0),
					AutoY = true,
					Wrap = true,
				})

				v41.LayoutOrder = 1

				local v42 = fn17(Frame26, {
					Text = arg6.Desc or "",
					Size = 13,
					Color = tbl6.sub,
					Box = UDim2.new(1, 0, 0, 0),
					AutoY = true,
					Wrap = true,
					AlignY = Enum.TextYAlignment.Top,
				})

				v42.LayoutOrder = 2
				v42.Visible = (arg6.Desc or "") ~= ""

				return {
					Type = "Paragraph",
					ElementFrame = v40,
					SetTitle = function(arg7, arg8)
						v41.Text = tostring(arg8 or "")
					end,
					SetDesc = function(arg7, arg8)
						v42.Text = tostring(arg8 or "")
						v42.Visible = v42.Text ~= ""
					end,
				}
			end

			tbl20.Input = function(arg5, arg6)
				local v40 = fn48(84)
				fn50(v40, arg6.Title).Size = UDim2.new(1, -36, 0, 38)

				local v41 = fn51(v40, {
					Class = "TextBox",
					Anchor = Vector2.zero,
					Position = UDim2.new(0, 16, 0, 38),
					Size = UDim2.new(1, -32, 0, 34),
					Auto = Enum.AutomaticSize.None,
				})

				v41.ClearTextOnFocus = false
				v41.FontFace = fn13(fontWeight.Regular)
				v41.TextSize = 13
				v41.TextColor3 = tbl6.text
				v41.PlaceholderText = arg6.Placeholder or ""
				v41.PlaceholderColor3 = tbl6.dim
				v41.Text = arg6.Value or ""
				v41.TextXAlignment = Enum.TextXAlignment.Left
				v41.TextTruncate = Enum.TextTruncate.AtEnd
				local uiStroke = v41:FindFirstChildWhichIsA("UIStroke")
				fn14("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = v41 })
				local tbl21

				tbl21 = {
					Type = "Input",
					Flag = arg6.Flag,
					Value = arg6.Value or "",
					ElementFrame = v40,
					Set = function(arg7, arg8)
						tbl21.Value = tostring(arg8 or "")
						v41.Text = tbl21.Value
						fn20(arg6.Callback, tbl21.Value)
					end,
					_load = function(arg7, arg8)
						tbl21:Set(arg8)
					end,
					_save = function()
						return tbl21.Value
					end,
				}

				v41.Focused:Connect(function()
					fn19(uiStroke, 0.15, { Color = tbl6.sub })
				end)

				v41.FocusLost:Connect(function()
					fn19(uiStroke, 0.15, { Color = tbl6.cardLine })

					if v41.Text ~= tbl21.Value then
						tbl21:Set(v41.Text)
					end
				end)

				fn20(arg6.Callback, tbl21.Value)
				return fn47(tbl21, arg6.Flag)
			end

			tbl20.Dropdown = function(arg5, arg6)
				local v40 = fn48(48)
				fn50(v40, arg6.Title, 180)
				local v41 = fn51(v40, { Position = UDim2.new(1, -14, 0.5, 0), Size = UDim2.fromOffset(0, 32) })
				fn14("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 9), Parent = v41 })

				fn14("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = v41,
				})

				local v42 = fn17(v41, { Size = 14, Weight = fontWeight.SemiBold, Box = UDim2.fromOffset(0, 32), AutoX = true })
				fn14("UISizeConstraint", { MaxSize = Vector2.new(150, 32), Parent = v42 })
				v42.LayoutOrder = 1
				local Frame26 = fn14("Frame", { BackgroundColor3 = color2, Size = UDim2.fromOffset(18, 18), LayoutOrder = 2, Parent = v41 })
				fn15(Frame26, 9)
				fn18(Frame26, "chevron-down", 12, tbl6.ink, tbl8)

				local tbl21 = {
					Type = "Dropdown",
					Flag = arg6.Flag,
					Values = arg6.Values or {},
					Value = arg6.Value,
					ElementFrame = v40,
				}

				local function fn52()
					v42.Text = tbl21.Value ~= nil and tostring(tbl21.Value) or "None"
				end

				fn52()

				tbl21.Select = function(arg7, value)
					tbl21.Value = value
					fn52()
					fn20(arg6.Callback, value)
				end

				tbl21.Set = tbl21.Select

				tbl21.Refresh = function(arg7, values)
					tbl21.Values = values or {}
					fn52()
				end

				tbl21._load = function(arg7, arg8)
					tbl21:Select(arg8)
				end

				tbl21._save = function()
					return tbl21.Value
				end

				v41.Activated:Connect(function()
					local v43 = fn39(v41, 210, math.min(#tbl21.Values, 7) * 34 + 10)

					local ScrollingFrame3 = fn14("ScrollingFrame", {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						CanvasSize = UDim2.new(),
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						ScrollBarThickness = 2,
						ScrollBarImageColor3 = tbl6.dim,
						ZIndex = 2,
						Parent = v43,
					})

					fn14("UIPadding", {
						PaddingTop = UDim.new(0, 5),
						PaddingBottom = UDim.new(0, 5),
						PaddingLeft = UDim.new(0, 5),
						PaddingRight = UDim.new(0, 5),
						Parent = ScrollingFrame3,
					})

					fn14("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = ScrollingFrame3 })

					for i, value in ipairs(tbl21.Values) do
						local flag6 = value == tbl21.Value

						local TextButton4 = fn14("TextButton", {
							Text = "",
							AutoButtonColor = false,
							BackgroundColor3 = flag6 and color2 or tbl6.hover,
							BackgroundTransparency = flag6 and 0 or 1,
							Size = UDim2.new(1, 0, 0, 34),
							LayoutOrder = i,
							ZIndex = 2,
							Parent = ScrollingFrame3,
						})

						fn15(TextButton4, 8)

						fn17(TextButton4, {
							Text = tostring(value),
							Size = 14,
							Weight = flag6 and fontWeight.SemiBold or fontWeight.Regular,
							Color = flag6 and tbl6.ink or tbl6.text,
							Position = UDim2.fromOffset(12, 0),
							Box = UDim2.new(1, -40, 1, 0),
							Z = 2,
						})

						if flag6 then
							fn18(TextButton4, "check", 14, tbl6.ink, { Anchor = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Z = 2 })
						end

						TextButton4.MouseEnter:Connect(function()
							if not flag6 then
								fn19(TextButton4, 0.12, { BackgroundTransparency = 0 })
							end
						end)

						TextButton4.MouseLeave:Connect(function()
							if not flag6 then
								fn19(TextButton4, 0.12, { BackgroundTransparency = 1 })
							end
						end)

						TextButton4.Activated:Connect(function()
							closePopup()
							tbl21:Select(value)
						end)
					end
				end)

				if tbl21.Value ~= nil then
					fn20(arg6.Callback, tbl21.Value)
				end

				return fn47(tbl21, arg6.Flag)
			end

			tbl20.Keybind = function(arg5, arg6)
				local v40 = fn48(48)
				fn50(v40, arg6.Title, 120)
				local v41 = fn51(v40, { Size = UDim2.fromOffset(0, 30) })
				fn14("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12), Parent = v41 })

				local v42 = fn17(v41, {
					Size = 13,
					Weight = fontWeight.Bold,
					Box = UDim2.fromOffset(0, 30),
					AutoX = true,
					AlignX = Enum.TextXAlignment.Center,
				})

				local uiStroke = v41:FindFirstChildWhichIsA("UIStroke")
				local tbl21 = { Type = "Keybind", Flag = arg6.Flag, Value = arg6.Value, ElementFrame = v40 }

				local function fn52()
					v42.Text = tostring(tbl21.Value or "None")
				end

				fn52()

				tbl21.Set = function(arg7, arg8)
					local name

					if typeof(arg8) == "EnumItem" then
						name = arg8.Name
					else
						name = arg8
					end

					tbl21.Value = name
					fn52()
					fn20(arg6.Callback, name)
				end

				tbl21._load = function(arg7, arg8)
					tbl21:Set(arg8)
				end

				tbl21._save = function()
					return tbl21.Value
				end

				local flag6 = false
				local connection2 = nil

				v41.Activated:Connect(function()
					if flag6 then
						return
					end
					flag6 = true
					v42.Text = "Press a key"
					fn19(v41, 0.15, { BackgroundColor3 = color2 })
					fn19(v42, 0.15, { TextColor3 = tbl6.ink })
					fn19(uiStroke, 0.15, { Color = color2 })

					connection2 = UserInputService2.InputBegan:Connect(function(input)
						if input.UserInputType ~= Enum.UserInputType.Keyboard then
							return
						end
						connection2:Disconnect()
						flag6 = false
						fn19(v41, 0.15, { BackgroundColor3 = tbl6.field })
						fn19(v42, 0.15, { TextColor3 = tbl6.text })
						fn19(uiStroke, 0.15, { Color = tbl6.cardLine })
						if input.KeyCode == Enum.KeyCode.Escape then
							fn52()
							return
						end
						tbl21:Set(input.KeyCode.Name)
					end)
				end)

				return fn47(tbl21, arg6.Flag)
			end

			tbl20.Colorpicker = function(arg5, arg6)
				local v40 = fn48(48)
				fn50(v40, arg6.Title, 80)
				local v41 = fn14
				local tbl21 = { Text = "", AutoButtonColor = false, BackgroundColor3 = arg6.Default or color2 }
				tbl21.AnchorPoint = Vector2.new(1, 0.5)
				tbl21.Position = UDim2.new(1, -16, 0.5, 0)
				tbl21.Size = UDim2.fromOffset(30, 30)
				tbl21.Parent = v40
				local TextButton4 = v41("TextButton", tbl21)
				fn15(TextButton4, 15)
				fn16(TextButton4, tbl6.cardLine).Thickness = 3
				local tbl22

				tbl22 = {
					Type = "Colorpicker",
					Flag = arg6.Flag,
					Value = arg6.Default or color2,
					ElementFrame = v40,
					Update = function(arg7, value)
						if typeof(value) ~= "Color3" then
							return
						end
						tbl22.Value = value
						TextButton4.BackgroundColor3 = value
					end,
					Set = function(arg7, arg8)
						if typeof(arg8) ~= "Color3" then
							return
						end
						tbl22:Update(arg8)
						fn20(arg6.Callback, arg8)
					end,
					_load = function(arg7, arg8)
						local ok, result = pcall(Color3.fromHex, tostring(arg8))

						if ok and result then
							tbl22:Set(result)
						end
					end,
					_save = function()
						return tbl22.Value:ToHex()
					end,
				}

				TextButton4.Activated:Connect(function()
					local v42 = fn39(TextButton4, 240, 240)

					fn14("UIPadding", {
						PaddingTop = UDim.new(0, 12),
						PaddingLeft = UDim.new(0, 12),
						PaddingRight = UDim.new(0, 12),
						Parent = v42,
					})

					local n10, n11, n12 = tbl22.Value:ToHSV()

					local Frame26 = fn14("Frame", {
						BackgroundColor3 = Color3.fromHSV(n10, 1, 1),
						Size = UDim2.new(1, 0, 0, 150),
						ZIndex = 2,
						Parent = v42,
					})

					fn15(Frame26, 9)
					local Frame27 = fn14("Frame", { BackgroundColor3 = color2, Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = Frame26 })
					fn15(Frame27, 9)
					fn14("UIGradient", { Transparency = NumberSequence.new(0, 1), Parent = Frame27 })
					local Frame28 = fn14("Frame", { BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), ZIndex = 2, Parent = Frame26 })
					fn15(Frame28, 9)
					fn14("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0), Parent = Frame28 })

					local Frame29 = fn14("Frame", {
						BackgroundTransparency = 1,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromOffset(14, 14),
						ZIndex = 3,
						Parent = Frame26,
					})

					fn15(Frame29, 7)
					fn16(Frame29, color2).Thickness = 2

					local Frame30 = fn14("Frame", {
						BackgroundColor3 = color2,
						Position = UDim2.fromOffset(0, 162),
						Size = UDim2.new(1, 0, 0, 12),
						ZIndex = 2,
						Parent = v42,
					})

					fn15(Frame30, 6)
					local tbl23 = {}

					for i = 0, 6 do
						tbl23[#tbl23 + 1] = ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6 % 1, 1, 1))
					end

					fn14("UIGradient", { Color = ColorSequence.new(tbl23), Parent = Frame30 })

					local Frame31 = fn14("Frame", {
						BackgroundColor3 = color2,
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromOffset(8, 18),
						ZIndex = 3,
						Parent = Frame30,
					})

					fn15(Frame31, 4)
					fn16(Frame31, tbl6.cardLine)

					local TextBox2 = fn14("TextBox", {
						BackgroundColor3 = tbl6.field,
						Position = UDim2.fromOffset(0, 188),
						Size = UDim2.new(1, -42, 0, 30),
						ClearTextOnFocus = false,
						FontFace = fn13(fontWeight.SemiBold),
						TextSize = 13,
						TextColor3 = tbl6.text,
						ZIndex = 2,
						Parent = v42,
					})

					fn15(TextBox2, 8)
					fn16(TextBox2, tbl6.cardLine)

					local Frame32 = fn14("Frame", {
						AnchorPoint = Vector2.new(1, 0),
						Position = UDim2.new(1, 0, 0, 188),
						Size = UDim2.fromOffset(34, 30),
						ZIndex = 2,
						Parent = v42,
					})

					fn15(Frame32, 8)
					fn16(Frame32, tbl6.cardLine)

					local function fn52(arg7)
						local color3 = Color3.fromHSV(n10, n11, n12)
						Frame26.BackgroundColor3 = Color3.fromHSV(n10, 1, 1)
						Frame29.Position = UDim2.fromScale(n11, 1 - n12)
						Frame31.Position = UDim2.fromScale(n10, 0.5)
						TextBox2.Text = "#" .. color3:ToHex():upper()
						Frame32.BackgroundColor3 = color3

						if arg7 then
							tbl22:Set(color3)
						end
					end

					fn52(false)

					local function fn53(arg7)
						n11 = math.clamp((arg7.X - Frame26.AbsolutePosition.X) / Frame26.AbsoluteSize.X, 0, 1)
						n12 = 1 - math.clamp((arg7.Y - Frame26.AbsolutePosition.Y) / Frame26.AbsoluteSize.Y, 0, 1)
						fn52(true)
					end

					local v43 = fn23(fn14("TextButton", { Text = "", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 4, Parent = Frame26 }), fn53, fn53)

					local function fn54(arg7)
						n10 = math.clamp((arg7.X - Frame30.AbsolutePosition.X) / Frame30.AbsoluteSize.X, 0, 0.999)
						fn52(true)
					end

					local v44 = fn23(fn14("TextButton", {
						Text = "",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 1, 8),
						Position = UDim2.fromOffset(0, -4),
						ZIndex = 4,
						Parent = Frame30,
					}), fn54, fn54)

					TextBox2.FocusLost:Connect(function()
						local v45 = pcall
						local color3 = Color3.fromHex
						local str2 = TextBox2.Text:gsub("#", "")
						local v46, v47 = v45(color3, str2)

						if v46 and v47 then
							local v48, v49, v50 = v47:ToHSV()
							n10 = v48
							n11 = v49
							n12 = v50
							fn52(true)
						else
							fn52(false)
						end
					end)

					v42.Destroying:Connect(function()
						v43:Disconnect()
						v44:Disconnect()
					end)
				end)

				return fn47(tbl22, arg6.Flag)
			end

			return tbl20
		end

		tbl10.Dialog = function(arg3, arg4)
			return { Show = function()
				closePopup()

				local TextButton4 = fn14("TextButton", {
					Text = "",
					AutoButtonColor = false,
					BackgroundColor3 = Color3.new(0, 0, 0),
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Parent = StarUI_Overlay,
				})

				fn19(TextButton4, 0.2, { BackgroundTransparency = 0.45 })

				local Frame24 = fn14("Frame", {
					BackgroundColor3 = tbl6.card,
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(350, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					Parent = TextButton4,
				})

				fn14("UIScale", { Scale = UIScale.Scale, Parent = Frame24 })
				fn15(Frame24, 16)
				fn16(Frame24, tbl6.cardLine)

				fn14("UIPadding", {
					PaddingTop = UDim.new(0, 20),
					PaddingBottom = UDim.new(0, 20),
					PaddingLeft = UDim.new(0, 20),
					PaddingRight = UDim.new(0, 20),
					Parent = Frame24,
				})

				fn14("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Frame24 })
				local Frame25 = fn14("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32), LayoutOrder = 1, Parent = Frame24 })

				if arg4.Icon then
					local Frame26 = fn14("Frame", {
						BackgroundColor3 = color2,
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 0, 0.5, 0),
						Size = UDim2.fromOffset(32, 32),
						Parent = Frame25,
					})

					fn15(Frame26, 10)
					fn18(Frame26, arg4.Icon, 16, tbl6.ink, tbl8)
				end

				fn17(Frame25, {
					Text = arg4.Title or "",
					Size = 18,
					Weight = fontWeight.Bold,
					Position = UDim2.fromOffset(arg4.Icon and 42 or 0, 0),
					Box = UDim2.new(1, -42, 1, 0),
				})

				fn17(Frame24, {
					Text = arg4.Content or "",
					Size = 14,
					Color = tbl6.sub,
					Wrap = true,
					Box = UDim2.new(1, 0, 0, 0),
					AutoY = true,
					AlignY = Enum.TextYAlignment.Top,
				}).LayoutOrder = 2

				local Frame26 = fn14("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = 3, Parent = Frame24 })

				fn14("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					VerticalAlignment = Enum.VerticalAlignment.Bottom,
					Padding = UDim.new(0, 8),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Frame26,
				})

				local function fn48()
					pcall(function()
						TextButton4:Destroy()
					end)
				end

				local v40 = ipairs
				local buttons = arg4.Buttons or {}

				for k, button in v40(buttons) do
					local flag6 = button.Variant == "Primary"

					local TextButton5 = fn14("TextButton", {
						Text = "",
						AutoButtonColor = false,
						BackgroundColor3 = flag6 and color2 or tbl6.field,
						Size = UDim2.fromOffset(0, 36),
						AutomaticSize = Enum.AutomaticSize.X,
						LayoutOrder = k,
						Parent = Frame26,
					})

					fn15(TextButton5, 18)

					if not flag6 then
						fn16(TextButton5, tbl6.cardLine)
					end

					fn14("UIPadding", { PaddingLeft = UDim.new(0, 18), PaddingRight = UDim.new(0, 18), Parent = TextButton5 })

					fn17(TextButton5, {
						Text = button.Title or "OK",
						Size = 14,
						Weight = fontWeight.SemiBold,
						Color = flag6 and tbl6.ink or tbl6.text,
						Box = UDim2.fromOffset(0, 36),
						AutoX = true,
					})

					TextButton5.Activated:Connect(function()
						fn48()
						fn20(button.Callback)
					end)
				end
			end }
		end

		tbl10.ConfigManager = {}

		tbl10.ConfigManager.CreateConfig = function(arg3, arg4)
			local str2 = "WindUI/" .. (tbl9.Folder or "StarHub") .. "/config"
			local str3 = str2 .. "/" .. arg4 .. ".json"

			local function fn48()
				local ok, result = pcall(function()
					return HttpService:JSONDecode(readfile(str3))
				end)

				return ok and type(result) == "table" and result or nil
			end

			return {
				Elements = tbl10.Flags,
				Path = str3,
				Save = function()
					local tbl20 = fn48() or {}
					local tbl21 = {}

					for k, flag6 in pairs(tbl10.Flags) do
						if flag6._save then
							local ok, result = pcall(flag6._save)

							if ok and result ~= nil then
								tbl21[k] = { __type = flag6.Type, value = result }
							end
						end
					end

					local v40 = pairs
					local elements = tbl20.__elements or {}

					for k, element in v40(elements) do
						if tbl21[k] == nil and tbl10.Flags[k] == nil then
							tbl21[k] = element
						end
					end

					local tbl22 = {
						__version = tbl20.__version or 1,
						__autoload = tbl20.__autoload,
						__elements = tbl21,
						__custom = tbl20.__custom or {},
					}

					pcall(function()
						if not isfolder("WindUI") then
							makefolder("WindUI")
						end

						if not isfolder("WindUI/" .. (tbl9.Folder or "StarHub")) then
							makefolder("WindUI/" .. (tbl9.Folder or "StarHub"))
						end

						if not isfolder(str2) then
							makefolder(str2)
						end
					end)

					writefile(str3, HttpService:JSONEncode(tbl22))
				end,
				Load = function()
					local v40 = fn48()

					if not v40 then
						error("no saved config")
					end

					local v41 = pairs
					local elements = v40.__elements or {}

					for k, element in v41(elements) do
						local v42 = tbl10.Flags[k]

						if v42 and v42._load and type(element) == "table" and element.value ~= nil then
							local ok, result = pcall(v42._load, v42, element.value)

							if not ok then
								warn("[Star UI] could not load " .. k .. ": " .. tostring(result))
							end
						end
					end
				end,
			}
		end

		return tbl10
	end

	tbl7.SetTheme = function()
	end

	tbl7.AddTheme = function()
	end

	tbl7.OnThemeChange = function()
	end

	return tbl7
end

_G.StarUI = fn12()
local starUI
starUI = _G.StarUI
_G.WindUI = starUI
pcall(_G.__ApplyActionButtonIcons)
_G.__ThemePainters = {}

_G.__ThemeColor = function(arg, arg2)
	local theme = starUI.Theme
	local value = theme and theme[arg]

	for i = 1, 6 do
		if not (type(value) ~= "string" or value:sub(1, 1) == "#") then
			value = theme[value]
			continue
		end
		break
	end

	if type(value) == "string" then
		local ok, result = pcall(Color3.fromHex, value)
		value = ok and result or nil
	elseif type(value) == "table" and typeof(value.Color) == "ColorSequence" then
		value = value.Color.Keypoints[1].Value
	end

	return typeof(value) == "Color3" and value or arg2
end

_G.__ThemeSequence = function(arg)
	local theme = starUI.Theme and starUI.Theme[arg]
	if type(theme) == "table" and typeof(theme.Color) == "ColorSequence" then
		return theme.Color, theme.Rotation
	end
end

_G.__OnTheme = function(arg)
	table.insert(_G.__ThemePainters, arg)
	pcall(arg)
end

pcall(function()
	starUI:OnThemeChange(function()
		for _, themePainter in ipairs(_G.__ThemePainters) do
			pcall(themePainter)
		end
	end)
end)

_G.WindNotify = function(arg, arg2, arg3)
	pcall(function()
		local v5 = starUI
		local notify = v5.Notify
		local tbl5 = { Title = arg, Content = arg2, Duration = 2.5 }
		local v6 = arg3
		local icon

		if arg3 then
			icon = v6
		else
			icon = "info"
		end

		tbl5.Icon = icon
		notify(v5, tbl5)
	end)
end

do
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegThrowAimbot"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 96
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.ThrowAimbotGui = screenGui
	local textButton = Instance.new("TextButton")
	textButton.Name = "ThrowAimbot"
	textButton.AnchorPoint = Vector2.new(0, 0.5)
	textButton.Position = UDim2.new(0, 500, 0.38, 84)
	_G.__TrackButtonPosition("ThrowKnife", textButton)
	textButton.Active = true
	textButton.Parent = screenGui
	local v5 = _G.__StyleSquareButton(textButton, "__mm2_throw_knife", "THROW\nKNIFE", Color3.fromRGB(255, 48, 70))
	_G.ThrowAimbotButtonEnabled = false

	_G.ThrowAimbotButtonSetEnabled = function(arg)
		_G.ThrowAimbotButtonEnabled = arg and true or false
		screenGui.Enabled = _G.ThrowAimbotButtonEnabled
	end

	textButton.MouseEnter:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(255, 120, 135), Transparency = 0 }):Play()
	end)

	textButton.MouseLeave:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(255, 48, 70), Transparency = 0.15 }):Play()
	end)

	local flag2 = false
	local flag3 = false
	local position = nil
	local position2 = nil
	local v6 = nil

	textButton.InputBegan:Connect(function(input)
		if _G.LockButtonsEnabled then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = true
			flag3 = false
			position = input.Position
			position2 = textButton.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag2 = false
				end
			end)
		end
	end)

	textButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v6 = input
		end
	end)

	table.insert(_G.CoinESPConn, UserInputService.InputChanged:Connect(function(input)
		if flag2 and input == v6 then
			local n2 = input.Position - position

			if n2.Magnitude > 6 then
				flag3 = true
			end

			textButton.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n2.X, position2.Y.Scale, position2.Y.Offset + n2.Y)
		end
	end))

	local flag4 = false

	textButton.Activated:Connect(function()
		if flag3 or flag4 then
			return
		end
		flag4 = true
		local v7, v8 = _G.ThrowAimbotOnce()

		if _G.WindNotify then
			if v7 then
				_G.WindNotify("Throw Aimbot", "Knife thrown.", "circle-check")
			else
				_G.WindNotify("Throw Aimbot", tostring(v8), "circle-x")
			end
		end

		flag4 = false
	end)
end

do
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MarbegKillAll"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 97
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Enabled = false
	screenGui.Parent = fn2()
	_G.KillAllGui = screenGui
	local textButton = Instance.new("TextButton")
	textButton.Name = "KillAll"
	textButton.AnchorPoint = Vector2.new(0, 0.5)
	textButton.Position = UDim2.new(0, 584, 0.38, 84)
	_G.__TrackButtonPosition("KillAll", textButton)
	textButton.Active = true
	textButton.AutoLocalize = false
	textButton.Parent = screenGui
	local v5 = _G.__StyleSquareButton(textButton, "__mm2_default_knife", "KILL\nALL", Color3.fromRGB(255, 35, 60))
	_G.KillAllButtonRequested = false

	_G.KillAllButtonSetEnabled = function(arg)
		_G.KillAllButtonRequested = arg and true or false
		screenGui.Enabled = _G.KillAllButtonRequested
	end

	textButton.MouseEnter:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(255, 110, 125), Transparency = 0 }):Play()
	end)

	textButton.MouseLeave:Connect(function()
		TweenService:Create(v5, TweenInfo.new(0.13), { Color = Color3.fromRGB(255, 35, 60), Transparency = 0.15 }):Play()
	end)

	local flag2 = false
	local flag3 = false
	local position = nil
	local position2 = nil
	local v6 = nil

	textButton.InputBegan:Connect(function(input)
		if _G.LockButtonsEnabled then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag2 = true
			flag3 = false
			position = input.Position
			position2 = textButton.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag2 = false
				end
			end)
		end
	end)

	textButton.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			v6 = input
		end
	end)

	table.insert(_G.CoinESPConn, UserInputService.InputChanged:Connect(function(input)
		if flag2 and input == v6 then
			local n2 = input.Position - position

			if n2.Magnitude > 6 then
				flag3 = true
			end

			textButton.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n2.X, position2.Y.Scale, position2.Y.Offset + n2.Y)
		end
	end))

	textButton.Activated:Connect(function()
		if flag3 or _G.KillAllBusy then
			return
		end
		local v7, v8 = _G.KillAllMurderer()

		if _G.WindNotify then
			_G.WindNotify("Kill All", tostring(v8 or v7 and "Started" or "Unavailable"), v7 and "skull" or "circle-x")
		end
	end)
end

local v5

v5 = starUI:CreateWindow({
	Title = "Star Hub",
	Icon = "star",
	Logo = "rbxthumb://type=Asset&id=118194363324034&w=420&h=420",
	Author = "Murder Mystery 2",
	Folder = "MarbegMM2",
	Size = UDim2.fromOffset(740, 520),
	MinSize = Vector2.new(560, 380),
	Resizable = true,
	SideBarWidth = 210,
	HideSearchBar = true,
	ScrollBarEnabled = false,
	User = { Enabled = true, Anonymous = false },
	OpenButton = {
		Title = "Star Hub",
		Icon = "star",
		CornerRadius = UDim.new(1, 0),
		StrokeThickness = 2,
		Enabled = true,
		Draggable = true,
		OnlyMobile = true,
	},
})

_G.WindUIWindow = v5
_G.ObsidianWindow = nil

pcall(function()
	v5:Tag({ Title = _G.ScriptVersion })
end)

table.insert(_G.CoinESPConn, UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == (_G.MenuToggleKey or Enum.KeyCode.RightShift) and not UserInputService:GetFocusedTextBox() then
		pcall(function()
			v5:Toggle()
		end)
	end
end))

local tbl5
tbl5 = { Home = v5:Tab({ Title = "Home", Icon = "house" }) }
v5:Divider()
local v6 = v5:Section({ Title = "Settings", Icon = "settings", Opened = false })
tbl5.Buttons = v6:Tab({ Title = "On-Screen Buttons", Icon = "mouse-pointer-click" })
tbl5.Keybinds = UserInputService.KeyboardEnabled and v6:Tab({ Title = "Keybinds", Icon = "keyboard" }) or nil
tbl5.General = v6:Tab({ Title = "General", Icon = "sliders-horizontal" })
local v7 = v5:Section({ Title = "Player", Icon = "user", Opened = true })
tbl5.Movement = v7:Tab({ Title = "Movement", Icon = "footprints" })
tbl5.Emotes = v7:Tab({ Title = "Emotes", Icon = "smile" })
tbl5.Players = v7:Tab({ Title = "Players", Icon = "users" })
local v8 = v5:Section({ Title = "Combat", Icon = "swords", Opened = true })
tbl5.Aim = v8:Tab({ Title = "Aim", Icon = "crosshair" })
tbl5.Roles = v8:Tab({ Title = "Sheriff & Murderer", Icon = "sword" })
tbl5.Fling = v8:Tab({ Title = "Fling", Icon = "wind" })
local v9 = v5:Section({ Title = "Visuals", Icon = "eye", Opened = true })
tbl5.ESP = v9:Tab({ Title = "ESP", Icon = "scan-eye" })
tbl5.Effects = v9:Tab({ Title = "Effects", Icon = "sparkles" })
tbl5.World = v9:Tab({ Title = "World", Icon = "sun" })
tbl5.Crosshair = v9:Tab({ Title = "Crosshair", Icon = "locate-fixed" })
local v10 = v5:Section({ Title = "Skin Changer", Icon = "palette", Opened = true })
tbl5.GunSkins = v10:Tab({ Title = "Gun", Icon = "crosshair" })
tbl5.KnifeSkins = v10:Tab({ Title = "Knife", Icon = "sword" })
local v11 = v5:Section({ Title = "Farming", Icon = "coins", Opened = true })
tbl5.Farm = v11:Tab({ Title = "Auto Farm", Icon = "bot" })
tbl5.Cases = v11:Tab({ Title = "Cases", Icon = "package-open" })
tbl5.Webhook = v11:Tab({ Title = "Webhook", Icon = "webhook" })
_G.CrosshairTab = tbl5.Crosshair
_G.MM2ScriptConfig = v5.ConfigManager and v5.ConfigManager:CreateConfig("mm2_settings")
_G.AutoConfigEnabled = true
_G.ConfigLoading = false
_G.ConfigReady = false
_G.ConfigSaveToken = 0

_G.SaveScriptConfig = function(arg)
	if not _G.MM2ScriptConfig then
		arg = arg and _G.WindNotify

		if arg then
			_G.WindNotify("Config", "Config is not supported.", "circle-x")
		end

		return false
	end

	local ok = pcall(function()
		_G.MM2ScriptConfig:Save()
	end)

	if arg and _G.WindNotify then
		_G.WindNotify("Config", ok and "Settings saved." or "Save failed.", ok and "save" or "circle-x")
	end

	return ok
end

_G.QueueConfigSave = function()
	if not _G.ConfigReady or not _G.AutoConfigEnabled or _G.ConfigLoading then
		return
	end
	local v12 = _G
	v12.ConfigSaveToken = v12.ConfigSaveToken + 1
	local configSaveToken = _G.ConfigSaveToken

	task.delay(0.35, function()
		if configSaveToken == _G.ConfigSaveToken and _G.AutoConfigEnabled and not _G.ConfigLoading then
			_G.SaveScriptConfig(false)
		end
	end)
end

_G.LoadScriptConfig = function(arg)
	if not _G.MM2ScriptConfig then
		return false
	end
	_G.ConfigLoading = true

	local ok = pcall(function()
		_G.MM2ScriptConfig:Load()
	end)

	_G.ConfigLoading = false

	if arg and _G.WindNotify then
		_G.WindNotify("Config", ok and "Settings loaded." or "No saved config found.", ok and "folder-open" or "circle-x")
	end

	return ok
end

queueConfigSave = _G.QueueConfigSave
saveScriptConfig = _G.SaveScriptConfig
loadScriptConfig = _G.LoadScriptConfig
local fn13

fn13 = function(arg, arg2, arg3)
	pcall(function()
		starUI:Notify({
			Title = arg,
			Content = arg2 and "Enabled" or "Disabled",
			Duration = 2,
			Icon = arg2 and (arg3 or "circle-check") or "circle-off",
		})
	end)
end

local tbl6

local function fn14(arg)
	if type(arg) == "string" then
		return _G[arg]
	end
	return arg
end

tbl6 = {
	Box = function(arg, arg2, arg3)
		return arg:Section({ Title = arg2, Icon = arg3, Opened = true })
	end,
	Switch = function(arg)
		return arg
	end,
	Toggle = function(arg, arg2)
		return tbl6.Switch(arg:Toggle({
			Title = arg2.Title,
			Flag = arg2.Flag,
			Value = arg2.Value == true,
			Callback = function(arg3)
				local v12 = fn14(arg2.Set)

				if v12 then
					v12(arg3)
				end

				queueConfigSave()

				if arg2.Notify then
					fn13(arg2.Title, arg3, arg2.Notify)
				end
			end,
		}))
	end,
	Slider = function(arg, arg2)
		return arg:Slider({
			Title = arg2.Title,
			Step = arg2.Step or 1,
			Flag = arg2.Flag,
			Value = { Min = arg2.Min, Max = arg2.Max, Default = arg2.Default },
			Callback = function(arg3)
				local v12 = fn14(arg2.Set)

				if v12 then
					v12(arg3)
				end

				queueConfigSave()
			end,
		})
	end,
	Color = function(arg, arg2)
		return arg:Colorpicker({
			Title = arg2.Title,
			Flag = arg2.Flag,
			Default = arg2.Default,
			Callback = function(arg3)
				local v12 = fn14(arg2.Set)

				if v12 then
					v12(arg3)
				end

				queueConfigSave()
			end,
		})
	end,
	Action = function(arg, arg2)
		return arg:Button({
			Title = arg2.Title,
			Icon = arg2.Icon,
			Color = arg2.Color,
			Callback = function()
				local v12, v13 = arg2.Run()

				if _G.WindNotify then
					local windNotify = _G.WindNotify
					local title = arg2.Title
					local str = tostring(v13 or v12 and "Done" or "Failed")
					local icon

					if v12 then
						icon = arg2.Icon or "circle-check"
					else
						icon = v12
					end

					windNotify(title, str, icon or "circle-x")
				end
			end,
		})
	end,
}

_G.AnonymousMode = false

_G.AnonymousSetEnabled = function(arg)
	_G.AnonymousMode = arg == true

	pcall(function()
		_G.WindUIWindow.User:SetAnonymous(_G.AnonymousMode)
	end)

	if _G.__HomeApplyIdentity then
		pcall(_G.__HomeApplyIdentity)
	end
end

_G.__BuildHome = function()
	local function fn15(arg)
		if type(arg) ~= "number" then
			return "-"
		end
		return (tostring(math.floor(arg)):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
	end

	local function fn16(arg)
		local n2 = math.max(0, math.floor(arg))
		return string.format("%dh %02dm", n2 // 3600, n2 % 3600 // 60)
	end

	local themeColor = _G.__ThemeColor

	local tbl7 = {
		Murderer = Color3.fromRGB(235, 50, 60),
		Sheriff = Color3.fromRGB(45, 120, 255),
		Hero = Color3.fromRGB(240, 190, 30),
		Innocent = Color3.fromRGB(40, 190, 90),
		Lobby = Color3.fromRGB(110, 112, 128),
		Dead = Color3.fromRGB(80, 80, 90),
	}

	local function fn17(arg)
		local windUI = _G.WindUI

		if windUI and windUI.Creator and windUI.Creator.Icon then
			local ok, result = pcall(windUI.Creator.Icon, arg)
			if ok and type(result) == "table" and result[1] then
				return result[1]
			end
		end

		return ""
	end

	local function createUICorner(parent, cornerRadius)
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = cornerRadius
		uiCorner.Parent = parent
		return uiCorner
	end

	local function createTextLabel(parent, text, textSize, arg)
		local textLabel = Instance.new("TextLabel")
		textLabel.BackgroundTransparency = 1
		textLabel.Text = text
		textLabel.TextSize = textSize
		textLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", arg or Enum.FontWeight.Medium)
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.AutoLocalize = false
		textLabel.Parent = parent
		return textLabel
	end

	local scrollingFrame = tbl5.Home.ContainerFrame and tbl5.Home.ContainerFrame:FindFirstChild("ScrollingFrame")
	local tbl8 = {}

	if scrollingFrame then
		local frame = Instance.new("Frame")
		frame.Name = "StarHubDashboard"
		frame.LayoutOrder = -100
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 0, 0)
		frame.AutomaticSize = Enum.AutomaticSize.Y
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.Padding = UDim.new(0, 10)
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Parent = frame
		local palette = _G.StarUI.Palette
		local tbl9 = {}

		local function fn18(layoutOrder, arg)
			local frame2 = Instance.new("Frame")
			frame2.LayoutOrder = layoutOrder
			frame2.Size = UDim2.new(1, 0, 0, arg)
			frame2.BorderSizePixel = 0
			frame2.Parent = frame
			createUICorner(frame2, UDim.new(0, 12))
			local uiGradient = Instance.new("UIGradient")
			uiGradient.Rotation = 90
			local color = Color3.fromRGB
			uiGradient.Color = ColorSequence.new(Color3.fromRGB(20, 20, 24), color(15, 15, 18))
			uiGradient.Parent = frame2
			local uiStroke = Instance.new("UIStroke")
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.Color = Color3.new(1, 1, 1)
			uiStroke.Parent = frame2
			local uiGradient2 = Instance.new("UIGradient")
			uiGradient2.Parent = uiStroke
			tbl9[#tbl9 + 1] = { frame = frame2, edge = uiGradient2 }
			return frame2, uiGradient2
		end

		local v12, v13 = fn18(1, 120)
		local frame2 = Instance.new("Frame")
		frame2.BorderSizePixel = 0
		frame2.Size = UDim2.fromScale(1, 1)
		frame2.BackgroundTransparency = 0.82
		frame2.Parent = v12
		createUICorner(frame2, UDim.new(0, 12))
		local uiGradient = Instance.new("UIGradient")
		local numberSequence = NumberSequence.new
		local tbl10 = {}
		local v14 = NumberSequenceKeypoint.new(0, 0)
		local v15 = NumberSequenceKeypoint.new(0.55, 0.75)
		tbl10[1] = v14
		tbl10[2] = v15

		do
			local values = table.pack(NumberSequenceKeypoint.new(1, 1))
			table.move(values, 1, values.n, 3, tbl10)
		end

		uiGradient.Transparency = numberSequence(tbl10)
		uiGradient.Parent = frame2
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Size = UDim2.fromOffset(56, 56)
		imageLabel.Position = UDim2.fromOffset(16, 16)
		imageLabel.BackgroundColor3 = Color3.new(0, 0, 0)
		imageLabel.BackgroundTransparency = 0.6
		imageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. localPlayer.UserId .. "&w=150&h=150"
		imageLabel.Parent = v12
		createUICorner(imageLabel, UDim.new(1, 0))
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 2
		uiStroke.Parent = imageLabel
		local v16 = createTextLabel(v12, localPlayer.DisplayName, 17, Enum.FontWeight.Bold)
		v16.Position = UDim2.fromOffset(86, 21)
		v16.Size = UDim2.new(1, -196, 0, 20)
		v16.TextTruncate = Enum.TextTruncate.AtEnd
		local v17 = createTextLabel(v12, "@" .. localPlayer.Name, 12)
		v17.Position = UDim2.fromOffset(86, 44)
		v17.Size = UDim2.new(1, -196, 0, 14)
		v17.TextTruncate = Enum.TextTruncate.AtEnd

		_G.__HomeApplyIdentity = function()
			local flag2 = _G.AnonymousMode == true
			imageLabel.Image = "rbxthumb://type=AvatarHeadShot&id=" .. (flag2 and 1 or localPlayer.UserId) .. "&w=150&h=150"
			v16.Text = flag2 and "Anonymous" or localPlayer.DisplayName
			v17.Text = flag2 and "@anonymous" or "@" .. localPlayer.Name
		end

		_G.__HomeApplyIdentity()
		local frame3 = Instance.new("Frame")
		frame3.AnchorPoint = Vector2.new(1, 0.5)
		frame3.Position = UDim2.new(1, -16, 0, 44)
		frame3.Size = UDim2.fromOffset(0, 24)
		frame3.AutomaticSize = Enum.AutomaticSize.X
		frame3.BorderSizePixel = 0
		frame3.Parent = v12
		createUICorner(frame3, UDim.new(1, 0))
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Color = Color3.fromRGB(10, 10, 16)
		uiStroke2.Transparency = 0.3
		uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke2.Parent = frame3
		local uiGradient2 = Instance.new("UIGradient")
		uiGradient2.Rotation = 90
		uiGradient2.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(190, 190, 190))
		uiGradient2.Parent = frame3
		local lobby = createTextLabel(frame3, "LOBBY", 11, Enum.FontWeight.Heavy)
		lobby.AutomaticSize = Enum.AutomaticSize.X
		lobby.Size = UDim2.fromOffset(0, 24)
		lobby.TextColor3 = Color3.new(1, 1, 1)
		lobby.TextStrokeTransparency = 0.5
		lobby.TextXAlignment = Enum.TextXAlignment.Center
		local uiPadding = Instance.new("UIPadding")
		uiPadding.PaddingLeft = UDim.new(0, 12)
		uiPadding.PaddingRight = UDim.new(0, 12)
		uiPadding.Parent = lobby
		local frame4 = Instance.new("Frame")
		frame4.BackgroundTransparency = 1
		frame4.Position = UDim2.fromOffset(16, 84)
		frame4.Size = UDim2.new(1, -32, 0, 22)
		frame4.Parent = v12
		local uiListLayout2 = Instance.new("UIListLayout")
		uiListLayout2.FillDirection = Enum.FillDirection.Horizontal
		uiListLayout2.Padding = UDim.new(0, 6)
		uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout2.Parent = frame4
		local tbl11 = {}

		local function fn19(layoutOrder, arg, imageColor3)
			local frame5 = Instance.new("Frame")
			frame5.LayoutOrder = layoutOrder
			frame5.Size = UDim2.fromOffset(0, 22)
			frame5.AutomaticSize = Enum.AutomaticSize.X
			frame5.BorderSizePixel = 0
			frame5.Parent = frame4
			createUICorner(frame5, UDim.new(1, 0))
			local uiPadding2 = Instance.new("UIPadding")
			uiPadding2.PaddingLeft = UDim.new(0, 8)
			uiPadding2.PaddingRight = UDim.new(0, 10)
			uiPadding2.Parent = frame5
			local uiListLayout3 = Instance.new("UIListLayout")
			uiListLayout3.FillDirection = Enum.FillDirection.Horizontal
			uiListLayout3.VerticalAlignment = Enum.VerticalAlignment.Center
			uiListLayout3.Padding = UDim.new(0, 5)
			uiListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
			uiListLayout3.Parent = frame5
			local imageLabel2 = Instance.new("ImageLabel")
			imageLabel2.Size = UDim2.fromOffset(12, 12)
			imageLabel2.BackgroundTransparency = 1
			imageLabel2.Image = fn17(arg)
			imageLabel2.ImageColor3 = imageColor3
			imageLabel2.Parent = frame5
			local v18 = createTextLabel(frame5, "", 11, Enum.FontWeight.SemiBold)
			v18.LayoutOrder = 1
			v18.AutomaticSize = Enum.AutomaticSize.X
			v18.Size = UDim2.fromOffset(0, 22)
			tbl11[#tbl11 + 1] = { frame = frame5, text = v18 }
			return frame5, v18
		end

		local v18, v19 = fn19(1, "sword", Color3.fromRGB(255, 80, 90))
		tbl8.murdererChip = v18
		tbl8.murdererText = v19
		tbl8.murdererIcon = tbl8.murdererChip:FindFirstChildWhichIsA("ImageLabel")
		local sword = fn17("sword")
		local hourglass = fn17("hourglass")
		tbl8.swordImage = sword
		tbl8.waitImage = hourglass
		local v20, v21 = fn19(2, "shield", Color3.fromRGB(80, 150, 255))
		tbl8.sheriffChip = v20
		tbl8.sheriffText = v21
		local v22, v23 = fn19(3, "shopping-bag", Color3.fromRGB(255, 196, 60))
		tbl8.bagChip = v22
		tbl8.bagText = v23
		local tbl12 = {}

		local function fn20(arg, arg2)
			local v24 = fn18(arg, 68)
			local tbl13 = {}

			for i, v25 in ipairs(arg2) do
				local frame5 = Instance.new("Frame")
				frame5.BackgroundTransparency = 1
				frame5.Position = UDim2.fromScale((i - 1) / #arg2, 0)
				frame5.Size = UDim2.fromScale(1 / #arg2, 1)
				frame5.Parent = v24
				local v26 = createTextLabel(frame5, "-", 20, Enum.FontWeight.Heavy)
				v26.TextXAlignment = Enum.TextXAlignment.Center
				v26.Position = UDim2.fromOffset(6, 13)
				v26.Size = UDim2.new(1, -12, 0, 22)
				v26.TextTruncate = Enum.TextTruncate.AtEnd
				local uiGradient3 = Instance.new("UIGradient")
				uiGradient3.Rotation = 90
				local color = Color3.fromRGB
				uiGradient3.Color = ColorSequence.new(Color3.new(1, 1, 1), color(182, 182, 192))
				uiGradient3.Parent = v26
				local v27 = createTextLabel(frame5, v25[1], 11, Enum.FontWeight.Heavy)
				v27.TextXAlignment = Enum.TextXAlignment.Center
				v27.Position = UDim2.fromOffset(6, 40)
				v27.Size = UDim2.new(1, -12, 0, 13)
				v27.TextColor3 = Color3.new(1, 1, 1)
				v27.TextTruncate = Enum.TextTruncate.AtEnd
				local v28 = v25[2]
				local uiGradient4 = Instance.new("UIGradient")
				local colorSequence = ColorSequence.new
				local tbl14 = {}
				local v29 = ColorSequenceKeypoint.new(0, v28)
				local v30 = ColorSequenceKeypoint.new(0.42, v28)
				local v31 = ColorSequenceKeypoint.new(0.5, v28:Lerp(Color3.new(1, 1, 1), 0.85))
				local v32 = ColorSequenceKeypoint.new(0.58, v28)
				local new = ColorSequenceKeypoint.new
				tbl14[1] = v29
				tbl14[2] = v30
				tbl14[3] = v31
				tbl14[4] = v32

				do
					local values = table.pack(new(1, v28))
					table.move(values, 1, values.n, 5, tbl14)
				end

				uiGradient4.Color = colorSequence(tbl14)
				uiGradient4.Offset = Vector2.new(-1, 0)
				uiGradient4.Parent = v27
				TweenService:Create(uiGradient4, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, false, 2.6 + i * 0.15), { Offset = Vector2.new(1, 0) }):Play()

				if i > 1 then
					local frame6 = Instance.new("Frame")
					frame6.BorderSizePixel = 0
					frame6.Position = UDim2.new(0, 0, 0, 16)
					frame6.Size = UDim2.new(0, 1, 1, -32)
					frame6.Parent = frame5
					tbl12[#tbl12 + 1] = frame6
				end

				tbl13[i] = v26
				tbl12[#tbl12 + 1] = v26
			end

			return tbl13
		end

		local tbl13 = {}
		local tbl14 = { "COINS", Color3.fromRGB(255, 196, 60) }
		local tbl15 = { "GEMS", Color3.fromRGB(120, 200, 255) }
		local tbl16 = { "LEVEL", Color3.fromRGB(190, 140, 255) }
		tbl13[1] = tbl14
		tbl13[2] = tbl15
		tbl13[3] = tbl16
		local v24 = fn20(2, tbl13)
		local v25 = v24[1]
		local v26 = v24[2]
		local v27 = v24[3]
		tbl8.coins = v25
		tbl8.gems = v26
		tbl8.level = v27
		local tbl17 = {}
		local tbl18 = { "AUTO FARM", Color3.fromRGB(142, 142, 151) }
		local tbl19 = { "PER HOUR", Color3.fromRGB(80, 220, 140) }
		local tbl20 = { "COLLECTED", Color3.fromRGB(255, 140, 90) }
		local tbl21 = { "UPTIME", Color3.fromRGB(243, 243, 245) }
		tbl17[1] = tbl18
		tbl17[2] = tbl19
		tbl17[3] = tbl20
		tbl17[4] = tbl21
		local v28 = fn20(3, tbl17)
		local v29 = v28[2]
		local v30 = v28[3]
		local v31 = v28[4]
		tbl8.farm = v28[1]
		tbl8.rate = v29
		tbl8.collected = v30
		tbl8.uptime = v31
		tbl8.pill = frame3
		tbl8.pillText = lobby
		tbl8.ring = uiStroke
		tbl8.glow = frame2
		tbl8.cardEdge = v13

		_G.__OnTheme(function()
			local Text = themeColor("Text", Color3.new(1, 1, 1))
			local Placeholder = themeColor("Placeholder", Color3.fromRGB(150, 150, 160))

			for i, v32 in ipairs(tbl9) do
				v32.frame.BackgroundColor3 = Color3.new(1, 1, 1)

				if i > 1 then
					v32.edge.Color = ColorSequence.new(palette.cardLine)
				end
			end

			for _, v32 in ipairs(tbl12) do
				if v32:IsA("TextLabel") then
					v32.TextColor3 = Color3.new(1, 1, 1)
				else
					v32.BackgroundColor3 = Text
					v32.BackgroundTransparency = 0.9
				end
			end

			for _, v32 in ipairs(tbl11) do
				v32.frame.BackgroundColor3 = Text
				v32.frame.BackgroundTransparency = 0.93
				v32.text.TextColor3 = Text
			end

			v16.TextColor3 = Text
			v17.TextColor3 = Placeholder
		end)

		frame.Parent = scrollingFrame
	end

	local v12 = tbl6.Box(tbl5.Home, "Quick Actions", "zap")

	tbl6.Action(v12, {
		Title = "Shoot Murderer",
		Icon = "crosshair",
		Run = function()
			local shootMurdererStatus = _G.ShootMurdererStatus
			return _G.ShootMurderer(), shootMurdererStatus
		end,
	})

	tbl6.Action(v12, {
		Title = "Fling Murderer",
		Icon = "skull",
		Run = function()
			return _G.RoleFlingTarget({ "Murderer" })
		end,
	})

	tbl6.Action(v12, {
		Title = "Kill All",
		Icon = "sword",
		Run = function()
			return _G.KillAllMurderer()
		end,
	})

	tbl6.Action(v12, {
		Title = "Hop Server",
		Icon = "shuffle",
		Run = function()
			return _G.HopServer()
		end,
	})

	local now = os.clock()

	local function fn18()
		local playerData = CurrentRoundClient.PlayerData
		local v13 = playerData and playerData[localPlayer.Name]
		if not _G.__RealInRound or not v13 or not v13.Role or v13.Role == "Lobby" then
			return "Lobby"
		end
		local str = "-"
		local str2 = "-"

		for k, v14 in pairs(playerData) do
			if type(v14) == "table" and not v14.Dead then
				if v14.Role == "Murderer" then
					str = k
				elseif v14.Role == "Sheriff" or v14.Role == "Hero" then
					str2 = k
				end
			end
		end

		local role = v13.Role

		if role == "Innocent" and _G.__IsHeroNow and _G.__IsHeroNow(localPlayer) then
			role = "Hero"
		end

		return v13.Dead and "Dead" or role, str, str2
	end

	local function fn19(arg)
		if _G.AnonymousMode and arg == localPlayer.Name then
			return "You"
		end
		return #arg > 13 and arg:sub(1, 12) .. "…" or arg
	end

	local homeLoopId = {}
	_G.__HomeLoopId = homeLoopId

	task.spawn(function()
		while _G.__HomeLoopId == homeLoopId do
			if tbl8.pill then
				pcall(function()
					local v13, v14, v15 = fn18()
					local lobby = tbl7[v13] or tbl7.Lobby
					tbl8.pill.BackgroundColor3 = lobby
					tbl8.ring.Color = lobby
					tbl8.glow.BackgroundColor3 = lobby
					tbl8.cardEdge.Color = ColorSequence.new(lobby, _G.StarUI.Palette.cardLine)
					tbl8.pillText.Text = string.upper(v13)
					local visible = v13 ~= "Lobby"
					tbl8.murdererText.Text = visible and fn19(v14) or "Waiting for a round"
					tbl8.murdererIcon.Image = visible and tbl8.swordImage or tbl8.waitImage
					tbl8.murdererIcon.ImageColor3 = visible and Color3.fromRGB(255, 80, 90) or Color3.fromRGB(150, 150, 160)
					tbl8.sheriffChip.Visible = visible
					tbl8.sheriffText.Text = visible and fn19(v15) or ""
					tbl8.bagChip.Visible = visible
					tbl8.bagText.Text = _G.BagFull and "Bag full" or "Bag filling"
				end)

				pcall(function()
					local v13, v14, v15 = _G.__FarmAccountStats()
					tbl8.coins.Text = fn15(v13)
					tbl8.gems.Text = fn15(v14)
					tbl8.level.Text = tostring(v15 or "-")
				end)

				pcall(function()
					local ok, result, result2, result3 = pcall(_G.FarmGetRates)
					tbl8.rate.Text = (result3 or 0) >= 2 and fn15(result2) or "-"
					tbl8.collected.Text = fn15(_G.FarmCoinsCollected or 0)
					tbl8.farm.Text = _G.AutoFarmEnabled and "ON" or "OFF"
					tbl8.uptime.Text = fn16(os.clock() - now)
					tbl8.farm.TextColor3 = _G.AutoFarmEnabled and Color3.fromRGB(120, 235, 165) or themeColor("Placeholder", Color3.fromRGB(150, 150, 160))
				end)
			end

			task.wait(1)
		end
	end)
end

_G.__BuildHome()

do
	local v12 = tbl6.Box(tbl5.Farm, "Coin Farm", "coins")

	local v13 = tbl6.Toggle(v12, {
		Title = "Auto Farm Coins",
		Flag = "AutoFarmCoins",
		Set = "AutoFarmSetEnabled",
		Notify = "bot",
	})

	_G.__SetReflectToggleOff(function()
		pcall(function()
			v13:Set(false)
		end)
	end)

	tbl6.Toggle(v12, {
		Title = "Farm Underground",
		Flag = "CollectCoinsUnderground",
		Value = true,
		Set = "CollectCoinsUndergroundSetEnabled",
		Notify = "move-down",
	})

	tbl6.Slider(v12, {
		Title = "Farm Speed",
		Flag = "FarmSpeed",
		Min = 15,
		Max = 25,
		Default = 25,
		Set = "AutoFarmSetSpeed",
	})
end

local v12 = tbl6.Box(tbl5.Farm, "When The Bag Is Full", "backpack")

tbl6.Toggle(v12, {
	Title = "Fling Murderer",
	Flag = "FlingMurdererAfterBagFull",
	Set = "FlingMurdererAfterBagFullSetEnabled",
	Notify = "skull",
})

tbl6.Toggle(v12, {
	Title = "Shoot Murderer",
	Flag = "ShootMurdererAfterBagFull",
	Set = "ShootMurdererAfterBagFullSetEnabled",
	Notify = "crosshair",
})

tbl6.Toggle(v12, {
	Title = "Kill All",
	Flag = "KillAllAfterBagFull",
	Set = "KillAllAfterBagFullSetEnabled",
	Notify = "swords",
})

tbl6.Toggle(v12, {
	Title = "Reset Character",
	Flag = "ResetAfterBagFull",
	Set = "ResetCharacterSetEnabled",
	Notify = "rotate-ccw",
})

do
	local v13 = tbl6.Box(tbl5.Farm, "Stats", "chart-line")
	local v14 = v13:Paragraph({ Title = "Coin Rate", Desc = "Waiting for the first coins..." })

	v13:Button({
		Title = "Reset Stats",
		Icon = "rotate-ccw",
		Callback = function()
			_G.FarmResetRates()

			pcall(function()
				v14:SetDesc("Waiting for the first coins...")
			end)
		end,
	})

	local farmStatsLoopId = {}
	_G.__FarmStatsLoopId = farmStatsLoopId

	task.spawn(function()
		while _G.__FarmStatsLoopId == farmStatsLoopId do
			task.wait(1)
			local ok, result, result2, result3 = pcall(_G.FarmGetRates)

			if ok then
				local str

				if (result3 or 0) < 2 then
					str = string.format("Collected: %d\nNeed a few more coins to measure the rate.", _G.FarmCoinsCollected or 0)
				else
					str = string.format([[Collected: %d
Per minute: %.1f
Per hour: %.0f
From the last %d pickups]], _G.FarmCoinsCollected or 0, result, result2, result3)
				end

				pcall(function()
					v14:SetDesc(str)
				end)
			end
		end
	end)
end

tbl6.Toggle(tbl6.Box(tbl5.Farm, "Daily Quest", "clipboard-check"), {
	Title = "Daily Quest Checker",
	Flag = "DailyQuestChecker",
	Set = "DailyQuestCheckerSetEnabled",
	Notify = "clipboard-check",
})

local v13 = tbl6.Box(tbl5.Cases, "Auto Open", "package-open")

tbl6.Toggle(v13, {
	Title = "Auto Open Cases",
	Flag = "AutoCase",
	Set = "AutoCaseSetEnabled",
	Notify = "package-open",
})

v13:Dropdown({
	Title = "Case",
	Values = _G.AutoCaseBoxList or { "MysteryBox1", "MysteryBox2", "KnifeBox3", "KnifeBox4", "GunBox3" },
	Flag = "AutoCaseBox",
	Value = "MysteryBox1",
	AllowNone = false,
	Callback = function(arg)
		_G.AutoCaseSetBox(arg)
		queueConfigSave()
	end,
})

tbl6.Slider(v13, {
	Title = "Keep Coin Reserve",
	Flag = "AutoCaseReserve",
	Min = 0,
	Max = 100000,
	Default = 0,
	Step = 500,
	Set = "AutoCaseSetReserve",
})

tbl6.Toggle(v13, {
	Title = "Only While Farming",
	Flag = "AutoCaseOnlyFarming",
	Value = true,
	Set = "AutoCaseSetOnlyWhileFarming",
})

tbl6.Toggle(v13, {
	Title = "Report To Webhook",
	Flag = "AutoCaseWebhook",
	Value = true,
	Set = "AutoCaseSetWebhookReport",
})

do
	local v14 = tbl6.Box(tbl5.Cases, "Status", "gift")
	local v15 = v14:Paragraph({ Title = "Idle", Desc = "Opened this session: 0" })

	v14:Button({
		Title = "Open One Now",
		Icon = "gift",
		Callback = function()
			local v16 = _G.AutoCaseOpenOnce()

			if _G.WindNotify then
				_G.WindNotify("Auto Case", tostring(_G.AutoCaseStatus), v16 and "gift" or "circle-x")
			end
		end,
	})

	local autoCaseUiLoopId = {}
	_G.__AutoCaseUiLoopId = autoCaseUiLoopId

	task.spawn(function()
		while _G.__AutoCaseUiLoopId == autoCaseUiLoopId do
			task.wait(1)

			pcall(function()
				v15:SetTitle(tostring(_G.AutoCaseStatus or "Idle"))
				v15:SetDesc(string.format("Opened this session: %d\nLast reward: %s", _G.AutoCaseOpened or 0, tostring(_G.AutoCaseLastReward or "-")))
			end)
		end
	end)
end

local v14 = tbl6.Box(tbl5.Webhook, "Discord", "webhook")

v14:Input({
	Title = "Webhook URL",
	Value = "",
	InputIcon = "link",
	Placeholder = "https://discord.com/api/webhooks/...",
	Flag = "FarmWebhookUrl",
	Callback = function(arg)
		_G.FarmWebhookSetUrl(arg)
		queueConfigSave()
	end,
})

tbl6.Toggle(v14, { Title = "Farm Webhook", Flag = "FarmWebhook", Set = "FarmWebhookSetEnabled", Notify = "webhook" })

tbl6.Action(v14, {
	Title = "Send Test Embed",
	Icon = "send",
	Run = function()
		return _G.FarmWebhookTest()
	end,
})

local v15 = tbl6.Box(tbl5.Webhook, "What To Send", "list-checks")

tbl6.Toggle(v15, {
	Title = "Bag Full",
	Flag = "FarmWebhookBagFull",
	Value = true,
	Set = function(arg)
		_G.FarmWebhookBagFull = arg and true or false
	end,
})

tbl6.Toggle(v15, {
	Title = "Periodic Summary",
	Flag = "FarmWebhookPeriodic",
	Value = true,
	Set = function(arg)
		_G.FarmWebhookPeriodic = arg and true or false
	end,
})

tbl6.Slider(v15, {
	Title = "Summary Interval",
	Flag = "FarmWebhookInterval",
	Min = 1,
	Max = 60,
	Default = 10,
	Set = function(farmWebhookInterval)
		_G.FarmWebhookInterval = farmWebhookInterval
	end,
})

local v16 = tbl6.Box(tbl5.Aim, "Triggerbot", "zap")
tbl6.Toggle(v16, { Title = "Triggerbot", Flag = "Triggerbot", Set = "TriggerbotSetEnabled", Notify = "zap" })

tbl6.Slider(v16, {
	Title = "Reaction Delay",
	Flag = "TriggerbotDelay",
	Min = 0,
	Max = 0.6,
	Default = 0.05,
	Step = 0.05,
	Set = "TriggerbotSetDelay",
})

local v17 = tbl6.Box(tbl5.Aim, "Aim Assist", "target")
tbl6.Toggle(v17, { Title = "Silent Aim", Flag = "SilentAim", Set = "SilentAimSetEnabled", Notify = "target" })

tbl6.Toggle(v17, {
	Title = "Aimlock",
	Flag = "ShiftLockAimbot",
	Set = "ShiftLockAimbotSetEnabled",
	Notify = "crosshair",
})

local v18 = tbl6.Box(tbl5.Aim, "Accuracy", "move")

tbl6.Toggle(v18, {
	Title = "Aim Prediction",
	Flag = "AimPrediction",
	Value = true,
	Notify = "move",
	Set = function(arg)
		_G.AimPredictionEnabled = arg and true or false
	end,
})

tbl6.Slider(v18, {
	Title = "Prediction Strength",
	Flag = "AimPredictionStrength",
	Min = 0.3,
	Max = 2.5,
	Default = 1,
	Step = 0.05,
	Set = function(aimPredictionStrength)
		_G.AimPredictionStrength = aimPredictionStrength
	end,
})

tbl6.Toggle(v18, {
	Title = "Wall Resolver",
	Flag = "AimWallResolve",
	Value = true,
	Notify = "scan-eye",
	Set = function(arg)
		_G.AimWallResolveEnabled = arg and true or false
	end,
})

local v19 = tbl6.Box(tbl5.Roles, "Sheriff", "shield")

_G.AutoGrabGunToggle = tbl6.Toggle(v19, {
	Title = "Auto Grab Dropped Gun",
	Flag = "AutoGrabGun",
	Value = true,
	Set = "AutoGrabGunSetEnabled",
	Notify = "hand",
})

tbl6.Action(v19, {
	Title = "Shoot Murderer",
	Icon = "crosshair",
	Run = function()
		local shootMurdererStatus = _G.ShootMurdererStatus
		return _G.ShootMurderer(), shootMurdererStatus
	end,
})

tbl6.Action(v19, {
	Title = "Rage Shoot",
	Icon = "zap",
	Run = function()
		local shootMurdererRageStatus = _G.ShootMurdererRageStatus
		return _G.ShootMurdererRage(), shootMurdererRageStatus
	end,
})

local v20 = tbl6.Box(tbl5.Roles, "Murderer", "sword")
tbl6.Toggle(v20, { Title = "Silent Throw", Flag = "SilentThrow", Set = "SilentThrowSetEnabled", Notify = "swords" })

tbl6.Toggle(v20, {
	Title = "Auto Throw Knife",
	Flag = "AutoThrowKnife",
	Set = "AutoThrowKnifeSetEnabled",
	Notify = "target",
})

tbl6.Action(v20, {
	Title = "Kill All",
	Icon = "sword",
	Run = function()
		return _G.KillAllMurderer()
	end,
})

local v21 = tbl6.Box(tbl5.Roles, "Knife Aura", "circle-dot")
tbl6.Toggle(v21, { Title = "Knife Aura", Flag = "KnifeAura", Set = "KnifeAuraSetEnabled", Notify = "circle-dot" })

tbl6.Slider(v21, {
	Title = "Range",
	Flag = "KnifeAuraRange",
	Min = 4,
	Max = 40,
	Default = 12,
	Set = "KnifeAuraSetRange",
})

tbl6.Toggle(v21, {
	Title = "Visible Only",
	Flag = "KnifeAuraVisibleOnly",
	Value = true,
	Set = "KnifeAuraSetVisibleOnly",
})

local v22 = tbl6.Box(tbl5.Fling, "Role Targets", "crosshair")

tbl6.Action(v22, {
	Title = "Fling Murderer",
	Icon = "skull",
	Run = function()
		return _G.RoleFlingTarget({ "Murderer" })
	end,
})

tbl6.Action(v22, {
	Title = "Fling Hero / Sheriff",
	Icon = "shield",
	Run = function()
		return _G.RoleFlingTarget({ "Hero", "Sheriff" })
	end,
})

do
	local v23 = tbl6.Box(tbl5.Fling, "Any Player", "users")
	_G.SelectedFlingPlayerName = nil

	local function fn15()
		local tbl7 = {}

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				table.insert(tbl7, player.Name)
			end
		end

		table.sort(tbl7, function(arg, arg2)
			return string.lower(arg) < string.lower(arg2)
		end)

		if #tbl7 == 0 then
			table.insert(tbl7, "No players found")
		end

		return tbl7
	end

	local v24 = fn15()

	if v24[1] ~= "No players found" then
		_G.SelectedFlingPlayerName = v24[1]
	end

	local v25 = v23:Dropdown({
		Title = "Player",
		Values = v24,
		Value = v24[1],
		Multi = false,
		AllowNone = false,
		Callback = function(arg)
			_G.SelectedFlingPlayerName = arg ~= "No players found" and arg or nil
		end,
	})

	local function fn16()
		local v26 = fn15()

		pcall(function()
			v25:Refresh(v26)
		end)

		if not _G.SelectedFlingPlayerName or not Players:FindFirstChild(_G.SelectedFlingPlayerName) then
			_G.SelectedFlingPlayerName = v26[1] ~= "No players found" and v26[1] or nil

			if _G.SelectedFlingPlayerName then
				pcall(function()
					v25:Select(_G.SelectedFlingPlayerName)
				end)
			end
		end
	end

	tbl6.Action(v23, {
		Title = "Fling Selected Player",
		Icon = "user-round-x",
		Run = function()
			return _G.FlingPlayerTarget(_G.SelectedFlingPlayerName and Players:FindFirstChild(_G.SelectedFlingPlayerName))
		end,
	})

	v23:Button({ Title = "Refresh Player List", Icon = "refresh-cw", Callback = fn16 })

	table.insert(_G.CoinESPConn, Players.PlayerAdded:Connect(function()
		task.defer(fn16)
	end))

	table.insert(_G.CoinESPConn, Players.PlayerRemoving:Connect(function()
		task.defer(fn16)
	end))
end

tbl6.Toggle(tbl6.Box(tbl5.Fling, "Protection", "shield-check"), {
	Title = "Anti Fling",
	Flag = "AntiFling",
	Value = true,
	Set = "AntiFlingSetEnabled",
	Notify = "shield-check",
})

local v23 = tbl6.Box(tbl5.ESP, "Roles", "scan-eye")

tbl6.Toggle(v23, {
	Title = "Murderer",
	Flag = "MurdererESP",
	Value = true,
	Notify = "skull",
	Set = function(arg)
		_G.RoleESPSetTypeEnabled("Murderer", arg)
	end,
})

tbl6.Toggle(v23, {
	Title = "Sheriff",
	Flag = "SheriffESP",
	Value = true,
	Notify = "shield",
	Set = function(arg)
		_G.RoleESPSetTypeEnabled("Sheriff", arg)
	end,
})

tbl6.Toggle(v23, {
	Title = "Hero",
	Flag = "HeroESP",
	Value = true,
	Notify = "star",
	Set = function(arg)
		_G.RoleESPSetTypeEnabled("Hero", arg)
	end,
})

tbl6.Toggle(v23, {
	Title = "Innocent",
	Flag = "InnocentESP",
	Value = true,
	Notify = "user",
	Set = function(arg)
		_G.RoleESPSetTypeEnabled("Innocent", arg)
	end,
})

local v24 = tbl6.Box(tbl5.ESP, "Look", "sparkles")

v24:Dropdown({
	Title = "Style",
	Values = { "Classic", "Pulse", "Neon" },
	Flag = "ESPStyle",
	Value = "Classic",
	AllowNone = false,
	Callback = function(arg)
		_G.ESPSetStyle(arg)
		queueConfigSave()
	end,
})

tbl6.Toggle(v24, { Title = "Character Fill", Flag = "ESPFill", Set = "ESPFillSetEnabled", Notify = "paint-bucket" })

tbl6.Slider(v24, {
	Title = "Fill Strength",
	Flag = "ESPFillOpacity",
	Min = 0.1,
	Max = 1,
	Default = 0.88,
	Step = 0.02,
	Set = "ESPFillSetOpacity",
})

tbl6.Toggle(v24, { Title = "Chams", Flag = "ESPChams", Value = true, Set = "ESPChamsSetEnabled", Notify = "layers" })

tbl6.Toggle(v24, {
	Title = "Outline Glow",
	Flag = "ESPGlow",
	Value = true,
	Set = "ESPGlowSetEnabled",
	Notify = "sparkles",
})

local v25 = tbl6.Box(tbl5.ESP, "Overlay", "scan")
tbl6.Toggle(v25, { Title = "Boxes", Flag = "ESPBoxes", Value = true, Set = "ESPBoxesSetEnabled", Notify = "square" })

tbl6.Toggle(v25, {
	Title = "Tracers",
	Flag = "ESPTracers",
	Set = "ESPTracersSetEnabled",
	Notify = "git-commit-horizontal",
})

tbl6.Toggle(v25, {
	Title = "Off-screen Arrows",
	Flag = "ESPArrows",
	Value = true,
	Set = "ESPArrowsSetEnabled",
	Notify = "navigation",
})

v25:Dropdown({
	Title = "Tracer Origin",
	Values = { "Bottom", "Center", "Top" },
	Flag = "ESPTracerOrigin",
	Value = "Bottom",
	AllowNone = false,
	Callback = function(arg)
		_G.ESPTracerSetOrigin(arg)
		queueConfigSave()
	end,
})

tbl6.Toggle(v25, {
	Title = "Nametags",
	Flag = "RoleNametags",
	Value = true,
	Set = "RoleNametagsSetEnabled",
	Notify = "tag",
})

tbl6.Toggle(v25, {
	Title = "Nametag Avatar",
	Flag = "ESPNametagAvatar",
	Value = true,
	Set = "ESPNametagAvatarSetEnabled",
	Notify = "circle-user",
})

tbl6.Toggle(v25, { Title = "Distance", Flag = "ESPDistance", Set = "ESPDistanceSetEnabled", Notify = "ruler" })
local v26 = tbl6.Box(tbl5.ESP, "Colors", "palette")

for _, v27 in ipairs({ "Murderer", "Sheriff", "Hero", "Innocent" }) do
	tbl6.Color(v26, {
		Title = v27,
		Flag = "ESPColor" .. v27,
		Default = _G.__RoleColors[v27],
		Set = function(arg)
			_G.ESPSetRoleColor(v27, arg)
		end,
	})
end

local v27 = tbl6.Box(tbl5.ESP, "World", "globe")

tbl6.Toggle(v27, {
	Title = "Dropped Gun",
	Flag = "SheriffGunESP",
	Value = true,
	Set = "SheriffGunESPSetEnabled",
	Notify = "badge",
})

tbl6.Toggle(v27, { Title = "Coins", Flag = "CoinESP", Set = "CoinESPSetEnabled", Notify = "gem" })
local v28 = tbl6.Box(tbl5.Effects, "Bullet Tracer", "minus")

tbl6.Toggle(v28, {
	Title = "Bullet Tracer",
	Flag = "BulletTracer",
	Value = true,
	Set = "BulletTracerSetEnabled",
	Notify = "crosshair",
})

tbl6.Toggle(v28, {
	Title = "Only My Shots",
	Flag = "BulletTracerOnlyMine",
	Value = true,
	Set = "BulletTracerSetOnlyMine",
	Notify = "user",
})

tbl6.Toggle(v28, {
	Title = "Glow",
	Flag = "BulletTracerGlow",
	Value = true,
	Set = "BulletTracerSetGlow",
	Notify = "sparkles",
})

tbl6.Slider(v28, {
	Title = "Thickness",
	Flag = "BulletTracerWidth",
	Min = 0.05,
	Max = 1.5,
	Default = 0.25,
	Step = 0.05,
	Set = "BulletTracerSetWidth",
})

tbl6.Slider(v28, {
	Title = "Duration",
	Flag = "BulletTracerDuration",
	Min = 0.2,
	Max = 4,
	Default = 0.8,
	Step = 0.1,
	Set = "BulletTracerSetDuration",
})

tbl6.Color(v28, {
	Title = "Your Shots",
	Flag = "BulletTracerSelfColor",
	Default = Color3.fromRGB(45, 155, 255),
	Set = "BulletTracerSetSelfColor",
})

tbl6.Color(v28, {
	Title = "Other Players",
	Flag = "BulletTracerOtherColor",
	Default = Color3.fromRGB(255, 70, 70),
	Set = "BulletTracerSetOtherColor",
})

local v29 = tbl6.Box(tbl5.Effects, "Kill Effects", "skull")

tbl6.Toggle(v29, {
	Title = "Death Dissolve",
	Flag = "DeathDissolve",
	Value = true,
	Set = "DeathDissolveSetEnabled",
	Notify = "sparkles",
})

tbl6.Action(v29, {
	Title = "Preview",
	Icon = "play",
	Run = function()
		return _G.DeathDissolvePreview()
	end,
})

tbl6.Toggle(v29, { Title = "Kill Cam", Flag = "KillCam", Set = "KillCamSetEnabled", Notify = "video" })

tbl6.Slider(v29, {
	Title = "Kill Cam Length",
	Flag = "KillCamDuration",
	Min = 0.6,
	Max = 3,
	Default = 1.4,
	Step = 0.1,
	Set = "KillCamSetDuration",
})

local v30 = tbl6.Box(tbl5.Effects, "Camera", "monitor")
tbl6.Toggle(v30, { Title = "Stretch Mode", Flag = "StretchMode", Set = "StretchModeSetEnabled", Notify = "monitor" })

v30:Dropdown({
	Title = "Aspect",
	Flag = "StretchAspect",
	Values = { "4:3", "5:4", "16:10", "16:9 (off)" },
	Value = "4:3",
	Callback = function(arg)
		_G.StretchModeSetAspect(({
			["4:3"] = 1.3333333333333333,
			["5:4"] = 1.25,
			["16:10"] = 1.6,
			["16:9 (off)"] = 1.7777777777777777,
		})[arg] or 1.3333333333333333)

		queueConfigSave()
	end,
})

tbl6.Toggle(v30, { Title = "Custom FOV", Flag = "CameraFOVEnabled", Set = "CameraSetFOVEnabled", Notify = "scan" })
tbl6.Slider(v30, { Title = "FOV", Flag = "CameraFOV", Min = 30, Max = 120, Default = 80, Set = "CameraSetFOV" })

tbl6.Toggle(v30, {
	Title = "Unlock Zoom",
	Flag = "CameraZoomEnabled",
	Set = "CameraSetZoomEnabled",
	Notify = "zoom-out",
})

tbl6.Slider(v30, {
	Title = "Max Zoom",
	Flag = "CameraMaxZoom",
	Min = 15,
	Max = 400,
	Default = 40,
	Set = "CameraSetMaxZoom",
})

do
	local v31 = tbl5.Emotes:Section({
		Title = "Emotes",
		Desc = "It's not client sided, everyone can see your emotes.",
		Icon = "smile",
		TextSize = 16,
		DescTextSize = 13,
		Box = true,
		BoxBorder = true,
		Opened = true,
	})

	local v32 = ipairs
	local emoteList = _G.EmoteList or {}

	for _, v33 in v32(emoteList) do
		tbl6.Action(v31, {
			Title = v33:sub(1, 1):upper() .. v33:sub(2),
			Icon = "play",
			Run = function()
				return _G.PlayEmote(v33)
			end,
		})
	end

	tbl6.Action(v31, {
		Title = "Stop",
		Icon = "square",
		Run = function()
			return _G.StopEmotes()
		end,
	})
end

local v31 = tbl6.Box(tbl5.World, "Lighting", "sun")

v31:Dropdown({
	Title = "Time",
	Values = _G.WorldTimeList,
	Flag = "WorldTime",
	Value = "Default",
	AllowNone = false,
	Callback = function(arg)
		_G.WorldSetTime(arg)
		queueConfigSave()
	end,
})

tbl6.Toggle(v31, { Title = "Fullbright", Flag = "WorldFullbright", Set = "WorldSetFullbright", Notify = "sun" })
tbl6.Toggle(v31, { Title = "No Fog", Flag = "WorldNoFog", Set = "WorldSetNoFog", Notify = "cloud-off" })

tbl6.Box(tbl5.World, "Sky", "cloud"):Dropdown({
	Title = "Sky Tint",
	Values = _G.WorldSkyList,
	Flag = "WorldSky",
	Value = "Default",
	AllowNone = false,
	Callback = function(arg)
		_G.WorldSetSky(arg)
		queueConfigSave()
	end,
})

local v32 = tbl6.Box(tbl5.World, "Color", "palette")
tbl6.Toggle(v32, { Title = "Color Grading", Flag = "WorldColor", Set = "WorldSetColor", Notify = "palette" })

tbl6.Slider(v32, {
	Title = "Saturation",
	Flag = "WorldSaturation",
	Min = -1,
	Max = 1,
	Default = 0.15,
	Step = 0.05,
	Set = "WorldSetSaturation",
})

tbl6.Slider(v32, {
	Title = "Contrast",
	Flag = "WorldContrast",
	Min = -0.5,
	Max = 1,
	Default = 0.1,
	Step = 0.05,
	Set = "WorldSetContrast",
})

tbl6.Slider(v32, {
	Title = "Brightness",
	Flag = "WorldBrightness",
	Min = -0.5,
	Max = 0.5,
	Default = 0,
	Step = 0.05,
	Set = "WorldSetBrightness",
})

tbl6.Color(v32, { Title = "Tint", Flag = "WorldTint", Default = Color3.new(1, 1, 1), Set = "WorldSetTint" })
local v33 = tbl6.Box(tbl5.World, "Bloom", "sparkles")
tbl6.Toggle(v33, { Title = "Bloom", Flag = "WorldBloom", Set = "WorldSetBloom", Notify = "sparkles" })

tbl6.Slider(v33, {
	Title = "Intensity",
	Flag = "WorldBloomIntensity",
	Min = 0.2,
	Max = 3,
	Default = 1.2,
	Step = 0.1,
	Set = "WorldSetBloomIntensity",
})

local v34 = tbl6.Box(tbl5.Movement, "Movement", "footprints")

tbl6.Slider(v34, {
	Title = "Walk Speed",
	Flag = "WalkSpeed",
	Min = 16,
	Max = 80,
	Default = 16,
	Set = "PlayerWalkSpeedSet",
})

tbl6.Slider(v34, {
	Title = "Jump Power",
	Flag = "JumpPower",
	Min = 50,
	Max = 200,
	Default = 50,
	Set = "PlayerJumpPowerSet",
})

tbl6.Toggle(v34, { Title = "Noclip", Flag = "Noclip", Set = "NoclipSetEnabled", Notify = "ghost" })
local v35 = tbl6.Box(tbl5.Movement, "Fly", "plane")
tbl6.Toggle(v35, { Title = "Fly", Flag = "Fly", Set = "PlayerFlySetEnabled", Notify = "plane" })

tbl6.Slider(v35, {
	Title = "Fly Speed",
	Flag = "FlySpeed",
	Min = 10,
	Max = 200,
	Default = 50,
	Step = 5,
	Set = "PlayerFlySpeedSet",
})

local v36 = tbl6.Box(tbl5.Movement, "Jumping", "chevrons-up")

tbl6.Toggle(v36, {
	Title = "Infinite Jump",
	Flag = "InfiniteJump",
	Set = "InfiniteJumpSetEnabled",
	Notify = "chevrons-up",
})

tbl6.Toggle(v36, { Title = "Wall Jump", Flag = "WallJump", Set = "WallJumpSetEnabled", Notify = "move-up" })
local v37 = tbl6.Box(tbl5.Movement, "Bomb Boost", "bomb")

tbl6.Action(v37, {
	Title = "Bomb Boost",
	Icon = "bomb",
	Run = function()
		return _G.BombBoost()
	end,
})

tbl6.Slider(v37, {
	Title = "Boost Power",
	Flag = "BombBoostPower",
	Min = 40,
	Max = 300,
	Default = 120,
	Step = 5,
	Set = "BombBoostSetPower",
})

_G.__BuildPlayersTab = function()
	local players = tbl5.Players
	local scrollingFrame = players and players.ContainerFrame and players.ContainerFrame:FindFirstChild("ScrollingFrame")
	if not scrollingFrame then
		return
	end

	tbl6.Toggle(tbl6.Box(players, "Alerts", "triangle-alert"), {
		Title = "Round Start Alert",
		Flag = "RoundStartAlert",
		Value = true,
		Set = function(roundStartAlertEnabled)
			_G.RoundStartAlertEnabled = roundStartAlertEnabled
		end,
	})

	_G.RoundStartAlertEnabled = true
	local palette = _G.StarUI.Palette
	local icon = _G.StarUI.Icon

	local tbl7 = {
		Murderer = Color3.fromRGB(235, 50, 60),
		Sheriff = Color3.fromRGB(45, 120, 255),
		Hero = Color3.fromRGB(240, 190, 30),
		Innocent = Color3.fromRGB(40, 190, 90),
		Dead = Color3.fromRGB(90, 90, 98),
		Lobby = Color3.fromRGB(90, 90, 98),
	}

	local tbl8 = { Murderer = 1, Sheriff = 2, Hero = 2, Innocent = 3, Lobby = 4, Dead = 5 }

	local function fn15(arg)
		local playerData = CurrentRoundClient.PlayerData
		playerData = playerData and playerData[arg.Name]
		if not _G.__RealInRound or type(playerData) ~= "table" or not playerData.Role or playerData.Role == "Lobby" then
			return "Lobby"
		end

		if playerData.Dead then
			return "Dead"
		end

		if playerData.Role == "Innocent" and _G.__IsHeroNow and _G.__IsHeroNow(arg) then
			return "Hero"
		end
		return playerData.Role
	end

	local function fn16(arg)
		local character = arg.Character
		return character and character:FindFirstChild("HumanoidRootPart")
	end

	local function fn17(arg, arg2, parent)
		local instance = Instance.new(arg)

		for k, v38 in pairs(arg2) do
			instance[k] = v38
		end

		if instance:IsA("GuiObject") then
			instance.BorderSizePixel = 0
		end

		instance.Parent = parent
		return instance
	end

	local function fn18(arg, arg2)
		fn17("UICorner", { CornerRadius = UDim.new(0, arg2) }, arg)
	end

	local function fn19(arg, arg2)
		return (fn17("TextLabel", {
			BackgroundTransparency = 1,
			AutoLocalize = false,
			TextXAlignment = Enum.TextXAlignment.Left,
			FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", arg2.Weight or Enum.FontWeight.Medium),
			TextSize = arg2.Size or 14,
			TextColor3 = arg2.Color or palette.text,
			Text = arg2.Text or "",
			TextTruncate = Enum.TextTruncate.AtEnd,
			Position = arg2.Position or UDim2.new(),
			Size = arg2.Box or UDim2.fromScale(1, 1),
		}, arg))
	end

	local v38 = nil

	local function fn20()
		v38 = nil
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")

		if character then
			workspace.CurrentCamera.CameraSubject = character
		end
	end

	local function fn21(arg)
		if v38 == arg then
			fn20()
			return false, "Stopped spectating"
		end
		local character = arg.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not character then
			return false, "No character"
		end
		v38 = arg
		workspace.CurrentCamera.CameraSubject = character
		return true, "Spectating " .. arg.DisplayName
	end

	local function fn22(arg)
		local v39 = fn16(localPlayer)
		local v40 = fn16(arg)
		if not (v39 and v40) then
			return false, "No character"
		end
		v39.CFrame = v40.CFrame * CFrame.new(0, 0, 3)
		return true, "Teleported to " .. arg.DisplayName
	end

	local frame = Instance.new("Frame")
	frame.Name = "StarPlayers"
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 0, 0)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	fn17("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, frame)

	local v39 = fn19(frame, {
		Text = "",
		Size = 12,
		Weight = Enum.FontWeight.Bold,
		Color = palette.dim,
		Box = UDim2.new(1, 0, 0, 16),
	})

	v39.LayoutOrder = -1
	local tbl9 = {}

	local function fn23(arg, arg2, arg3, arg4)
		local TextButton = fn17("TextButton", {
			Text = "",
			AutoButtonColor = false,
			BackgroundColor3 = palette.field,
			Size = UDim2.fromOffset(32, 32),
			LayoutOrder = arg3,
		}, arg)

		fn18(TextButton, 16)
		local UIStroke = fn17("UIStroke", { Color = palette.cardLine, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, TextButton)

		local ImageLabel = fn17("ImageLabel", {
			BackgroundTransparency = 1,
			Image = icon(arg2),
			ImageColor3 = palette.sub,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(15, 15),
		}, TextButton)

		TextButton.MouseEnter:Connect(function()
			TweenService:Create(TextButton, TweenInfo.new(0.15), { BackgroundColor3 = Color3.new(1, 1, 1) }):Play()
			local tbl10 = { ImageColor3 = palette.ink }
			TweenService:Create(ImageLabel, TweenInfo.new(0.15), tbl10):Play()
		end)

		TextButton.MouseLeave:Connect(function()
			local tbl10 = { BackgroundColor3 = palette.field }
			TweenService:Create(TextButton, TweenInfo.new(0.15), tbl10):Play()
			local tbl11 = { ImageColor3 = palette.sub }
			TweenService:Create(ImageLabel, TweenInfo.new(0.15), tbl11):Play()
		end)

		TextButton.Activated:Connect(arg4)
		return TextButton, ImageLabel, UIStroke
	end

	local function fn24(arg, arg2, arg3, arg4)
		if _G.WindNotify then
			_G.WindNotify(arg, tostring(arg3 or ""), arg2 and arg4 or "circle-x")
		end
	end

	local function fn25(arg)
		local Frame = fn17("Frame", { BackgroundColor3 = palette.card, Size = UDim2.new(1, 0, 0, 60) }, frame)
		fn18(Frame, 12)
		fn17("UIStroke", { Color = palette.cardLine, ApplyStrokeMode = Enum.ApplyStrokeMode.Border }, Frame)

		local ImageLabel = fn17("ImageLabel", {
			BackgroundColor3 = palette.field,
			Position = UDim2.fromOffset(12, 10),
			Size = UDim2.fromOffset(40, 40),
			Image = "rbxthumb://type=AvatarHeadShot&id=" .. arg.UserId .. "&w=150&h=150",
		}, Frame)

		fn18(ImageLabel, 20)
		local UIStroke = fn17("UIStroke", { Thickness = 2, Color = tbl7.Lobby }, ImageLabel)

		fn19(Frame, {
			Text = arg.DisplayName,
			Size = 15,
			Weight = Enum.FontWeight.SemiBold,
			Position = UDim2.fromOffset(62, 11),
			Box = UDim2.new(1, -230, 0, 18),
		})

		local v40 = fn19(Frame, {
			Text = "@" .. arg.Name,
			Size = 12,
			Color = palette.sub,
			Position = UDim2.fromOffset(62, 30),
			Box = UDim2.new(1, -230, 0, 15),
		})

		local Frame2 = fn17("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -128, 0.5, -9),
			Size = UDim2.fromOffset(0, 18),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundColor3 = tbl7.Lobby,
		}, Frame)

		fn18(Frame2, 9)
		fn17("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, Frame2)

		local v41 = fn19(Frame2, {
			Text = "LOBBY",
			Size = 10,
			Weight = Enum.FontWeight.Heavy,
			Color = Color3.new(1, 1, 1),
			Box = UDim2.fromOffset(0, 18),
		})

		v41.AutomaticSize = Enum.AutomaticSize.X

		local v42 = fn19(Frame, {
			Text = "",
			Size = 12,
			Weight = Enum.FontWeight.SemiBold,
			Color = palette.sub,
			Position = UDim2.new(1, -128, 0.5, 2),
			Box = UDim2.fromOffset(0, 16),
		})

		v42.AnchorPoint = Vector2.new(1, 0)
		v42.TextXAlignment = Enum.TextXAlignment.Right
		v42.AutomaticSize = Enum.AutomaticSize.X

		local Frame3 = fn17("Frame", {
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, 0),
			Size = UDim2.fromOffset(108, 32),
		}, Frame)

		fn17("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}, Frame3)

		local v43, v44 = fn23(Frame3, "eye", 1, function()
			local v43, v44 = fn21(arg)
			fn24("Spectate", v43 or v44 == "Stopped spectating", v44, "eye")
		end)

		fn23(Frame3, "navigation", 2, function()
			local v45, v46 = fn22(arg)
			fn24("Teleport", v45, v46, "navigation")
		end)

		fn23(Frame3, "wind", 3, function()
			local v45, v46 = _G.FlingPlayerTarget(arg)
			fn24("Fling", v45, v46, "wind")
		end)

		tbl9[arg] = {
			card = Frame,
			ring = UIStroke,
			pill = Frame2,
			roleText = v41,
			distance = v42,
			specButton = v43,
			specIcon = v44,
			handle = v40,
		}
	end

	local function fn26()
		local v40 = fn16(localPlayer)
		local tbl10 = {}

		for k, v41 in pairs(tbl9) do
			local v42 = fn15(k)
			local lobby = tbl7[v42] or tbl7.Lobby
			v41.pill.BackgroundColor3 = lobby
			v41.ring.Color = lobby
			v41.roleText.Text = string.upper(v42)
			local v43 = fn16(k)
			local n2 = v40 and v43 and math.floor((v43.Position - v40.Position).Magnitude + 0.5) or nil
			v41.distance.Text = n2 and n2 .. " m" or "-"
			local flag2 = v38 == k
			v41.specButton.BackgroundColor3 = flag2 and Color3.new(1, 1, 1) or palette.field
			v41.specIcon.ImageColor3 = flag2 and palette.ink or palette.sub
			tbl10[#tbl10 + 1] = { player = k, rank = tbl8[v42] or 4, studs = n2 or 1000000 }
		end

		table.sort(tbl10, function(arg, arg2)
			if arg.rank ~= arg2.rank then
				return arg.rank < arg2.rank
			end
			return arg.studs < arg2.studs
		end)

		for i, v41 in ipairs(tbl10) do
			tbl9[v41.player].card.LayoutOrder = i
		end

		v39.Text = string.format("%d PLAYERS IN THIS SERVER", #tbl10)
	end

	local function fn27()
		for k, v40 in pairs(tbl9) do
			if not k.Parent then
				v40.card:Destroy()
				tbl9[k] = nil
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and not tbl9[player] then
				fn25(player)
			end
		end

		if v38 and not v38.Parent then
			fn20()
		end

		fn26()
	end

	fn27()
	frame.Parent = scrollingFrame

	table.insert(_G.CoinESPConn, Players.PlayerAdded:Connect(function()
		task.defer(fn27)
	end))

	table.insert(_G.CoinESPConn, Players.PlayerRemoving:Connect(function()
		task.defer(fn27)
	end))

	local playersLoopId = {}
	_G.__PlayersLoopId = playersLoopId

	task.spawn(function()
		while _G.__PlayersLoopId == playersLoopId do
			if players.Page and players.Page.Visible and _G.WindUIWindow and _G.WindUIWindow.Opened then
				pcall(fn26)
			end

			if v38 then
				local character = v38.Character
				character = character and character:FindFirstChildOfClass("Humanoid")

				if not v38.Parent or not character or character.Health <= 0 then
					fn20()
				end
			end

			task.wait(1)
		end
	end)

	table.insert(_G.CoinESPConn, gameplay.RoundStart.OnClientEvent:Connect(function()
		if not _G.RoundStartAlertEnabled then
			return
		end

		task.spawn(function()
			local v40 = nil
			local v41

			for i = 1, 25 do
				local playerData = CurrentRoundClient.PlayerData

				if type(playerData) == "table" then
					for k, v42 in pairs(playerData) do
						if type(v42) == "table" then
							if v42.Role == "Murderer" then
								v41 = k
							end

							if v42.Role == "Sheriff" then
								v40 = k
							end
						end
					end
				end

				if not (v41 and v40) then
					task.wait(0.2)
					continue
				end
				break
			end

			local v42 = fn15(localPlayer)

			local function fn28(arg)
				if not arg then
					return "?"
				end

				if arg == localPlayer.Name then
					return "You"
				end
				local v43 = Players:FindFirstChild(arg)
				return v43 and v43.DisplayName or arg
			end

			if _G.WindNotify then
				pcall(function()
					_G.WindUI:Notify({
						Title = "Round started  ·  you are " .. v42,
						Content = "Murderer: " .. fn28(v41) .. "\nSheriff: " .. fn28(v40),
						Icon = v42 == "Murderer" and "skull" or v42 == "Sheriff" and "shield" or "swords",
						Duration = 6,
					})
				end)
			end
		end)
	end))
end

_G.__BuildPlayersTab()

do
	local themeColor = _G.__ThemeColor

	local function fn15(arg, arg2)
		local v38, v39 = _G.SkinChanger.ListSkins(arg2)
		if not v38 or #v38 == 0 then
			arg:Paragraph({ Title = "Skins unavailable", Desc = tostring(v39 or "No " .. arg2 .. " skins in the list.") })
			return
		end
		local scrollingFrame = arg.ContainerFrame and arg.ContainerFrame:FindFirstChild("ScrollingFrame")

		if not scrollingFrame then
			arg:Paragraph({
				Title = "Skins unavailable",
				Desc = "This WindUI build does not expose a tab canvas to draw into.",
			})

			return
		end

		local v40 = _G.SkinChanger.LoadData()
		local rarityColor = _G.SkinChanger.RarityColor
		local frame = Instance.new("Frame")
		frame.Name = "MM2SkinGrid"
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 0, 0)
		frame.AutomaticSize = Enum.AutomaticSize.Y
		local uiListLayout = Instance.new("UIListLayout")
		uiListLayout.FillDirection = Enum.FillDirection.Vertical
		uiListLayout.Padding = UDim.new(0, 8)
		uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiListLayout.Parent = frame
		local textBox = Instance.new("TextBox")
		textBox.Name = "Search"
		textBox.LayoutOrder = 1
		textBox.Size = UDim2.new(1, 0, 0, 34)
		textBox.BorderSizePixel = 0
		textBox.ClearTextOnFocus = false
		textBox.Text = ""
		textBox.PlaceholderText = "Search " .. #v38 .. " " .. arg2:lower() .. " skins..."
		textBox.TextSize = 14
		textBox.Font = Enum.Font.GothamMedium
		textBox.TextXAlignment = Enum.TextXAlignment.Left
		textBox.Parent = frame
		local uiPadding = Instance.new("UIPadding")
		uiPadding.PaddingLeft = UDim.new(0, 12)
		uiPadding.Parent = textBox
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = textBox
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Thickness = 1
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = textBox
		local textLabel = Instance.new("TextLabel")
		textLabel.Name = "Status"
		textLabel.LayoutOrder = 2
		textLabel.Size = UDim2.new(1, 0, 0, 16)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "Tap a skin to equip it."
		textLabel.TextSize = 13
		textLabel.Font = Enum.Font.Gotham
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.Parent = frame
		local frame2 = Instance.new("Frame")
		frame2.Name = "Grid"
		frame2.LayoutOrder = 3
		frame2.BackgroundTransparency = 1
		frame2.Size = UDim2.new(1, 0, 0, 0)
		frame2.AutomaticSize = Enum.AutomaticSize.Y
		frame2.Parent = frame
		local uiGridLayout = Instance.new("UIGridLayout")
		uiGridLayout.CellSize = UDim2.fromOffset(72, 72)
		uiGridLayout.CellPadding = UDim2.fromOffset(8, 8)
		uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		uiGridLayout.Parent = frame2
		local v41 = nil
		local tbl7 = {}

		for i, v42 in ipairs(v38) do
			local meta = v40 and v40[v42.Key]
			meta = meta and meta.Meta
			local color = rarityColor[v42.Rarity] or Color3.fromRGB(200, 200, 200)
			local name = v42.Chroma and "Chroma " .. v42.Name or v42.Name
			local imageButton = Instance.new("ImageButton")
			imageButton.Name = v42.Key
			imageButton.LayoutOrder = i
			imageButton.BorderSizePixel = 0
			imageButton.AutoButtonColor = true
			imageButton.Image = meta and meta.Image or ""
			imageButton.ScaleType = Enum.ScaleType.Fit
			imageButton.Parent = frame2
			local uiCorner2 = Instance.new("UICorner")
			uiCorner2.CornerRadius = UDim.new(0, 10)
			uiCorner2.Parent = imageButton
			local uiStroke2 = Instance.new("UIStroke")
			uiStroke2.Color = color
			uiStroke2.Thickness = 1
			uiStroke2.Transparency = 0.35
			uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke2.Parent = imageButton
			local textLabel2 = Instance.new("TextLabel")
			textLabel2.Name = "Caption"
			textLabel2.AnchorPoint = Vector2.new(0.5, 1)
			textLabel2.Position = UDim2.new(0.5, 0, 1, -3)
			textLabel2.Size = UDim2.new(1, -6, 0, 22)
			textLabel2.BackgroundTransparency = 1
			textLabel2.Text = v42.Name
			textLabel2.TextColor3 = Color3.fromRGB(245, 245, 245)
			textLabel2.TextStrokeTransparency = 1
			textLabel2.TextSize = 10
			textLabel2.Font = Enum.Font.GothamMedium
			textLabel2.TextWrapped = true
			textLabel2.TextYAlignment = Enum.TextYAlignment.Bottom
			textLabel2.Parent = imageButton

			if v42.Chroma then
				local frame3 = Instance.new("Frame")
				frame3.Name = "ChromaTag"
				frame3.AnchorPoint = Vector2.new(0.5, 1)
				frame3.Position = UDim2.new(0.5, 0, 1, -16)
				frame3.Size = UDim2.fromOffset(0, 12)
				frame3.AutomaticSize = Enum.AutomaticSize.X
				frame3.BackgroundColor3 = Color3.fromRGB(0, 213, 255)
				frame3.BorderSizePixel = 0
				frame3.ZIndex = 3
				frame3.Parent = imageButton
				Instance.new("UICorner", frame3).CornerRadius = UDim.new(1, 0)
				local uiStroke3 = Instance.new("UIStroke")
				uiStroke3.Color = Color3.fromRGB(10, 10, 16)
				uiStroke3.Thickness = 1
				uiStroke3.Transparency = 0.25
				uiStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				uiStroke3.Parent = frame3
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Name = "BG"
				imageLabel.Size = UDim2.fromScale(1, 1)
				imageLabel.BackgroundTransparency = 1
				imageLabel.Image = "rbxassetid://2576540162"
				imageLabel.ScaleType = Enum.ScaleType.Stretch
				imageLabel.ZIndex = 3
				imageLabel.Parent = frame3
				Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(1, 0)
				local textLabel3 = Instance.new("TextLabel")
				textLabel3.Name = "TagName"
				textLabel3.AutomaticSize = Enum.AutomaticSize.X
				textLabel3.Size = UDim2.fromOffset(0, 12)
				textLabel3.BackgroundTransparency = 1
				textLabel3.Text = "Chroma"
				textLabel3.TextColor3 = Color3.new(1, 1, 1)
				textLabel3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
				textLabel3.TextSize = 9
				textLabel3.TextStrokeColor3 = Color3.fromRGB(20, 10, 40)
				textLabel3.TextStrokeTransparency = 0.2
				textLabel3.ZIndex = 4
				textLabel3.Parent = frame3
				local uiPadding2 = Instance.new("UIPadding")
				uiPadding2.PaddingLeft = UDim.new(0, 6)
				uiPadding2.PaddingRight = UDim.new(0, 6)
				uiPadding2.Parent = textLabel3
			end

			imageButton.MouseEnter:Connect(function()
				textLabel.Text = name .. "  ·  " .. (v42.Chroma and "Chroma" or v42.Rarity)
			end)

			imageButton.MouseButton1Click:Connect(function()
				_G.SkinChanger.Select(arg2, v42.Key)
				local v43, v44 = _G.SkinChanger.Apply(arg2)

				if v41 and v41 ~= uiStroke2 then
					v41.Thickness = 1
					v41.Transparency = 0.35
				end

				v41 = uiStroke2
				uiStroke2.Thickness = 2.5
				uiStroke2.Transparency = 0
				textLabel.Text = name .. "  ·  " .. tostring(v44)

				if _G.WindNotify then
					_G.WindNotify("Skin Changer", name .. ": " .. tostring(v44), v43 and "circle-check" or "circle-x")
				end
			end)

			local n2 = #tbl7 + 1
			local rarity = v42.Rarity
			tbl7[n2] = { Tile = imageButton, Search = name:lower() .. " " .. rarity:lower() }
		end

		_G.__OnTheme(function()
			local ElementBackground = themeColor("ElementBackground", Color3.fromRGB(28, 28, 32))
			textBox.BackgroundColor3 = ElementBackground
			textBox.BackgroundTransparency = 0
			textBox.TextColor3 = themeColor("Text", Color3.fromRGB(235, 235, 235))
			textBox.PlaceholderColor3 = themeColor("Placeholder", Color3.fromRGB(130, 130, 130))
			uiStroke.Color = themeColor("Primary", Color3.fromRGB(255, 178, 63))
			uiStroke.Transparency = 0.7
			textLabel.TextColor3 = themeColor("Placeholder", Color3.fromRGB(160, 160, 160))

			for _, v42 in ipairs(tbl7) do
				v42.Tile.BackgroundColor3 = themeColor("Tile", ElementBackground)
				v42.Tile.BackgroundTransparency = 0
			end
		end)

		textBox:GetPropertyChangedSignal("Text"):Connect(function()
			local str = textBox.Text:lower():gsub("^%s+", ""):gsub("%s+$", "")
			local n2 = 0

			for _, v42 in ipairs(tbl7) do
				local visible = str == "" or v42.Search:find(str, 1, true) ~= nil
				v42.Tile.Visible = visible

				if visible then
					n2 += 1
				end
			end

			textLabel.Text = str == "" and "Tap a skin to equip it." or n2 .. " of " .. #tbl7 .. " match \"" .. str .. "\""
		end)

		frame.Parent = scrollingFrame
	end

	fn15(tbl5.GunSkins, "Gun")
	fn15(tbl5.KnifeSkins, "Knife")
end

_G.BuildCrosshairPicker = function()
	local tbl7 = {
		{ Name = "Little Crosshair", Id = "1827745864" },
		{ Name = "Clean Crosshair", Id = "4048495272" },
		{ Name = "Little Crosshair 2", Id = "1827745860" },
		{ Name = "Glow Circle", Id = "10891594364" },
		{ Name = "Kitten", Id = "5998624788" },
		{ Name = "Soft Crosshair", Id = "5689419560" },
		{ Name = "Thin Crosshair", Id = "2207556774" },
		{ Name = "Gun Cursor", Id = "426730675" },
		{ Name = "43 Cross", Id = "2128690040" },
		{ Name = "Counter Blox", Id = "2827093428" },
		{ Name = "Crosshair 9524", Id = "9524023226" },
		{ Name = "Counter Blox 2", Id = "3750055370" },
		{ Name = "Dot", Id = "2943445535" },
		{ Name = "Heart", Id = "11754490336" },
		{ Name = "Cyan", Id = "358650771" },
		{ Name = "Crosshairs", Id = "6398507494" },
		{ Name = "Green Dot", Id = "240080506" },
		{ Name = "White Crosshair", Id = "749187669" },
		{ Name = "Pink", Id = "358650766" },
		{ Name = "Crosshair Dot", Id = "1389344386" },
		{ Name = "Crosshair Kitten 2", Id = "5998624778" },
		{ Name = "Gh0stly", Id = "2169048245" },
		{ Name = "Pastel Kitty", Id = "11351620355" },
		{ Name = "Pink Star", Id = "11719595129" },
		{ Name = "Rainbow Dot", Id = "4000131509" },
		{ Name = "Red Crosshair", Id = "6480864794" },
		{ Name = "Crosshair Zoom", Id = "9720078113" },
		{ Name = "ZombieCon", Id = "129875025" },
		{ Name = "Exclusive Crosshair", Id = "2159978195" },
		{ Name = "Red Dot Aim", Id = "240080272" },
		{ Name = "Alt Crosshair", Id = "4941755400" },
		{ Name = "Test Crosshair", Id = "1469004289" },
		{ Name = "Soft Dot", Id = "3521125035" },
		{ Name = "Crosshair Set", Id = "1489774665" },
		{ Name = "Symbol Crosshair", Id = "569870649" },
		{ Name = "Crosshair 7019", Id = "7019318577" },
		{ Name = "Red Crosshair 2", Id = "6480864782" },
		{ Name = "Crsshair", Id = "2614612882" },
		{ Name = "Crosshair 9472", Id = "9472683590" },
		{ Name = "Depressed Crosshair", Id = "11390723044" },
		{ Name = "Heart Crosshair", Id = "11722368344" },
		{ Name = "Glow Circle 2", Id = "10891594349" },
		{ Name = "Crosshair 1086", Id = "10868459554" },
		{ Name = "43 Cross 2", Id = "2128690043" },
		{ Name = "Crosshair Symbol", Id = "6079707648" },
		{ Name = "Pastel Kitty 2", Id = "11351620343" },
		{ Name = "Heart Crosshair 2", Id = "11754490323" },
		{ Name = "Small Crosshair 2.0", Id = "2526607594" },
		{ Name = "Crosshair 7905", Id = "7905983439" },
		{ Name = "Relly 2", Id = "11722088774" },
		{ Name = "White Crosshair 2", Id = "749187664" },
		{ Name = "Crosshair >.<", Id = "10831379335" },
		{ Name = "Small Crosshair 2.0 B", Id = "2526607598" },
		{ Name = "H Cursor", Id = "5144114880" },
		{ Name = "T-Mobile", Id = "11960132111" },
		{ Name = "Cursor Hello Kitty", Id = "11716290197" },
		{ Name = "Cursor 3", Id = "11716557686" },
		{ Name = "Crosshair Block", Id = "7242005920" },
		{ Name = "K6uro Dot", Id = "11716452437" },
		{ Name = "Y2K Cross", Id = "11767037107" },
		{ Name = "White Crosshair 3", Id = "6480864064" },
		{ Name = "Cursor 2", Id = "11716159644" },
		{ Name = "Crosshair Heart", Id = "10878218322" },
		{ Name = "Crosshair 1086 B", Id = "10868459539" },
		{ Name = "Gengar", Id = "11759293347" },
		{ Name = "Short Crosshair", Id = "2526593748" },
		{ Name = "Heart Cursor", Id = "11722081515" },
		{ Name = "Blaster", Id = "7810818531" },
		{ Name = "Pixel Heart", Id = "13034143275" },
		{ Name = "Triangle", Id = "10164277641" },
		{ Name = "Rip Lol", Id = "2167171797" },
		{ Name = "Main", Id = "11150110589" },
		{ Name = "Nice Crosshair", Id = "6647211778" },
		{ Name = "Pika Crosshair", Id = "11754499452" },
		{ Name = "Pompom Crosshair", Id = "11747026268" },
		{ Name = "ZombKitty Crosshair", Id = "11767337318" },
		{ Name = "XBOX Crosshair", Id = "11759202791" },
		{ Name = "Cutie Mark Star", Id = "158554297" },
		{ Name = "Crosshair A", Id = "11716453554" },
		{ Name = "Aim", Id = "7051824015" },
		{ Name = "SuperColor", Id = "11716455808" },
		{ Name = "Kuromi", Id = "7173989509" },
		{ Name = "Pink Crosshair", Id = "11716485793" },
		{ Name = "Hello Kitty Heart", Id = "7397723594" },
		{ Name = "Unknown Crosshair", Id = "11716687704" },
		{ Name = "Crosshair B", Id = "11717093063" },
		{ Name = "Crosshair C", Id = "11717104785" },
		{ Name = "Hello Kitty Bow", Id = "11717287400" },
		{ Name = "Hello Kitty Christmas", Id = "11717288272" },
		{ Name = "Hello Kitty Cursor", Id = "11717813996" },
		{ Name = "HKC", Id = "11717828297" },
		{ Name = "Big Aim 2", Id = "2555584348" },
		{ Name = "Turtle", Id = "7590894535" },
		{ Name = "Hello Kitty Cursor 2", Id = "11718192673" },
		{ Name = "Kuromi Maid", Id = "7660329894" },
		{ Name = "Hello Kitty Cursor 3", Id = "11719412806" },
		{ Name = "Osu Cursor", Id = "7820635056" },
		{ Name = "Cutie Mark Blue Star", Id = "170174107" },
		{ Name = "Cat Cursor", Id = "11722553511" },
		{ Name = "Kuromi 1", Id = "11723083138" },
		{ Name = "Sasuke Curse Mark", Id = "11723817205" },
		{ Name = "Santa Dust Sans", Id = "8890685159" },
		{ Name = "Bright Blue Crosshair", Id = "11724945237" },
		{ Name = "Unknown Crosshair 28", Id = "11726821301" },
		{ Name = "Cursor 1", Id = "11733622734" },
		{ Name = "Cursor 2", Id = "11733801922" },
		{ Name = "Cursor 3", Id = "11734552820" },
		{ Name = "Power Star", Id = "1718840561" },
		{ Name = "Santa Sam", Id = "4788466659" },
		{ Name = "19", Id = "11734623772" },
		{ Name = "21", Id = "11734712236" },
		{ Name = "22", Id = "11734738174" },
		{ Name = "Hello Kitty PNG", Id = "9509978501" },
	}

	local themeColor = _G.__ThemeColor
	local v38 = tbl6.Box(_G.CrosshairTab, "Crosshair", "locate-fixed")

	tbl6.Toggle(v38, {
		Title = "Enable Crosshair",
		Flag = "CrosshairEnabled",
		Set = "CrosshairSetEnabled",
		Notify = "crosshair",
	})

	tbl6.Slider(v38, {
		Title = "Size",
		Flag = "CrosshairSize",
		Min = 24,
		Max = 160,
		Default = 64,
		Step = 2,
		Set = "CrosshairSetSize",
	})

	tbl6.Toggle(v38, { Title = "Spin", Flag = "CrosshairSpinEnabled", Set = "CrosshairSetSpin" })

	tbl6.Slider(v38, {
		Title = "Spin Speed",
		Flag = "CrosshairSpinSpeed",
		Min = 0,
		Max = 720,
		Default = 180,
		Step = 10,
		Set = "CrosshairSetSpinSpeed",
	})

	tbl6.Toggle(v38, {
		Title = "Hide Shift Lock Crosshair",
		Flag = "HideShiftLockCrosshair",
		Set = "ShiftLockCrosshairSetEnabled",
		Notify = "eye-off",
	})

	local scrollingFrame = _G.CrosshairTab.ContainerFrame and _G.CrosshairTab.ContainerFrame:FindFirstChild("ScrollingFrame")

	if not scrollingFrame then
		_G.CrosshairTab:Paragraph({
			Title = "Crosshair picker unavailable",
			Desc = "This WindUI build does not expose a tab canvas.",
		})

		return
	end

	local frame = Instance.new("Frame")
	frame.Name = "CrosshairPicker"
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 0, 0)
	frame.AutomaticSize = Enum.AutomaticSize.Y
	frame.LayoutOrder = 100000
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Vertical
	uiListLayout.Padding = UDim.new(0, 8)
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Parent = frame
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = "Selected"
	textLabel.LayoutOrder = 1
	textLabel.Size = UDim2.new(1, 0, 0, 18)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "Choose a crosshair below."
	textLabel.TextSize = 13
	textLabel.Font = Enum.Font.Gotham
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.Parent = frame
	local frame2 = Instance.new("Frame")
	frame2.Name = "Grid"
	frame2.LayoutOrder = 2
	frame2.BackgroundTransparency = 1
	frame2.Size = UDim2.new(1, 0, 0, 0)
	frame2.AutomaticSize = Enum.AutomaticSize.Y
	frame2.Parent = frame
	local uiGridLayout = Instance.new("UIGridLayout")
	uiGridLayout.CellSize = UDim2.fromOffset(84, 84)
	uiGridLayout.CellPadding = UDim2.fromOffset(8, 8)
	uiGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiGridLayout.Parent = frame2
	local tbl8 = {}
	local v39 = nil

	local function fn15(arg)
		arg.Color = themeColor("Placeholder", Color3.fromRGB(110, 115, 130))
		arg.Thickness = 1
		arg.Transparency = 0.55
	end

	local function fn16(arg)
		arg.Color = themeColor("Primary", Color3.fromRGB(255, 178, 63))
		arg.Thickness = 2
		arg.Transparency = 0
	end

	for i, v40 in ipairs(tbl7) do
		local imageButton = Instance.new("ImageButton")
		imageButton.Name = v40.Name:gsub("%W", "")
		imageButton.LayoutOrder = i
		imageButton.Size = UDim2.fromOffset(84, 84)
		imageButton.BorderSizePixel = 0
		imageButton.AutoButtonColor = false
		imageButton.Image = ""
		imageButton.ScaleType = Enum.ScaleType.Fit
		imageButton.ClipsDescendants = true
		imageButton.Parent = frame2
		local imageLabel = Instance.new("ImageLabel")
		imageLabel.Name = "Preview"
		imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		imageLabel.Position = UDim2.new(0.5, 0, 0.43, 0)
		imageLabel.Size = UDim2.new(1, -8, 1, -24)
		imageLabel.BackgroundTransparency = 1
		imageLabel.BorderSizePixel = 0
		imageLabel.ScaleType = Enum.ScaleType.Fit
		imageLabel.Image = "rbxthumb://type=Asset&id=" .. v40.Id .. "&w=150&h=150"
		imageLabel.ZIndex = 3
		imageLabel.Parent = imageButton
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 10)
		uiCorner.Parent = imageButton
		local uiStroke = Instance.new("UIStroke")
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = imageButton
		local frame3 = Instance.new("Frame")
		frame3.AnchorPoint = Vector2.new(0.5, 1)
		frame3.Position = UDim2.new(0.5, 0, 1, 0)
		frame3.Size = UDim2.new(1, 0, 0, 24)
		frame3.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		frame3.BackgroundTransparency = 0.45
		frame3.BorderSizePixel = 0
		frame3.ZIndex = 4
		frame3.Parent = imageButton
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.BackgroundTransparency = 1
		textLabel2.Size = UDim2.new(1, -6, 1, 0)
		textLabel2.Position = UDim2.fromOffset(3, 0)
		textLabel2.Text = v40.Name
		textLabel2.TextColor3 = Color3.fromRGB(240, 240, 245)
		textLabel2.TextSize = 10
		textLabel2.Font = Enum.Font.GothamMedium
		textLabel2.TextWrapped = true
		textLabel2.TextYAlignment = Enum.TextYAlignment.Center
		textLabel2.ZIndex = 5
		textLabel2.Parent = frame3

		imageButton.MouseEnter:Connect(function()
			if uiStroke ~= v39 then
				uiStroke.Transparency = 0
			end
		end)

		imageButton.MouseLeave:Connect(function()
			if uiStroke ~= v39 then
				uiStroke.Transparency = 0.55
			end
		end)

		imageButton.MouseButton1Click:Connect(function()
			_G.CrosshairSetDecal(v40.Id)

			if v39 and v39 ~= uiStroke then
				fn15(v39)
			end

			v39 = uiStroke
			fn16(uiStroke)
			textLabel.Text = "Selected: " .. v40.Name
			queueConfigSave()
		end)

		local id = v40.Id

		if tostring(_G.CrosshairDecalId) == id then
			v39 = uiStroke
			textLabel.Text = "Selected: " .. v40.Name
		end

		tbl8[#tbl8 + 1] = { Card = imageButton, Stroke = uiStroke }
	end

	_G.__OnTheme(function()
		local ElementBackground = themeColor("ElementBackground", Color3.fromRGB(28, 28, 34))
		textLabel.TextColor3 = themeColor("Placeholder", Color3.fromRGB(170, 170, 170))

		for _, v40 in ipairs(tbl8) do
			v40.Card.BackgroundColor3 = themeColor("Tile", ElementBackground)
			v40.Card.BackgroundTransparency = 0

			if v40.Stroke == v39 then
				fn16(v40.Stroke)
			else
				fn15(v40.Stroke)
			end
		end
	end)

	frame.Parent = scrollingFrame
end

_G.BuildCrosshairPicker()
tbl5.Home:Select()

do
	local function fn15()
		if _G.StopRoleFling then
			_G.StopRoleFling()
		end

		if _G.AutoFarmSetEnabled then
			_G.AutoFarmSetEnabled(false)
		end

		if _G.AutoThrowKnifeSetEnabled then
			_G.AutoThrowKnifeSetEnabled(false)
		end

		_G.__KillAllLoopId = nil
		_G.KillAllBusy = false

		if _G.ThrowAimbotButtonSetEnabled then
			_G.ThrowAimbotButtonSetEnabled(false)
		end

		if _G.AutoGrabGunSetEnabled then
			_G.AutoGrabGunSetEnabled(false)
		end

		if _G.KillAllButtonSetEnabled then
			_G.KillAllButtonSetEnabled(false)
		end

		if _G.QuickRageShootButtonSetEnabled then
			_G.QuickRageShootButtonSetEnabled(false)
		end

		if _G.AntiFlingSetEnabled then
			_G.AntiFlingSetEnabled(false)
		end

		if _G.ShiftLockCrosshairSetEnabled then
			_G.ShiftLockCrosshairSetEnabled(false)
		end

		if _G.PlayerFlySetEnabled then
			_G.PlayerFlySetEnabled(false)
		end

		if _G.FpsBoostSetEnabled then
			_G.FpsBoostSetEnabled(false)
		end

		_G.__FarmWebhookLoopId = nil

		if _G.AutoCaseSetEnabled then
			_G.AutoCaseSetEnabled(false)
		end

		_G.__AutoCaseLoopId = nil
		_G.__AutoCaseUiLoopId = nil
		_G.__HomeLoopId = nil
		_G.__FarmStatsLoopId = nil

		if _G.CoinESPConn then
			for _, v38 in ipairs(_G.CoinESPConn) do
				pcall(function()
					v38:Disconnect()
				end)
			end
		end

		_G.__CoinRescanLoopId = nil
		_G.__RoleRescanLoopId = nil
		_G.__RoleRefreshBurstId = nil
		_G.__BagPollLoopId = nil
		_G.__DailyQuestLoopId = nil
		_G.__QuickShootLoopId = nil
		_G.__AutoThrowKnifeLoopId = nil
		_G.__AutoGrabGunLoopId = nil

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegQuickShotCameraLock")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegShiftLockAim")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegTriggerFOVRing")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegTriggerMarker")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegCrosshair")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegHideShiftLockCursor")
		end)

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegESPOverlay")
		end)

		if _G.ESPOverlayGui then
			pcall(function()
				_G.ESPOverlayGui:Destroy()
			end)
		end

		if _G.__KillFxConns then
			for _, killFxConn in ipairs(_G.__KillFxConns) do
				pcall(function()
					killFxConn:Disconnect()
				end)
			end
		end

		if _G.KillFxGui then
			pcall(function()
				_G.KillFxGui:Destroy()
			end)
		end

		if _G.WorldVisualsReset then
			pcall(_G.WorldVisualsReset)
		end

		if _G.CameraSettingsReset then
			pcall(_G.CameraSettingsReset)
		end

		_G.KnifeAuraEnabled = false

		pcall(function()
			RunService:UnbindFromRenderStep("MarbegCameraFOV")
		end)

		if _G.AutoFarmCharConn then
			pcall(function()
				_G.AutoFarmCharConn:Disconnect()
			end)
		end

		if _G.CoinESPFolder then
			pcall(function()
				_G.CoinESPFolder:Destroy()
			end)
		end

		if _G.RoleESPFolder then
			pcall(function()
				_G.RoleESPFolder:Destroy()
			end)
		end

		if _G.DailyQuestCheckerGui then
			pcall(function()
				_G.DailyQuestCheckerGui:Destroy()
			end)
		end

		if _G.TriggerMarkerGui then
			pcall(function()
				_G.TriggerMarkerGui:Destroy()
			end)
		end

		if _G.QuickShootGui then
			pcall(function()
				_G.QuickShootGui:Destroy()
			end)
		end

		if _G.QuickRageShootGui then
			pcall(function()
				_G.QuickRageShootGui:Destroy()
			end)
		end

		if _G.ThrowAimbotGui then
			pcall(function()
				_G.ThrowAimbotGui:Destroy()
			end)
		end

		if _G.KillAllGui then
			pcall(function()
				_G.KillAllGui:Destroy()
			end)
		end

		pcall(function()
			v5:Destroy()
		end)

		_G.WindUIWindow = nil
	end

	local HttpService = game:GetService("HttpService")
	local TeleportService = game:GetService("TeleportService")
	local flag2 = false
	_G.__RecentServers = _G.__RecentServers or {}

	_G.HopServer = function()
		if flag2 then
			return false, "Already hopping"
		end
		flag2 = true

		local ok, result, result2 = pcall(function()
			local str = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
			local v38 = fn(str)
			if not v38 then
				return nil, "Could not reach the server list"
			end
			local data = HttpService:JSONDecode(v38)
			if type(data) ~= "table" or type(data.data) ~= "table" then
				return nil, "Unexpected server list"
			end
			local huge = math.huge
			local id = nil

			for _, v39 in ipairs(data.data) do
				if type(v39.id) == "string" and v39.id ~= game.JobId and not _G.__RecentServers[v39.id] and type(v39.playing) == "number" and type(v39.maxPlayers) == "number" and v39.playing < v39.maxPlayers and v39.playing < huge then
					id = v39.id
					huge = v39.playing
				end
			end

			if not id then
				return nil, "No other server available"
			end
			return id, ("Joining a server with %d players"):format(huge)
		end)

		if not ok or not result then
			flag2 = false
			result2 = type(result2) == "string" and result2

			if result2 then
				result = result2
			else
				result = type(result) == "string" and result
			end

			return false, result or "Server hop failed"
		end

		local v38 = result
		_G.__RecentServers[v38] = true

		task.delay(120, function()
			_G.__RecentServers[v38] = nil
		end)

		local ok2 = pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, v38, localPlayer)
		end)

		task.delay(5, function()
			flag2 = false
		end)

		return ok2, ok2 and "Teleporting..." or "Teleport was refused"
	end

	local v38 = tbl6.Box(tbl5.Buttons, "Layout", "layout-grid")
	_G.LockButtonsToggle = tbl6.Toggle(v38, { Title = "Lock Buttons", Flag = "LockButtons", Set = "LockButtonsSetEnabled", Notify = "lock" })

	v38:Slider({
		Title = "Button Size",
		Step = 1,
		Flag = "ActionButtonSize",
		Value = { Min = 48, Max = 120, Default = _G.ActionButtonSize or 72 },
		Callback = function(arg)
			if _G.__SetActionButtonSize then
				_G.__SetActionButtonSize(arg)
			end

			if _G.__SaveActionButtonLayout then
				_G.__SaveActionButtonLayout()
			end

			queueConfigSave()
		end,
	})

	tbl6.Color(v38, {
		Title = "Text Color",
		Flag = "ActionButtonTextColor",
		Default = Color3.fromRGB(255, 255, 255),
		Set = "SetActionButtonTextColor",
	})

	v38:Button({
		Title = "Reset Size",
		Icon = "maximize-2",
		Callback = function()
			if _G.__SetActionButtonSize then
				_G.__SetActionButtonSize(72)
			end

			if _G.__SaveActionButtonLayout then
				_G.__SaveActionButtonLayout()
			end

			queueConfigSave()
		end,
	})

	tbl6.Action(v38, {
		Title = "Reset Positions",
		Icon = "refresh-ccw",
		Run = function()
			local resetActionButtonPositions = _G.__ResetActionButtonPositions and _G.__ResetActionButtonPositions()
			return resetActionButtonPositions, resetActionButtonPositions and "Positions reset." or "Could not reset positions."
		end,
	})

	local v39 = tbl6.Box(tbl5.Buttons, "Sheriff", "shield")

	tbl6.Toggle(v39, {
		Title = "Shoot Murderer",
		Flag = "ShootLegitButton",
		Set = "QuickShootButtonSetEnabled",
		Notify = "crosshair",
	})

	tbl6.Toggle(v39, {
		Title = "Rage Shoot",
		Flag = "ShootRageButton",
		Set = "QuickRageShootButtonSetEnabled",
		Notify = "zap",
	})

	local v40 = tbl6.Box(tbl5.Buttons, "Murderer", "sword")

	tbl6.Toggle(v40, {
		Title = "Throw Knife",
		Flag = "ThrowAimbotButton",
		Set = "ThrowAimbotButtonSetEnabled",
		Notify = "mouse-pointer-click",
	})

	tbl6.Toggle(v40, {
		Title = "Kill All",
		Flag = "KillAllButton",
		Set = "KillAllButtonSetEnabled",
		Notify = "skull",
	})

	local v41 = tbl6.Box(tbl5.Buttons, "Fling", "wind")

	tbl6.Toggle(v41, {
		Title = "Fling Murderer",
		Flag = "FlingMurdererButton",
		Set = "FlingMurdererButtonSetEnabled",
		Notify = "skull",
	})

	tbl6.Toggle(v41, {
		Title = "Fling Hero / Sheriff",
		Flag = "FlingSheriffButton",
		Set = "FlingSheriffButtonSetEnabled",
		Notify = "shield",
	})

	local v42 = tbl6.Box(tbl5.Buttons, "Player", "user")

	tbl6.Toggle(v42, {
		Title = "Bomb Boost",
		Flag = "BombBoostButton",
		Set = "BombBoostButtonSetEnabled",
		Notify = "bomb",
	})

	tbl6.Toggle(v42, { Title = "Noclip", Flag = "NoclipButton", Set = "NoclipButtonSetEnabled", Notify = "ghost" })
	tbl6.Toggle(v42, { Title = "Fly", Flag = "FlyButton", Set = "FlyButtonSetEnabled", Notify = "plane" })

	tbl6.Toggle(v42, {
		Title = "Infinite Jump",
		Flag = "InfJumpButton",
		Set = "InfJumpButtonSetEnabled",
		Notify = "chevrons-up",
	})

	tbl6.Toggle(v42, {
		Title = "Wall Jump",
		Flag = "WallJumpButton",
		Set = "WallJumpButtonSetEnabled",
		Notify = "move-up",
	})

	if tbl5.Keybinds then
		tbl6.Toggle(tbl6.Box(tbl5.Keybinds, "Keybinds", "keyboard"), {
			Title = "Enable Keybinds",
			Flag = "KeybindsEnabled",
			Value = true,
			Set = function(keybindsEnabled)
				_G.KeybindsEnabled = keybindsEnabled
			end,
			Notify = "keyboard",
		})

		_G.KeybindsEnabled = true
		local v43 = tbl6.Box(tbl5.Keybinds, "Actions", "zap")
		_G.Keybinds = _G.Keybinds or {}

		local tbl7 = {
			id = "RageShoot",
			title = "Rage Shoot",
			icon = "zap",
			default = Enum.KeyCode.R,
			run = function()
				local shootMurdererRageStatus = _G.ShootMurdererRageStatus
				return _G.ShootMurdererRage(), shootMurdererRageStatus
			end,
		}

		local tbl8 = {
			id = "ThrowKnife",
			title = "Throw Knife",
			icon = "sword",
			default = Enum.KeyCode.Q,
			run = function()
				return _G.ThrowAimbotOnce()
			end,
		}

		local tbl9 = {
			id = "KillAll",
			title = "Kill All",
			icon = "sword",
			default = Enum.KeyCode.T,
			run = function()
				return _G.KillAllMurderer()
			end,
		}

		local tbl10 = {
			id = "BombBoost",
			title = "Bomb Boost",
			icon = "bomb",
			default = Enum.KeyCode.B,
			run = function()
				return _G.BombBoost()
			end,
		}

		local tbl11 = {
			id = "FlingMurderer",
			title = "Fling Murderer",
			icon = "skull",
			default = Enum.KeyCode.F,
			run = function()
				return _G.RoleFlingTarget({ "Murderer" })
			end,
		}

		local tbl12 = {
			id = "ToggleFarm",
			title = "Auto Farm",
			icon = "bot",
			default = Enum.KeyCode.G,
			run = function()
				_G.AutoFarmSetEnabled(not _G.AutoFarmEnabled)
				return _G.AutoFarmEnabled, _G.AutoFarmEnabled and "Enabled" or "Disabled"
			end,
		}

		local tbl13 = {
			id = "ToggleTriggerbot",
			title = "Triggerbot",
			icon = "zap",
			default = Enum.KeyCode.C,
			run = function()
				_G.TriggerbotSetEnabled(not _G.TriggerbotEnabled)
				return _G.TriggerbotEnabled, _G.TriggerbotEnabled and "Enabled" or "Disabled"
			end,
		}

		local tbl14 = {
			{
				id = "ShootMurderer",
				title = "Shoot Murderer",
				icon = "crosshair",
				default = Enum.KeyCode.E,
				run = function()
					local shootMurdererStatus = _G.ShootMurdererStatus
					return _G.ShootMurderer(), shootMurdererStatus
				end,
			},
			tbl7,
			tbl8,
			tbl9,
			tbl10,
			tbl11,
			tbl12,
			tbl13,
		}

		local tbl15 = {}

		local function fn16()
			tbl15 = {}

			for _, v44 in ipairs(tbl14) do
				local v45 = _G.Keybinds[v44.id]

				if v45 then
					tbl15[v45] = v44
				end
			end
		end

		for _, v44 in ipairs(tbl14) do
			_G.Keybinds[v44.id] = _G.Keybinds[v44.id] or v44.default

			v43:Keybind({
				Title = v44.title,
				Value = v44.default.Name,
				Flag = "Key" .. v44.id,
				Callback = function(arg)
					local flag3 = typeof(arg) == "EnumItem" and arg or Enum.KeyCode[tostring(arg)]

					if flag3 then
						_G.Keybinds[v44.id] = flag3
						fn16()
						queueConfigSave()
					end
				end,
			})
		end

		fn16()

		table.insert(_G.CoinESPConn, UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end

			if _G.KeybindsEnabled == false then
				return
			end
			local v44 = tbl15[input.KeyCode]
			if not v44 then
				return
			end

			task.spawn(function()
				local ok, result, result2 = pcall(v44.run)
				if not ok then
					return
				end
				local str = tostring(result2 or result and "Done" or "Failed")

				if _G.WindNotify then
					_G.WindNotify(v44.title, str, result and (v44.icon or "circle-check") or "circle-x")
				end
			end)
		end))
	end

	_G.MenuToggleKey = _G.MenuToggleKey or Enum.KeyCode.RightShift

	if UserInputService.KeyboardEnabled then
		tbl6.Box(tbl5.General, "Menu", "panel-top"):Keybind({
			Title = "Open / Close Menu",
			Value = "RightShift",
			Flag = "KeyToggleMenu",
			Callback = function(arg)
				local menuToggleKey = typeof(arg) == "EnumItem" and arg or Enum.KeyCode[tostring(arg)]

				if menuToggleKey then
					_G.MenuToggleKey = menuToggleKey
					queueConfigSave()
				end
			end,
		})
	end

	local v43 = tbl6.Box(tbl5.General, "Performance", "gauge")
	tbl6.Toggle(v43, { Title = "FPS Boost", Flag = "FpsBoost", Set = "FpsBoostSetEnabled", Notify = "gauge" })

	tbl6.Slider(v43, {
		Title = "FPS Cap",
		Flag = "FpsCap",
		Min = 0,
		Max = 360,
		Default = 0,
		Step = 10,
		Set = "FpsBoostSetCap",
	})

	local v44 = tbl6.Box(tbl5.General, "Server", "server")

	tbl6.Toggle(v44, {
		Title = "Anti-AFK",
		Flag = "AntiAfk",
		Value = true,
		Set = "AntiAfkSetEnabled",
		Notify = "coffee",
	})

	tbl6.Action(v44, {
		Title = "Hop Server",
		Icon = "shuffle",
		Run = function()
			return _G.HopServer()
		end,
	})

	tbl6.Toggle(tbl6.Box(tbl5.General, "Privacy", "shield"), {
		Title = "Anonymous Mode",
		Flag = "AnonymousMode",
		Set = "AnonymousSetEnabled",
		Notify = "user-x",
	})

	local v45 = tbl6.Box(tbl5.General, "Config", "save")

	tbl6.Switch(v45:Toggle({
		Title = "Auto Save",
		Flag = "AutoSaveConfig",
		Value = true,
		Callback = function(arg)
			_G.AutoConfigEnabled = arg and true or false

			if _G.ConfigReady and not _G.ConfigLoading then
				saveScriptConfig(false)
			end

			fn13("Auto Save Config", arg, "save")
		end,
	}))

	v45:Button({
		Title = "Save Now",
		Icon = "save",
		Callback = function()
			saveScriptConfig(true)
		end,
	})

	v45:Button({
		Title = "Load Saved",
		Icon = "folder-open",
		Callback = function()
			loadScriptConfig(true)
		end,
	})

	local v46 = tbl6.Box(tbl5.General, "Panel", "panel-top")

	v46:Button({
		Title = "Hide Panel",
		Icon = "eye-off",
		Callback = function()
			pcall(function()
				v5:Close()
			end)
		end,
	})

	v46:Button({
		Title = "Unload Script",
		Icon = "power",
		Color = Color3.fromRGB(235, 70, 70),
		Callback = function()
			v5:Dialog({
				Icon = "triangle-alert",
				Title = "Unload Script",
				Content = "Close the panel and stop all enabled features?",
				Buttons = {
					{ Title = "Unload", Variant = "Primary", Callback = fn15 },
					{ Title = "Cancel", Variant = "Tertiary" },
				},
			}):Show()
		end,
	})
end

_G.CoinESPSetEnabled(false)
_G.DailyQuestCheckerSetEnabled(false)
_G.QuickShootButtonSetEnabled(false)
_G.QuickRageShootButtonSetEnabled(false)
_G.AutoThrowKnifeSetEnabled(false)
_G.ThrowAimbotButtonSetEnabled(false)
_G.AutoGrabGunSetEnabled(true)
_G.ShiftLockCrosshairSetEnabled(false)
_G.KillAllButtonSetEnabled(false)
_G.AntiFlingSetEnabled(true)
_G.LockButtonsSetEnabled(false)
_G.PlayerWalkSpeedSet(16)
_G.PlayerJumpPowerSet(50)
_G.PlayerFlySpeedSet(50)
_G.PlayerFlySetEnabled(false)
_G.RoleESPSetEnabled(true)
_G.ESPGlowSetEnabled(true)
_G.RoleNametagsSetEnabled(true)
_G.SheriffGunESPSetEnabled(true)
_G.RoleESPSetTypeEnabled("Murderer", true)
_G.RoleESPSetTypeEnabled("Sheriff", true)
_G.RoleESPSetTypeEnabled("Innocent", true)
_G.RoleESPSetTypeEnabled("Hero", true)
loadScriptConfig(false)

pcall(function()
	_G.ShiftLockCrosshairSetEnabled(_G.HideShiftLockCrosshair)
end)

pcall(function()
	_G.CrosshairSetSize(_G.CrosshairSize or 64)
end)

pcall(function()
	_G.__SetActionButtonSize(_G.ActionButtonSize or 72)
end)

pcall(function()
	_G.LockButtonsToggle:Set(false)
end)

pcall(function()
	_G.AutoGrabGunToggle:Set(true)
end)

_G.LockButtonsSetEnabled(false)
_G.AutoGrabGunSetEnabled(true)
_G.ConfigReady = true

do
	local function fn15(arg)
		pcall(function()
			arg.AutoLocalize = false
		end)

		for _, descendant in ipairs(arg:GetDescendants()) do
			pcall(function()
				descendant.AutoLocalize = false
			end)
		end
	end

	local hui = gethui()

	for _, child in ipairs(hui:GetChildren()) do
		fn15(child)
	end

	local connection2 = hui.DescendantAdded:Connect(function(descendant)
		task.defer(function()
			pcall(function()
				descendant.AutoLocalize = false
			end)
		end)
	end)

	table.insert(_G.CoinESPConn, connection2)
end

pcall(_G.__ApplyActionButtonIcons)
pcall(_G.SetActionButtonTextColor, _G.ActionButtonTextColor)
print(_G.ScriptVersion .. " fully loaded (ESP defaults ON, safe MoveTo-based farm)")
