return {
	Name = script.Name,
	Hp = 200000,
	Color = Color3.fromRGB(74, 246, 255),
	RewardsAmount = function()
		return math.random(180, 200)
	end,
	FieldsDrop = {
		Red = {
			["Strawberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 10
			},
			["Strawberry Juice"] = {
				Type = "Item",
				Chance = 25,
				Amount = 1,
			},
		},
		Blue = {
			["Blueberry"] = {
				Type = "Item",
				Chance = 425,
				Amount = 10
			},
			["Blueberry Juice"] = {
				Type = "Item",
				Chance = 25,
				Amount = 1,
			},
		},
		White = {
			["Seed"] = {
				Type = "Item",
				Chance = 425,
				Amount = 10
			},
			["Energy Drink"] = {
				Type = "Item",
				Chance = 25,
				Amount = 1,
			},
		},
	},
	Rewards = {
		["Honey"] = {
			Type = "Currency",
			Chance = 500,
			Amount = function()
				return math.random(8000, 15000)
			end,
		},
		["Ticket"] = {
			Type = "Item",
			Chance = 30,
			Amount = 1,
		},
		["Treat"] = {
			Type = "Item",
			Chance = 500,
			Amount = 10,
		},
		["Bee Jar"] = {
			Type = "Item",
			Chance = 50,
			Amount = 1,
		},
		["Diamond Egg"] = {
			Type = "Item",
			Chance = 1,
			Amount = 1,
		},
	},
}