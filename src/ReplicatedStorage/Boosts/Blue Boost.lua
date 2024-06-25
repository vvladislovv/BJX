
local module = {
	Name = "Blue Boost",
	BoostImage = "rbxassetid://17024845722",
	Color = Color3.fromRGB(171, 255, 174),
	SColor = Color3.fromRGB(79, 118, 80),
	Time = 60,
	MaxStack = 10,
	Layout = 5005,
	StringNames = {"Blue Pollen"},
	Boosts = {
		{
			["Type"] = "Blue Pollen",
			["Mod"] = "Percent",
			["Amount"] = 20,
		},
	},
}

return module
