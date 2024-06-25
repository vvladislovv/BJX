local module = {
	Name = "Cute",
	Description = "Cute bee, loves red pollen very much",
	
	Rarity = "Rare",
	Color = "Red",
	Sim = "!",
	
	Attack = 2,
	Layout = 30,
	
	Icon = "rbxassetid://17132794341",
	Thumb = "rbxassetid://17164979410",
	GiftedThumb = "rbxassetid://15046296630",
	
	GiftedBonus = {"Red Pollen","Mult", 1.15},
	FavoriteFood = "Strawberry",
	
	Speed = 12,
	Energy = 25,
	Particles = 10,
	
	CollectTime = 2,

	Tokens = {"Red Boost"},
	
	ConvertsTime = 2,
	Converts = 50,
	
	StatsModule = {
		Collecting = 15,
		Power = 0.15,

		Bee = true,
		Color = "Red",
		ColorMutltiplier = 8,
	},
}

return module
