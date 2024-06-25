
local module = {
	Name = "Red Boost",
	BoostImage = "rbxassetid://17024862275",
	Color = Color3.fromRGB(171, 255, 174),
	SColor = Color3.fromRGB(79, 118, 80),
	Time = 60,
	MaxStack = 10,
	Layout = 5004,
	StringNames = {"Red Pollen"},
	Boosts = {
		{
			["Type"] = "Red Pollen",
			["Mod"] = "Percent",
			["Amount"] = 20,
		},
	},
}

return module
