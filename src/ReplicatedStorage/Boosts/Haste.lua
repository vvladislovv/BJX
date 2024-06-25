
local module = {
	Name = script.Name,
	BoostImage = "rbxassetid://12875068920",
	Color = Color3.fromRGB(245, 255, 134),
	SColor = Color3.fromRGB(152, 157, 83),
	Time = 30,
	MaxStack = 1,
	Layout = 5005,
	StringNames = {"Player Movespeed"},
	Boosts = {
		{
			["Type"] = "Player Movespeed",
			["Mod"] = "Percent",
			["Amount"] = 10,
		},
	},
}

return module
