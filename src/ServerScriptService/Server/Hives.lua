local Remotes = game.ReplicatedStorage.Remotes
local Data = require(game.ServerScriptService.Server.Data)
local Items = require(game.ReplicatedStorage.Modules.Items)

local Utils = require(game.ReplicatedStorage.Modules.Utils)
local GetRealStats = require(game.ServerScriptService.Functions.GetRealStats)
local egs = require(game.ReplicatedStorage.Modules.Eggs).Eggs
--local badges = require(game.ReplicatedStorage.Modules.Badges).Badges
local LHivesManager = require(game.ReplicatedStorage.Modules.HivesManager)
local SHivesManager = require(game.ServerScriptService.Modules.HivesManager)
local TS = game:GetService("TweenService")

local function CheckMagnitude(Client, Platform)
	if (Platform.Position-Client.Character:GetPrimaryPartCFrame().Position).Magnitude <= 15 then
		return true
	end
	return false
end

local function RandomBee(Item)
	local Data = egs[Item]
	local TotalWeight = 0

	for i,v in pairs(Data) do
		TotalWeight += v.Rarity
	end
	local Chance = math.random(1, TotalWeight)
	local coun = 0
	for i,v in pairs(Data) do
		coun += v.Rarity
		if coun >= Chance then
			return v
		end
	end
end

local function HaveExBee(Bee, Bees)
	for i,v in pairs(Bees) do
		if v.BeeName == Bee then
			return true
		end
	end
end

local HiveDebs = {}

_G.Hives = {}
local Hives = {}
Hives.__index = Hives

--local function AutoRoll(Item, Args)
--	local bee = ""
--	local used = 0
--	local limit = Args.Limit
--	local BeeModule
--	while true do
--		if used < limit then
--			used += 1
--			bee = RandomBee(Item)
--			BeeModule = require(game.ReplicatedStorage.Bees[bee.Name])
--			if BeeModule.Rarity == Args.Rarity or BeeModule.Rarity == "Mythic" then
--				break
--			end
--		elseif used >= limit then
--			bee = RandomBee(Item)
--			break
--		end
--	end
--	return {bee, used}
--end

_G.Hives.CreateBeeSlot = function(Player, Item, Slot)
	local PData = Data:Get(Player)
	if Slot.Parent.Parent.Owner.Value == Player.Name then
		if PData.Inventory[Item] >= 1 then
			local ChoosedBee = RandomBee(Item)
			local AutoRollResult
			local Used = 1
			
			if PData.TotalBees == 0 then
				if Item == "Diamond Egg" or Item == "Mythic Egg" then
					ChoosedBee = RandomBee(Item)
				else
					ChoosedBee = RandomBee("Golden Egg")
				end
				if not game:GetService("BadgeService"):UserHasBadge(Player.UserId, 2140826477834613) then
					game:GetService("BadgeService"):AwardBadge(Player.UserId, 2140826477834613)
				end
			end
			local Old_BeeModule
			local Old_Bee
			local Old_Gifted

			local New_Bee
			local New_UI

			local Gifted = false
			local BeeModule = require(game.ReplicatedStorage.Bees[ChoosedBee.Name])
			if BeeModule.Rarity == "Limited" then
				if HaveExBee(ChoosedBee.Name, PData.Bees) then
					ChoosedBee = RandomBee("Basic Egg")
					PData.Inventory[Item] = 0
				end
			end
			if Slot.BeeN.Value ~= "" then
				Old_BeeModule = require(game.ReplicatedStorage.Bees[Slot.BeeN.Value])
				Old_Bee = Slot.BeeN.Value
				Old_Gifted = false
				workspace.PlayersE[Player.Name].Bees[Slot.Name]:Destroy()
				if Old_BeeModule.Rarity == "Limited" then
					PData.Inventory[Old_BeeModule.Name.." Bee Egg"] = 1
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", Old_BeeModule.Name.." Bee Egg", 1})
				end
			end

			if not Player.PlayerGui.UI:FindFirstChild("BeePopUp") then
				New_UI = false
			else
				New_UI = true
			end
			
			local GiftedChance = math.random(1,100)
			if PData.TotalBees == 0 then
				GiftedChance = math.random(1,25)
			end
			
			if string.find(Item, "Star") then
				Gifted = true
			else
				if GiftedChance == 1 then
					Gifted = true
				end
			end
			
			local Bee_Info = {
				ChoosedBee.Name,
				tonumber(Slot.Name),
				BeeModule.Energy,
				BeeModule.Attack + (5 * (PData.Bees[tonumber(Slot.Name)].Level / 100))
			}
			
			PData.Bees[tonumber(Slot.Name)].BeeName = ChoosedBee.Name
			PData.Bees[tonumber(Slot.Name)].Slot = tonumber(Slot.Name)
			PData.Bees[tonumber(Slot.Name)].ELimit = BeeModule.Energy
			PData.Bees[tonumber(Slot.Name)].Energy = BeeModule.Energy
			PData.Bees[tonumber(Slot.Name)].Attack = BeeModule.Attack + (5 * (PData.Bees[tonumber(Slot.Name)].Level / 100))
			
			SHivesManager.CreateSlot(Slot, ChoosedBee.Name, Player, Gifted, PData.Bees[tonumber(Slot.Name)], PData)
			LHivesManager.PopUp(Player, ChoosedBee.Name, Item, Gifted, Slot, New_UI, PData)
			
			GetRealStats.GetRealStats(Player, PData)
			
			PData.Inventory[Item] -= Used
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Bees", tonumber(Slot.Name), PData.Bees[tonumber(Slot.Name)]})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", Item, PData.Inventory[Item]})
		end
	else
		Player:Kick("Don't do that anymore.")
	end
end

_G.Hives.NewHive = function(Player, Hive)
	local PData = Data:Get(Player)
	local Deb = false
	if PData.Vars.Hive == "" and Hive.Owner.Value == "" and CheckMagnitude(Player, Hive.Pad.Circle) then
		if not Deb then
			Deb = true
			Hive.Owner.Value = Player.Name
			PData.Vars.Hive = Hive.Name
		

			--local Colors = {
			--	["Yellow"] = Color3.fromRGB(245, 205, 48),
			--	["White"] = Color3.fromRGB(255, 255, 255),
			--	["Pink"] = Color3.fromRGB(215, 164, 245),
			--	["Red"] = Color3.fromRGB(245, 104, 104),
			--	["Blue"] = Color3.fromRGB(135, 192, 245),
			--	["Black"] = Color3.fromRGB(81, 81, 81),
			--}
			
			--workspace.Hives[PData.Vars.Hive].Pilar.Color = Colors[PData.Hive.Color]
			--workspace.Hives[PData.Vars.Hive].Pad.Bottom.Color = Colors[PData.Hive.Color]
			Remotes.Boost:Fire(Player, "Blue Boost", 1)
			Remotes.Boost:Fire(Player, "Red Boost", 1)
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Vars", "Hive", PData.Vars.Hive})
			if not game:GetService("BadgeService"):UserHasBadge(Player.UserId, 2153658736) then
				game:GetService("BadgeService"):AwardBadge(Player.UserId, 2153658736)
			end
			GetRealStats.GetRealStats(Player, PData)
			
			Hive.Pad.Circle.Gui.TextLabel2.Text = "@"..Player.Name
			Hive.Pad.Circle.Gui.TextLabel2.TextLabel2.Text = "@"..Player.Name
			
			Hive.Pad.Circle.Gui.TextLabel1.Text = Player.DisplayName
			Hive.Pad.Circle.Gui.TextLabel1.TextLabel1.Text = Player.DisplayName

			Hive.Display.Gui.TextLabel1.Text = Player.Name
			Hive.Display.Transparency = 0
			Hive.FF.Transparency = 0
			
			Hive.Pad.Bottom.Transparency = 0
			Hive.Pad.FF2.Transparency = 1
			
			if PData.TotalBees == 0 then
				if PData.Inventory["Basic Egg"] <= 0 then
					PData.Inventory["Basic Egg"] = 1
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
				end
			end
			local needsslots = PData.IStats.TotalSlots - 5
			local nowslot = 5
			if needsslots >= 1 then
				for i = 1, needsslots do
					SHivesManager.NewSlot(PData, nowslot)
					needsslots -= 1
					nowslot += 1
				end
			end
			SHivesManager.GetSlots(Player)
		end
	end
end

return Hives