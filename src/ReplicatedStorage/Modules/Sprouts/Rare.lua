return {
	Name = script.Name,
	Hp = 35000,
	Color = Color3.fromRGB(226, 226, 226),
	RewardsAmount = function()
		return math.random(80, 110)
	end,
	FieldsDrop = {
		Red = {
			["Strawberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 3
			},
			["Strawberry Juice"] = {
				Type = "Item",
				Chance = 5,
				Amount = 1,
			},
		},
		Blue = {
			["Blueberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 3
			},
			["Blueberry Juice"] = {
				Type = "Item",
				Chance = 5,
				Amount = 1,
			},
		},
		White = {
			["Seed"] = {
				Type = "Item",
				Chance = 425,
				Amount = 3
			},
			["Energy Drink"] = {
				Type = "Item",
				Chance = 5,
				Amount = 1,
			},
		},
	},
	Rewards = {
		["Honey"] = {
			Type = "Currency",
			Chance = 500,
			Amount = function()
				return math.random(500, 1500)
			end,
		},
		["Ticket"] = {
			Type = "Item",
			Chance = 15,
			Amount = 1,
		},
		["Treat"] = {
			Type = "Item",
			Chance = 500,
			Amount = 3,
		},
		["Bee Jar"] = {
			Type = "Item",
			Chance = 25,
			Amount = 1,
		},
		["Silver Egg"] = {
			Type = "Item",
			Chance = 3,
			Amount = 1,
		},
	},
}