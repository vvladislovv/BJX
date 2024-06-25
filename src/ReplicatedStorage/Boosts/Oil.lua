
local module = {
	Name = script.Name,
	BoostImage = "rbxassetid://14907834660",
	Color = Color3.fromRGB(245, 255, 134),
	SColor = Color3.fromRGB(152, 157, 83),
	Time = 600,
	MaxStack = 1,
	Layout = 5009,
	StringNames = {"Caramel", "White Instant Conversion", "White Pollen"},
	Boosts = {
		{
			["Type"] = "Caramel",
			["Mod"] = "Percent",
			["Amount"] = 50,
		},
		{
			["Type"] = "White Instant",
			["Mod"] = "Percent",
			["Amount"] = 10,
		},
		{
			["Type"] = "White Pollen",
			["Mod"] = "Percent",
			["Amount"] = 25,
		},
	},
}

return module
