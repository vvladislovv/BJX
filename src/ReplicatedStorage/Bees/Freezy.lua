local module = {
	Name = "Freezy",
	Description = "Brrr. why is it so cold next to him",
	
	Rarity = "Epic",
	Color = "Blue",
	Sim = "!!",

	Attack = 4,
	Layout = 50,

	Icon = "rbxassetid://17184396260",
	Thumb = "rbxassetid://17256975152",
	GiftedThumb = "rbxassetid://15042072869",

	GiftedBonus = {"Blue Bomb Instant","Percent", 5},
	FavoriteFood = "Blueberry",
	
	Speed = 10,
	Energy = 20,
	Particles = 15,
	
	CollectTime = 5,

	Tokens = {"Blue Boost"},
	
	Converts = 175,
	ConvertsTime = 2,
	
	StatsModule = {
		Collecting = 50,
		Power = 0.3,

		Bee = true,
		Color = "Blue",
		ColorMutltiplier = 6,
	},
}

return module
