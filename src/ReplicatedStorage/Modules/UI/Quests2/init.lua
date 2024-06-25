local module = {}
local UserInputService = game:GetService("UserInputService")
local Items = require(game.ReplicatedStorage.Modules.Items)

local Utils = require(game.ReplicatedStorage.Modules.Utils)
local Utilities = require(game.ReplicatedStorage.Utilities)
local ClientUtilities = require(game.ReplicatedStorage.ClientUtilities)

local QuestsFolder = require(game.ReplicatedStorage.Modules.Quests)

local Remotes = game.ReplicatedStorage.Remotes
local Tween = game:GetService("TweenService")

local Camera = workspace.Camera

local UI
local NPCMenu
local NPCName
local Cnt

local Deb = false

function module:QuestUpdate(Gui, Info, State)
	if Gui then
		local Label = Gui:FindFirstChild("TextLabel")
		require(script:FindFirstChild(State)).Get(Label, Utils:AbNumber(Info.StartAmount), Utils:AbNumber(Info.NeedAmount), Info)
	end
end

function module:QuestI(Player)
	for NPCName, In in pairs(_G.PData.QuestsGivers) do
		if game.Workspace.NPCs:FindFirstChild(NPCName) then
			if In.Claimed2 and not In.CompletedNow then
				if _G.PData.QuestsGivers[NPCName].CompletedQuests <= #QuestsFolder.Quests[NPCName].Quests then
					if game.Workspace.NPCs[NPCName].Circle.PointAt.BillboardGui.Enabled then
						game.Workspace.NPCs[NPCName].Circle.PointAt.BillboardGui.Enabled = false
					end

					local QuestsFrame = UI.Tabs.Quests.List
					for i,v in pairs(QuestsFrame:GetChildren()) do
						if v and v:IsA("Frame") then
							if v:FindFirstChild("Tasks") then
								for k,TaskFrame in pairs(v:FindFirstChild("Tasks"):GetChildren()) do
									if TaskFrame and TaskFrame:IsA("Frame") then
										local Bar = TaskFrame:FindFirstChild("FillBar")
										if _G.PData.Quests2 ~= nil and _G.PData.Quests2[TaskFrame.Name] ~= nil and _G.PData.Quests2[TaskFrame.Name][k - 3] ~= nil and _G.PData.Quests2[TaskFrame.Name][k - 3].Type ~= nil then
											local v19 = math.clamp(_G.PData.Quests2[TaskFrame.Name][k - 3].StartAmount / _G.PData.Quests2[TaskFrame.Name][k - 3].NeedAmount, 0, 1)
											module:QuestUpdate(TaskFrame, _G.PData.Quests2[TaskFrame.Name][k - 3], _G.PData.Quests2[TaskFrame.Name][k - 3].Type)
											if TaskFrame:FindFirstChild("FillBar") then
												TaskFrame.FillBar.Size = UDim2.new(v19,0,1,0)
											end
										end
									end
								end
							end
						end
					end
				end
			else
				if not game.Workspace.NPCs[NPCName]:WaitForChild("Circle").PointAt.BillboardGui.Enabled then
					game.Workspace.NPCs[NPCName]:WaitForChild("Circle").PointAt.BillboardGui.Enabled = true
				end
			end
		end
	end
end

local bears = {
	["Black Bear"] = "rbxassetid://14826050508",
	["Cosmic Bear"] = "rbxassetid://14826050508",
	["Brown Bear"] = "rbxassetid://14826070131",
	["Brown Bear2"] = "rbxassetid://14826070131",
	["Resin Bear"] = "rbxassetid://14826072347",
	["Master Bear"] = "rbxassetid://15011888722",
	["Plush Bear"] = "rbxassetid://14946892323",
	["Warm Bear"] = "rbxassetid://14826050508",
	["North Bear"] = "rbxassetid://14826050508",
}

function module:QuestUI(Info)
	if Info then
		if Info.Name then
			spawn(function()
				local QuestMK = script.Quest:Clone()
				QuestMK.TextLabel.Text = Info.Name
				QuestMK.TextLabel.BearIcon.Image = bears[Info.Giver]
				QuestMK.LayoutOrder -= 1
				if Info.Winter then
					QuestMK.BackgroundColor3 = Color3.fromRGB(144, 229, 144)
					QuestMK.B2.BackgroundColor3 = Color3.fromRGB(182, 88, 88)
					QuestMK.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 123, 123)
				end
				for i,v in pairs(Info.Tasks) do
					local TEmp = script.Template:Clone()
					TEmp.Parent = QuestMK.Tasks
					TEmp.Name = Info.Giver
					local Label = TEmp.TextLabel
					if i > 1 then
						QuestMK.Tasks.Size = UDim2.new(0.9,0,0,QuestMK.Tasks.Size.Y.Offset + 45)
						QuestMK.Size = UDim2.new(1,0,0,QuestMK.Tasks.Size.Y.Offset + 60)
					end

					require(script:FindFirstChild(v.Type)).Get(Label, Utils:AbNumber(v.StartAmount), Utils:AbNumber(v.NeedAmount), v)
				end
				QuestMK.Name = Info.Name
				QuestMK.Parent = UI.Tabs.Quests.List

				if UI.Tabs.Quests.List:GetChildren() ~= 0 then
					for i,v in pairs(UI.Tabs.Quests.List:GetChildren()) do
						if v:IsA("Frame") then
							QuestMK.LayoutOrder = v.LayoutOrder - 1
						end
					end
				end
			end)
		end
	end
end
function module:Freeze()
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Disable()
end

function module:GetQuestType(NPCttt)
	local Type
	if not _G.PData.QuestsGivers[NPCttt].Claimed2 then
		Type = "Start"
	elseif _G.PData.QuestsGivers[NPCttt].Claimed2 and not _G.PData.QuestsGivers[NPCttt].CompletedNow then
		Type = "During"
	elseif _G.PData.QuestsGivers[NPCttt].Claimed2 and _G.PData.QuestsGivers[NPCttt].CompletedNow then
		Type = "Completed"
	end
	return Type
end

function module:QuestDestroy(InfoT)
	local QuestDM = UI.Tabs.Quests.List:FindFirstChild(InfoT.Name)
	if QuestDM ~= nil then
		QuestDM:Destroy()
	end
end

function module:Unfreeze()
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Enable()
end

function module:Dialoge(NPC)
	module:Freeze()
	NPCMenu.Visible = true
	_G.Talking = true
	Utils:TweenCam(nil, CFrame.new(NPC.Camera.View.WorldPosition, NPC.Camera.Position))
	NPCMenu:TweenPosition(UDim2.new(0.5,0,0.733,0), "Out", "Back", 0.3, true)
	local Index = 1
	local QuestType = module:GetQuestType(NPC.Name)
	local QuestCount = _G.PData.QuestsGivers[NPC.Name].CompletedQuests
	NPCMenu.BearIcon.Image = bears[game.Workspace.NPCs:FindFirstChild(NPC.Name).Named.Value]
	NPCMenu.NPC.Text = game.Workspace.NPCs:FindFirstChild(NPC.Name).Named.Value
	local Connection
	NPCName = NPC.Name
	Cnt = QuestCount
	if _G.PData.QuestsGivers[NPC.Name].Infinity == false and _G.PData.QuestsGivers[NPC.Name].CompletedQuests <= #QuestsFolder.Quests[NPCName].Quests then
		local DialogsModule = QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPC.Name].CompletedQuests].Dialogue
		NPCMenu.TextBox.Text = DialogsModule[QuestType][Index]
	elseif _G.PData.QuestsGivers[NPC.Name].Infinity == false and _G.PData.QuestsGivers[NPC.Name].CompletedQuests > #QuestsFolder.Quests[NPCName].Quests then
		NPCMenu.TextBox.Text = QuestsFolder.Quests[NPCName].NoQuests[Index]
	elseif _G.PData.QuestsGivers[NPC.Name].Infinity == true then
		local DialogsModule = QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPC.Name].CompletedQuests].Dialogue
		NPCMenu.TextBox.Text = DialogsModule[QuestType][Index]
	end
	Connection = NPCMenu.ButtonOverlay.MouseButton1Click:Connect(function()
		Index += 1
		if _G.PData.QuestsGivers[NPC.Name].CompletedQuests <= #QuestsFolder.Quests[NPCName].Quests then
			local DialogsModule = QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPC.Name].CompletedQuests].Dialogue
			script.Talk:Play()
			if not _G.PData.QuestsGivers[NPC.Name].Claimed2 and not _G.PData.QuestsGivers[NPC.Name].CompletedNow then
				if Index > #DialogsModule.Start then
					if not Deb then
						spawn(function()
							Deb = true
							NPCMenu:TweenPosition(UDim2.new(0.5,0,1.733,0), "In", "Back", 0.3, true)
							Camera.CameraType = Enum.CameraType.Custom
							Tween:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
							Remotes.Quest:FireServer(NPCName)
							--QuestUI(QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPC.Name].CompletedQuests])
							_G.Talking = false
							Connection:Disconnect()
							Index = 1
							wait(0.1)
							Deb = false
							script.GetQuest:Play()
							module:Unfreeze()
						end)
					end
				else
					module:Animate(NPCMenu)
					NPCMenu.TextBox.Text = DialogsModule.Start[Index]
					module:Unfreeze()
				end
			elseif _G.PData.QuestsGivers[NPC.Name].Claimed2 and not _G.PData.QuestsGivers[NPC.Name].CompletedNow then
				if Index > #DialogsModule.During then
					if not Deb then
						spawn(function()
							Deb = true
							NPCMenu:TweenPosition(UDim2.new(0.5,0,1.733,0), "In", "Back", 0.3, true)
							Camera.CameraType = Enum.CameraType.Custom
							Tween:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
							Connection:Disconnect()
							_G.Talking = false
							Index = 1
							wait(0.1)
							Deb = false
							module:Unfreeze()
						end)
					end
				else
					module:Animate(NPCMenu)
					NPCMenu.TextBox.Text = DialogsModule.During[Index]
					module:Unfreeze()
				end
			elseif _G.PData.QuestsGivers[NPC.Name].CompletedNow then
				if Index > #DialogsModule.Completed then
					if not Deb then
						spawn(function()
							Deb = true
							_G.Talking = false
							NPCMenu:TweenPosition(UDim2.new(0.5,0,1.733,0), "In", "Back", 0.3, true)
							Camera.CameraType = Enum.CameraType.Custom
							Tween:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
							Remotes.Quest:FireServer(NPC.Name)
							module:QuestDestroy(QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPC.Name].CompletedQuests])
							Connection:Disconnect()
							Index = 1
							wait(0.1)
							Deb = false
							script.CompleteQuest:Play()
							module:Unfreeze()
						end)
					end
				else
					module:Animate(NPCMenu)
					NPCMenu.TextBox.Text = DialogsModule.Completed[Index]
					module:Unfreeze()
				end
			end
		else
			if Index > #QuestsFolder.Quests[NPCName].NoQuests then
				if not Deb then
					spawn(function()
						Deb = true
						NPCMenu:TweenPosition(UDim2.new(0.5,0,1.733,0), "In", "Back", 0.3, true)
						Camera.CameraType = Enum.CameraType.Custom
						Tween:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
						Connection:Disconnect()
						_G.Talking = false
						Index = 1
						wait(0.01)
						Deb = false
						module:Unfreeze()
					end)
				end
			else
				module:Animate(NPCMenu)
				NPCMenu.TextBox.Text = QuestsFolder.Quests[NPCName].NoQuests[Index]
				module:Unfreeze()
			end
		end
	end)
end

function module:Animate(NPCMenu)
	spawn(function()
		NPCMenu.Click:Play()
		NPCMenu:TweenPosition(UDim2.new(0.5,0,0.737,0), "Out", "Back", 0.075, true)
		NPCMenu:TweenSize(UDim2.new(0.363, 0,0.247, 0), "Out", "Back", 0.3, true)
		wait(0.1)
		NPCMenu:TweenSize(UDim2.new(0.35, 0,0.252, 0), "Out", "Back", 0.3, true)
		NPCMenu:TweenPosition(UDim2.new(0.5,0,0.733,0), "Out", "Back", 0.075, true)
	end)
end

function module:VisualDialoge(NPC)
	module:Freeze()
	NPCMenu.Visible = true
	_G.Talking = true
	Utils:TweenCam(nil, CFrame.new(NPC.Camera.View.WorldPosition, NPC.Camera.Position))
	NPCMenu:TweenPosition(UDim2.new(0.5,0,0.733,0), "Out", "Back", 0.3, true)
	local Index = 1
	local DialogsModule = QuestsFolder.Dialogs[NPC.Name]
	local Connection

	NPCMenu.NPC.Text = NPC.Name
	NPCMenu.TextBox.Text = DialogsModule.Dialogue[Index]

	Connection = NPCMenu.ButtonOverlay.MouseButton1Click:Connect(function()
		Index += 1
		if Index > #DialogsModule.Dialogue then
			NPCMenu:TweenPosition(UDim2.new(0.5,0,1.733,0), "In", "Back", 0.3, true)
			Camera.CameraType = Enum.CameraType.Custom
			Tween:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
			_G.Talking = false
			Connection:Disconnect()
			Index = 1
			wait(0.1)
			Deb = false
			module:Unfreeze()

			if NPC.Name == "BeezBuzz Bear" then

			end
		else
			module:Animate(NPCMenu)
			NPCMenu.TextBox.Text = DialogsModule.Dialogue[Index]
		end
	end)
end

function module.Init(Player)
	UI = Player.PlayerGui.Screen
	NPCMenu = UI.NPC
	for i,v in pairs(_G.PData.QuestsGivers) do
		if QuestsFolder.Quests[i] then
			if v.Claimed2 then
				module:QuestUI(QuestsFolder.Quests[i].Quests[_G.PData.QuestsGivers[i].CompletedQuests])
			end
		end
	end

	Remotes.CQuest.OnClientEvent:Connect(function()
		module:QuestUI(QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPCName].CompletedQuests])
	end)
	Remotes.DQuest.OnClientEvent:Connect(function()
		module:QuestDestroy(QuestsFolder.Quests[NPCName].Quests[_G.PData.QuestsGivers[NPCName].CompletedQuests])
	end)
end

return module
