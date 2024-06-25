wait(4)
--// Player
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
--fuck you / ты ахуел сам пошёл нахуй брат <3 ☻
local Character = Player.Character
--// UI
local UI = script.Parent
local UIScale = UI:WaitForChild("UIScale")
--// Services 
local SocialService = game:GetService("SocialService")
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
game.StarterGui:SetCore("ResetButtonCallback", false)
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Remotes = game.ReplicatedStorage.Remotes
local bees = game.ReplicatedStorage.Bees

--// Modules
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local Hovers = require(game.ReplicatedStorage.Modules.InfoHover)
local Eggs = require(game.ReplicatedStorage.Modules.Items).Eggs
local Alerts = require(game.ReplicatedStorage.Modules.Alerts)
local Shops = require(game.ReplicatedStorage.Modules.UI.Shops)
local BeeLevels = require(game.ReplicatedStorage.Modules.BeeLevels)
local Quests = require(game.ReplicatedStorage.Modules.UI.Quests)

--// Vars
local Scale
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
local Humanoid = Player.Character:WaitForChild("Humanoid")
local List_Index = UI.Tabs.Index.Icon.List

local ColorsSSS = {
	Common = Color3.fromRGB(108, 88, 75),
	Rare = Color3.fromRGB(179, 197, 250),
	Epic = Color3.fromRGB(245, 205, 48),
	Legendary = Color3.fromRGB(18, 238, 212),
	Mythic = Color3.fromRGB(147, 94, 238),
	Limited = Color3.fromRGB(132, 221, 109)
}
local ShadowColors = {
	["Colorless"] = Color3.fromRGB(0, 0, 0),
	["Blue"] = Color3.fromRGB(0, 0, 255),
	["Red"] = Color3.fromRGB(255, 0, 0),
}

local ColorTypes = {
	["Colorless"] = Color3.fromRGB(243, 243, 243),
	["Blue"] = Color3.fromRGB(102, 105, 255),
	["Red"] = Color3.fromRGB(255, 70, 70),
}

local ItemPicked
local ItemModule
local Dragging = false
local ChoosenSlot
local PutItem = false

repeat _G.PData = game.ReplicatedStorage.Remotes.GetPlayerData:InvokeServer() until _G.PData

UI.UseItem.MouseEnter:Connect(function()
	PutItem = true
end)

UI.UseItem.MouseLeave:Connect(function()
	PutItem = false
end)

Hovers.Init()
Shops.Init(Player)
Remotes.AlertClient.OnClientEvent:Connect(function(Info)
	require(game.ReplicatedStorage.Modules.NEWAlerts).Alert(Info)
end)

local function MakeSendList()
	for i,v in pairs(UI.SendBJP.List:GetChildren()) do
		if v.Name ~= "UIListLayout" then
			v:Destroy()
		end
	end
	
	for _, Plr in pairs(game.Players:GetChildren()) do
		local Exm = script.PlrRow:Clone()
		Exm.Rare.Text = Plr.Name
		if Plr.Name == Player.Name then
			Exm.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
			Exm.Rare.TextColor3 = Color3.fromRGB(188, 188, 188)
			Exm.Rare.Text = Exm.Rare.Text.." (you)"
		end
		Exm.Parent = UI.SendBJP.List

		Exm.MouseEnter:Connect(function()
			Exm:TweenSize(UDim2.new(0.96, 0, 0, 33), "Out", "Back", 0.2, true)
		end)
		Exm.MouseLeave:Connect(function()
			Exm:TweenSize(UDim2.new(0.9, 0, 0, 30), "Out", "Back", 0.2, true)
		end)
	end
end
MakeSendList()

local OpenedMenu = ""
local function UpdateBoosts()
	for i,v in pairs(UI.Boosts:GetChildren()) do
		if v:IsA("ImageButton") then
			if not _G.PData.Boosts[v.Name] then
				v:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.3, true)
				spawn(function()
					wait(0.3)
					v.Visible = false
				end)
			end
		end
	end
end

local function CntBees()
	local t = 0
	for i,v in pairs(_G.PData.Bees) do
		if v.BeeName ~= "" then
			t += 1
		end
	end
	return t
end

local function CntDis()
	local t = 0
	for i,v in pairs(_G.PData.DiscoveredBees) do
		t += 1
	end
	return t
end

local function UpdateIndexStats()
	List_Index.Parent.Have.Text = "In your hive "..CntBees().." Bees"
	List_Index.Parent.Have.Have.Text = "In your hive "..CntBees().." Bees"

	List_Index.Parent.Dis.Text = "You discovered "..CntDis().." Bees"
	List_Index.Parent.Dis.Dis.Text = "You discovered "..CntDis().." Bees"
end


local function UpdateGates()
	for i,v in pairs(workspace.Zones:GetChildren()) do
		if CntBees() >= tonumber(v.Name) then
			v.Door.Color = Color3.fromRGB(82, 255, 73)
			v.Door.CanCollide = false
		end
	end
end
UpdateGates()
local IndTab = false
local function CreateBoostsIndex()
	for i, v in pairs(game.ReplicatedStorage.Boosts:GetChildren()) do
		local Bmod = require(v)
		local Row = script.IndBoostRow:Clone()
		Row.Icon.Image = Bmod.BoostImage
		Row.Icon.BackgroundColor3 = Bmod.Color
		Row.BackgroundColor3 = Bmod.SColor
		Row.Parent = UI.Tabs.Index.Icon.BoostsList
	end
end
CreateBoostsIndex()
local function CreateIndex()
	UpdateIndexStats()
	for i, v in pairs(bees:GetChildren()) do
		local BM = require(v)
		local Example = script.Bee:Clone()
		Example.Bee.Image = BM.Thumb
		Example.Shadow.ImageColor3 = ShadowColors[BM.Color]
		Example.LayoutOrder = BM.Layout
		Example.Bee.MouseEnter:Connect(function()
			UI.BeeHover.Item.Text = BM.Name.." Bee"
			UI.BeeHover.Rare.Text = BM.Rarity
			UI.BeeHover.Rare.Rare.Text = BM.Rarity
			UI.BeeHover.Rare.Rare.TextColor3 = ColorsSSS[BM.Rarity]
			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0), UI.BeeHover)
			Example.Bee:TweenSize(UDim2.new(1.25*1.15, 0, 0.8*1.15, 0), "Out", "Back", 0.25, true)
		end)
		Example.Bee.MouseMoved:Connect(function()
			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0), UI.BeeHover)
		end)
		Example.Bee.MouseLeave:Connect(function()
			TS:Create(Example.Bee, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
			Hovers:Remove(UI.BeeHover)
			Example.Bee:TweenSize(UDim2.new(1.25, 0, 0.8, 0), "Out", "Back", 0.25, true)
		end)

		Example.Bee.MouseButton1Down:Connect(function()
			Example.Bee:TweenSize(UDim2.new(1.25*0.85, 0, 0.8*0.85, 0), "Out", "Back", 0.25, true)
			TS:Create(Example.Bee, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 8}):Play()
		end)
		Example.Bee.MouseButton1Up:Connect(function()
			Example.Bee:TweenSize(UDim2.new(1.25*1.15, 0, 0.8*1.15, 0), "Out", "Back", 0.25, true)
			TS:Create(Example.Bee, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
			
			UI.Tabs.Index.Tab.Lbl.Text = BM.Name.." Bee"
			UI.Tabs.Index.Tab.Lbl.Lbl.Text = BM.Name.." Bee"
			UI.Tabs.Index.Tab.Lbl.Rare.Text = BM.Rarity
			UI.Tabs.Index.Tab.Lbl.Rare.Rare.Text = BM.Rarity
			UI.Tabs.Index.Tab.Lbl.Rare.Rare.TextColor3 = ColorsSSS[BM.Rarity]
			
			UI.Tabs.Index.Tab.Rare.Lbl.Text = BM.Rarity
			UI.Tabs.Index.Tab.Rare.Lbl.Lbl.Text = BM.Rarity
			UI.Tabs.Index.Tab.Rare.Lbl.Lbl.TextColor3 = ColorsSSS[BM.Rarity]
			
			UI.Tabs.Index.Tab.CType.Lbl.Text = BM.Color
			UI.Tabs.Index.Tab.CType.Lbl.Lbl.Text = BM.Color
			UI.Tabs.Index.Tab.CType.Lbl.Lbl.TextColor3 = ColorTypes[BM.Color]
			
			UI.Tabs.Index.Tab.Energy.Lbl.Text = "Energy: "..BM.Energy
			UI.Tabs.Index.Tab.Energy.Lbl.Lbl.Text = "Energy: "..BM.Energy
			
			UI.Tabs.Index.Tab.Speed.Lbl.Text = "Speed: "..BM.Speed
			UI.Tabs.Index.Tab.Speed.Lbl.Lbl.Text = "Speed: "..BM.Speed
			
			UI.Tabs.Index.Tab.Damage.Lbl.Text = "Damage: "..BM.Attack
			UI.Tabs.Index.Tab.Damage.Lbl.Lbl.Text = "Damage: "..BM.Attack

			UI.Tabs.Index.Tab.Gathers.Lbl.Lbl.Text = "Collects "..BM.StatsModule.Collecting.." Pollen in "..BM.CollectTime.." seconds"
			UI.Tabs.Index.Tab.Gathers.Lbl.Text = "Collects "..BM.StatsModule.Collecting.." Pollen in "..BM.CollectTime.." seconds"
			UI.Tabs.Index.Tab.Convert.Lbl.Lbl.Text = "Makes "..BM.Converts.." Honey in "..BM.ConvertsTime.." seconds"
			UI.Tabs.Index.Tab.Convert.Lbl.Text = "Makes "..BM.Converts.." Honey in "..BM.ConvertsTime.." seconds"
			
			UI.Tabs.Index.Tab.IMG.Image = BM.Thumb
			
			UI.Tabs.Index.Tab.Visible = true
			UI.Tabs.Index.Tab:TweenPosition(UDim2.new(2, 0, -0.02, 0), "Out", "Back", 0.2)
			UI.Tabs.Index.Tab:TweenSize(UDim2.new(1.1, 0, 1, 0), "Out", "Back", 0.2)

			--UI.Tabs.Index.Tab.IMG:TweenSize(UDim2.new(0.456 * 1.4, 0, 0.202 * 1.4, 0), "Out", "Back", 0.25)
			--UI.Tabs.Index.Tab.IMG:TweenSize(UDim2.new(0.456, 0, 0.202, 0), "Out", "Back", 0.25)
		end)
		Example.Parent = List_Index
	end
end
UI.Tabs.Index.Tab.Close.Arw.MouseButton1Click:Connect(function()
	UI.Tabs.Index.Tab:TweenPosition(UDim2.new(1.03, 0, -0.02, 0), "Out", "Back", 0.2)
	UI.Tabs.Index.Tab:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Back", 0.2)
	spawn(function()
		wait(0.17)
		UI.Tabs.Index.Tab.Visible = false
	end)
end)
CreateIndex()
--Color3.fromRGB(26, 175, 255)
game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage('<font size="15"><font color="#1aafff"><b>[ +1 Ticket ]</b></font></font>')

spawn(function()
	while wait(0.4) do
		TS:Create(UI.Tabs.Index.Tab.IMG, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 10}):Play()
		wait(0.32)
		TS:Create(UI.Tabs.Index.Tab.IMG, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -5}):Play()
	end
end)
local Badgess = require(game.ReplicatedStorage.Modules.Badges).Badges
local Badgesss = require(game.ReplicatedStorage.Modules.Badges)
local function UpdateBadges()
	for i, BRow in pairs(UI.Tabs.Badges.Icon.List:GetChildren()) do
		if BRow:IsA("Frame") then
			if _G.PData.Badges[BRow.Name] then
				local BInfo = Badgess[BRow.Name]
				local BType = BRow.Name
				local NowTier = BInfo[_G.PData.Badges[BRow.Name].Tier]
				BRow.Frame.Title.Text = BType.." Badge - "..NowTier.TierName
				BRow.Frame.Title.Title.Text = BType.." Badge - "..NowTier.TierName
				
				BRow.Frame.BackgroundColor3 = Badgesss.BadgesColors[_G.PData.Badges[BRow.Name].Tier]
				
				if BInfo.Req == "Playtime" then
					BRow.Frame.Bar.Title.Text = Utils:FormatTime(_G.PData.Badges[BRow.Name].Amount).." / "..NowTier.Vis.." "..BInfo.Req
				else
					BRow.Frame.Bar.Title.Text = Utils:CommaNumber(_G.PData.Badges[BRow.Name].Amount).." / "..Utils:CommaNumber(NowTier.Needs).." "..BInfo.Req
				end
				BRow.Frame.Bar.Fill.Size = UDim2.new(math.clamp(_G.PData.Badges[BRow.Name].Amount/NowTier.Needs, 0, 1), 0, 1, 0)
				if _G.PData.Badges[BRow.Name].Tier > 1 then
					BRow.Frame["Bonus".._G.PData.Badges[BRow.Name].Tier - 1].BackgroundColor3 = Color3.fromRGB(109, 255, 99)
					BRow.Frame["Bonus".._G.PData.Badges[BRow.Name].Tier - 1].BackgroundTransparency = 0.3
				end
				for i = 1, 5 do
					BRow.Frame["Bonus"..i].Text = "+"..BInfo[i].BuffAmount.."%"
				end

				if _G.PData.Badges[BRow.Name].Tier > 1 then
					BRow.Frame["Bonus".._G.PData.Badges[BRow.Name].Tier - 1].BackgroundColor3 = Color3.fromRGB(109, 255, 99)
					BRow.Frame["Bonus".._G.PData.Badges[BRow.Name].Tier - 1].BackgroundTransparency = 0.3
				end
				if _G.PData.Badges[BRow.Name].Amount >= NowTier.Needs then
					BRow.Frame.Bar.Title.Text = "Claim Rewards!"
					BRow.Frame.Bar.Fill.ColorChanger.Enabled = true
				else
					if BInfo.Req == "Playtime" then
						BRow.Frame.Bar.Title.Text = Utils:FormatTime(_G.PData.Badges[BRow.Name].Amount).." / "..NowTier.Vis.." "..BInfo.Req
					else
						BRow.Frame.Bar.Title.Text = Utils:CommaNumber(_G.PData.Badges[BRow.Name].Amount).." / "..Utils:CommaNumber(NowTier.Needs).." "..BInfo.Req
					end
					BRow.Frame.Bar.Fill.ColorChanger.Enabled = false
					BRow.Frame.Bar.Fill.BackgroundColor3 = Color3.fromRGB(126, 236, 102)
				end
			end
		end
	end
end

local function CreateBadges()
	for BType, Badge in pairs(Badgess) do
		local PBadge = _G.PData.Badges[BType]
		local NowTier = Badge[PBadge.Tier]
		
		local BRow = script.BadgeRow:Clone()
		BRow.Name = BType
		local CChanger = script.ColorChanger:Clone()
		CChanger.Parent = BRow.Frame.Bar.Fill
		BRow.LayoutOrder = Badge.Layout
		BRow.Frame.Bar.Tct.Title.Text = NowTier.Reward[2]
		BRow.Frame.Bar.Tct.Title.Title.Text = NowTier.Reward[2]

		BRow.Frame.Title.Text = BType.." Badge - "..NowTier.TierName
		BRow.Frame.Title.Title.Text = BType.." Badge - "..NowTier.TierName

		if Badge.Req == "Playtime" then
			BRow.Frame.Bar.Title.Text = Utils:FormatTime(PBadge.Amount).." / "..NowTier.Vis.." "..Badge.Req
		else
			BRow.Frame.Bar.Title.Text = Utils:CommaNumber(PBadge.Amount).." / "..Utils:CommaNumber(NowTier.Needs).." "..Badge.Req
		end
		BRow.Frame.Bar.Fill.Size = UDim2.new(math.clamp(PBadge.Amount/NowTier.Needs, 0, 1), 0, 1, 0)
		
		if PBadge.Amount >= NowTier.Needs then
			BRow.Frame.Bar.Title.Text = "Claim Rewards!"
			BRow.Frame.Bar.Fill.ColorChanger.Enabled = true
		else
			if Badge.Req == "Playtime" then
				BRow.Frame.Bar.Title.Text = Utils:FormatTime(PBadge.Amount).." / "..NowTier.Vis.." "..Badge.Req
			else
				BRow.Frame.Bar.Title.Text = Utils:CommaNumber(PBadge.Amount).." / "..Utils:CommaNumber(NowTier.Needs).." "..Badge.Req
			end
			BRow.Frame.Bar.Fill.ColorChanger.Enabled = false
			BRow.Frame.Bar.Fill.BackgroundColor3 = Color3.fromRGB(126, 236, 102)
		end
		
		BRow.Frame.BonusType.Text = Badge.BuffType
		
		for i = 1, 5 do -- ДОБАВИТЬ В АПДЕЙТ БЕЙДЖЕЙ!!!!!!
			BRow.Frame["Bonus"..i].Text = "+"..Badge[i].BuffAmount.."%"
		end
		
		if PBadge.Tier > 1 then
			BRow.Frame["Bonus"..PBadge.Tier - 1].BackgroundColor3 = Color3.fromRGB(109, 255, 99)
			BRow.Frame["Bonus"..PBadge.Tier - 1].BackgroundTransparency = 0.3
		end

		BRow.Frame.Bar.Claim.MouseButton1Down:Connect(function()
			BRow.Frame.Bar:TweenSize(UDim2.new(0.88*0.9, 0, 0.3 * 0.9, 0), "Out", "Back", 0.2, true)
		end)
		BRow.Frame.Bar.Claim.MouseButton1Up:Connect(function()
			Remotes.ClaimBadge:FireServer(BType)
			BRow.Frame.Bar:TweenSize(UDim2.new(0.88, 0, 0.3, 0), "Out", "Back", 0.2, true)
		end)
		
		BRow.Parent = UI.Tabs.Badges.Icon.List
	end
end
CreateBadges()
UpdateBadges()

local function UpdateSetting(Name: string)
	local Frame = UI.Tabs.Settings.Icon.Settings:FindFirstChild(Name)
	if Frame then
		local Value = _G.PData.Options[Name]
		Frame.TextButton.TextLabel.Text = Value and "Enabled" or "Disabled"
		Frame.TextButton.BackgroundColor3 = Value and Color3.fromRGB(132, 217, 87) or Color3.fromRGB(161, 161, 161)
	end
end

local function CreateSettings()
	local PlayerData = _G.PData
	local Frame = UI.Tabs.Settings.Icon.Settings
	for Name, Value in PlayerData.Options do
		local Clone = Frame.UIListLayout.Template:Clone()
		Clone.Name = Name
		Clone.TextLabel.Text = Name
		Clone.TextLabel.TextLabel.Text = Name
		--Clone.TextButton.TextLabel.Text = Value and "Enabled" or "Disabled"
		--Clone.TextButton.BackgroundColor3 = Value and Color3.fromRGB(39, 255, 39) or Color3.fromRGB(255, 26, 26)
		Clone.Parent = Frame
		UpdateSetting(Name)
		Clone.TextButton.MouseButton1Click:Connect(function()
			Remotes.ChangeSetting:FireServer(Name)
		end)
	end
end
CreateSettings()
local function CreateBoosts()
	for _, v in pairs(game.ReplicatedStorage.Boosts:GetChildren()) do
		local Mod = require(v)
		local BoostTemp = script.Boost:Clone()
		BoostTemp.Visible = false
		BoostTemp.LayoutOrder = Mod.Layout
		BoostTemp.Icon.Image = Mod.BoostImage
		BoostTemp.BackgroundColor3 = Mod.Color
		BoostTemp.Fill.BackgroundColor3 = Mod.Color
		BoostTemp.Name = Mod.Name

		if _G.PData.Boosts[Mod.Name] then
			BoostTemp.Visible = true
			BoostTemp.Hover.Disabled = false
			BoostTemp.Amount.Text = "x".._G.PData.Boosts[Mod.Name].Amount
			BoostTemp.Amount.Amount.Text = "x".._G.PData.Boosts[v.Name].Amount
			BoostTemp.Icon.Size = UDim2.new(0.9,0,0.9,0)
		end

		BoostTemp.Parent = UI.Boosts
	end
end
CreateBoosts()

local function CountBoosts()
	local t = 0
	for i, v in pairs(_G.PData.Boosts) do
		t += 1
	end
	return t
end
local function UpdBoost(Boost)
	local Frame = UI.Boosts[Boost]
	local ABoosts = CountBoosts()
	local Info = _G.PData.Boosts[Boost]
	local Amount = Info.Amount

	if Amount > 0 then
		Frame.Visible = true
		Frame.Amount.Text = "x"..Amount
		Frame.Amount.Amount.Text = "x"..Amount
		Frame.Hover.Disabled = false
		Frame:TweenSize(UDim2.new(0.07, 0, 0.7, 0), "Out", "Back", 0.2, true)
		Frame.Icon:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true)
		spawn(function()
			wait(0.2)
			Frame:TweenSize(UDim2.new(0.1, 0, 1, 0), "Out", "Back", 0.3, true)
			Frame.Icon:TweenSize(UDim2.new(0.9, 0, 0.9, 0), "Out", "Back", 0.3, true)
		end)
	else
		Frame:TweenSize(UDim2.new(0.07, 0, 0.7, 0), "Out", "Back", 0.2, true)
		Frame.Icon:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true)
		spawn(function()
			wait(0.2)
			Frame.Visible = false
		end)
	end
end

local function CreateItemDecal(Name, Item, Pos)
	if _G.PData.Vars.Hive ~= "" then
		local NewItem = Item:Clone()
		NewItem.Visible = true
		NewItem.ImageTransparency = 0.15
		NewItem.AnchorPoint = Vector2.new(0.5, 0.85)
		NewItem.Position = UDim2.new(0, Pos.X / UI.UIScale.Scale, 0, Pos.Y / UI.UIScale.Scale)
		NewItem.Size = UDim2.new(0, 0, 0, 0)
		NewItem.BackgroundTransparency = 1
		NewItem.ZIndex = 9999
		NewItem.Name = "Drag"
		NewItem.Parent = UI
		NewItem:TweenSize(UDim2.new(0, 90, 0, 90), "Out", "Back", 0.33, true)
	end
end
local function HighlightHive(HiveGiven)
	if ItemModule.Type == "Egg" then
		for _, Slot in pairs(HiveGiven:GetChildren()) do
			if Slot:IsA("BasePart")	 then
				Slot.Material = Enum.Material.Neon
				Slot.Color = Color3.fromRGB(75, 171, 97)
				Slot.Transparency = 0
			else
				local BeeMod = require(game.ReplicatedStorage.Bees[Slot.BeeN.Value])
				Slot.Color = ColorsSSS[BeeMod.Rarity]
				Slot.Material = Enum.Material.SmoothPlastic
				Slot.Transparency = 0
			end
		end
	elseif ItemModule.Type == "Food" then
		for _, Slot in pairs(HiveGiven:GetChildren()) do
			if Slot:IsA("BasePart") and Slot.BeeN.Value ~= "" then
				if _G.PData.Bees[tonumber(Slot.Name)].Level < 15 then
					Slot.Material = Enum.Material.Neon
					Slot.Color = Color3.fromRGB(75, 171, 97)
					Slot.Transparency = 0
				end
			end
		end
	elseif ItemModule.Type == "EffectFood" then
		for _, Slot in pairs(HiveGiven:GetChildren()) do
			if Slot:IsA("BasePart") and Slot.BeeN.Value ~= "" then
				Slot.Material = Enum.Material.Neon
				Slot.Color = Color3.fromRGB(75, 171, 97)
				Slot.Transparency = 0
			end
		end
	elseif ItemModule.Type == "Jelly" then
		for _, Slot in pairs(HiveGiven:GetChildren()) do
			if Slot:IsA("BasePart") and Slot.BeeN.Value ~= "" then
				Slot.Material = Enum.Material.Neon
				Slot.Color = Color3.fromRGB(75, 171, 97)
				Slot.Transparency = 0
			end
		end
	end
end

local function ClearHive(Hive)
	for _, Slot in pairs(Hive:GetChildren()) do
		if Slot:IsA("BasePart") then
			if Slot.BeeN.Value == "" then
				Slot.Material = Enum.Material.SmoothPlastic
				Slot.Color = Color3.fromRGB(25,25,25)
				Slot.Transparency = 0.5
			else
				local BeeMod = require(game.ReplicatedStorage.Bees[Slot.BeeN.Value])
				Slot.Material = Enum.Material.SmoothPlastic
				Slot.Color = ColorsSSS[BeeMod.Rarity]
				Slot.Transparency = 0
			end
		end
	end
end

local function UpdPlayersSBJP()
	
end

local function EndEgg()
	if Dragging and _G.PData.Vars.Hive ~= "" then
		Dragging = false
		ClearHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
		spawn(function()
			wait(0.25)
			UI.UseItem:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.2, true)
			spawn(function()
				wait(0.2)
				UI.UseItem.Visible = false
			end)
		end)
		--if HotbarSlot > 0 then
		--	if Hotbar[HotbarSlot].Item.Image == ItemModule.Image then
		--		Hotbar[HotbarSlot].Item.Image = ""

		--		Hotbar[HotbarSlot].BackgroundColor3 = Color3.fromRGB(102, 80, 63)
		--		Hotbar[HotbarSlot].Out.ImageColor3 = Color3.fromRGB(227, 178, 140)

		--		Hotbar[HotbarSlot].Amount.Text = ""
		--	else
		--		if CheckAllHot(ItemModule.Image) then
		--			local it = CheckAllHot(ItemModule.Image)
		--			it.Amount.Text = ""
		--			it.BackgroundColor3 = Color3.fromRGB(102, 80, 63)
		--			it.Out.ImageColor3 = Color3.fromRGB(227, 178, 140)
		--			it.Item.Image = ""
		--		end
		--		Hotbar[HotbarSlot].Item.Image = ItemModule.Image

		--		Hotbar[HotbarSlot].Out.ImageColor3 = Color3.fromRGB(75, 59, 46)
		--		Hotbar[HotbarSlot].BackgroundColor3 = Color3.fromRGB(139, 109, 86)

		--		Hotbar[HotbarSlot].Amount.Text = "x"..Utils:AbNumber(_G.PData.Inventory[ItemModule.Name])
		--	end
		--end
		--for i,v in pairs(Hotbar:GetChildren()) do
		--	v:TweenSize(UDim2.new(0.175, 0, 1, 0), "Out", "Back", 0.3, true)
		--	if v.Item.Image ~= "" then
		--		v.BackgroundColor3 = Color3.fromRGB(139, 109, 86)
		--		v.Out.ImageColor3 = Color3.fromRGB(75, 59, 46)
		--	else
		--		v.BackgroundColor3 = Color3.fromRGB(102, 80, 63)
		--		v.Out.ImageColor3 = Color3.fromRGB(227, 178, 140)
		--	end
		--end
		if ItemModule.Type == "Egg" then
			if ChoosenSlot then
				Remotes.CreateBeeSlot:FireServer(ItemPicked.Name, ChoosenSlot)
			end
		elseif ItemModule.Type == "Jelly" then
			if ChoosenSlot then
				Remotes.CreateBeeSlot:FireServer(ItemPicked.Name, ChoosenSlot)
			end
		elseif ItemModule.Type == "Food" then
			if ChoosenSlot then
				Remotes.OpenFoodGui:FireServer(ItemPicked.Name)
				_G.ItemName = ItemPicked.Name
				_G.CSlot = ChoosenSlot
			end
		elseif ItemModule.Type == "EffectFood" then
			if ChoosenSlot then
				Remotes.FoodBee:FireServer(ItemPicked.Name, ChoosenSlot, "EffectFood", 1)
			end
		elseif ItemModule.Type == "FieldEffect" or ItemModule.Type == "Boost" or ItemModule.Type == "Effect" or ItemModule.Type == "Sprout" then
			if PutItem then
				Remotes.UseItem:FireServer(ItemPicked.Name)
			end
		end
	end
end

local function CloseAllMenus()
	for _, Tab in pairs(UI.Tabs:GetChildren()) do
		Tab:TweenPosition(UDim2.new(-1, 0, 0.5, 0), "Out", "Back", 0.2, true)
		spawn(function()
			wait(0.3)
			Tab.Visible = false
		end)
	end
end

local function OpenMenu(Menu)
	UI.Tabs[Menu]:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.2, true)
	UI.Tabs[Menu].Visible = true
end

local function UpdHUD()
	UI.HUD.Honey.Msg.Text = Utils:CommaNumber(_G.PData.IStats.Honey)
	UI.HUD.Honey.Msg.Msg.Text = Utils:CommaNumber(_G.PData.IStats.Honey)

	UI.HUD.Pollen.Msg.Text = Utils:CommaNumber(_G.PData.IStats.Pollen).."/"..Utils:CommaNumber(_G.PData.IStats.Capacity)
	UI.HUD.Pollen.Msg.Msg.Text = Utils:CommaNumber(_G.PData.IStats.Pollen).."/"..Utils:CommaNumber(_G.PData.IStats.Capacity)

	UI.HUD.Pollen.Fill:TweenSize(UDim2.new(math.clamp(_G.PData.IStats.Pollen/_G.PData.IStats.Capacity, 0, 1), 0, 1, 0), "Out", "Back", 0.25, true)
end
UpdHUD()
local function BeeInfo()
	for _, Slot in pairs(workspace.Hives[_G.PData.Vars.Hive].Slots:GetChildren()) do
		if _G.PData.Bees[tonumber(Slot.Name)].BeeName ~= "" and Slot:FindFirstChild("Dc") then
			Slot.Dc.UI.Decal.MouseButton1Click:Connect(function()
				UI.BeeInfo.Size = UDim2.new(0, 148, 0, 190)
				UI.BeeInfo:TweenSize(UDim2.new(0, 295, 0, 380), "Out", "Back", 0.25, true)

				UI.BeeInfo.Close.MouseButton1Click:Connect(function()
					UI.BeeInfo:TweenSize(UDim2.new(0, 29, 0, 38), "Out", "Back", 0.25, true)
					spawn(function()
						wait(0.2)
						UI.BeeInfo.Visible = false
					end)
				end)

				local BeI = _G.PData.Bees[tonumber(Slot.Name)]
				local BeI_M = require(game.ReplicatedStorage.Bees[BeI.BeeName])
				UI.BeeInfo.BeeName.BeeName.Bee.Text = BeI.BeeName.." Bee"
				UI.BeeInfo.BeeName.BeeName.Bee.QName.Text = BeI.BeeName.." Bee"
				UI.BeeInfo.BeeName.BeeName.Rare.Text = BeI_M.Rarity
				UI.BeeInfo.BeeName.BeeName.Rare.QName.Text = BeI_M.Rarity
				UI.BeeInfo.BeeName.BeeName.Rare.QName.TextColor3 = ColorsSSS[BeI_M.Rarity]

				UI.BeeInfo.BeeFrame.IMG.Image = BeI_M.Thumb

				UI.BeeInfo.Energy.QName.Text = BeI.Energy.."/"..BeI.ELimit
				UI.BeeInfo.Energy.QName.QName2.Text = BeI.Energy.."/"..BeI.ELimit

				UI.BeeInfo.Bond.QName.Text = BeI.Bond.."/"..BeeLevels[BeI.Level]
				UI.BeeInfo.Bond.QName.QName2.Text = BeI.Bond.."/"..BeeLevels[BeI.Level]

				UI.BeeInfo.BackgroundColor3 = ColorsSSS[BeI_M.Rarity]
				local Collects = BeI_M.StatsModule.Collecting
				local Color = BeI_M.StatsModule.Color
				local ColorMult = BeI_M.StatsModule.ColorMutltiplier

				UI.BeeInfo.Stats.Collect.White.QName.Text = Collects
				UI.BeeInfo.Stats.Collect.Blue.QName.Text = Collects
				UI.BeeInfo.Stats.Collect.Red.QName.Text = Collects
				if Color ~= "None" then
					UI.BeeInfo.Stats.Collect[Color].QName.Text = Collects * ColorMult
				end

				UI.BeeInfo.Stats.Convert.Pollen.QName.Text = BeI_M.Converts
				UI.BeeInfo.Stats.Convert.Arrow.QName.Text = BeI_M.ConvertsTime.."s"
				UI.BeeInfo.Stats.Convert.Honey.QName.Text = BeI_M.Converts

				UI.BeeInfo.Stats.Attack.QName.QName.Text = "Damage: "..BeI_M.Attack
				UI.BeeInfo.Stats.Attack.QName.Text = "Damage: "..BeI_M.Attack

				UI.BeeInfo.Stats.Speed.QName.QName.Text = "Speed: "..BeI_M.Speed
				UI.BeeInfo.Stats.Speed.QName.Text = "Speed: "..BeI_M.Speed

				Hovers:Move(UDim2.new(0, (UserInputService:GetMouseLocation().X / Scale) + 20, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075)+10), Scale, Vector2.new(0,0), UI.BeeInfo)

				UI.BeeInfo.Bond.Bar:TweenSize(UDim2.new(math.clamp(BeI.Bond/BeeLevels[BeI.Level], 0, 1), 0, 1, 0), "Out", "Back", 0.2, true)
				UI.BeeInfo.Energy.Bar:TweenSize(UDim2.new(math.clamp(BeI.Energy/BeI.ELimit, 0, 1), 0, 1, 0), "Out", "Back", 0.2, true)
			end)
		end
	end
end

local function UpdateInventory()
	for _, Ex in pairs(UI.Tabs.Inventory.Icon.List:GetChildren()) do
		if Ex:IsA("ImageButton") then
			local pamount = _G.PData.Inventory[Ex.Name]
			local IMod = Eggs[Ex.Name]

			--if IMod.Settings then
			--	if IMod.Settings.AmountHide then
			--		Ex.Am.Text = ""
			--		Ex.Am.Am.Text = ""
			--	else
			--		Ex.Am.Text = Utils:AbNumber(pamount)
			--		Ex.Am.Am.Text = Utils:AbNumber(pamount)
			--	end
			--end

			Ex.Am.Text = Utils:AbNumber(pamount)
			Ex.Am.Am.Text = Utils:AbNumber(pamount)

			if pamount ~= 0 then
				Ex.Visible = true
				Ex.Icon:TweenSize(UDim2.new(0.85,0,0.85,0), "Out", "Elastic", 0.33, true)
			else
				Ex.Icon:TweenSize(UDim2.new(0,0,0,0), "Out", "Elastic", 0.33, true)
				spawn(function()
					wait(0.3)
					Ex.Visible = false
				end)
			end
		end
	end
end

local function MakeInv()
	for Item, Amount in pairs(_G.PData.Inventory) do
		local Ex = script.Item:Clone()
		local IMod = Eggs[Item]

		Ex.Name = Item

		if IMod.Settings.AmountHide then
			Ex.Am.Text = ""
			Ex.Am.Am.Text = ""
		else
			Ex.Am.Text = Utils:AbNumber(Amount)
            Ex.Am.Am.Text = Utils:AbNumber(Amount)
		end

		Ex.Icon.Image = IMod.Image
		Ex.LayoutOrder = IMod.Layout

		Ex.Parent = UI.Tabs.Inventory.Icon.List
		if Amount > 0 then
			Ex.Visible = true
			Ex.Icon:TweenSize(UDim2.new(0.85,0,0.85,0), "Out", "Elastic", 0.1, true)
		else
			Ex.Visible = false
			Ex.Icon:TweenSize(UDim2.new(0,0,0,0), "Out", "Elastic", 0.1, true)
		end

		Ex.MouseEnter:Connect(function()
			script.Enter:Play()
			UI.ItemInfo.Item.Text = Item
			UI.ItemInfo.Desc.Text = IMod.Description

			Ex.Icon:TweenSize(UDim2.new(0.95, 0, 0.95, 0), "Out", "Elastic", 0.35, true)
			TS:Create(Ex.Icon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 6}):Play()

			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0), UI.ItemInfo)
		end)
		Ex.MouseMoved:Connect(function()
			UI.ItemInfo.Item.Text = Item
			UI.ItemInfo.Desc.Text = IMod.Description

			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0), UI.ItemInfo)
		end)
		Ex.MouseLeave:Connect(function()
			TS:Create(Ex.Icon, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
			Ex.Icon:TweenSize(UDim2.new(0.85, 0, 0.85, 0), "Out", "Elastic", 0.35, true)
			Hovers:Remove(UI.ItemInfo)
		end)

		Ex.Icon.MouseButton1Down:Connect(function()
			Ex.Icon:TweenSize(UDim2.new(0.72, 0, 0.72, 0), "Out", "Back", 0.35, true)
			if _G.PData.Vars.Hive ~= "" then
				if not Dragging then
					Dragging = true
					ItemPicked = Ex
					ItemModule = IMod
					if ItemModule.Type == "Egg" or ItemModule.Type == "Food" or ItemModule.Type == "EffectFood" or ItemModule.Type == "Jelly" then
						if _G.PData.Vars.Hive ~= "" then
							HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
						end 
					elseif ItemModule.Type == "Effect" or ItemModule.Type == "Boost" or ItemModule.Type == "Sprout" then
						UI.UseItem:TweenSize(UDim2.new(0, 1200, 0, 800), "Out", "Back", 0.2, true)
						UI.UseItem.Visible = true
						--elseif HotbarItems[Item.Name] then
						--	for i,v in pairs(Hotbar:GetChildren()) do
						--		v:TweenSize(UDim2.new(0.19*1.15, 0, 1.1*1.15, 0), "Out", "Back", 0.3, true)
						--		v.BackgroundColor3 = Color3.fromRGB(124, 195, 109)
						--		v.Out.ImageColor3 = Color3.fromRGB(124, 195, 109)

						--		v.Enter.MouseEnter:Connect(function()
						--			HotbarSlot = tonumber(v.Name)
						--		end)
						--		v.Enter.MouseLeave:Connect(function()
						--			HotbarSlot = 0
						--		end)
						--	end
					end
				end
			end
		end)
		Ex.Icon.MouseButton1Up:Connect(function()
			Ex.Icon:TweenSize(UDim2.new(0.95, 0, 0.95, 0), "Out", "Back", 0.35, true)
		end)
	end
end

local function CreateQuests()
	for NPC, Data in _G.PData.Quests do
		if Data.Claimed then
			Quests.Update(NPC)
		end
	end
end
CreateQuests()

local function rotatetokens()
	RunService.RenderStepped:Connect(function(deltaTime)
		local Tokens = {}
		for i, Token in workspace.Tokens:GetChildren() do
			table.insert(Tokens, Token)
		end
		if workspace.PlayersE:FindFirstChild(Player.Name) then
			for i, Token in workspace.PlayersE[Player.Name].Tokens:GetChildren() do
				table.insert(Tokens, Token)
			end
		end
		
		for _, Token in Tokens do
			Token.CFrame *= CFrame.Angles(0, math.rad(1.5), 0)
		end
	end)
	--if #workspace.Tokens:GetChildren() >= 1 then
	--	for _, token in pairs(workspace.Tokens:GetChildren()) do
	--		token.Orientation += Vector3.new(0, 1, 0)
	--	end
	--end
	--wait(0.15)
end
local function rotatetokens2()
	if workspace.PlayersE:FindFirstChild(Player.Name) then
		if #workspace.PlayersE[Player.Name].Tokens:GetChildren() >= 1 then
			for _, token in pairs(workspace.PlayersE[Player.Name].Tokens:GetChildren()) do
				token.Orientation += Vector3.new(0, 1, 0)
			end
		end
		wait(0.15)
	end
end

MakeInv()
if UserInputService.TouchEnabled then
	UserInputService.TouchEnded:Connect(function(Input, GPE)
		EndEgg()
		if UI:FindFirstChild("Drag") then
			ItemPicked.Icon.Size = UDim2.new(0,0,0,0)
			ItemPicked.Icon.Visible = true
			ItemPicked.Icon:TweenSize(UDim2.new(0.85, 0, 0.85, 0), "Out", "Back", 0.33, true)
			UI:FindFirstChild("Drag"):Destroy()
		end
		ChoosenSlot = nil
		--UI.UItem:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.2, true)
		--wait(0.1)
		--UI.UItem.Visible = false
	end)
end

UserInputService.InputEnded:Connect(function(key)
	if key.UserInputType == Enum.UserInputType.MouseButton1 then
		EndEgg()
		if UI:FindFirstChild("Drag") then
			ItemPicked.Icon.Size = UDim2.new(0,0,0,0)
			ItemPicked.Icon.Visible = true
			ItemPicked.Icon:TweenSize(UDim2.new(0.85, 0, 0.85, 0), "Out", "Back", 0.33, true)
			UI:FindFirstChild("Drag"):Destroy()
		end
		ChoosenSlot = nil
		--UI.UItem:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.2, true)
		--wait(0.1)
		--UI.UItem.Visible = false
	end
end)
--Animations
for _, Btn in pairs(UI.Btns:GetChildren()) do
	if Btn.Name ~= "UIListLayout" then
		Btn.Icon.MouseButton1Down:Connect(function()
			Btn:TweenSize(UDim2.new(1 * 0.85, 0, 0.167 * 0.85, 0), "Out", "Back", 0.2, true)
		end)
		Btn.Icon.MouseButton1Up:Connect(function()
			script.Click:Play()
			Btn:TweenSize(UDim2.new(1 * 1.2, 0, 0.167 * 1.2, 0), "Out", "Back", 0.2, true)

			if OpenedMenu ~= Btn.Name then
				OpenedMenu = Btn.Name
				CloseAllMenus()
				spawn(function()
					wait(0.3)
					OpenMenu(Btn.Name)
				end)
			else
				OpenedMenu = ""
				CloseAllMenus()
			end
		end)

		Btn.Icon.MouseEnter:Connect(function()
			script.Enter:Play()
			Hovers:UpdateText(Btn.Name)
			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
			Btn.Icon.ImageTransparency = 0
			Btn:TweenSize(UDim2.new(1 * 1.2, 0, 0.167 * 1.2, 0), "Out", "Back", 0.3, true)
			TS:Create(Btn.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 5}):Play()
		end)
		Btn.Icon.MouseMoved:Connect(function()
			Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.1), 0), Scale, Vector2.new(0,0.22))
			Btn:TweenSize(UDim2.new(1 * 1.2, 0, 0.167 * 1.2, 0), "Out", "Back", 0.3, true)
		end)
		Btn.Icon.MouseLeave:Connect(function()
			Hovers:Remove()
			Btn.Icon.ImageTransparency = 0.2
			Btn:TweenSize(UDim2.new(1, 0, 0.167, 0), "Out", "Back", 0.3, true)
			TS:Create(Btn.Icon, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = 0}):Play()
		end)
	end
end

UI.HUD.Honey.MouseEnter:Connect(function()
	script.Enter:Play()
	Hovers:UpdateText("Honey")
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0.5))
	UI.HUD.Honey:TweenSize(UDim2.new(1.014*1.1, 0, 0.896*1.1, 0), "Out", "Back", 0.3, true)
end)
UI.HUD.Honey.MouseMoved:Connect(function()
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0.5))
end)
UI.HUD.Honey.MouseLeave:Connect(function()
	UI.HUD.Honey:TweenSize(UDim2.new(1.014, 0, 0.896, 0), "Out", "Back", 0.3, true)
	Hovers:Remove()
end)

UI.HUD.Pollen.MouseEnter:Connect(function()
	script.Enter:Play()
	Hovers:UpdateText("Pollen")
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0.5))
	UI.HUD.Pollen:TweenSize(UDim2.new(1.014*1.1, 0, 0.896*1.1, 0), "Out", "Back", 0.3, true)
end)
UI.HUD.Pollen.MouseMoved:Connect(function()
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(0,0.5))
end)
UI.HUD.Pollen.MouseLeave:Connect(function()
	UI.HUD.Pollen:TweenSize(UDim2.new(1.014, 0, 0.896, 0), "Out", "Back", 0.3, true)
	Hovers:Remove()
end)


UI.HPBar.MouseEnter:Connect(function()
	script.Enter:Play()
	Hovers:UpdateText("Your Health")
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(1,0.5))
	UI.HPBar:TweenSize(UDim2.new(0, 260*1.1, 0, 27*1.1), "Out", "Back", 0.3, true)
end)
UI.HPBar.MouseMoved:Connect(function()
	Hovers:Move(UDim2.new(0, UserInputService:GetMouseLocation().X / Scale, 0, UserInputService:GetMouseLocation().Y / (Scale * 1.075), 0), Scale, Vector2.new(1,0.5))
end)
UI.HPBar.MouseLeave:Connect(function()
	UI.HPBar:TweenSize(UDim2.new(0, 260, 0, 27), "Out", "Back", 0.3, true)
	Hovers:Remove()
end)

Remotes.Effects.OnClientEvent:Connect(function(Effect)
	spawn(function()
		if Effect == "Test" then
			print("Test")
		end
	end)
end)
Remotes.UpdateClientBoost.OnClientEvent:Connect(function(BoostType, BoostAmount, BoostTime)
	local v = UI.Boosts:FindFirstChild(BoostType)
	if v and tonumber(BoostAmount) > 0 then
		spawn(function()
			v.Visible = true
			v.Size = UDim2.new(0.07,0,0.5,0)
			v.Hover.Disabled = false
			TS:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.14,0,1,0)}):Play()
			v.Bar.Size = UDim2.new(1,0,1,0)
			if _G.PData.Boosts[v.Name] then
				if _G.PData.Boosts[v.Name].Amount > 1 then
					v.Count.Text = "x".._G.PData.Boosts[v.Name].Amount
				else
					v.Count.Text = ""
				end
			else
				v.Visible = false
			end
			spawn(function()
				wait(BoostTime)
				UpdateBoosts()
			end)
		end)
	end
end)
Remotes.DataUpdated.OnClientEvent:Connect(function(Info)
	if _G.PData then
		if #Info == 2 then
			_G.PData[Info[1]] = Info[2]
		elseif #Info == 3 then
			_G.PData[Info[1]][Info[2]] = Info[3]
		elseif #Info == 4 then
			_G.PData[Info[1]][Info[2]][Info[3]] = Info[4]
		elseif #Info == 5 then
			_G.PData[Info[1]][Info[2]][Info[3]][Info[4]] = Info[5]
		end
		if Info[1] == "Quests" then
			Quests.Update(Info[2])
		end
		if Info[1] == "Boosts" then
			UpdateBoosts()
		end
		if Info[1] == "Inventory" then
			UpdateInventory()
		end
		if Info[1] == "IStats" then
			UpdHUD()
		end
		if Info[1] == "Boosts" then
			if Info[3] then
				UpdBoost(Info[2])
			end
		end
		if Info[1] == "DiscoveredBees" then
			UpdateIndexStats()
		end
		if Info[1] == "Bees" then
			UpdateIndexStats()
			UpdateGates()
			if _G.PData.Vars.Hive ~= "" then
				BeeInfo()
			end
		end
		
		if Info[1] == "Badges" then
			UpdateBadges()
		end
		if Info[1] == "Options" then
			UpdateSetting(Info[2])
		end

		if script.Parent.Shop.Visible then
			Shops.Update()
		end
	else
		_G.PData = Remotes.GetPlayerData:InvokeServer()
	end
end)

--// Actions
local Action
local ActionParams

function CheckActions()
	script.Click:Play()
	if Action == "ClaimHive" then
		Remotes.ClaimHive:FireServer(ActionParams)
		wait(5)
		BeeInfo()
	elseif Action == "ShopOpen" then
		Shops.Open(ActionParams)
		--UI.Action:TweenPosition(UDim2.new(0.5, 0, 0.97, 0), "Out", "Back", 0.3, true)
	elseif Action == "ShopClose" then
		Shops.Close()
	elseif Action == "StopHoney" then
		Remotes.ConvertPollen:FireServer(false)
		_G.PData.Vars.Making = false
	elseif Action == "MakeHoney" then
		Remotes.ConvertPollen:FireServer(true)
		_G.PData.Vars.Making = true
	elseif Action == "TalkWith" then
		Quests.StartDialogue(ActionParams)
	end
end

local ActBar = UI.Action
local TS = game:GetService("TweenService")

ActBar.MouseEnter:Connect(function()
	script.Enter:Play()
	TS:Create(ActBar.UIGradient, TweenInfo.new(0.4), {Rotation = 25}):Play()
	ActBar:TweenSize(UDim2.new(0, 350*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)
ActBar.MouseMoved:Connect(function()
	ActBar:TweenSize(UDim2.new(0, 350*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)
ActBar.MouseLeave:Connect(function()
	TS:Create(ActBar, TweenInfo.new(0.4), {Rotation = 0}):Play()
	TS:Create(ActBar.UIGradient, TweenInfo.new(0.4), {Rotation = -30}):Play()
	ActBar:TweenSize(UDim2.new(0, 350, 0, 60), "Out", "Back", 0.3, true)
end)

ActBar.MouseButton1Down:Connect(function()
	TS:Create(ActBar, TweenInfo.new(0.4), {Rotation = -3}):Play()
	ActBar:TweenSize(UDim2.new(0, 350*0.85, 0, 60*0.85), "Out", "Back", 0.3, true)
end)
ActBar.MouseButton1Up:Connect(function()
	CheckActions()
	TS:Create(ActBar, TweenInfo.new(0.4), {Rotation = 0}):Play()
	ActBar:TweenSize(UDim2.new(0, 350*1.2, 0, 60*1.2), "Out", "Back", 0.3, true)
end)

UserInputService.InputEnded:Connect(function(Input, GPE)
	if not GPE then
		if Input.KeyCode == Enum.KeyCode.E then
			if Action ~= nil then
				TS:Create(ActBar, TweenInfo.new(0.4), {Rotation = 0}):Play()
				ActBar:TweenSize(UDim2.new(0, 350, 0, 60), "Out", "Back", 0.3, true)

				ActBar.Key:TweenSize(UDim2.new(0, 45, 0, 45), "Out", "Back", 0.3, true)
				ActBar.Key.Rotation = 0
				TS:Create(ActBar.UIGradient, TweenInfo.new(0.4), {Rotation = -30}):Play()
				CheckActions()
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(Input, GPE)
	if not GPE then
		if Input.KeyCode == Enum.KeyCode.E then
			TS:Create(ActBar, TweenInfo.new(0.4), {Rotation = -3}):Play()
			ActBar:TweenSize(UDim2.new(0, 350*0.85, 0, 60*0.85), "Out", "Back", 0.3, true)
			TS:Create(ActBar.UIGradient, TweenInfo.new(0.4), {Rotation = 25}):Play()

			ActBar.Key:TweenSize(UDim2.new(0, 45/1.1, 0, 45/1.1), "Out", "Back", 0.3, true)
			ActBar.Key.Rotation = 3
			--elseif Input.KeyCode == Enum.KeyCode.One then
			--	HotbarUse(1)
			--elseif Input.KeyCode == Enum.KeyCode.Two then
			--	HotbarUse(2)
			--elseif Input.KeyCode == Enum.KeyCode.Three then
			--	HotbarUse(3)
			--elseif Input.KeyCode == Enum.KeyCode.Four then
			--	HotbarUse(4)
			--elseif Input.KeyCode == Enum.KeyCode.Five then
			--	HotbarUse(5)
		end
	end
end)
local ActColors = {
	["Red"] = Color3.fromRGB(255, 110, 110),
	["Blue"] = Color3.fromRGB(137, 167, 231),
	["Green"] = Color3.fromRGB(152, 255, 167)
}

local function ChangeAction(Color, Text)
	ActBar.TextLabel.Text = Text
	ActBar.BackgroundColor3 = ActColors[Color]
end
local function CanvasLists()
	for _, v in pairs(UI.Tabs:GetChildren()) do
		if(v.Name == "Developer Menu") then
			if v.Handler:FindFirstChild("List") and v.Handler:FindFirstChild("List"):FindFirstChild("UIListLayout") then
				v.Handler:FindFirstChild("List").CanvasSize = UDim2.new(0,0,0,v.Handler:FindFirstChild("List"):FindFirstChild("UIListLayout").AbsoluteContentSize.Y / Scale)
			end
		else
			if v.Icon:FindFirstChild("List") and v.Icon:FindFirstChild("List"):FindFirstChild("UIListLayout") then
				v.Icon:FindFirstChild("List").CanvasSize = UDim2.new(0,0,0,v.Icon:FindFirstChild("List"):FindFirstChild("UIListLayout").AbsoluteContentSize.Y / Scale)
			end
		end
	end
end

rotatetokens()
RunService.RenderStepped:Connect(function(deltaTime)
	Character = game.Workspace:WaitForChild(Player.Name)
	if Character and Character.PrimaryPart then
		Scale = UI.AbsoluteSize.Y / 1080 * 1.075
		UIScale.Scale = Scale

		CanvasLists()
		--rotatetokens2()
		--rotatetokens()

		if Action then
			UI.Action:TweenPosition(UDim2.new(0.5, 0, 0.97, 0), "Out", "Back", 0.3, true)
		else
			UI.Action:TweenPosition(UDim2.new(0.5, 0, 1.2, 0), "Out", "Back", 0.3, true)
			_G.PData.Vars.Making = false
		end
		Action = nil

		for _, Shop in pairs(workspace.Map.Shops:GetChildren()) do
			if Utils.CheckMag(Character.PrimaryPart, Shop:WaitForChild("Region"), Shop:WaitForChild("Region").Val.Value) then
				ActionParams = Shop.Name
				if not UI.Shop.Visible then
					ChangeAction("Green", "Enter in Shop")
					Action = "ShopOpen"
				else
					ChangeAction("Red", "Leave the Shop")
					Action = "ShopClose"
				end
			end
		end
		
		for _, NPC in workspace.Quests:GetChildren() do
			if Utils.CheckMag(Character.PrimaryPart, NPC:WaitForChild("Circle"), 11) and not Quests.Talking then
				ActionParams = NPC.Name
				Action = "TalkWith"
				ChangeAction("Green", "Talk with "..NPC.Name)
			end
		end

		for _, Hive in pairs(workspace.Hives:GetChildren()) do
			if _G.PData.Vars.Hive == "" and Hive.Owner.Value == "" then
				Hive.Pad.Circle.PointAt.BillboardGui.Enabled = true
			else
				Hive.Pad.Circle.PointAt.BillboardGui.Enabled = false
			end

			if Utils.CheckMag(Character.PrimaryPart, Hive.Pad.Circle, 11) then
				ActionParams = Hive
				if _G.PData.Vars.Hive == "" then
					if Hive.Owner.Value == "" then
						Action = "ClaimHive"
						ChangeAction("Green", "Claim Hive")
					else
						Action = "CantClaimHive"
						ChangeAction("Blue", Hive.Owner.Value.."'s Hive")
					end
				else
					if Hive.Owner.Value == Player.Name then
						if _G.PData.IStats.Pollen > 0 then
							if _G.PData.Vars.Making then
								Action = "StopHoney"
								ChangeAction("Red", "Stop Making Honey")
							else
								Action = "MakeHoney"
								ChangeAction("Green", "Make Honey")
							end
						else
							Action = "FarmField"
							ChangeAction("Blue", "Your backpack is empty")
						end
					end
				end
			end
		end

		if Dragging and ItemModule.Settings.CanInput then
			if not UI:FindFirstChild("Drag") then
				local mousePos = UserInputService:GetMouseLocation()
				ItemPicked.Icon.Visible = false
				CreateItemDecal(ItemPicked.Name, ItemPicked.Icon, mousePos)
				if _G.PData.Vars.Hive ~= "" then
					HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
				end
			else
				local mousePos = UserInputService:GetMouseLocation()
				local dragable = UI:FindFirstChild("Drag")

				dragable.Position = UDim2.new(0, mousePos.X / UI.UIScale.Scale, 0, mousePos.Y / UI.UIScale.Scale)

				if ItemModule.Type == "Egg" or ItemModule.Type == "Food" or ItemModule.Type == "EffectFood" or ItemModule.Type == "Jelly" then
					local RayParams = RaycastParams.new()
					RayParams.FilterType = Enum.RaycastFilterType.Exclude
					RayParams.FilterDescendantsInstances = {Player.Character, workspace.PlayersE}

					local MousePosition = UserInputService:GetMouseLocation()
					local UnitRay = Camera:ViewportPointToRay(MousePosition.X, MousePosition.Y)

					local Result = workspace:Raycast(UnitRay.Origin, UnitRay.Direction * 90, RayParams)
					if _G.PData.Vars.Hive ~= "" then
						HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)

						if Result and Result.Instance then
							if Result.Instance:IsA("MeshPart") and Result.Instance.Parent == workspace.Hives[_G.PData.Vars.Hive].Slots and Result.Instance.BeeN.Value == "" then
								local Slot = Result.Instance
								if ItemModule.Type == "Egg" then
									HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
									Slot.Material = Enum.Material.Neon
									Slot.Color = Color3.fromRGB(135, 236, 124)
									Slot.Transparency = 0
									ChoosenSlot = Slot
								end
							elseif (Result.Instance:IsA("MeshPart") or Result.Instance:IsA("BasePart")) and (Result.Instance.Parent == workspace.Hives[_G.PData.Vars.Hive].Slots or (Result.Instance.Parent:FindFirstChild("BeeN") and Result.Instance.Parent.Parent == workspace.Hives[_G.PData.Vars.Hive].Slots)) then
								local Slot
								if Result.Instance.Parent:FindFirstChild("BeeN") then
									Slot = Result.Instance.Parent
								else
									Slot = Result.Instance
								end
								if Slot.BeeN.Value ~= "" then
									if ItemModule.Type == "Food" or ItemModule.Type == "EffectFood" or ItemModule.Type == "Jelly" then
										if ItemModule.Type == "Food" then
											if _G.PData.Bees[tonumber(Slot.Name)].Level < 15 then
												HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
												Slot.Material = Enum.Material.Neon
												Slot.Color = Color3.fromRGB(135, 236, 124)
												Slot.Transparency = 0
												ChoosenSlot = Slot
											else
												ChoosenSlot = nil
											end
										else
											HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
											Slot.Material = Enum.Material.Neon
											Slot.Color = Color3.fromRGB(135, 236, 124)
											Slot.Transparency = 0

											ChoosenSlot = Slot
										end
									elseif ItemModule.Type == "Egg" then
										HighlightHive(workspace.Hives[_G.PData.Vars.Hive].Slots)
										Slot.Material = Enum.Material.Neon
										Slot.Color = Color3.fromRGB(135, 236, 124)
										Slot.Transparency = 0

										ChoosenSlot = Slot
									end
								end
							else
								if ChoosenSlot ~= nil then
									ChoosenSlot.Color = Color3.fromRGB(75, 171, 97)
									ChoosenSlot = nil
								end
							end
						end
					end
				else
					--UI.UItem.Visible = true
					--UI.UItem:TweenSize(UDim2.new(0,200,0,200), "Out", "Back", 0.2, true)
				end
			end
		end
		
		 -- NPCs exclamation mark
		for _, NPC in workspace.Quests:GetChildren() do
			local Billdoard = NPC.Circle:FindFirstChild("Exclamation")
			if not Billdoard then
				Billdoard = script.Exclamation:Clone()
				Billdoard.Parent = NPC.Circle
			end
			Billdoard.Enabled = not _G.PData.Quests[NPC.Name].Claimed or _G.PData.Quests[NPC.Name].Completed
			if Billdoard.Enabled then
				Billdoard.StudsOffset = Vector3.new(0, 6 + math.sin(tick() * 1.7) / 1.1, 0)
			end
		end
	end
end)