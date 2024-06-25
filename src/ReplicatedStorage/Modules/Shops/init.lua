 local module = {}

module.WorkerShop = require(script.WorkerShop)
module.HiveShop = require(script.HiveShop)

module.Functions = {}
module.Functions.GetCost = function(PlayerData, Item, Amount: number?)
	if PlayerData.IStats[Item.Item] then
		return PlayerData.IStats[Item.Item] * (Amount and Amount or 1)
	end
	return Item.Cost * (Amount and Amount or 1)
end
module.Functions.GetStatus = function(PlayerData, Item, Amount: number?)
	local Cost = module.Functions.GetCost(PlayerData, Item, Amount)
	local HaveIngredients = 0
	for _, Ingredient in Item.Craft do
		if PlayerData.Inventory[Ingredient.Name] >= Ingredient.Amount then
			HaveIngredients += 1
		end
	end
	if Item.Category == "Equipment" then
		if not PlayerData.Equipment[Item.Type] then
			return "Not For Sale"
		end
		if PlayerData.Equipment[Item.Type] == Item.Item then
			return "Equipped"
		elseif PlayerData.Equipment[Item.Type.."s"][Item.Item] then
			return "Equip"
		end
	end
	if Item.Category == "Hive Slot" then
		if PlayerData.IStats.TotalSlots >= 50 then
			return "Not For Sale"
		end
	end
	if PlayerData[Item.CostType == "Currency" and "IStats" or "Inventory"][Item.CostName] >= Cost and HaveIngredients == #Item.Craft then
		return "Purchase"
	else
		return "Can't afford"
	end
end

return module