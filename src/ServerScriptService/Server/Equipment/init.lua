local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local PhysService = game:GetService("PhysicsService")
local PlayerGroup = PhysService:RegisterCollisionGroup("p")
PhysService:CollisionGroupSetCollidable("p","p",false)
local Items = game.ServerScriptService:FindFirstChild("Assets")
local Assets = game.ServerStorage:FindFirstChild("Assets")
local Server = script.Parent
local Data = require(Server.Data)
local Utils = require(RS:FindFirstChild("Modules").Utils)
local GetStatsModule = require(Server.Parent.Functions.GetRealStats)
local bags = require(game.ReplicatedStorage.Modules.Equipment.Bags).Bags
local MarketPlace = game:GetService("MarketplaceService")
local TS = game:GetService("TweenService")
local Zone = require(game.ReplicatedStorage.Zone)
local FieldZones = game.Workspace.FieldZones

local Equipment = {}

function NoCollide(model)
	spawn(function()
		wait(1)
		model:WaitForChild("Humanoid")
		model:WaitForChild("HumanoidRootPart")
		model:WaitForChild("Head")
		for k,v in pairs(model:GetChildren()) do
			if v:IsA"BasePart" then
				PhysService:SetPartCollisionGroup(v,"p")
			end
		end
	end)
end

function GetGamepasses(Player, PData)
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 49998955) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Convert Rate Pass", 1)
	end
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 50000061) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Pollen from Bees Pass", 1)
	end
	if MarketPlace:UserOwnsGamePassAsync(Player.UserId, 50000000) then
		game.ReplicatedStorage.Remotes.Boost:Fire(Player, "x2 Pollen from Tools Pass", 1)
	end
end

function GetPermBoosts(Player, PData)
	local BearsWithBoost = {
		["Plush Bear"] = "Plush Boost",
		["Resin Bear"] = "Resin Aura",
		["Master Bear"] = "Master Boost",
	}

	for i,v in pairs(BearsWithBoost) do
		if PData.QuestsGivers[i].TotalQuests > 0 then
			PData.Boosts[v] = nil
			game.ReplicatedStorage.Remotes.Boost:Fire(Player, v, PData.QuestsGivers[i].TotalQuests)
		end
	end
end
local function PlatformDist(Hive, HRP)
	if (HRP.Position - Hive.Position).Magnitude <= 10 then
		return true
	else
		return false
	end
end

function Equipment.StartTimers(Player, PData)
	spawn(function()
		while Player do wait(0.95)
			PData.Badges.Playtime.Amount += 1
			PData.Vars.PlaytimeOnServer += 1

			if PData.AllStats.Health < 100 then
				PData.AllStats.Health += 1
				if PData.AllStats.Health > 100 then
					PData.AllStats.Health = 100
				end
				game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"AllStats", "Health", PData.AllStats["Health"]})
			end

			for i,v in pairs(PData.Cooldowns) do
				if v and v.Time then
					if v.Time - os.time() <= 0 then
						PData.Cooldowns[i] = nil
					end
				end
			end

			if PData.Boosts ~= {} then
				for i,v in pairs(PData.Boosts) do
					if v then
						if v.Time - os.time() <= 0 then
							PData.Boosts[v.BoostType] = nil
						end
					end
				end
			end

			if PData.Vars.Making and PData.Vars.Hive ~= "" and not PlatformDist(workspace.Hives[PData.Vars.Hive].Pad.Circle, Player.Character.HumanoidRootPart) then
				PData.Vars.Making = false
			end

			Player.Character.Humanoid.WalkSpeed = 24 * (PData.AllStats["Player Movespeed"] / 100)
			Player.Character.Humanoid.JumpHeight = 8.2 * (PData.AllStats["Jump Power"] / 100)

			GetStatsModule.GetRealStats(Player, PData)
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Boosts", PData.Boosts})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", PData.IStats})
			game.ReplicatedStorage:FindFirstChild("Remotes").DataUpdated:FireClient(Player, {"Vars", PData.Vars})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Badges", "Playtime", PData.Badges.Playtime})
		end
	end)
end

function Equipment.Load(Player, PData, Character)
	if not workspace.PlayersE:FindFirstChild(Player.Name) then
		local PlrE = Instance.new("Folder")
		PlrE.Name = Player.Name
		PlrE.Parent = workspace.PlayersE
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local TokensF = Instance.new("Folder")
		TokensF.Name = "Tokens"
		TokensF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local BeesF = Instance.new("Folder")
		BeesF.Name = "Bees"
		BeesF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local EEeesF = Instance.new("Folder")
		EEeesF.Name = "Effects"
		EEeesF.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
		local Totems = Instance.new("Folder")
		Totems.Name = "Totems"
		Totems.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	if workspace.PlayersE:FindFirstChild(Player.Name) then
		local PlayerHydrants = Instance.new("Folder")
		PlayerHydrants.Name = "Hydrants"
		PlayerHydrants.Parent = workspace.PlayersE:FindFirstChild(Player.Name)
	end

	Equipment:EquipItem(Player, "Bag")
	Equipment:EquipItem(Player, "Tool")

	if PData.Boosts ~= {} then
		for BoostName, Info in pairs(PData.Boosts) do
			if Info == BoostName then
				PData.Boosts[BoostName] = nil
			end
		end
	end

	--if PData.Equipment.Hydrant ~= "" then
	--	PData.Inventory["Hydrant Builder"] = 1
	--	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Inventory", PData.Inventory})
	--end

	--for _, Bee in pairs(PData.Bees) do
	--	if Bee.BeeName ~= "" then
	--		Bee.ELimit = math.round(require(game.ReplicatedStorage.Bees[Bee.BeeName]).Energy + (Bee.Level*Bee.Level/1.5))
	--	end
	--end

	for i,v in pairs(PData.Inventory) do
		if v < 0 then
			v = 0
		end
	end

	Character.Humanoid.WalkSpeed = 24 * (PData.AllStats["Player Movespeed"] / 100)
	Character.Humanoid.JumpHeight = 7.2 * (PData.AllStats["Jump Power"] / 100)
	game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Boosts", PData.Boosts})

	if PData.IStats.Banned then
		Player:Kick("Banned. Join our Discord Server and contact the developers.")
	end

	require(script.Parent.Parent.Functions.GetCapacity).GetCapacity(Player)
	GetGamepasses(Player, PData)
	NoCollide(Character)
	GetStatsModule.GetRealStats(Player, PData)
end

function Equipment:EquipItem(Player, Type)
	local PData = Data:Get(Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:WaitForChild("Humanoid")

	if PData.Equipment[Type] then
		local Item = PData.Equipment[Type]
		local ItemObject
		local ItemObject2

		if Item ~= "" then
			if Type == "Boot" then
				for i = 1, 2 do
					ItemObject = Items:WaitForChild(Type.."s")[Item .. (i == 1 and "L" or "R")]:Clone()
					Humanoid:AddAccessory(ItemObject)
					ItemObject.Name = Type
				end
			else
				ItemObject = Items:WaitForChild(Type.."s")[Item]:Clone()
				if ItemObject:IsA("Accessory") then
					Humanoid:AddAccessory(ItemObject)
					ItemObject.Name = Type

					if Type == "Bag" then
						Assets.BagScript:Clone().Parent = ItemObject
					end
				elseif ItemObject:IsA("Tool") then
					local CollectorScripts = Assets.CollectorScripts:Clone()
					CollectorScripts.Parent = ItemObject
					ItemObject.Parent = Character
					ItemObject.Name = "Tool"
				else
					ItemObject.Parent = Character
				end
			end
		end
	end
end



return Equipment