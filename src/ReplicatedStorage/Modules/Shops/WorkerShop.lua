local Collectors = require(game.ReplicatedStorage.Modules.Equipment.Collectors)

local module = {
	ShopName = "Worker Shop",
	RealName = "WorkerShop",
	Items = {
		[1] = {
			Item = "Scooper",
			Description = "Collects 1 Pollen from 2 patches in 0.75 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 0,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[2] = {
			Item = "Rake",
			Description = "Collects 3 Pollen from 6 patches in 0.6 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 600,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[3] = {
			Item = "Magnet",
			Description = "Collects 10 Pollen from 12 patches in 0.8 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 2500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[4] = {
			Item = "Scissors",
			Description = "Collecting 65 Pollen from 2 patches in 0.55 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 8000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[5] = {
			Item = "Vacuum",
			Description = "Collecting 65 Pollen from 13 patches in 0.7 seconds",
			Type = "Tool",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 21000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[6] = {
			Item = "Pouch",
			Description = "\nContains 400 Pollen",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 0,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[7] = {
			Item = "Jar",
			Description = "\nContains 1500 Pollen \n\nloses 15 pollen every 40 sec.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 800,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[8] = {
			Item = "Backpack",
			Description = "\nContains 7.500 Pollen \n\nloses 25 pollen every 120 sec.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 5500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[9] = {
			Item = "Knapsack",
			Description = "\nContains 14.500 Pollen \n\nloses 100 pollen every 300 sec.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 12000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[10] = {
			Item = "Jousack",
			Description = "\nContains 27.000 Pollen \n\nloses 120 pollen every 600 sec.",
			Type = "Bag",
			Category = "Equipment",

			CraftNum = 0,
			Cost = 22500,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {}
		},
		[11] = {
			Item = "Worker",
			Description = "Worker Boots \n[Stats]\n Movement Collection - 1 \n +20% Player Movespeed \n +10% Jump Power",
			Type = "Boot",
			Category = "Equipment",

			CraftNum = 1,
			Cost = 25000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Blueberry",
					Amount = 10,
				}
			}
		},
		[12] = {
			Item = "Bee's Larva",
			Description = "Bee's Larva Mask \n[Stats]\n +5% Pollen \n +25% Convert Rate",
			Type = "Hat",
			Category = "Equipment",

			CraftNum = 1,
			Cost = 20000,
			CostType = "Currency",
			CostName = "Honey",
			Craft = {
				[1] = {
					Name = "Seed",
					Amount = 10,
				}
			}
		},

		--[1] = {
		--	Item = "Pouch",
		--	Description = "\n+200 Capacity \n\nloses 20 pollen per minute.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 2,
		--	Cost = 0,
		--	Craft = {
		--		["Diamond Egg"] = 1,
		--		["Basic Egg"] = 9999,
		--	}
		--},
		--[2] = {
		--	Item = "Backpack",
		--	Description = "\n+800 Capacity \n\nloses 15 pollen per 40 seconds.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 650,
		--	Craft = {}
		--},
		--[3] = {
		--	Item = "Soft Bag",
		--	Description = "\n+3,000 Capacity \n\nloses 25 pollen per 2 minutes.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 5800,
		--	Craft = {}
		--},
		--[4] = {
		--	Item = "Medium Bag",
		--	Description = "DON'T BUY THIS ITEM\n\n\n+10,000 Capacity \n\nloses 100 pollen per 5 minutes.",
		--	Type = "Bag",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 22000,
		--	Craft = {}
		--},
		----// Shovels \\--
		--[5] = {
		--	Item = "Scooper",
		--	Description = "Collects 1 Pollen from 2 patches in 0.75 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 0,
		--	Craft = {}
		--},
		--[6] = {
		--	Item = "Pickaxe",
		--	Description = "Collects 5 Pollen from 5 patches in 0.9 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 700,
		--	Craft = {}
		--},
		--[7] = {
		--	Item = "Rake",
		--	Description = "Collects 7 Pollen from 7 patches in 0.65 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 4500,
		--	Craft = {}
		--},
		--[8] = {
		--	Item = "Hoe",
		--	Description = "Collects 10 Pollen from 6 patches in 0.55 seconds.",
		--	Type = "Tool",
		--	Category = "Equipment",

		--	CraftNum = 0,
		--	Cost = 15000,
		--	Craft = {}
		--},
	}
}


return module
