local module = {
	Name = "Worker",
	Description = "An ordinary bee, but you'll never know how useful it is",
	
	Rarity = "Common",
	Color = "Colorless",
	Sim = "",
	
	Attack = 1,
	Layout = 1,
	
	Icon = "rbxassetid://16827170837",
	Thumb = "rbxassetid://17256964441",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Pollen","Mult", 1.25},
	FavoriteFood = "Seed",
	
	Speed = 8,
	Energy = 20,
	Particles = 5,
	
	CollectTime = 5,
	
	Tokens = {},
	
	ConvertsTime = 5,
	Converts = 50,
	
	StatsModule = {
		Collecting = 15,
		Power = 0.15,

		Bee = true,
		Color = "None",
		ColorMutltiplier = 1,
	},
}

return module
