
local module = {
	Name = "Strawberry Juice",
	BoostImage = "rbxassetid://17271282571",
	Color = Color3.fromRGB(245, 255, 134),
	SColor = Color3.fromRGB(152, 157, 83),
	Time = 600,
	MaxStack = 1,
	Layout = 5006,
	StringNames = {"Red Pollen", "Red Instant Conversion"},
	Boosts = {
		{
			["Type"] = "Red Pollen",
			["Mod"] = "Percent",
			["Amount"] = 25,
		},
		{
			["Type"] = "Red Instant",
			["Mod"] = "Percent",
			["Amount"] = 10,
		},
	},
}

return module
