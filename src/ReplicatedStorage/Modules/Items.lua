local Items = {}

Items.Eggs = {
	["Hydrant Builder"] = {
		Name = "Hydrant Builder",
		Description = "Places your Hydrant on field.",
		Image = "rbxassetid://14833409019",
		Layout = 0,

		Type = "Hydrant",

		Settings = {
			CanInput = true,
			AmountHide = true,
			Amount = 50,
		},
	},

	-- Values
	["Ticket"] = {
		Name = "Ticket",
		Description = "A special currency used to activate and purchase special things.",
		Image = "rbxassetid://17120110218",
		Layout = 900,

		Type = "Value",

		Settings = {

		},
	},
	["BJ Point"] = {
		Name = "BJ Point",
		Description = "A special currency used to purchase gamepasses, bundles and other.",
		Image = "rbxassetid://17096487861",
		Layout = 910,

		Type = "Value",

		Settings = {

		},
	},
	
	["Beespass Premium"] = {
		Name = "Beespass Premium",
		Description = "Activates Premium Beespass for 1 Season.",
		Image = "rbxassetid://15451531782",
		Layout = 910,

		Type = "Effect",

		Settings = {
			CanInput = true,
		},
	},

	-- Misc
	["Instant Converter"] = {
		Name = "Instant Converter",
		Description = "Instant converts your pollen to honey.",
		Image = "rbxassetid://14776604700",
		Layout = 1002,

		Type = "Effect",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	["Spike"] = {
		Name = "Spike",
		Description = "Makes the Bees Attack twice as much!",
		Image = "rbxassetid://17120212085",
		Layout = 1003,

		Type = "Boost",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	-- Resources
	["Caramel"] = {
		Name = "Caramel",
		Description = "Covers the flowers with sweet caramel and gives you a bonus honey. \n Press [C] for quick use",
		Image = "rbxassetid://17266681513",
		Layout = 1005,

		Type = "Effect",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	["Sugar"] = {
		Name = "Sugar",
		Description = "It tastes very sweet, used in cooking Caramel.",
		Image = "rbxassetid://17120190251",
		Layout = 1004,

		Type = "Value",

		Settings = {
			CanInput = false,
			Amount = 50,
		},
	};

	["Strawberry"] = {
		Name = "Strawberry",
		Description = "Grants 50 Bonds for Bee.",
		Image = "rbxassetid://17120176308",
		Layout = 2000,

		Type = "Food",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	["Blueberry"] = {
		Name = "Blueberry",
		Description = "Grants 50 Bonds for Bee.",
		Image = "rbxassetid://17120178241",
		Layout = 2010,

		Type = "Food",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	["Seed"] = {
		Name = "Seed",
		Description = "Grants 50 Bonds for Bee.",
		Image = "rbxassetid://17120179581",
		Layout = 2020,

		Type = "Food",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	--Boosters
	["Energy Drink"] = {
		Name = "Energy Drink",
		Description = "Grants +50% White Pollen \n +10% Instant Conversion.",
		Image = "rbxassetid://12875068920",
		Layout = 2501,

		Type = "Boost",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	["Strawberry Juice"] = {
		Name = "Strawberry Juice",
		Description = "Grants +25% Red Pollen \n +10% Red Instant Conversion.",
		Image = "rbxassetid://17271282571",
		Layout = 2503,

		Type = "Boost",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	["Blueberry Juice"] = {
		Name = "Blueberry Juice",
		Description = "Grants +25% Blue Pollen \n +10% Blue Instant Conversion.",
		Image = "rbxassetid://17271281261",
		Layout = 2504,

		Type = "Boost",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	["Caramel Bottle"] = {
		Name = "Caramel Bottle",
		Description = "Grants Caramel +50%, \n +10% White Instant Conversion.\n +25% White Pollen.",
		Image = "rbxassetid://14907805094",
		Layout = 2505,

		Type = "Boost",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	["Oil"] = {
		Name = "Oil",
		Description = "Grants Player Movespeed x1.2, \n Bee Movespeed x1.2",
		Image = "rbxassetid://14907834660",
		Layout = 2506,

		Type = "Boost",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	["Fertilizer"] = {
		Name = "Fertilizer",
		Description = "When used, It Fertilizes the Field on which you are Standing",
		Image = "rbxassetid://14907836182",
		Layout = 2507,

		Type = "Effect",
		Crafting = true,
		CraftIndex = 1,
		ReceptNum = 3,
		Recept = {
			["Seed"] = 10,
			["Strawberry"] = 10,
			["Blueberry"] = 10,
		},
		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};

	--Bees Food
	["Treat"] = {
		Name = "Treat",
		Description = "Grants 10 Bonds for Bee.",
		Image = "rbxassetid://17085351146",
		Layout = 3000,

		Type = "Food",


		Settings = {
			CanInput = true,
			Amount = 10,
		},
	};

	["Magic Treat"] = {
		Name = "Magic Treat",
		Description = "Makes a Bee into a Star Bee.",
		Image = "rbxassetid://17120185711",
		Layout = 3001,

		Type = "EffectFood",


		Settings = {
			CanInput = true,
			Amount = 10,
		},
	};

	["Bee Jar"] = {
		Name = "Bee Jar",
		Description = "Jar with random any bee. Can only be used on occupied cells.",
		Image = "rbxassetid://15431515785",
		Layout = 4000,

		Type = "Jelly",

		Settings = {
			CanInput = true,
		},
	};
	-- Sprouts
	["Sprout Bean"] = {
		Name = "Sprout Bean",
		Description = "Spawns a random Sprout.",
		Image = "rbxassetid://14874786982",
		Layout = 5001,

		Type = "Sprout",

		Settings = {
			CanInput = true,
			Amount = 50,
		},
	};
	-- Eggs
	["Basic Egg"] = {
		Name = "Basic Egg",
		Description = "Hatches an ordinary bee.",
		Image = "rbxassetid://18190722132",
		Layout = 6000,

		Type = "Egg",

		Settings = {
			CanInput = true,
		},
	};

	["Silver Egg"] = {
		Name = "Silver Egg",
		Description = "Hatches a Rare Bee and with a small chance Epic and Legendary.",
		Image = "rbxassetid://17044197581",
		Layout = 7000,

		Type = "Egg",

		Settings = {
			CanInput = true,
		},
	};

	["Golden Egg"] = {
		Name = "Golden Egg",
		Description = "Hatches an Epic Bee and with a small chance Legendary.",
		Image = "rbxassetid://18190726521",
		Layout = 8000,

		Type = "Egg",

		Settings = {
			CanInput = true,
		},
	};

	["Diamond Egg"] = {
		Name = "Diamond Egg",
		Description = "Legendary Bee hatches with 100% chance",
		Image = "rbxassetid://18190724232",
		Layout = 9000,

		Type = "Egg",

		Settings = {
			CanInput = true,
		},
	};

	-- Bee Eggs
	["Bear Bee Egg"] = {
		Name = "Bear Bee Egg",
		Description = "Bear Bee hatches with 100% chance",
		Image = "rbxassetid://14825226126",
		Layout = 15000,

		Type = "Egg",

		Settings = {
			CanInput = true,
		},
	};
}

return Items
