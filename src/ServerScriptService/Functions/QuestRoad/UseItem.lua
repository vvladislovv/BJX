local Data = require(game.ServerScriptService.Server.Data)
local module = {}

function module.QuetRoad(Player, Arg)
	local PData = Data:Get(Player)
	for _, NPC in pairs(PData.Quests) do
		for i, Task in pairs(NPC) do
			if Task.Type == "UseItem" then
				if Arg == Task.Item then
					NPC[i].StartAmount += 1
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
				end
			end
		end
	end
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Quests", PData.Quests})
end

return module