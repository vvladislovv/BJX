local Data = require(game.ServerScriptService.Server.Data)
local module = {}

function module.QuetRoad(Player, Arg)
	local PData = Data:Get(Player)
	for _, NPC in pairs(PData.Quests2) do
		for i, Task in pairs(NPC) do
			if Task.Type == "UseDispenser" then
				if Arg == Task.Dispenser then
					NPC[i].StartAmount += 1
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
				end
			end
		end
	end
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Quests2", PData.Quests2})
end

return module