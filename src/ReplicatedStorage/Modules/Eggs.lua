local module = {}

local X = 1000

module.Eggs = {
	["Bear Bee Egg"] = {
		["Bear"] = {Name = "Bear", Rarity = 100 * X},
	},

	["Basic Egg"] = {
		["Worker"] = {Name = "Worker", Rarity = 100 * X},
	},

	["Silver Egg"] = {
		["Cute"] = {Name = "Cute", Rarity = 33 * X},
		["Happy"] = {Name = "Happy", Rarity = 33 * X},
	},
	
	["Golden Egg"] = {
		["Freezy"] = {Name = "Freezy", Rarity = 33 * X},
		["Bored"] = {Name = "Bored", Rarity = 33 * X},
		["Fire"] = {Name = "Fire", Rarity = 33 * X},
	},
	
	["Diamond Egg"] = {
		["Gnat"] = {Name = "Gnat", Rarity = 33 * X},
		["Barbel"] = {Name = "Barbel", Rarity = 33 * X},
		["Staggy"] = {Name = "Staggy", Rarity = 33 * X},
		
		--["Silky"] = {Name = "Silky", Rarity = 2000},
		--["Sharp"] = {Name = "Sharp", Rarity = 2000},
		--["Aquatic"] = {Name = "Aquatic", Rarity = 2000},
	},

	--["Mythic Egg"] = {
	--	["Silky"] = {Name = "Silky", Rarity = 9500},
	--	["Sharp"] = {Name = "Sharp", Rarity = 9500},
	--	["Aquatic"] = {Name = "Aquatic", Rarity = 9500},
	--},
	
	-- 500 = 0.5
	-- 750 = 0.75 and 75 = 0.075%
	["Bee Jar"] = {
		["Cute"] = {Name = "Cute", Rarity = 70 * X},
		["Happy"] = {Name = "Happy", Rarity = 70 * X},

		["Freezy"] = {Name = "Freezy", Rarity = 27 * X},
		["Bored"] = {Name = "Bored", Rarity = 27 * X},
		["Fire"] = {Name = "Fire", Rarity = 27 * X},

		--["Gnat"] = {Name = "Gnat", Rarity = 3 * X},
		--["Barbel"] = {Name = "Barbel", Rarity = 3 * X},
		--["Staggy"] = {Name = "Staggy", Rarity = 3 * X},
	},
}

return module