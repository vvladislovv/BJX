local FlowerRegister = require(game:GetService("ServerScriptService"):WaitForChild("Server").FlowerRegister)
local Remotes = game.ReplicatedStorage.Remotes
local Tools = require(game.ReplicatedStorage:WaitForChild("Modules").Equipment.Collectors).Collectors
local Data = require(game:GetService("ServerScriptService"):WaitForChild("Server").Data)
local Cooldowns = {}
script.Collect.OnServerEvent:Connect(function(Player, RootPart)
	local PData = Data:Get(Player)
	if PData.IStats.Pollen >= PData.IStats.Capacity then
		Remotes.AlertClient:FireClient(Player, {
			Color = "Red",
			Msg = "The backpack is full"
		})
	end
	local Character = RootPart.Parent
	local moduletool = Tools[PData.Equipment.Tool]
	if PData.IStats.Pollen < PData.IStats.Capacity and not Cooldowns[Player.Name] then
		Cooldowns[Player.Name] = true
		FlowerRegister:CollectPatches(Player, {
			RootPart = RootPart,
			Stamp = moduletool.Stamp,
			StatsModule = moduletool.StatsModule,
		})
		wait(moduletool.Cooldown - 0.2)
		Cooldowns[Player.Name] = false
	end
end)