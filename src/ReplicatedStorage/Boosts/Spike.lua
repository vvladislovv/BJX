local module = {
	Name = script.Name,
	BoostImage = "rbxassetid://17120212085",
	Color = Color3.fromRGB(255, 35, 35),
	SColor = Color3.fromRGB(208, 29, 29),
	Time = 30,
	MaxStack = 1,
	Layout = 5005,
	StringNames = {"Attack"},
	Boosts = {
		{
			["Type"] = "Attack",
			["Mod"] = "Percent",
			["Amount"] = 50,
		},
	},
}

return module
