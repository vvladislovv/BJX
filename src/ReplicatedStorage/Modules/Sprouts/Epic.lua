return {
	Name = script.Name,
	Hp = 60000,
	Color = Color3.fromRGB(255, 194, 53),
	RewardsAmount = function()
		return math.random(140, 160)
	end,
	FieldsDrop = {
		Red = {
			["Strawberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 5
			},
			["Strawberry Juice"] = {
				Type = "Item",
				Chance = 8,
				Amount = 1,
			},
		},
		Blue = {
			["Blueberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 5
			},
			["Blueberry Juice"] = {
				Type = "Item",
				Chance = 8,
				Amount = 1,
			},
		},
		White = {
			["Seed"] = {
				Type = "Item",
				Chance = 425,
				Amount = 5
			},
			["Energy Drink"] = {
				Type = "Item",
				Chance = 8,
				Amount = 1,
			},
		},
	},
	Rewards = {
		["Honey"] = {
			Type = "Currency",
			Chance = 500,
			Amount = function()
				return math.random(3500, 5000)
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
			Amount = 5,
		},
		["Bee Jar"] = {
			Type = "Item",
			Chance = 25,
			Amount = 1,
		},
		["Golden Egg"] = {
			Type = "Item",
			Chance = 3,
			Amount = 1,
		},
	},
}