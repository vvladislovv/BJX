local DSS = game:GetService("DataStoreService")
local DND = DSS:GetDataStore("DailyNameDatastore")
local DN
if(DND:GetAsync("daily") == nil or DND:GetAsync("daily") == "") then
	DND:SetAsync("daily", 1)
	DN = 1
else
	DN = DND:GetAsync("daily")
end
print(DN)
script.Parent.Parent.Parent.Last.Value = DN
local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Data = require(SSS.Server.Data)
local CurrencyName = "Daily Honey"
local Leaderboard = script.Parent.Parent.Parent
local LeaderStore = DSS:GetOrderedDataStore(CurrencyName.."LeaderboardStore"..tostring(DN))

local Holder = script.Parent:WaitForChild("Holder")
local Template = script:WaitForChild("Template")

local Utils = require(game.ReplicatedStorage:WaitForChild("Modules").Utils)
local function ClearBoard()
	for _, T in pairs(Holder:GetChildren()) do
		if not T:IsA("UIListLayout") then
			T:Destroy()
		end
	end
end
local blacklist = {}
function UpdateBoard()
	local Pages = LeaderStore:GetSortedAsync(false, 100)
	local TopTen = Pages:GetCurrentPage()
	ClearBoard()
	wait()
	for Key, Value in pairs(TopTen) do
		local PlayerName = Players:GetNameFromUserIdAsync(Value.key)
		if blacklist[PlayerName] then
			LeaderStore:SetAsync(Value.key,0)
		end
		if Value.value >= 0 then
			local NewPlayer = Template:Clone()
			NewPlayer.Parent = Holder
			if Key == 1 then
				NewPlayer.BackgroundColor3 = Color3.fromRGB(47, 228, 255)
			elseif Key == 2 then
				NewPlayer.BackgroundColor3 = Color3.fromRGB(255, 195, 41)
			elseif Key == 3 then
				NewPlayer.BackgroundColor3 = Color3.fromRGB(212, 212, 212)
			else
				local r = math.random(1,2)
				if r == 1 then 
					NewPlayer.BackgroundColor3 = Color3.fromRGB(84, 65, 53)
					NewPlayer.Player.UIStroke.Enabled = true
					NewPlayer.Coins.UIStroke.Enabled = true
					NewPlayer.Rank.UIStroke.Enabled = true
					NewPlayer.Player.TextColor3 = Color3.new(255,255,255)
					NewPlayer.Coins.TextColor3 = Color3.new(255,255,255)
					NewPlayer.Rank.TextColor3 = Color3.new(255,255,255)
				else
					NewPlayer.BackgroundColor3 = Color3.fromRGB(109, 84, 69)
					NewPlayer.Player.UIStroke.Enabled = true
					NewPlayer.Coins.UIStroke.Enabled = true
					NewPlayer.Rank.UIStroke.Enabled = true
					NewPlayer.Player.TextColor3 = Color3.new(255,255,255)
					NewPlayer.Coins.TextColor3 = Color3.new(255,255,255)
					NewPlayer.Rank.TextColor3 = Color3.new(255,255,255)
					--NewPlayer.Drop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				end
			end
			NewPlayer.Player.Text = PlayerName
			NewPlayer.Rank.Text = Key..":"
			NewPlayer.Coins.Text = Utils:CommaNumber(Value.value)
		end
	end
end

spawn(function()
	while true do
		for _, Player in pairs(Players:GetPlayers()) do
			local PData = Data:Get(Player)
			local Currency = PData.Daily.Honey
			if not blacklist[Player.Name] then
				LeaderStore:SetAsync(Player.UserId, math.floor(Currency))
			else
				LeaderStore:SetAsync(Player.UserId,0)
			end
		end
		wait(60)
	end
end)

local function UpdateDN()
	DN = DND:GetAsync("daily")
	LeaderStore = DSS:GetOrderedDataStore(CurrencyName.."LeaderboardStore"..tostring(DN))
	script.Parent.Parent.Parent.Last.Value = DN
end

local function ResetLeaderboard()
	ClearBoard()
	UpdateDN()
	
	local Players = game:GetService("Players")
	local allPlayers = Players:GetPlayers()
	
	for _, player in pairs(allPlayers) do
		local success, errorMessage = pcall(function()
			local PData = require(game.ServerScriptService.Server.Data):Get(player)
			PData.Daily.Honey = 0
		end)
	end
end

local function isTimeToReset()
	local currentTime = os.time(os.date("!*t"))
	local midnightTime = os.time({year=os.date("%Y", currentTime), month=os.date("%m", currentTime), day=os.date("%d", currentTime), hour=0, min=0, sec=0}) + 86400
	
	if currentTime >= midnightTime and currentTime < midnightTime + 86400 then
		return true
	else
		return false
	end
end

spawn(function()
	while true do
		if isTimeToReset() then
			DND:SetAsync("daily", DN + 1)
			ResetLeaderboard()
			print("Лидерборд ресетнут")
		else
			UpdateBoard()
		end
		wait(60)
	end
end)

spawn(function()
	while true do
		local label = script.Parent.Parent.Parent.Timer.SurfaceGui.Timer.TextLabel
		local currentTime = os.time()
		local midnightTime = os.time({year=os.date("%Y", currentTime), month=os.date("%m", currentTime), day=os.date("%d", currentTime), hour=0, min=0, sec=0}) + 86400
		local timeUntilMidnight = midnightTime - currentTime

		local hours = math.floor(timeUntilMidnight / 3600)
		local minutes = math.floor((timeUntilMidnight - (hours * 3600)) / 60)
		local seconds = timeUntilMidnight - (hours * 3600) - (minutes * 60)

		local msg = string.format("Resets in: %02dh %02dm %02ds", hours, minutes, seconds)
		label.Text = msg
		wait(1)
	end
end)