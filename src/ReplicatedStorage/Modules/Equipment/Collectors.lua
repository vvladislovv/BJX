local Items = {} do

	Items.Collectors = {
		["Scooper"] = {
			Name = "Scooper",
			Description = "Collects 1 Pollen from 2 flowers \n\n Cooldown: 0.75s",

			Cooldown = 0.75,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 1,
				Power = 0.2,
				
				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Scooper",
			Ability = "None",
		},
		["Rake"] = {
			Name = "Rake",
			Description = "Collects 3 Pollen from 6 flowers. \n\n Cooldown: 0.6s",

			Cooldown = 0.6,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 3,
				Power = 0.5,

				Tool = true,

				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Rake",
			Ability = "None",
		},
		["Magnet"] = {
			Name = "Magnet",
			Description = "Collecting 10 Pollen from 12 Flowers \n\n Cooldown: 0.8s",

			Cooldown = 0.8,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 10,
				Power = 0.5,

				Tool = true,

				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Magnet",
			Ability = "None",
		},
		["Scissors"] = {
			Name = "Scissors",
			Description = "Collecting 65 Pollen from 2 Flowers \n\n Cooldown: 0.55s",

			Cooldown = 0.55,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 65,
				Power = 0.5,

				Tool = true,
				Color = "None",
				ColorMutltiplier = 1,
			},

			Stamp = "Scooper",
			Ability = "None",
		},
		["Vacuum"] = {
			Name = "Vacuum",
			Description = "some text idk \nx1.1 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 0.7,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 36,
				Power = 0.3,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.1,
			},

			Stamp = "Vacuum",
			Ability = "None",
		},
		["Opener"] = {
			Name = "Opener",
			Description = "Collecting 45 Pollen from x flowers. \n x1.2 White Pollen from this Tool \n\n Cooldown: 0.5s",

			Cooldown = 0.5,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 45,
				Power = 0.3,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.2,
			},

			Stamp = "Opener",
			Ability = "None",
		},
		["Brush"] = {
			Name = "Brush",
			Description = "Collecting 70 Pollen from x flowers. \n x1.3 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 0.7,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 70,
				Power = 0.2,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.3,
			},

			Stamp = "Opener",
			Ability = "None",
		},
		["Scrape"] = {
			Name = "Scrape",
			Description = "Collecting 60 Pollen from 13 flowers. \n x1.3 White Pollen from this Tool \n\n Cooldown: 0.8s",

			Cooldown = 0.8,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 60,
				Power = 0.5,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.3,
			},

			Stamp = "Scrape",
			Ability = "None",
		},
		["Electro-Magnet"] = {
			Name = "Electro-Magnet",
			Description = "Collecting 150 Pollen from 6 flowers. \n x1.3 White Pollen from this Tool \n\n Cooldown: 0.9s",

			Cooldown = 0.9,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 150,
				Power = 0.5,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.3,
			},

			Stamp = "Magnet2",
			Ability = "None",
		},
		["Honey-Spoon"] = {
			Name = "Honey-Spoon",
			Description = "Collecting 70 Pollen from 21 flowers. \n x1.5 White Pollen from this Tool \n\n Cooldown: 0.6s",

			Cooldown = 0.6,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 70,
				Power = 0.5,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.5,
			},

			Stamp = "HoneySpoon",
			Ability = "None",
		},
		["Honey Cutter"] = {
			Name = "Honey Cutter",
			Description = "Collecting 140 Pollen from [x] flowers. \n x2 White Pollen from this Tool \n\n Cooldown: 0.8s",

			Cooldown = 0.8,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 140,
				Power = 0.4,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 2,
			},

			Stamp = "HoneyCutter",
			Ability = "None",
		},
		["Caramel Hammer"] = {
			Name = "Caramel Hammer",
			Description = "Collecting 45 Pollen from 59 flowers. \n x1.75 White Pollen from this Tool \n\n Cooldown: 0.7s",

			Cooldown = 0.7,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 45,
				Power = 0.5,

				Tool = true,
				Color = "White",
				ColorMutltiplier = 1.75,
			},

			Stamp = "Hammer",
			Ability = "None",
		},
		["Scythe"] = {
			Name = "Scythe",
			Description = "Collecting 33 Pollen from 14 flowers. \n x1.6 Red Pollen from this Tool \n\n Cooldown: 0.5s",

			Cooldown = 0.5,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 33,
				Power = 0.7,

				Tool = true,
				Color = "Red",
				ColorMutltiplier = 1.5,
			},

			Stamp = "Scythe",
			Ability = "None",
		},
		["Snowflake Wand"] = {
			Name = "Snowflake Wand",
			Description = "Collecting 44 Pollen from 14 flowers. \n x1.6 Red Pollen from this Tool \n\n Cooldown: 0.75s",

			Cooldown = 0.75,

			StatsModule = {
				AnimTools = "rbxassetid://522635514",
				Collecting = 44,
				Power = 0.3,

				Tool = true,
				Color = "Blue",
				ColorMutltiplier = 1.5,
			},

			Stamp = "SnowflakeWand",
			Ability = "None",
		},
	}
end

return Items
