local module = {
	Name = "Happy",
	Description = "He is really happy to spend time with you",
	
	Rarity = "Rare",
	Color = "Blue",
	Sim = "!",
	
	Attack = 2,
	Layout = 20,
	
	Icon = "rbxassetid://17132811115",
	Thumb = "rbxassetid://17256972738",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Blue Bomb Pollen","Mult", 1.15},
	FavoriteFood = "Blueberry",
	
	Speed = 10,
	Energy = 25,
	Particles = 10,
	
	CollectTime = 5,

	Tokens = {"Blue Boost", "Blue Bomb"},
	
	ConvertsTime = 5,
	Converts = 80,
	
	StatsModule = {
		Collecting = 25,
		Power = 0.2,
		
		Bee = true,
		Color = "Blue",
		ColorMutltiplier = 4,
	},
}

return module
