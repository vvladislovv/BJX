local module = {} do
	local Fields = require(script.Parent.GenerateFields)
	local Data = require(game.ServerScriptService.Server.Data)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ts = game:GetService("TweenService")
	local Modules = ReplicatedStorage.Modules
	local Items = require(Modules.Equipment.Collectors)
	local FieldZones = game.Workspace.FieldZones
	local Zone = require(game.ServerScriptService.Zone)

	local VisualEvent = game.ReplicatedStorage.Remotes.Visual
	
	function RToken(Field)
		local Data = Items.FieldsDrop[Field]
		local TotalWeight = 0

		for i,v in pairs(Data) do
			TotalWeight += v.Rarity
		end
		local Chance = math.random(1, TotalWeight)
		local coun = 0
		for i,v in pairs(Data) do
			coun += v.Rarity
			if coun >= Chance then
				return v.Name
			end
		end
	end
	
	local TokensM = require(game.ServerScriptService.Modules.TokensManager)
	function QuestRoad(Client, PData, White, Blue, Red, Honey, Caramel)
		local playerField = PData.Vars.Field
		for ty, NPC in pairs(PData.Quests2) do
			for i, Task in pairs(NPC) do
				if Task.Type == "FieldPollen" then
					if playerField == Task.Field then
						if Task.Color then
							if Task.Color == "White" then
								NPC[i].StartAmount += White
							elseif Task.Color == "Blue" then
								NPC[i].StartAmount += Blue
							elseif Task.Color == "Red" then
								NPC[i].StartAmount += Red
							end
							if NPC[i].StartAmount >= NPC[i].NeedAmount then
								NPC[i].StartAmount = NPC[i].NeedAmount
							end
							game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
						else
							NPC[i].StartAmount += (White + Blue + Red)
							if NPC[i].StartAmount >= NPC[i].NeedAmount then
								NPC[i].StartAmount = NPC[i].NeedAmount
							end
							game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
						end
					end
				end

				if Task.Type == "PollenColor" then
					if Task.NColor == "Red" then
						NPC[i].StartAmount += Red
					elseif Task.NColor == "White" then
						NPC[i].StartAmount += White
					elseif Task.NColor == "Blue" then
						NPC[i].StartAmount += Blue
					end
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
				end

				if Task.Type == "AnyPollen" then
					NPC[i].StartAmount += (White + Blue + Red)
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
				end

				if Task.Type == "AnyCaramel" then
					NPC[i].StartAmount += Caramel
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
				end

				if Task.Type == "CaramelField" then
					if PData.Vars.Field == Task.Field then
						NPC[i].StartAmount += Caramel
						if NPC[i].StartAmount >= NPC[i].NeedAmount then
							NPC[i].StartAmount = NPC[i].NeedAmount
						end
					end
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
				end

				if Task.Type == "CaramelColor" then
					if Task.NColor == "White" then
						if Caramel > 0 then
							NPC[i].StartAmount += Caramel
						end
					elseif Task.NColor == "Red" then
						if Caramel > 0 then
							NPC[i].StartAmount += Caramel
						end
					elseif Task.NColor == "Blue" then
						if Caramel > 0 then
							NPC[i].StartAmount += Caramel
						end
					end
					if NPC[i].StartAmount >= NPC[i].NeedAmount then
						NPC[i].StartAmount = NPC[i].NeedAmount
					end
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Client, {"Quests2", ty, PData.Quests2[ty]})
				end

			end
		end
	end
	local Tabs = {}

	game.Players.PlayerAdded:Connect(function(Player)
		Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}
	end)
	game.Players.PlayerRemoving:Connect(function(Player)
		Tabs[Player.Name] = nil
	end)
	-- БЕЙДЖИ ПОЛЕЙ
	local badgeModule = require(game.ReplicatedStorage.Modules.Badges)
	
	local function GetRotation(Character)
		local Orientation = CFrame.Angles(0, math.rad(0), 0)
		if(Character ~= nil) then
			local HOrient = Character.PrimaryPart.Orientation

			if HOrient.Magnitude >= 50 and HOrient.Magnitude < 110 then
				Orientation = CFrame.Angles(0, math.rad(90), 0)
			end

			if HOrient.Magnitude > -90 and HOrient.Magnitude < 90 then
				Orientation = CFrame.Angles(0, math.rad(-90), 0)
			end

			if HOrient.Magnitude > 0 and HOrient.Magnitude < 50 then
				Orientation = CFrame.Angles(0, math.rad(-180), 0)
			end

			if HOrient.Magnitude <= 110 and HOrient.Magnitude >= 180 then
				Orientation = CFrame.Angles(0, math.rad(0), 0)
			end

			if HOrient.Magnitude > 110 and HOrient.Magnitude < 180 then
				Orientation = CFrame.Angles(0, math.rad(0), 0)
			end
		end
		return Orientation
	end

	function lookAt(target, eye)
		local forwardVector = (eye - target).Unit
		local upVector = Vector3.new(0, 1, 0)
		local rightVector = forwardVector:Cross(upVector)
		local upVector2 = rightVector:Cross(forwardVector)
		return CFrame.fromMatrix(eye, rightVector, upVector2)
	end
	
	function module:CollectPatches(Player, Args)
		local Model = game.ServerStorage.Stamps[Args.Stamp]:Clone()
		Model.Parent = workspace.Stamps
		local PData = Data:Get(Player)
		local CheckPart = Instance.new("Part")
		CheckPart.Name = "Hit"
		CheckPart.Size = Vector3.new(0.1,0.1,0.1)
		CheckPart.Anchored = false
		CheckPart.CanCollide = false
		CheckPart.Massless = true
		CheckPart.Transparency = 0
		CheckPart.Parent = Args.RootPart
		if Args.RootPart.Position then
			CheckPart.Position = Args.RootPart.Position
		end

		local Crit = false
		local Crit_Chance = math.random(1,100)
		if Crit_Chance <= 8 then
			Crit = true
		end

		CheckPart.Touched:Connect(function(part)
			if part.Name == "Flower" then
				spawn(function()
					if Model:IsA("Model") then
						for _, Object in pairs(Model:GetChildren()) do
							Object.Anchored = false
						end
						Model:SetPrimaryPartCFrame(CFrame.new(part.Position) * GetRotation(Player.Character))

						wait(0.1)

						for _, Object in pairs(Model:GetChildren()) do
							Object.Anchored = true
						end

						wait(0.1)
						pcall(function()
							Model:SetPrimaryPartCFrame(CFrame.new(Args.RootPart.Position))
						end)
					else
						Model.CFrame = CFrame.new(part.Position) * GetRotation(Player.Character)
					end
				end)
			end
		end)

		CheckPart.Position = CheckPart.Position + Vector3.new(0,-2.48,0)
		wait()
		CheckPart:Destroy()

		local Weld = Instance.new("WeldConstraint", CheckPart)
		Weld.Part0 = Args.RootPart
		Weld.Part1 = CheckPart

		if Model:IsA("Model") then
			for _, Object in pairs(Model:GetChildren()) do
				if Object.Name ~= "Root" then
					Object.Touched:Connect(function(Object)
						if Object.Name == "Flower" and PData.Vars.Field ~= "" then
							module:CollectFlower(Player, Object, Args.StatsModule)
						end
					end)
				end
			end
		else
			Model.Touched:Connect(function(Object)
				if Object.Name == "Flower" and PData.Vars.Field ~= "" then
					module:CollectFlower(Player, Object, Args.StatsModule)
				end
			end)
		end

		spawn(function()
			wait(1)
			Model:Destroy()
		end)
	end
	
	function module:CollectFlower(Player, Flower, StatsModule)
		local PData = Data:Get(Player)
		if Flower and PData and PData.Vars.Field ~= "" and (Flower.Position.Y - Fields.Flowers[Flower.FlowerID.Value].MinPosition) > 0.2 then
			local FlowerMod = Fields.Flowers[Flower.FlowerID.Value]
			local FieldName = PData.Vars.Field

			local Conversion = math.round(PData.AllStats[FlowerMod.Color.." Instant"] + PData.AllStats["Instant"])
			if Conversion > 100 then
				Conversion = 100
			end

			local Collected = StatsModule.Collecting
			local DecreaseAmount = StatsModule.Power

			local Caramel = 0
			local HoneyCollected = 0
			local PollenCollected = 0

			if PData.Vars.LastField ~= "" then
				Collected *= PData.AllStats["Pollen"]/100
				Collected *= PData.AllStats[FlowerMod.Color.." Pollen"]/100
				Collected *= PData.AllStats[PData.Vars.LastField]/100
				if StatsModule.boot then
					Collected *= PData.AllStats["Movement Collection"]
				end
			end

			if Flower:FindFirstChild("CaramelPart") then
				Caramel = math.round((Collected / 10) * (PData.AllStats["Caramel"] / 100))
				if Caramel <= 0 then
					Caramel = 1
				end
				HoneyCollected += Caramel
				--for i,v in pairs(PData.Results) do
				--	v.Caramel += math.round(Caramel)
				--end
				PData.Badges["Caramel"].Amount += math.round(Caramel)
			end
			if FlowerMod.Color == StatsModule.Color then
				Collected *=  StatsModule.ColorMutltiplier
			end
			
			if FlowerMod.Stat == "2" then
				if DecreaseAmount > 0 then
					DecreaseAmount /= 1.5
				end
			elseif FlowerMod.Stat == "3" then
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2
				end
			elseif FlowerMod.Stat == "4" then
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2.5
				end
			end
			
			local Convert = math.round(Collected * (Conversion / 100))
			if PollenCollected < 0 then
				PollenCollected = 0
			elseif Convert < 0 then
				Convert = 0
			end
			HoneyCollected += Convert
			PollenCollected += math.round(Collected - Convert)

			--local FieldGrant = math.random(1,10000)
			--if FieldGrant <= 10 then
			--	if Items.FieldsDrop[FieldName.." Field"] then
			--		local RandomToken = RToken(FieldName)
			--		TokensM.SpawnToken({
			--			Position = Flower.Position,
			--			Cooldown = 15,
			--			Token = {
			--				Item = RandomToken,
			--				Amount = 1,
			--				Type = "Drop",
			--			},
			--			Resourse = FieldName.." Field",
			--		})
			--	end
			--end
			
			ts:Create(Flower, TweenInfo.new(0.22), {Position = Flower.Position - Vector3.new(0,DecreaseAmount,0)}):Play()
			--Flower.Position -= Vector3.new(0,DecreaseAmount,0)
			Flower.TopTexture.Transparency = (Fields.Flowers[Flower.FlowerID.Value].MaxPosition-Flower.Position.Y)/2.5

			
			if (PData.IStats.Pollen + math.round(PollenCollected)) > PData.IStats.Capacity then
				PollenCollected = PData.IStats.Capacity - PData.IStats.Pollen
			end
			if FlowerMod.Stat == "2" then
				PollenCollected *= 1.5
				HoneyCollected *= 1.5
			elseif FlowerMod.Stat == "3" then
				PollenCollected *= 2
				HoneyCollected *= 2
			elseif FlowerMod.Stat == "4" then
				PollenCollected *= 2.5
				HoneyCollected *= 2.5
			end
			PData.IStats.Pollen += math.round(PollenCollected)
			PData.IStats.Honey += math.round(HoneyCollected)
			if Tabs[Player.Name] then
				Tabs[Player.Name][FlowerMod.Color] += math.round(PollenCollected)
				Tabs[Player.Name].Honey += math.round(HoneyCollected)
			end
			spawn(function()
				wait(0.005)
				if Tabs[Player.Name] then
					for i,v in pairs(Tabs[Player.Name]) do
						if v > 0 then
							VisualEvent:FireClient(Player, {Pos = Flower.Position + Vector3.new(0,6,0), Amount = v, Color = i, Crit = false})
						end
					end
					QuestRoad(Player, PData, Tabs[Player.Name].White, Tabs[Player.Name].Blue, Tabs[Player.Name].Red, Tabs[Player.Name].Honey, Caramel)
					Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}
				end
			end)
			

			local BadgeType = PData.Vars.Field.." Field"
			local P_BadgeType = PData.Badges[BadgeType]
			if P_BadgeType and P_BadgeType.Tier then
				if(P_BadgeType.Tier <= 5) then
					P_BadgeType.Amount += PollenCollected
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Badges", BadgeType, P_BadgeType})
				end
			end
			
			if workspace.Fields:FindFirstChild(PData.Vars.Field) and workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout") and workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout"):FindFirstChild("Grow") then
				workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout").Grow.Value += HoneyCollected + PollenCollected
			end
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", "Honey", PData.IStats.Honey})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", "Pollen", PData.IStats.Pollen})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Badges", PData.Badges})
		end
	end
	
	function module:RegisterField(Field: Instance)
		--local FieldInfo = Fields[Field.Name]
		local FieldInfo = Field.Name
		for _, Pollen in pairs(Field:GetChildren()) do
			if Pollen:IsA("BasePart") then
				FieldInfo = Fields.Flowers[Pollen.FlowerID.Value]
				Pollen.Changed:Connect(function()
					if Pollen.Position.Y <= FieldInfo.MinPosition then
						Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z)
					end
				end)
			end
		end
		if FieldInfo then
			spawn(function()
				while Field do wait(5)
					for _, Pollen in pairs(Field:GetChildren()) do
						if Pollen:IsA("BasePart") then
							FieldInfo = Fields.Flowers[Pollen.FlowerID.Value]
							if Pollen.Position.Y <= FieldInfo.MinPosition then
								Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z)
							end
							if Pollen.Position.Y < FieldInfo.MaxPosition then
								local DistanceToMax = tonumber(FieldInfo.MaxPosition - Pollen.Position.Y)
								Pollen.TopTexture.Transparency = (Fields.Flowers[Pollen.FlowerID.Value].MaxPosition-Pollen.Position.Y)/2.5

								if DistanceToMax < FieldInfo.Regen then
									Pollen.Position += Vector3.new(0, DistanceToMax, 0)
								else
									Pollen.Position += Vector3.new(0, FieldInfo.Regen, 0)
								end
								if Pollen.Position.Y > FieldInfo.MaxPosition then
									Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MaxPosition, Pollen.Position.Z)
								end
							end
						end
					end
				end
			end)
		else
			print("не фиелд инфо")
		end
	end
	wait(0.05)
	for _, Field in pairs(workspace.Fields:GetChildren()) do
		module:RegisterField(Field)
	end
end

return module
