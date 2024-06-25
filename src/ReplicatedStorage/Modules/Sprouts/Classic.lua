return {
	Name = script.Name,
	Hp = 15000,
	Color = Color3.fromRGB(52, 142, 64),
	RewardsAmount = function()
		return math.random(40, 50)
	end,
	FieldsDrop = {
		Red = {
			["Strawberry"] = {
				Type = "Item",
				Chance = 150,
				Amount = 1
			},
		},
		Blue = {
			["Blueberry"] = {
				Type = "Item",
				Chance = 150,
				Amount = 1
			},
		},
		White = {
			["Seed"] = {
				Type = "Item",
				Chance = 150,
				Amount = 1
			},
		},
	},
	Rewards = {
		["Honey"] = {
			Type = "Currency",
			Chance = 200,
			Amount = function()
				return math.random(150, 200)
			end,
		},
		["Ticket"] = {
			Type = "Item",
			Chance = 10,
			Amount = 1,
		},
		["Treat"] = {
			Type = "Item",
			Chance = 200,
			Amount = 1,
		},
		["Bee Jar"] = {
			Type = "Item",
			Chance = 25,
			Amount = 1,
		},
	},
}