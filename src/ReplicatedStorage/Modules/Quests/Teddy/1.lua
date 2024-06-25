return {
	Quest = "Beekeeper",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Amount = 200,
		},
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"My Name is Teddy",
			"Good Luck completing my first quest",
		},
		["During"] = {
			"Return when you complete the quest!"
		},
		["Finish"] = {
			"Good job!",
			"You have complated the first quest",
			"Here is your reward!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 250,
		}
	}
}