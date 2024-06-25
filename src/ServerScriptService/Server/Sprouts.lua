local Sprouts = {}; do
	local Tokens = require(game.ServerScriptService.Functions.MakeToken)
	local TweenService = game:GetService("TweenService")
	local Stages = {75, 50, 25, 10}
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local HpMultipliers = { -- Zone = Multiplier
		["0"] = 1,
		["5"] = 1.25,
		["10"] = 1.5,
		["15"] = 2,
		["20"] = 2.5,
		["25"] = 3.5
	}
	local Chances = {
		["Classic"] = {
			["Classic"] = 100,
			["Rare"] = 25,
			["Epic"] = 5,
			["Legendary"] = 1,
		},
		["Rare"] = {
			["Rare"] = 100,
			["Epic"] = 35,
			["Legendary"] = 5,
		},
		["Epic"] = {
			["Epic"] = 100,
			["Legendary"] = 10,
		},
		["Legendary"] = {
			["Legendary"] = 100,
		},
	}
	function Sprouts.Spawn(Name: string, Field: string, Player: Player?)
		local CurrentStage = 0
		local FieldModel = workspace.FieldZones:FindFirstChild(Field)
		local Type = string.find(Name, "Rare") and "Rare" or string.find(Name, "Epic") and "Epic" or string.find(Name, "Legendary") and "Legendary" or "Classic"
		Type = Utils.PickRandom(Chances[Type])

		local Data = require(game.ReplicatedStorage.Modules.Sprouts[Type])
		local Model = game.ReplicatedStorage.Assets.Sprout:Clone()
		Model.Parent = FieldModel
		Model.Color = Data.Color
		Model.Position = FieldModel.Position - Vector3.new(0, FieldModel.Size.Y / 2 + Model.Size.Y / 2)
		local HpUI = script.HpUI:Clone()
		HpUI.Parent = Model
		local HpValue = Instance.new("IntValue", Model)
		HpValue.Name = "Hp"
		HpValue.Value = 0
		local HpMultiplier = HpMultipliers[Utils.GetFieldZone(Field)]
		
		game.ReplicatedStorage.Remotes.AlertClient:FireAllClients({
			Color = "Blue",
			Msg = Player and (Player.Name.." has planted a " .. Type ~= "Classic" and Type or "" .. "Sprout on "..Field.." Field") or ((Type ~= "Classic" and Type.." " or "") .."Sprout has appeared on "..Field.." Field")
		})
		
		Model.Size = Vector3.zero
		TweenService:Create(Model, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = game.ReplicatedStorage.Assets.Sprout.Size,
			Position = FieldModel.Position + Vector3.new(0, -(FieldModel.Size.Y / 2) + (game.ReplicatedStorage.Assets.Sprout.Size.Y / 2), 0)
		}):Play()
		
		HpValue.Changed:Connect(function(Hp)
			if Hp <= 0 then
				local PossibleDrop = table.clone(Data.Rewards)
				local FieldType = FieldModel.FColor.Value
				for Name, Reward in Data.FieldsDrop[FieldType] do
					PossibleDrop[Name] = Reward
				end
				local Rewards = {}
				for i = 1, Data.RewardsAmount() do
					local Reward = Utils.PickRandom(PossibleDrop)
					local RewardData = PossibleDrop[Reward]
					table.insert(Rewards, {
						Name = Reward,
						Type = RewardData.Type,
						Amount = type(RewardData.Amount) == "function" and RewardData.Amount() or RewardData.Amount
					})
				end
				
				task.defer(function()
					--local All = {}
					for _, Reward in Rewards do
						--if not All[Reward.Name] then
						--	All[Reward.Name] = 0
						--end
						--All[Reward.Name] += Reward.Amount
						local Position = workspace.Fields[Field]:GetChildren()[math.random(1, #workspace.Fields[Field]:GetChildren())].Position + Vector3.new(0, 2.5, 0)
						Tokens.SpawnToken("Any", Reward.Name, Position, nil, {
							Amount = Reward.Amount,
							Resource = "Sprout"
						})
						task.wait(0.03)
					end
					--warn(Type.." Sprout Loot:")
					--print(All)
				end)

				Model:Destroy()
			else
				local Percent = (((Hp / Data.Hp) * 100))
				local NewStage = nil
				for Index, StageValue in Stages do
					if Percent <= StageValue then
						NewStage = Index
					end
				end
				if NewStage and CurrentStage ~= NewStage then
					CurrentStage = NewStage
					local Size = game.ReplicatedStorage.Assets.Sprout.Size * (1.1 + (CurrentStage / 5)) --math.max(CurrentStage / 1.05, 1.1)
					TweenService:Create(Model, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
						Size = Size,
						Position = FieldModel.Position + Vector3.new(0, -(FieldModel.Size.Y / 2) + (Size.Y / 2), 0)
					}):Play()
				end
				HpUI.TextLabel.Text = string.format("🌸 %s", Utils:CommaNumber(Hp))
				HpUI.TextLabel.TextLabel.Text = HpUI.TextLabel.Text
			end
		end)
		HpValue.Value = math.floor(Data.Hp * HpMultiplier)
	end
	
	local function SproutSpawner()
		task.defer(function()
			while true do task.wait(math.random(60 * 4, 60 * 7))
				local Field = nil
				local Attempt = 0
				repeat 
					Field = workspace.FieldZones:GetChildren()[math.random(1, #workspace.FieldZones:GetChildren())]
					if Field:FindFirstChild("Sprout") then
						Field = nil
					end
					Attempt += 1
				until Field or Attempt >= 50
				if Field then
					Sprouts.Spawn("Classic", Field.Name)
				end
			end
		end)
	end
	
	--SproutSpawner()
	
end

return Sprouts