local Items = {} do

	Items.Bags = {
		["Pouch"] = {
			Name = "Pouch",

			Capacity = 400,
			Loses = 20,
			Timer = 60,

			BagColor = "None",
		},
		["Jar"] = {
			Name = "Jar",

			Capacity = 1500,
			Loses = 15,
			Timer = 40,

			BagColor = "None",
		},
		["Backpack"] = {
			Name = "Backpack",

			Capacity = 7500,
			Loses = 25,
			Timer = 120,

			BagColor = "None",
		},
		["Knapsack"] = {
			Name = "Knapsack",

			Capacity = 14500,
			Loses = 100,
			Timer = 300,

			BagColor = "None",
		},
		["Jousack"] = {
			Name = "Jousack",

			Capacity = 27000,
			Loses = 120,
			Timer = 600,
			Buffs = {
				{"Convert Rate", "Percent", 10},
				{"Pollen", "Percent", 3}
			},
			BagColor = "None",
		},
		["Satchel"] = {
			Name = "Satchel",

			Capacity = 45000,
			Loses = 120,
			Timer = 600,

			BagColor = "None",
		},
		["Barrel"] = {
			Name = "Barrel",

			Capacity = 95000,
			Loses = 120,
			Timer = 600,

			BagColor = "None",
		},
		["Nesting Box"] = {
			Name = "Nesting Box",

			Capacity = 175000,
			Loses = 120,
			Timer = 600,
			
			Buffs = {
				{"Convert Rate", "Percent", 25},
				{"Pollen", "Percent", 10}
			},
			
			BagColor = "None",
		},
		["Jetpack"] = {
			Name = "Jetpack",

			Capacity = 350000,
			Loses = 120,
			Timer = 600,
			
			Buffs = {
				{"Convert Rate", "Percent", 50},
				{"Pollen", "Percent", 20}
			},
			
			BagColor = "None",
		},
		["Port-Hive"] = {
			Name = "Port-Hive",

			Capacity = 850000,
			Loses = 120,
			Timer = 600,
			
			Buffs = {
				{"Convert Rate", "Percent", 100},
				{"White Pollen", "Percent", 25},
				{"Pollen", "Multiplier", 1.1}
			},
			
			BagColor = "None",
		},
		
		["Waxed Port-Hive"] = {
			Name = "Waxed Port-Hive",

			Capacity = 1600000,
			Loses = 120,
			Timer = 600,
			
			Description = "Contains 12000000 capacity. /n[Stats]/nCovert Rate +250%/nWhite Pollen +150%/nPollen 1.2x",
			
			Buffs = {
				{"Convert Rate", "Percent", 250},
				{"White Pollen", "Percent", 150},
				{"Pollen", "Multiplier", 1.2}
			},

			BagColor = "None",
		},

		["United Bag"] = {
			Name = "United Bag",

			Capacity = 5000000,
			Loses = 120,
			Timer = 600,

			Buffs = {
				{"Convert Rate", "Percent", 500},
				{"White Pollen", "Percent", 200},
				{"Blue Pollen", "Percent", 150},
				{"Red Pollen", "Percent", 150},
				{"Blue Pollen", "Multiplier", 1.15},
				{"Red Pollen", "Multiplier", 1.15},
				{"Pollen", "Multiplier", 1.5}
			},

			BagColor = "None",
		},

		["Bubble Bag"] = {
			Name = "Bubble Bag",

			Capacity = 75000000,

			Buffs = {
				{"Convert Rate", "Percent", 1000},
				{"Blue Pollen", "Percent", 300},
				{"Pollen From Bubbles", "Percent", 200},
				{"Blue Instant", "Percent", 10},
				{"Capacity", "Percent", 50},
				{"Pollen", "Multiplier", 2},
			},

			BagColor = "Blue",
		},

		["Furnace"] = {
			Name = "Furnace",

			Capacity = 1400000,
			Loses = 120,
			Timer = 600,

			Buffs = {
				{"Convert Rate", "Percent", 125},
				{"Red Pollen", "Percent", 100},
			},

			BagColor = "Red",
		},
		["Fridge"] = {
			Name = "Furnace",

			Capacity = 1400000,
			Loses = 120,
			Timer = 600,

			Buffs = {
				{"Convert Rate", "Percent", 125},
				{"Blue Pollen", "Percent", 100},
			},

			BagColor = "Blue",
		},
	}

end

return Items
