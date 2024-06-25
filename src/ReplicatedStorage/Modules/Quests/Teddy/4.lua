return {
	Quest = "Red Blue and white",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Field = "Daisy",
			Amount = 1500
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 1500,
		},
		[3] = {
			Type = "CollectPollen",
			Field = "Red Flowers",
			Amount = 1500,
		},
	},
	Dialogues = {
		["Start"] = {
			"Yeah, you did my quests so fast.",
			"Then. Collect Me 1500 Pollen From Blue Flowers, Daisy and Red Flowers Fields",
		},
		["During"] = {
			"Return when you complete the quest!"
		},
		["Finish"] = {
			"Here is your reward!"
		}
	},
	
	Rewards = {
		{
			Present = "IStats",
			ValueType = "Honey",
			Amount = 4000,
		},
		{
			Present = "Inventory",
			ValueType = "Ticket",
			Amount = 5,
		},
		{
			Present = "Inventory",
			ValueType = "Silver Egg",
			Amount = 1,
		},
	},
}