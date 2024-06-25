local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Hive Shop",
	RealName = "HiveShop",
	Items = {
		[1] = {
			Item = "Hive Slot",
			Description = "Adds 1 Honeycomb to your Hive!",
			Type = "Hive Slot",
			Category = "Hive Slot",

			CraftNum = 0,
			Cost = 250,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[2] = {
			Item = "Basic Egg",
			Description = "\nHatches an ordinary bee.\n",
			
			Type = "Item",
			Category = "Inventory",

			Amount = 1,
			
			CraftNum = 0,
			Cost = 600,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[3] = {
			Item = "Treat",
			Description = "Grants 10 Bonds for Bee.",

			Type = "Item",
			Category = "Inventory",

			Amount = 1,
	
			MultiBuy = {1,10,100,1000,10000,100000},
			
			CraftNum = 0,
			Cost = 1000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[4] = {
			Item = "Bee Jar",
			Description = "Jar with random any bee. Can only be used on occupied cells.",

			Type = "Item",
			Category = "Inventory",

			Amount = 1,

			CraftNum = 0,
			Cost = 10000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
	}
}


return module
