local Quests = {}; do
	local TweenService = game:GetService("TweenService")
	local Remotes = game.ReplicatedStorage.Remotes
	local Player = game.Players.LocalPlayer
	local UI = Player.PlayerGui:WaitForChild("UI")
	local DialogueFrame = UI.Dialogue
	local QuestsMenu = UI.Tabs.Quests
	local Camera = workspace.CurrentCamera
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	Quests.Talking = false
	
	local function GetTaskName(Task: {})
		if Task.Type == "CollectPollen" then
			return string.format("Collect %s%s Pollen%s", Task.Amount, Task.Color and " "..Task.Color or "", Task.Field and " from "..Task.Field.." Field" or "")
		elseif Task.Type == "ConvertPollen" then
			return string.format("Convert %s Pollen", Task.Amount)
		elseif Task.Type == "UseItem" then
			return string.format("Use %s %s times", Task.Item or "Any Item", Task.Amount)
		elseif Task.Type == "CollectToken" then
			return string.format("Collect %s %s Token%s", Task.Amount, Task.Token or "Any", Task.Amount ~= 1 and "s" or "")
		end
		return "Unknown Task"
	end
	
	function Quests.Update(NPC: string)
		local PlayerData = _G.PData
		
		-- Remove Quest
		if not PlayerData.Quests[NPC].Claimed then
			local PreviousQuest = require(game.ReplicatedStorage.Modules.Quests[NPC][PlayerData.Quests[NPC].Quest - 1])
			local QuestFrame = QuestsMenu.Icon.List:FindFirstChild(PreviousQuest.Quest)
			if QuestFrame then
				QuestFrame:Destroy()
			end
			if #QuestsMenu.Icon.List:GetChildren() - 1 == 0 then
				QuestsMenu.Icon.NoQuests.Visible = true
			end
			return
		end
		
		-- Create and Update Quest
		
		local QuestData = game.ReplicatedStorage.Modules.Quests:FindFirstChild(NPC):FindFirstChild(PlayerData.Quests[NPC].Quest)
		if not QuestData then
			return
		end
		QuestData = require(QuestData)
		
		local QuestFrame = QuestsMenu.Icon.List:FindFirstChild(QuestData.Quest)
		QuestsMenu.Icon.NoQuests.Visible = false
		if not QuestFrame then
			QuestFrame = UI.Client.Quest:Clone()
			QuestFrame.Name = QuestData.Quest
			QuestFrame.QName.Text = QuestData.Quest
			QuestFrame.Parent = QuestsMenu.Icon.List
			for Index, Task in QuestData.Tasks do
				local TaskFrame = UI.Client.Task:Clone()
				TaskFrame.Name = Index
				TaskFrame.LayoutOrder = Index
				TaskFrame.QName.Text = GetTaskName(Task)
				TaskFrame.Parent = QuestFrame.Tasks
			end
		end
		
		for Index, Task  in QuestData.Tasks do
			local TaskFrame = QuestFrame.Tasks:FindFirstChild(Index)
			if TaskFrame then
				TaskFrame.Bar.Amount.Text = string.format("%s / %s", Utils:CommaNumber(math.round(PlayerData.Quests[NPC].Tasks[Index]) or 0), Utils:CommaNumber(math.round(Task.Amount)))
				TaskFrame.Bar.Amount.Amount.Text = TaskFrame.Bar.Amount.Text
				TweenService:Create(TaskFrame.Bar.Fill, TweenInfo.new(0.2), {
					Size = UDim2.fromScale(PlayerData.Quests[NPC].Tasks[Index] / Task.Amount, 1)
				}):Play()
			end
		end
	end
	
	-- Dialogues
	
	local function AnimateText(Text: string)
		DialogueFrame.TextLabel.MaxVisibleGraphemes = 0
		DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = 0
		DialogueFrame.TextLabel.Text = Text
		DialogueFrame.TextLabel.TextLabel.Text = Text
		for i = 1, string.len(Text) do
			if DialogueFrame.TextLabel.Text ~= Text and DialogueFrame.TextLabel.TextLabel.Text ~= Text then
				break
			end
			DialogueFrame.TextLabel.MaxVisibleGraphemes = i
			DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = i
			task.wait(0.01)
		end
		DialogueFrame.TextLabel.MaxVisibleGraphemes = -1
		DialogueFrame.TextLabel.TextLabel.MaxVisibleGraphemes = -1
	end
	
	local function GetQuestType(NPC: string)
		local PlayerData = _G.PData
		if not PlayerData.Quests[NPC].Claimed then
			return "Start"
		elseif PlayerData.Quests[NPC].Claimed and not PlayerData.Quests[NPC].Completed then
			return "During"
		else
			return "Finish"
		end
	end
	
	local function FinishDialogue(NPC: string)
		
	end
	
	function Quests.StartDialogue(NPC: string)
		local PlayerData = _G.PData
		local QuestGiverData = game.ReplicatedStorage.Modules.Quests[NPC]
		local QuestData = QuestGiverData:FindFirstChild(PlayerData.Quests[NPC].Quest)
		if QuestData then
			QuestData = require(QuestData)
		end
		local Dialogue = {}
		if not QuestData then
			Dialogue = {"I don't have more quests right now!", "Return latter to claim quest"}
		else
			Dialogue = QuestData.Dialogues[GetQuestType(NPC)]
			--Dialogue = require(QuestGiverData[PlayerData.Quests[NPC].Quest]).Dialogue
		end
		
		TweenService:Create(DialogueFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0.5,0,1,0)
		}):Play()
		Camera.CameraType = Enum.CameraType.Scriptable
		TweenService:Create(Camera, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = CFrame.new(workspace.Quests[NPC].Camera.View.WorldPosition, workspace.Quests[NPC].Camera.Position)
		}):Play()
		Controls:Disable()
		Quests.Talking = true
		local ClickConnection = nil
		local Index = 1
		--DialogueFrame.TextLabel.Text = Dialogue[Index]
		AnimateText(Dialogue[1])
		ClickConnection = game.UserInputService.InputBegan:Connect(function(input, gpe)
			if not gpe and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				if DialogueFrame.TextLabel.MaxVisibleGraphemes == -1 then
					Index = Index + 1
					if not Dialogue[Index] then
						ClickConnection:Disconnect()
						TweenService:Create(DialogueFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
							Position = UDim2.new(0.5, 0, 1.5, 0)
						}):Play()
						Camera.CameraType = Enum.CameraType.Custom
						Remotes.ClaimQuest:FireServer(NPC)
						Controls:Enable()
						Quests.Talking = false
					else
						AnimateText(Dialogue[Index])
					end
				end
			end
		end)
	end
end

return Quests