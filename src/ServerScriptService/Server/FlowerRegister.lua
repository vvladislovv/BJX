local module = {} do
	local Fields = require(script.Parent.GenerateFields)
	local Data = require(game.ServerScriptService.Server.Data)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ts = game:GetService("TweenService")
	local Modules = ReplicatedStorage.Modules
	local Items = require(Modules.Equipment.Collectors)
	local FieldZones = game.Workspace.FieldZones
	local Zone = require(game.ReplicatedStorage.Zone)
	local VisualEvent = game.ReplicatedStorage.Remotes.Visual
	local Tabs = {}
	
	
	game.Players.PlayerAdded:Connect(function(Player)
		Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}
	end)
	game.Players.PlayerRemoving:Connect(function(Player)
		Tabs[Player.Name] = nil
	end)

	local function GetRotation(Character)
		local Orientation = CFrame.Angles(0, math.rad(0), 0)
		if Character then
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
		local PData = Data:Get(Player)
		
		local Model = game.ServerStorage.Stamps[Args.Stamp]:Clone()
		Model.Parent = workspace.Stamps
		game.Debris:AddItem(Model, 1)
		
		local Crit = false
		local Crit_Chance = math.random(1,100)
		if Crit_Chance <= 8 then
			Crit = true
		end
		
		local FlowerRay = Ray.new(not Args.Position and Player.Character.PrimaryPart.Position or Args.Position, Vector3.new(0, -12, 0))
		local RayResult = workspace:FindPartOnRayWithWhitelist(FlowerRay, {workspace.Fields})
		
		if RayResult then
			if RayResult.Name == "Flower" then
				if Model:IsA("Model") then
					Model:SetPrimaryPartCFrame(CFrame.new(RayResult.Position + Vector3.new(0,3,0)) * GetRotation(Player.Character))
				else
					Model.CFrame = CFrame.new(RayResult.Position) * GetRotation(Player.Character)
				end
			end
		end
		
		if Model:IsA("Model") then
			for _, Object in pairs(Model:GetChildren()) do
				if Object.Name ~= "Root" then
					local FlowerRay2 = Ray.new(Object.Position, Vector3.new(0, -12, 0))
					local RayResult2 = workspace:FindPartOnRayWithWhitelist(FlowerRay2, {workspace.Fields})
					if RayResult2 and RayResult2.Name == "Flower" and PData.Vars.Field ~= "" then
						module:CollectFlower(Player, RayResult2, Args.StatsModule)
					end
				end
			end
		else
			local FlowerRay3 = Ray.new(Model.Position, Vector3.new(0, -12, 0))
			local RayResult3 = workspace:FindPartOnRayWithWhitelist(FlowerRay3, {workspace.Fields})
			if RayResult3 and RayResult3.Name == "Flower" and PData.Vars.Field ~= "" then
				module:CollectFlower(Player, RayResult3, Args.StatsModule)
			end
		end
	end

	function module:CollectFlower(Player, Flower: Part, StatsModule)
		local PData = Data:Get(Player)
		if PData.IStats.Pollen < PData.IStats.Capacity and PData.Vars.LastField ~= "" and (Flower.Position.Y - Fields.Flowers[Flower.FlowerID.Value].MinPosition) > 0.2 then
			local FlowerMod = Fields.Flowers[Flower.FlowerID.Value]
			local FieldName = PData.Vars.Field
			local FieldModel = workspace.FieldZones:FindFirstChild(FieldName)
			local Conversion = math.round(PData.AllStats[FlowerMod.Color.." Instant"] + PData.AllStats["Instant"])
			local Collected = StatsModule.Collecting
			local DecreaseAmount = StatsModule.Power
			local Caramel = 0
			local HoneyCollected = 0
			local PollenCollected = 0
			local BadgeType = PData.Vars.Field.." Field"
			local P_BadgeType = PData.Badges[BadgeType]
			
			--// Boosts
			if PData.Vars.LastField ~= "" then
				Collected *= PData.AllStats["Pollen"]/100
				Collected *= PData.AllStats[FlowerMod.Stat.Color.." Pollen"]/100
				Collected *= PData.AllStats[PData.Vars.LastField]/100
				if StatsModule.boot then
					Collected *= PData.AllStats["Movement Collection"]
				end
			end
			if FlowerMod.Stat.Color == StatsModule.Color then
				Collected *=  StatsModule.ColorMutltiplier
			end
			if StatsModule.DopX then
				Collected *= StatsModule.DopX
			end
			if StatsModule.Bee then
				Collected *= PData.AllStats["Pollen From Bees"]/100
			elseif StatsModule.Tool then
				Collected *= PData.AllStats["Pollen From Tools"]/100
			end
			--// Caramel
			if Flower:FindFirstChild("CaramelPart") then
				Caramel = math.round((Collected / 10) * (PData.AllStats["Caramel"] / 100))
				if Caramel <= 0 then
					Caramel = 1
				end
				HoneyCollected += Caramel
				PData.Badges["Caramel"].Amount += math.round(Caramel)
			end
			--// Flower Size
			if FlowerMod.Stat.Value == "2" then
				Collected *= 1.5
				if DecreaseAmount > 0 then
					DecreaseAmount /= 1.5
				end
			elseif FlowerMod.Stat.Value == "3" then
				Collected *= 2
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2
				end
			elseif FlowerMod.Stat.Value == "4" then
				Collected *= 2.5
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2.5
				end
			end
			--// Debs
			if Conversion > 100 then
				Conversion = 100
			end
			local Convert = math.round(Collected * (Conversion / 100))
			if PollenCollected < 0 then
				PollenCollected = 0
			elseif Convert < 0 then
				Convert = 0
			end
			
			
			HoneyCollected += Convert
			PollenCollected += math.round(Collected - Convert)
			local NewPos = Flower.Position - Vector3.new(0,DecreaseAmount,0)
			game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Flower, NewPos)
			Flower:WaitForChild("TopTexture").Transparency = (FlowerMod.MaxPosition-NewPos.Y)/2.5
			spawn(function()
				wait(0.22)
				Flower.Position = NewPos
			end)

			spawn(function()
				wait(0.005)
				if Tabs[Player.Name] then
					if PData.Options["Pollen Text"] then
						for i,v in pairs(Tabs[Player.Name]) do
							if v > 0 then
								VisualEvent:FireClient(Player, {Pos = Flower.Position + Vector3.new(0,6,0), Amount = v, Color = i, Crit = false})
							end
						end
					end
					--if PData.Quests2 ~= {} then
					--	QuestRoad(Player, PData, Tabs[Player.Name].White, Tabs[Player.Name].Blue, Tabs[Player.Name].Red, Tabs[Player.Name].Honey, Caramel)
					--end
					Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}
				end
			end)
			
			if (PData.IStats.Pollen + math.round(PollenCollected)) > PData.IStats.Capacity then
				PollenCollected = PData.IStats.Capacity - PData.IStats.Pollen
			end
			PData.IStats.Pollen += math.round(PollenCollected)
			PData.IStats.Honey += math.round(HoneyCollected)
			PData.Daily.Honey += math.round(HoneyCollected)
			if Tabs[Player.Name] then
				Tabs[Player.Name][FlowerMod.Stat.Color] += math.round(PollenCollected)
				Tabs[Player.Name].Honey += math.round(HoneyCollected)
			end

			if P_BadgeType and P_BadgeType.Tier then
				if P_BadgeType.Tier <= 5 then
					P_BadgeType.Amount += PollenCollected
					game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"Badges", BadgeType, P_BadgeType})
				end
			end
			
			_G.CompleteQuest(Player, "CollectPollen", {
				White = FlowerMod.Stat.Color == "White" and PollenCollected or 0,
				Blue = FlowerMod.Stat.Color == "Blue" and PollenCollected or 0,
				Red = FlowerMod.Stat.Color == "Red" and PollenCollected or 0,
				Field = PData.Vars.Field,
			})
			
			if FieldModel and FieldModel:FindFirstChild("Sprout") then
				FieldModel.Sprout.Hp.Value = math.max(FieldModel.Sprout.Hp.Value - (HoneyCollected + PollenCollected), 0)
			end

			--if workspace.Fields:FindFirstChild(PData.Vars.Field) and workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout") and workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout"):FindFirstChild("Grow") then
			--	workspace.FieldZones[PData.Vars.Field]:FindFirstChild("Sprout").Grow.Value += HoneyCollected + PollenCollected
			--end
			
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", "Honey", PData.IStats.Honey})
			game.ReplicatedStorage:WaitForChild("Remotes").DataUpdated:FireClient(Player, {"IStats", "Pollen", PData.IStats.Pollen})
		end
	end

	function module:RegisterField(Field: Instance)
		--local FieldInfo = Fields[Field.Name]
		local FieldInfo = Field.Name
		for _, Pollen: Part in pairs(Field:GetChildren()) do
			if Pollen:IsA("BasePart") then
				FieldInfo = Fields.Flowers[Pollen.FlowerID.Value]
				Pollen.Changed:Connect(function()
					if Pollen.Position.Y <= FieldInfo.MinPosition then
						game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Pollen, Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z))
						spawn(function()
							wait(0.25)
							Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z)
						end)
					end
				end)
			end
		end
		if FieldInfo then
			spawn(function()
				while Field do wait(math.random(2,7))
					for _, Pollen: Part in pairs(Field:GetChildren()) do
						if Pollen:IsA("BasePart") then
							FieldInfo = Fields.Flowers[Pollen.FlowerID.Value]
							if Pollen.Position.Y <= FieldInfo.MinPosition then
								game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Pollen, Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z))
								spawn(function()
									wait(0.25)
									Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MinPosition, Pollen.Position.Z)
								end)
							end
							if Pollen.Position.Y < FieldInfo.MaxPosition then
								local DistanceToMax = tonumber(FieldInfo.MaxPosition - Pollen.Position.Y)
								Pollen.TopTexture.Transparency = (FieldInfo.MaxPosition-Pollen.Position.Y)/2.5

								if DistanceToMax < FieldInfo.Regen then
									game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Pollen, Vector3.new(Pollen.Position.X, Pollen.Position.Y + DistanceToMax, Pollen.Position.Z))
									spawn(function()
										wait(0.25)
										Pollen.Position = Vector3.new(Pollen.Position.X, Pollen.Position.Y + DistanceToMax, Pollen.Position.Z)
									end)
								else
									game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Pollen, Vector3.new(Pollen.Position.X, Pollen.Position.Y + FieldInfo.Regen, Pollen.Position.Z))
									spawn(function()
										wait(0.25)
										Pollen.Position = Vector3.new(Pollen.Position.X, Pollen.Position.Y + FieldInfo.Regen, Pollen.Position.Z)
									end)
								end
								if Pollen.Position.Y > FieldInfo.MaxPosition then
									game.ReplicatedStorage.Remotes.VisualRemotes.FlowerUpd:FireAllClients(Pollen, Vector3.new(Pollen.Position.X, FieldInfo.MaxPosition, Pollen.Position.Z))
									spawn(function()
										wait(0.25)
										Pollen.Position = Vector3.new(Pollen.Position.X, FieldInfo.MaxPosition, Pollen.Position.Z)
									end)
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
		spawn(function()
			module:RegisterField(Field)
		end)
	end
end

return module
