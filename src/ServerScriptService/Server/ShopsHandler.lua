local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Rep = game.ReplicatedStorage
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local Data = require(script.Parent.Data)
local Items = require(Modules.Items)
local Utils = require(Modules.Utils)
local Equipment = require(SSS.Server.Equipment)
local Shops = require(game.ReplicatedStorage.Modules.Shops)
local GetStatsModule = require(SSS.Functions.GetRealStats)
local GetCapacityModule = require(SSS.Functions.GetCapacity)
local DataModifier = require(SSS.Functions.DataModifier)

local ItemMod = {
	["Bee Jar"] = 1000000,
	["Basic Egg"] = 10000000,
}

local BoostsHandler = {} do
	local hivedeb = false
	local function checkIngridients(Ingridients, PData)
		local ingridientsCompleted = 0
		for Type, amount in pairs(Ingridients) do
			if PData.Inventory[Type] >= amount[1] then
				ingridientsCompleted += 1
			end
		end
		return ingridientsCompleted
	end
	local function checkitem(Shop, Item)
		local shop2 = require(game.ReplicatedStorage.Modules.Shops:FindFirstChild(Shop))
		local itm = false
		local check1 = false
		local check2 = false
		local check3 = false
		for i,v in pairs(shop2.Items) do
			if Item.Item == v.Item then
				check1 = true
			end
			if Item.Cost == v.Cost then
				check2 = true
			end
		end
		if check1 and check2 then
			itm = true
		end
		return itm
	end
	local function HaveExBee(Bee, Bees)
		for i,v in pairs(Bees) do
			if v.BeeName == Bee then
				return true
			end
		end
	end
	local function DestroyEquipment(Character, Item)
		if Character:FindFirstChild(Item.Type) then
			Character:WaitForChild(Item.Type):Destroy()
			if Item.Type == "Boot" then
				Character:WaitForChild(Item.Type):Destroy()
			end
		end
	end
	local function CheckEquip(PData, Item)
		if PData[Item.Category][Item.Type.."s"][Item.Item] and Item.Item ~= PData[Item.Category][Item.Type] then
			return "Equip"
		else
			return "Purchase"
		end
	end

	Remotes.Shop.OnServerEvent:Connect(function(Player: Player, Shop: string, Item: number, Amount: number?)
		local PlayerData = Data:Get(Player)
		local ShopData = Shops[Shop]
		if not ShopData then return end
		local ItemData = ShopData.Items[Item]
		if not ItemData then return end
		
		if Amount and ItemData.MultiBuy and ItemData.MultiBuy[Amount] then
			Amount = ItemData.MultiBuy[Amount]
		else
			Amount = nil
		end

		local Cost = Shops.Functions.GetCost(PlayerData, ItemData, Amount)
		local Type = Shops.Functions.GetStatus(PlayerData, ItemData, Amount)
		if Type == "Purchase" then
			for _, Ingredient in ItemData.Craft do
				DataModifier.InventoryChange(Player, {"-", Ingredient.Amount, Ingredient.Name})
			end
			if ItemData.CostType == "Currency" then
				DataModifier.IStatsChange(Player, {"-", Cost, ItemData.CostName})
			elseif ItemData.CostType == "Item" then
				DataModifier.InventoryChange(Player, {"-", Cost, ItemData.CostName})
			end
		elseif Type == "Can't afford" then
			return warn("can't afford")
		elseif Type == "Not For Sale" then
			return
		end

		-- выдаем
		if ItemData.Category == "Equipment" then
			if not PlayerData.Equipment[ItemData.Type.."s"][ItemData.Item] then
				PlayerData.Equipment[ItemData.Type.."s"][ItemData.Item] = true
			end
			if PlayerData.Equipment[ItemData.Type] ~= ItemData.Item then
				PlayerData.Equipment[ItemData.Type] = ItemData.Item
				DestroyEquipment(Player.Character, ItemData)
				--wait(0.1)
				Equipment:EquipItem(Player, ItemData.Type)
			end
		elseif ItemData.Category == "Inventory" then
			DataModifier.InventoryChange(Player, {"+", Amount or ItemData.Amount, ItemData.Item})
			--PlayerData.Inventory[ItemData.Item] += ItemData.Amount
			if PlayerData.IStats[ItemData.Item] then
				PlayerData.IStats[ItemData.Item] = math.round(PlayerData.IStats[ItemData.Item] * 1.5)
				if PlayerData.IStats[ItemData.Item] > ItemMod[ItemData.Item] then
					PlayerData.IStats[ItemData.Item] = ItemMod[ItemData.Item]
				end
			end
		elseif ItemData.Category == "Hive Slot" then
			PlayerData.IStats["Hive Slot"] = math.round(PlayerData.IStats["Hive Slot"] * 1.5)
			require(game.ServerScriptService.Modules.HivesManager).NewSlot(PlayerData, PlayerData.IStats.TotalSlots)
			PlayerData.IStats.TotalSlots += 1
		end
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Equipment", PlayerData["Equipment"]})
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PlayerData.IStats})
		game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PlayerData.Inventory})
		GetStatsModule.GetRealStats(Player, PlayerData)
	end)

	--Remotes.Shop.OnServerEvent:Connect(function(Player, Shop, ItemID)
	--	local PData = Data:Get(Player)
	--	local Item = require(game.ReplicatedStorage.Modules.Shops:FindFirstChild(Shop)).Items[ItemID]
	--	local Cost = Item.Cost
	--	if Item.CostMult then
	--		Cost = math.round(Cost * PData.CostsMults[Item.Item]["X"])
	--	end

	--	if Item.Category == "Equipment" then
	--		if CheckEquip(PData, Item) == "Equip" then
	--			PData["Equipment"][Item.Type] = Item.Item
	--			DestroyEquipment(Player.Character, Item)
	--			wait(0.1)
	--			Equipment:EquipItem(Player.Character, Item.Type, PData)
	--		elseif CheckEquip(PData, Item) == "Purchase" then
	--			if PData.IStats.Honey >= Cost then
	--				if Item.CraftNum > 0 and checkIngridients(Item.Craft, PData) >= Item.CraftNum then
	--					PData["Equipment"][Item.Type.."s"][Item.Item] = true
	--					PData["Equipment"][Item.Type] = Item.Item

	--					for i,v in pairs(Item.Craft) do
	--						PData.Inventory[i] -= v[1]
	--					end

	--					DestroyEquipment(Player.Character, Item)
	--					wait(0.1)
	--					Equipment:EquipItem(Player, Item.Type, PData)
	--					PData.IStats.Honey -= Cost
	--				elseif Item.CraftNum == 0 then
	--					PData["Equipment"][Item.Type.."s"][Item.Item] = true
	--					PData["Equipment"][Item.Type] = Item.Item

	--					if Item.Type == "Hydrant" then
	--						PData.Inventory["Hydrant Builder"] = 1
	--					else
	--						DestroyEquipment(Player.Character, Item)
	--						wait(0.1)
	--						Equipment:EquipItem(Player, Item.Type, PData)
	--					end
	--					PData.IStats.Honey -= Cost
	--				end
	--			end
	--		end
	--	elseif Item.Category == "Inventory" then
	--		if PData.IStats[Item.Item] then
	--			Cost = PData.IStats[Item.Item]
	--		end
	--		if PData.IStats.Honey >= Cost then
	--			if Item.CraftNum > 0 and checkIngridients(Item.Craft, PData) >= Item.CraftNum then
	--				if Item.Type == "Exclusive Bee" then
	--					if HaveExBee(Item.Bee, PData.Bees) then
	--						Remotes.AlertClient:FireClient(Player, {
	--							Color = "Red",
	--							Msg = "You already have "..Item.Bee.." Bee!"
	--						})
	--					else
	--						PData.Inventory[Item.Item] += Item.Amount
	--						for i,v in pairs(Item.Craft) do
	--							PData.Inventory[i] -= v[1]
	--						end
	--						PData.IStats.Honey -= Cost
	--					end
	--				else
	--					PData.Inventory[Item.Item] += Item.Amount
	--					for i,v in pairs(Item.Craft) do
	--						PData.Inventory[i] -= v[1]
	--					end
	--					PData.IStats.Honey -= Cost
	--				end
	--			elseif Item.CraftNum == 0 then
	--				PData.Inventory[Item.Item] += Item.Amount
	--				PData.IStats.Honey -= Cost
	--				PData.IStats[Item.Item] = math.round(PData.IStats[Item.Item] * 1.5)
	--				if PData.IStats[Item.Item] > ItemMod[Item.Item] then
	--					PData.IStats[Item.Item] = ItemMod[Item.Item]
	--				end
	--			end
	--		end
	--	elseif Item.Category == "Hive Slot" then
	--		Cost = PData.IStats["Hive Slot"]
	--		if PData.IStats.Honey >= Cost and PData.IStats.TotalSlots < 50 and not hivedeb then
	--			hivedeb = true

	--			PData.IStats.Honey -= Cost
	--			PData.IStats["Hive Slot"] = math.round(PData.IStats["Hive Slot"] * 1.5)
	--			require(game.ServerScriptService.Modules.HivesManager).NewSlot(PData, PData.IStats.TotalSlots)
	--			wait(0.1)
	--			PData.IStats.TotalSlots += 1

	--			spawn(function()
	--				wait(0.33)
	--				hivedeb = false
	--			end)
	--		end
	--	end

	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Equipment", PData["Equipment"]})
	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
	--	--game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"CostsMults", Item.CostMult, PData.CostsMults[Item.CostMult]})
	--	GetStatsModule.GetRealStats(Player, PData)
	--end)
end



return BoostsHandler