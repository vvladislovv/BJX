return {
	Quest = "Blue pollen is better",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 450
		},
		[2] = {
			Type = "CollectPollen",
			Field = "Blue Flowers",
			Amount = 250,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello Again",
			"They say blue pollen is better?",
			"Is it true?",
			"Collect 450 blue pollen",
			"and",
			"Collect 250 pollen in the blue flowers field",
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
			Type = "Currency",
			Name = "Honey",
			Amount = 999,
		},
		{
			Type = "Item",
			Name = "Blueberry",
			Amount = 25,
		},
	}
}