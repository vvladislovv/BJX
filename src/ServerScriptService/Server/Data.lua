local Data = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local Items = require(Modules.Items)

Data.PlayerData = {}

function Data.new(Player)
	local PData = {}
	PData.Vars = {
		Making = false,
		CollectingBees = true,
		Hive = "",
		
		Field = "",
		LastField = "",
		
		Attack = false,
		Status = "Player",
		
		
		PlaytimeOnServer = 0,
		PlacedHydrants = 0,
		HP = 100,
		Tokens = {}
	}
	
	PData.IStats = {
		["Basic Egg"] = 1000,
		["Hive Slot"] = 1000,
		["Bee Jar"] = 10000,
		
		Premium = false,
		Banned = false,
		RobuxDonated = 0,
		
		Playtime = 0,
		Hours = 0,
		
		TotalBJPoints = 0,
		Pollen = 0,
		Honey = 0,
		Capacity = 20000,
		
		ObtainedBees = 0,
		TotalSlots = 5,
		
		LastDN = "",
		
		Rank = "OWNER",
		
		Level = 1,
		RobuxPurchases = {
			
		}
	}
	
	PData.DiscoveredBees = {}
	PData.Equipment = {
		Tool = "Scooper",
		Tools = {["Scooper"] = true},
		
		Bag = "Pouch",
		Bags = {["Pouch"] = true},
		
		Hat = "",
		Hats = {},
		
		Boot = "",
		Boots = {},
	}
	
	PData.Daily = {
		Honey = 0
	}
	
	PData.Bees = {}
	for Slot = 1, 50 do
		PData.Bees[Slot] = {
			Properties = {
				PollenX = 1,
				MoveX = 1,
			},
			Attack = 0, BeeName = "", Slot = 0, ELimit = 0, Energy = 0, Gifted = false, Bond = 0, Level = 1
		}
	end
	
	PData.AllStats = {
		--Pollen
		["Red Pollen"] = 100,
		["Blue Pollen"] = 100,
		["White Pollen"] = 100,
		["Pollen"] = 100,
		["Honey Bonus"] = 100,
		["Pollen From Tools"] = 100,
		["Pollen From Bees"] = 100,
		--Instant
		["Instant"] = 0,
		["Red Instant"] = 0,
		["Blue Instant"] = 0,
		["White Instant"] = 0,
		--Boots
		["Movement Collection"] = 0,
		--Crit
		["Critical Chance"] = 0,
		["Critical Power"] = 100,
		--Bees
		["Attack"] = 100,
		["Bee's Attack"] = 0,
		["Red Bee's Attack"] = 0,
		["Colorless Bee's Attack"] = 0,
		["Blue Bee's Attack"] = 0,
		["Convert Rate"] = 100,
		["Bee Movespeed"] = 100,
		["Total Converts"] = 0,
		["Convert Amount"] = 0,
		["Ability Rate"] = 100,
		--Misc
		["Capacity"] = 100,
		["Caramel"] = 100,
		["Tools Speed"] = 100,
		["Honey From Tokens"] = 100,
		["Loot Luck"] = 100,
		["Flame Duration"] = 100,
		["Pollen From Bubbles"] = 100,
		["Pollen From Flames"] = 100,
		["Pollen From Totems"] = 100,
		--Bombs
		["Glitch"] = 100,
		["Bomb Pollen"] = 100,
		["White Bomb Pollen"] = 100,
		["Blue Bomb Pollen"] = 100,
		["Red Bomb Pollen"] = 100,

		["Bomb Instant"] = 0,
		["White Bomb Instant"] = 0,
		["Blue Bomb Instant"] = 0,
		["Red Bomb Instant"] = 0,

		-- Character
		["Player Movespeed"] = 100,
		["Jump Power"] = 100,
		["Health"] = 100,

		--Fields
		["Daisy"] = 100,
		["Blue Flowers"] = 100,
		["Red Flowers"] = 100,
		["Strawberry"] = 100,
		["Lemon"] = 100,
		["Cabbage"] = 100,
		["Pine Tree"] = 100,
		["Clover"] = 100,
		["Rose"] = 100,
		["Tomato"] = 100,
		["Fungus"] = 100,
		["Cattail"] = 100,
		--["Mountain Top"] = 100,
		--["Clover"] = 100,
		--["Stump"] = 100,
		--["Pear"] = 100,
		--["Tomato"] = 100,
	}

	PData.Badges = {
		["Honey"] = {
			Tier = 1,
			Amount = 0,
		},
		["Battle"] = {
			Tier = 1,
			Amount = 0,
		},
		["Quests"] = {
			Tier = 1,
			Amount = 0,
		},
		["Total BJ-Points"] = {
			Tier = 1,
			Amount = 0,
		},
		["Playtime"] = {
			Tier = 1,
			Amount = 0,
		},
		["Caramel"] = {
			Tier = 1,
			Amount = 0,
		},
	}
	for _, Field in pairs(workspace.FieldZones:GetChildren()) do
		PData.Badges[Field.Name.." Field"] = {
			Tier = 1,
			Amount = 0,
		}
	end
	
	PData.Options = {
		["Music"] = true,
		["Pollen Text"] = true,
		["Hide Other Bees"] = false,
	}
	
	PData.Quests = {}
	for i, v in Modules.Quests:GetChildren() do
		PData.Quests[v.Name] = {
			Claimed = false,
			Tasks = {},
			Quest = 1,
			Completed = false,
		}
	end
	
	PData.Inventory = {}
	for i,v in pairs(Items.Eggs) do
		PData.Inventory[i] = 999
	end
	PData.Inventory["Basic Egg"] = 1
	PData.Boosts = {}
	PData.Codes = {}
	PData.Cooldowns = {}
	
	-- admin stats fro test
	if RunService:IsStudio() then
		PData.Inventory["Seed"] = 9
		PData.IStats.Honey = 999999
		PData.Equipment.Tool = "Caramel Hammer"
		PData.Equipment.Bag = "Bubble Bag"
	end

	Data.PlayerData[Player.Name] = PData
	return PData
end

function Data:Get(Player)
	if game:GetService("RunService"):IsServer() then
		return Data.PlayerData[Player.Name]
	else
		return Remotes.GetPlayerData:InvokeServer()
	end
end

local AutoSaves = {}

local MainKey = 'BJX_M_Ver_TestRelm1'
local ClientKey = 'BJX_C_Ver_TestRelm1'

local DataStore2 = require(game.ServerScriptService.DataStore2)

function LoadData(Client)
	DataStore2.Combine(MainKey, ClientKey)
	local PData = Data.new(Client)
	Data.PlayerData[Client.Name] = PData
	local DataStorage = DataStore2(ClientKey, Client):GetTable(PData)
	PData = GetDataFromDataStorage(Client, DataStorage)
	print(PData)
	AutoSaves[Client.Name] = Client
end

function SaveData(client, PData)
	DataStore2(ClientKey, client):Set(PData)
end

function GetDataFromDataStorage(Client, DataStorage)
	local PData = Data:Get(Client)
	for i,v in pairs(DataStorage.DiscoveredBees) do
		PData.DiscoveredBees[i] = DataStorage.DiscoveredBees[i]
	end
	
	for i,v in pairs(DataStorage.Equipment) do
		PData.Equipment[i] = DataStorage.Equipment[i]
	end
	
	for i,v in pairs(DataStorage.Bees) do
		PData.Bees[i] = DataStorage.Bees[i]
	end

	for i,v in pairs(DataStorage.AllStats) do
		PData.AllStats[i] = DataStorage.AllStats[i]
	end
	
	for i,v in pairs(DataStorage.Badges) do
		PData.Badges[i] = DataStorage.Badges[i]
	end

	for i,v in pairs(DataStorage.Codes) do
		PData.Codes[i] = DataStorage.Codes[i]
	end
	
	for i,v in pairs(DataStorage.Cooldowns) do
		PData.Cooldowns[i] = DataStorage.Cooldowns[i]
	end
	
	for i,v in pairs(DataStorage.IStats) do
		PData.IStats[i] = DataStorage.IStats[i]
	end
	
	for i,v in pairs(DataStorage.Daily) do
		PData.Daily[i] = DataStorage.Daily[i]
	end

	for i,v in pairs(DataStorage.Boosts) do
		PData.Boosts[i] = DataStorage.Boosts[i]
	end

	for i,v in pairs(DataStorage.Inventory) do
		PData.Inventory[i] = DataStorage.Inventory[i]
	end

	for i,v in pairs(DataStorage.Options) do
		PData.Options[i] = DataStorage.Options[i]
	end
	
	for i, v in DataStorage.Quests do
		PData.Quests[i] = DataStorage.Quests[i]
	end
end

do
	Players.PlayerAdded:Connect(LoadData)
	Players.PlayerRemoving:Connect(function(Client)
		SaveData(Client, Data:Get(Client))
		AutoSaves[Client.Name] = nil
	end)
	--Players.PlayerRemoving:Connect(function(Client) SaveData(Client, Data:Get(Client)) AutoSaves[Client.Name] = nil end)

	game.ReplicatedStorage.Remotes.GetPlayerData.OnServerInvoke = function(client)
		local PData = Data:Get(client)
		return PData
	end
end

local TotalDelta = 0
spawn(function()
	while wait(2) do
		for _, Player in pairs(AutoSaves) do
			local PData = Data:Get(Player)
			SaveData(Player, PData)
		end
	end
end)

return Data