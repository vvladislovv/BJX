local module = {
	Name = "Fire",
	Description = "A very fast bee, she often has a high temperature",

	Rarity = "Epic",
	Color = "Red",
	Sim = "!!",

	Attack = 6,
	Layout = 60,

	Icon = "rbxassetid://17184435131",
	Thumb = "rbxassetid://17256977150",
	GiftedThumb = "rbxassetid://15042070429",

	GiftedBonus = {"Red Pollen","Mult", 1.15},
	FavoriteFood = "Strawberry",
	
	Speed = 11,
	Energy = 20,
	Particles = 15,
	
	CollectTime = 3,
	
	Tokens = {"Red Boost"},
	
	Converts = 200,
	ConvertsTime = 3,
	
	StatsModule = {
		Collecting = 20,
		Power = 0.25,

		Bee = true,
		Color = "Red",
		ColorMutltiplier = 15,
	},
}

return module
