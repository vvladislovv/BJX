
local module = {
	Name = "Blueberry Juice",
	BoostImage = "rbxassetid://17271281261",
	Color = Color3.fromRGB(245, 255, 134),
	SColor = Color3.fromRGB(152, 157, 83),
	Time = 600,
	MaxStack = 1,
	Layout = 5007,
	StringNames = {"Blue Pollen", "Blue Instant Conversion"},
	Boosts = {
		{
			["Type"] = "Blue Pollen",
			["Mod"] = "Percent",
			["Amount"] = 25,
		},
		{
			["Type"] = "Blue Instant",
			["Mod"] = "Percent",
			["Amount"] = 10,
		},
	},
}

return module
