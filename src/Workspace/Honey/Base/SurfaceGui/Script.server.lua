local DSS = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Data = require(SSS.Server.Data)
local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local CurrencyName = "Total Honey"
local Leaderboard = script.Parent.Parent.Parent
local LeaderStore = DSS:GetOrderedDataStore(CurrencyName.."LeaderboardStore48")

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
local blacklist = {
}
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
		if Value.value > 0 then
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
			local Currency = PData.Badges.Honey.Amount
			if not blacklist[Player.Name] then
				LeaderStore:SetAsync(Player.UserId, math.floor(Currency))
			else
				LeaderStore:SetAsync(Player.UserId,0)
			end
		end
		wait(60)
	end
end)


local SIN = math.cos
local PI = math.pi

while true do
	UpdateBoard()
	wait(60)
end
