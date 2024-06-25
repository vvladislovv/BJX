
local module = {}

module.Badges = {
	["Honey"] = {
		Layout = 1,
		BuffType = "Convert Rate",
		Req = "Honey",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 10,
			BuffType = "Percent",
			BadgeID = 3064356994167661,
			Needs = 500000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 20,
			BuffType = "Percent",
			BadgeID = 391599203589841,
			Needs = 10000000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 40,
			BuffType = "Percent",
			BadgeID = 1056797408813702,
			Needs = 500000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 100,
			BuffType = "Percent",
			BadgeID = 1715983670979815,
			Needs = 10000000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 200,
			BuffType = "Percent",
			BadgeID = 1368685580097046,
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			BadgeID = 3239320328337947,
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Battle"] = {
		Layout = 2,
		BuffType = "Attack",
		Req = "Battle Points",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 100,
			Reward = {"Spike", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 20,
			BuffType = "Percent",
			Needs = 1000,
			Reward = {"Spike", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 30,
			BuffType = "Percent",
			Needs = 10000,
			Reward = {"Spike", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 40,
			BuffType = "Percent",
			Needs = 500000,
			Reward = {"Spike", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 75,
			BuffType = "Percent",
			Needs = 10000000,
			Reward = {"Spike", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Spike", 1},
		},
	},

	["Quests"] = {
		Layout = 2.2,
		BuffType = "Capacity",
		Req = "Completed Quests",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 5,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 20,
			BuffType = "Percent",
			Needs = 50,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 30,
			BuffType = "Percent",
			Needs = 500,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 40,
			BuffType = "Percent",
			Needs = 5000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 75,
			BuffType = "Percent",
			Needs = 10000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Playtime"] = {
		Layout = 3,
		BuffType = "Bee Movespeed",
		Req = "Playtime",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 3,
			BuffType = "Percent",
			Needs = 3600,
			Vis = "1 Hour",
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 6,
			BuffType = "Percent",
			Needs = 86400,
			Vis = "1 Day",
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 9,
			BuffType = "Percent",
			Vis = "7 Days",
			Needs = 604800,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 12,
			BuffType = "Percent",
			Vis = "1 Month",
			Needs = 2592000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 15,
			BuffType = "Percent",
			Vis = "3 Month",
			Needs = 15552000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Vis = "999 years",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Caramel"] = {
		Layout = 3.2,
		BuffType = "Caramel",
		Req = "Caramel",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 500000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 35,
			BuffType = "Percent",
			Needs = 10000000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 60,
			BuffType = "Percent",
			Needs = 100000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 90,
			BuffType = "Percent",
			Needs = 5000000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 150,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Daisy Field"] = {
		Layout = 4,
		BuffType = "White Pollen",
		Req = "Daisy Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 5,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 25,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 30,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Sunflower Field"] = {
		Layout = 5,
		BuffType = "White Instant",
		Req = "Sunflower Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 1,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 2,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 4,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 7,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Blue Flowers Field"] = {
		Layout = 7,
		BuffType = "Blue Pollen",
		Req = "Blue Flowers Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 5,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 25,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 30,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Clover Field"] = {
		Layout = 8,
		BuffType = "Pollen",
		Req = "Clover Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 4,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 8,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 12,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 16,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 25,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Strawberry Field"] = {
		Layout = 9,
		BuffType = "Red Pollen",
		Req = "Strawberry Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 5,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 25,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 30,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Pine Tree Field"] = {
		Layout = 11,
		BuffType = "Blue Instant",
		Req = "Pine Tree Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 1,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 2,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 4,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 7,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Cattail Field"] = {
		Layout = 13,
		BuffType = "Blue Bomb Instant",
		Req = "Cattail Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 3,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 6,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 9,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 12,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Red Flowers Field"] = {
		Layout = 14,
		BuffType = "Red Bomb Instant",
		Req = "Red Flowers Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 3,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 6,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 9,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 12,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 15,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},

	["Dandelion Field"] = {
		Layout = 15,
		BuffType = "Instant",
		Req = "Dandelion Field Pollen",
		[1] = {
			TierName = "Bronze",
			BuffAmount = 2,
			BuffType = "Percent",
			Needs = 250000,
			Reward = {"Ticket", 5},
		},

		[2] = {
			TierName = "Silver",
			BuffAmount = 4,
			BuffType = "Percent",
			Needs = 2500000,
			Reward = {"Ticket", 10},
		},

		[3] = {
			TierName = "Golden",
			BuffAmount = 6,
			BuffType = "Percent",
			Needs = 25000000,
			Reward = {"Ticket", 15},
		},

		[4] = {
			TierName = "Diamond",
			BuffAmount = 8,
			BuffType = "Percent",
			Needs = 500000000,
			Reward = {"Ticket", 25},
		},

		[5] = {
			TierName = "Platinum",
			BuffAmount = 10,
			BuffType = "Percent",
			Needs = 100000000000,
			Reward = {"Ticket", 40},
		},

		[6] = {
			TierName = "Californium",
			BuffAmount = 0,
			BuffType = "Percent",
			Needs = math.huge,
			Reward = {"Ticket", 1},
		},
	},
}

module.BadgesColors = {
	[1] = Color3.fromRGB(255, 203, 179),
	[2] = Color3.fromRGB(192, 217, 230),
	[3] = Color3.fromRGB(255, 222, 101),
	[4] = Color3.fromRGB(140, 243, 255),
	[5] = Color3.fromRGB(160, 255, 149),
	[6] = Color3.fromRGB(187, 205, 231),
	[7] = Color3.fromRGB(132, 130, 184),
}

return module
