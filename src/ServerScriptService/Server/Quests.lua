local Quests = {}; do
	local Remotes = game.ReplicatedStorage.Remotes
	local Data = require(script.Parent.Data)
	local DataModifier = require(game.ServerScriptService.Functions.DataModifier)
	local Quests = game.ReplicatedStorage.Modules.Quests
	
	local function Complete(Player: Player, Type: string, Progress: {})
		local PlayerData = Data:Get(Player)
		for NPC, NPCData in PlayerData.Quests do
			if NPCData.Claimed and not NPCData.Completed then
				local QuestInfo = require(Quests[NPC][NPCData.Quest])
				for Index, Task in NPCData.Tasks do
					local TaskInfo = QuestInfo.Tasks[Index]
					if TaskInfo.Type == Type then
						if Type == "CollectPollen" then
							if not TaskInfo.Color and not TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.White + Progress.Red + Progress.Blue)
							elseif TaskInfo.Color and not TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress[TaskInfo.Color] or 0)
							elseif not TaskInfo.Color and TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.Field == TaskInfo.Field and (Progress.White + Progress.Red + Progress.Blue) or 0)
							elseif TaskInfo.Color and TaskInfo.Field then
								NPCData.Tasks[Index] += (Progress.Field == TaskInfo.Field and Progress[TaskInfo.Color] or 0)
							end
						elseif Type == "ConvertPollen" then
							NPCData.Tasks[Index] += Progress.Amount
						elseif Type == "UseItem" then
							if TaskInfo.Item then
								NPCData.Tasks[Index] += (Progress.Item == TaskInfo.Item and (Progress.Amount or 1) or 0)
							else
								NPCData.Tasks[Index] += Progress.Amount or 0
							end
						elseif Type == "CollectToken" then
							if TaskInfo.Token then
								NPCData.Tasks[Index] += (Progress.Token == TaskInfo.Token and 1 or 0)
							else
								NPCData.Tasks[Index] += 1
							end
						end
					end
					if NPCData.Tasks[Index] > TaskInfo.Amount then
						NPCData.Tasks[Index] = TaskInfo.Amount
					end
				end
				
				local Completed = 0
				for Index, Task in NPCData.Tasks do
					local TaskInfo = QuestInfo.Tasks[Index]
					if Task == TaskInfo.Amount then
						Completed += 1
					end
				end
				if Completed == #NPCData.Tasks then
					NPCData.Completed = true
				end
				Remotes.DataUpdated:FireClient(Player, {"Quests", NPC, PlayerData.Quests[NPC]})
			end
		end
	end
	
	local function Claim(Player: Player, QuestGiver: string)
		local PData = Data:Get(Player)
		local QuestsFolder = Quests:FindFirstChild(QuestGiver)
		if not QuestsFolder then return end
		if not PData.Quests[QuestGiver].Claimed and not PData.Quests[QuestGiver].Completed then
			local QuestData = QuestsFolder:FindFirstChild(PData.Quests[QuestGiver].Quest)
			if not QuestData then
				return warn("All quests completed!")
			end
			QuestData = require(QuestData)
			for i, Task in QuestData.Tasks do
				PData.Quests[QuestGiver].Tasks[i] = 0
			end
			PData.Quests[QuestGiver].Claimed = true
			Remotes.DataUpdated:FireClient(Player, {"Quests",  QuestGiver, PData.Quests[QuestGiver]})
		elseif PData.Quests[QuestGiver].Claimed and PData.Quests[QuestGiver].Completed then
			local QuestData = require(QuestsFolder[PData.Quests[QuestGiver].Quest])
			
			-- rewards
			
			for _, Reward in QuestData.Rewards do
				if Reward.Type == "Item" then
					DataModifier.InventoryChange(Player, {"+", Reward.Amount, Reward.Name, "from Quest", true})
				elseif Reward.Type == "Currency" then
					DataModifier.IStatsChange(Player, {"+", Reward.Amount, Reward.Name, "from Quest", true})
				end
			end
			
			PData.Quests[QuestGiver].Claimed = false
			PData.Quests[QuestGiver].Completed = false
			PData.Quests[QuestGiver].Tasks = {}
			PData.Quests[QuestGiver].Quest += 1
			Remotes.DataUpdated:FireClient(Player, {"Quests", QuestGiver, PData.Quests[QuestGiver]})
		end
	end
	
	Remotes.ClaimQuest.OnServerEvent:Connect(Claim)
	_G.CompleteQuest = Complete
end

return Quests