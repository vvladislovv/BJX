local module = {
	Name = script.Name,
	BoostImage = "rbxassetid://14907805094",
	Color = Color3.fromRGB(245, 255, 134),
	SColor = Color3.fromRGB(152, 157, 83),
	Time = 600,
	MaxStack = 1,
	Layout = 5008,
	StringNames = {"Player Movespeed", "Bee Movespeed"},
	Boosts = {
		{
			["Type"] = "Player Movespeed",
			["Mod"] = "Percent",
			["Amount"] = 20,
		},
		{
			["Type"] = "Bee Movespeed",
			["Mod"] = "Percent",
			["Amount"] = 20,
		},
	},
}

return module
