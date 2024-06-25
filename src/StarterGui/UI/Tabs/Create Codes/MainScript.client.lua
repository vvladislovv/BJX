wait(5)
--// Player
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character
--// UI
local UI = script.Parent.Parent.Parent
local UIScale = UI:WaitForChild("UIScale")
--// Services 
local SocialService = game:GetService("SocialService")
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
local Scale = UIScale.Scale
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = Player:GetMouse()
local Humanoid = Player.Character:WaitForChild("Humanoid")

local function loadItems()
	for itemName, itemData in pairs(Eggs) do
		local Ex = script.Parent.ItemExample:Clone()

		Ex.Visible = true
		Ex.Name = itemData.Name
		Ex.Icon.Image = itemData.Image
		Ex.LayoutOrder = itemData.Layout

		Ex.Parent = script.Parent.Handler.ItemsTab.List
	end
end

local function loadBoosts()
	for _, boostModule: ModuleScript in pairs(game.ReplicatedStorage.Boosts:GetChildren()) do
		local Ex = script.Parent.BoostExample:Clone()
		local boostData = require(boostModule)
		
		Ex.Visible = true
		Ex.Name = boostData.Name
		Ex.Icon.Image = boostData.BoostImage
		Ex.LayoutOrder = boostData.Layout

		Ex.Parent = script.Parent.Handler.BoostsTab.List
	end
end

local function init()
	loadItems();
	loadBoosts();
end
init()

local function toggleTab(tabName)
	local tab: ImageButton = script.Parent.Handler[tabName];
	if(tab.Position.X.Scale > 1.1) then -- Если открыто (закрыть надо)
		tab:TweenPosition(UDim2.new(1, 0, -0.02, 0), "Out", "Back", 0.6)
	else -- Если закрыто (открыть надо)
		local secondTabName = "BoostsTab";
		if(tab ~= "ItemsTab") then
			secondTabName = "ItemsTab"
			local secondTab = script.Parent.Handler[secondTabName];
			if(secondTab.Position.X.Scale > 1.1) then -- Если второй таб открыт
				secondTab:TweenPosition(UDim2.new(1, 0, -0.02, 0), "Out", "Back", 0.6)
			end
		end
		tab:TweenPosition(UDim2.new(2.03, 0, -0.02, 0), "Out", "Back", 0.6)
	end
end

script.Parent.Icon.OpenItemsList.MouseButton1Click:Connect(function()
	script.Click:Play()
	toggleTab("ItemsTab")
end)
script.Parent.Icon.OpenBoostsList.MouseButton1Click:Connect(function()
	script.Click:Play()
	toggleTab("BoostsTab")
end)

script.Parent.Icon.SaveFrame.TextButton.MouseButton1Click:Connect(function()
	script.Click:Play()
	local button: TextButton = script.Parent.Icon.SaveFrame.TextButton;
	if(button.Bool.Value) then
		button.Bool.Value = false
		button.Text = "✖"
	else
		button.Bool.Value = true
		button.Text = "✔"
	end
end)

local function createCode(codeName: string, codeData: {}, uses: number)
	game.ReplicatedStorage.Remotes.CreateCode:FireServer(codeName, codeData, uses)
end

script.Parent.Icon.Codes.TextButton.MouseButton1Click:Connect(function()
	script.Click:Play()
	local ui = script.Parent.Icon;
	local codeName: string = "";
	local codeData: {} = {
		["Items"] = {
			
		},
		["Boosts"] = {
			
		}
	};
	local uses: number = 1;
	
	if(ui.Codes.TextBox.Text == "") then return end
	codeName = ui.Codes.TextBox.Text
	
	for i,v in pairs(script.Parent.Handler.ItemsTab.List:GetChildren()) do
		if(v.Name ~= "l") then
			if(v.ItemValue.TextBox.Text ~= "") then
				local itemName: string = v.Name;
				local itemValue: number = tonumber(v.ItemValue.TextBox.Text)
				codeData["Items"][itemName] = itemValue;
			end
		end
	end
	

	for i,v in pairs(script.Parent.Handler.BoostsTab.List:GetChildren()) do
		if(v.Name ~= "l") then
			if(v.ItemValue.TextBox.Text ~= "") then
				local boostName: string = v.Name;
				local boostValue: number = tonumber(v.ItemValue.TextBox.Text)
				codeData["Boosts"][boostName] = boostValue;
			end
		end
	end
	
	createCode(codeName, codeData, uses)
end)