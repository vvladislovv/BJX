local module = {
	Name = "Bored",
	Description = "Very slow, but hardworking hard worker",

	Rarity = "Epic",
	Color = "Colorless",
	Sim = "!!",

	Attack = 0,
	Layout = 40,

	Icon = "rbxassetid://17184445680",
	Thumb = "rbxassetid://17256966805",
	GiftedThumb = "rbxassetid://15042072869",

	GiftedBonus = {"White Pollen","Percent", 15},
	FavoriteFood = "Seed",
	
	Speed = 8,
	Energy = 20,
	Particles = 15,
	
	CollectTime = 6,
	
	Tokens = {},
	
	Converts = 350,
	ConvertsTime = 6,
	
	StatsModule = {
		Collecting = 100,
		Power = 0.2,

		Bee = true,
		Color = "White",
		ColorMutltiplier = 3,
	},
}

return module
