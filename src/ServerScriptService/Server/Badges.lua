local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Rep = game.ReplicatedStorage
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local Data = require(script.Parent.Data)
local Items = require(Modules.Items)
local Badgess = require(Modules.Badges).Badges
local GetStatsModule = require(SSS.Functions.GetRealStats)

local BoostsHandler = {} do
	Remotes.ClaimBadge.OnServerEvent:Connect(function(Player, Badge)
		local PData = Data:Get(Player)
		local PBadge = PData.Badges[Badge]
		local MBadge = Badgess[Badge]
		
		if PBadge.Tier <= 5 then
			if PBadge.Amount >= MBadge[PBadge.Tier].Needs then
				PData.Inventory[MBadge[PBadge.Tier].Reward[1]] += MBadge[PBadge.Tier].Reward[2]
				GetStatsModule.GetRealStats(Player, PData)
				PBadge.Tier += 1
				Remotes.DataUpdated:FireClient(Player, {"Badges", PData.Badges})
				Remotes.DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
			end
		end
	end)
end

return BoostsHandler