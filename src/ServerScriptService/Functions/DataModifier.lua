local Data = require(game.ServerScriptService.Server.Data)
local Rep = game.ReplicatedStorage
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local GetRealStats = require(game.ServerScriptService.Functions.GetRealStats)
local Utils = require(Modules.Utils)

local module = {}

function module.InventoryChange(Player, Args) -- module.InventoryChange(Player, {"+", 1, "Ticket", "Sprout", true})
	local PData = Data:Get(Player)
	local Operation = Args[1]
	local Amount = Args[2]
	local Item = Args[3]
	local Resource = Args[4]
	local NotifyColor
	local TransID = "D:"..math.random(-999999,999999).."M:"..math.random(-999999,999999).."Q:"..math.random(-999999,999999)

	if Operation == "+" then
		NotifyColor = "Blue"
		PData.Inventory[Item] += Amount
	elseif Operation == "-" then
		NotifyColor = "Red"
		PData.Inventory[Item] -= Amount
	end

	if Args[5] then
		Remotes.AlertClient:FireClient(Player, {
			Color = NotifyColor,
			Msg = Operation..Utils:AbNumber(Amount).." "..Item.." ("..Resource..")",
			Item = Item,
			Chat = true,
		})
	end
	
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
end

function module.IStatsChange(Player, Args) -- module.InventoryChange(Player, {"+", 1, "Honey", "Sprout", true})
	local PData = Data:Get(Player)
	local Operation = Args[1]
	local Amount = Args[2]
	local Item = Args[3]
	local Resource = Args[4]
	local NotifyColor
	local TransID = "D:"..math.random(-999999,999999).."M:"..math.random(-999999,999999).."Q:"..math.random(-999999,999999)

	if Operation == "+" then
		if Item == "Honey" then
			PData.Badges.Honey.Amount += Amount
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Badges", "Honey", PData.Badges.Honey})
		end
		NotifyColor = "Blue"
		PData.IStats[Item] += Amount
	elseif Operation == "-" then
		NotifyColor = "Red"
		PData.IStats[Item] -= Amount
	end
	
	if Args[5] then
		Remotes.AlertClient:FireClient(Player, {
			Color = NotifyColor,
			Msg = Operation..Utils:AbNumber(Amount).." "..Item.." ("..Resource..")",
			Item = Item,
			Chat = true,
		})
	end 
	
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
end

function module.MakeCooldown(Player, Args) -- module.MakeCooldown(Player, {"Sprout", 10})
	local PData = Data:Get(Player)
	local Obj = Args[1]
	local Time = Args[2]

	PData.Cooldowns[Obj] = {Time = os.time() + Time}

	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Cooldowns", PData.Cooldowns})
end

function module.QuestGiverManage(Player, Args) -- module.MakeCooldown(Player, {NPC, "Completed"})
	local PData = Data:Get(Player)
	local NPC = Args[1]
	local Completed = Args[2]
	
	if Completed == "Completed" then
		PData["QuestsGivers"][NPC].CompletedQuests += 1
		PData["QuestsGivers"][NPC].Claimed2 = false
		PData["QuestsGivers"][NPC].CompletedNow = false
	else
		PData["QuestsGivers"][NPC].Claimed2 = true
	end
	
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"QuestsGivers", PData.QuestsGivers})
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Quests2", PData.Quests2})
end

return module
