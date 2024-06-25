local Items = require(game.ReplicatedStorage.Modules.Equipment.Bags).Bags
local Data = require(game.ServerScriptService.Server.Data)

local BoostsHandler = {} do
	function BoostsHandler.GetCapacity(Player)
		local PData = Data:Get(Player)
		
		PData.IStats.Capacity = math.round(Items[PData.Equipment.Bag].Capacity * (PData.AllStats["Capacity"] / 100))
		
		--if PData.Equipment.LeftGuard ~= "" then
		--	PData.IStats.Capacity += Items[PData.Equipment.LeftGuard].Capacity * (PData.AllStats["Capacity"] / 100)
		--end
		--if PData.Equipment.RightGuard ~= "" then
		--	PData.IStats.Capacity += Items[PData.Equipment.RightGuard].Capacity * (PData.AllStats["Capacity"] / 100)
		--end
		
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", "Capacity", PData.IStats.Capacity})
	end
end

return BoostsHandler