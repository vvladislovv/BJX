return {
	Quest = "Fungus Field",
	Tasks = {
		[1] = {
			Type = "CollectPollen",
			Color = "White",
			Field = "Fungus",
			Amount = 100,
		},
		[2] = {
			Type = "CollectPollen",
			Color = "Blue",
			Amount = 250
		},
		--[3] = {
		--	Type = "CollectToken",
		--	--Token = "",
		--	Amount = 3,
		--}
	},
	Dialogues = {
		["Start"] = {
			"Hello!",
			"This is not an ordinary field of mushrooms",
			"There mushrooms are very rare",
			"Good Luck completing my Second quest",
		},
		["During"] = {
			"Return when you complete the quest!"
		},
		["Finish"] = {
			"Good job!",
			"Bro, You have complated the second quest",
			"Here is your reward!",
		}
	},
	
	Rewards = {
		{
			Type = "Currency",
			Name = "Honey",
			Amount = 450,
		},
		{
			Type = "Item",
			Name = "Strawberry",
			Amount = 15,
		},
	}
}