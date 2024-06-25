wait(2)
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local e = game.ReplicatedStorage.Assets.PlayerExample
local e2 = game.ReplicatedStorage.Assets.CategoryExample
local e3 = game.ReplicatedStorage.Assets.DataExample

local AllCategories = {"IStats", "Daily", "Vars", "Boosts", "Equipment", "Cooldowns", "Codes", "AllStats", "Badges", "Inventory", "Settings"}

local Categories = {
	["IStats"] = {Name = "IStats", Path = "PData.IStats", LayoutOrder = 1}, -- 1
	["Daily"] = {Name = "Daily", Path = "PData.Daily", LayoutOrder = 18}, -- 18
	["Vars"] = {Name = "Vars", Path = "PData.Vars", LayoutOrder = 2}, -- 2
	["Boosts"] = {Name = "Boosts", Path = "PData.Boosts", LayoutOrder = 8}, -- 8
	["Equipment"] = {Name = "Equipment", Path = "PData.Equipment", LayoutOrder = 4}, -- 4
	["Cooldowns"] = {Name = "Cooldowns", Path = "PData.Cooldowns", LayoutOrder = 14}, -- 14
	["Codes"] = {Name = "Codes", Path = "PData.Codes", LayoutOrder = 5}, -- 5
	["AllStats"] = {Name = "AllStats", Path = "PData.AllStats", LayoutOrder = 6}, -- 6
	["Badges"] = {Name = "Badges", Path = "PData.Badges", LayoutOrder = 7}, -- 7
	["Inventory"] = {Name = "Inventory", Path = "PData.Inventory", LayoutOrder = 3}, -- 3
	["Settings"] = {Name = "Settings", Path = "PData.Settings", LayoutOrder = 15}, -- 15
}

local CategoriesData = {
	["IStats"] = {},
	["Daily"] = {},
	["Vars"] = {},
	["Boosts"] = {},
	["Equipment"] = {},
	["Cooldowns"] = {},
	["Codes"] = {},
	["AllStats"] = {},
	["Badges"] = {},
	["Inventory"] = {},
	["Settings"] = {},
}

local function FillData()
	for i,v in pairs(AllCategories) do
		for i1,v1 in pairs(_G.PData[v]) do
			table.insert(CategoriesData[v], i1)
		end
	end
end

local function LoadPlayerData()
	game.ReplicatedStorage.Remotes.GetDataStore:FireServer(script.Parent.SelectedPlayer.Value)
end

local function LoadPlayers()
	for i,v in pairs(game.Players:GetChildren()) do
		local thumbType = Enum.ThumbnailType.HeadShot
		local thumbSize = Enum.ThumbnailSize.Size60x60
		local content, isReady = Players:GetUserThumbnailAsync(v.UserId, thumbType, thumbSize)
		local a = e:Clone()
		a.Parent = script.Parent.PlayersFrame
		a.Name = tostring(v.Name)
		a.PlayerName.Text = tostring(v.Name)
		a.PlayerImage.Image = content
		
		a.Button.MouseButton1Click:Connect(function()
			if(script.Parent.SelectedPlayer.Value == v.Name) then -- Если уже выбрана категория (снять цвет)
				script.Parent.SelectedPlayer.Value = ""
				a.PlayerName.TextColor3 = e.PlayerName.TextColor3
				a.BackgroundColor3 = e.BackgroundColor3
			else -- А если нет, то иди нахуй
				if(script.Parent.SelectedPlayer.Value ~= nil and script.Parent.SelectedPlayer.Value ~= "") then
					script.Parent.PlayersFrame[script.Parent.SelectedPlayer.Value].PlayerName.TextColor3 = e.PlayerName.TextColor3
					script.Parent.PlayersFrame[script.Parent.SelectedPlayer.Value].BackgroundColor3 = e.BackgroundColor3
				end
				script.Parent.SelectedPlayer.Value = a.Name
				a.PlayerName.TextColor3 = Color3.fromRGB(255, 217, 0)
				a.BackgroundColor3 = Color3.fromRGB(255, 183, 15)
			end
		end)
	end
end
LoadPlayers()

local function LoadCategories()
	for i,v in pairs(Categories) do
		local a = e2:Clone()
		a.Name = v.Name
		a.Text = v.Name
		a.Parent = script.Parent.CategoryFrame
		
		a.MouseButton1Click:Connect(function()
			if(script.Parent.SelectedCategory.Value == v.Name) then -- Если уже выбрана категория (снять цвет)
				script.Parent.SelectedCategory.Value = ""
				a.TextColor3 = e2.TextColor3
				a.BackgroundColor3 = e2.BackgroundColor3
				
				for i1,v1 in pairs(script.Parent.DataFrame:GetChildren()) do
					if v1.Name ~= "l" then
						if v1.Category.Value == v.Name then
							v1.Visible = false
						end
					end
				end
			else -- А если нет, то иди нахуй
				if(script.Parent.SelectedCategory.Value ~= nil and script.Parent.SelectedCategory.Value ~= "") then
					script.Parent.CategoryFrame[script.Parent.SelectedCategory.Value].TextColor3 = e2.TextColor3
					script.Parent.CategoryFrame[script.Parent.SelectedCategory.Value].BackgroundColor3 = e2.BackgroundColor3
				end
				
				for i1,v1 in pairs(script.Parent.DataFrame:GetChildren()) do
					if v1.Name ~= "l" then
						if v1.Category.Value == v.Name then
							v1.Visible = true
						else
							v1.Visible = false
						end
					end
				end
				
				script.Parent.SelectedCategory.Value = a.Name
				a.TextColor3 = Color3.fromRGB(255, 217, 0)
				a.BackgroundColor3 = Color3.fromRGB(255, 183, 15)
			end
		end)
	end
end
LoadCategories()

local function LoadData()
	for i,v in pairs(CategoriesData) do
		for i1,v1 in pairs(v) do
			--		i = Daily 			/\/\/\			v = Таблица с Honey
			--		i1 = 1 (номер) 		/\/\/\			v1 = Honey (Назв того что в таблице)
			local a = e3:Clone()
			a.Name = v1
			a.Text = v1
			a.Category.Value = tostring(i)
			a.Parent = script.Parent.DataFrame
			a.Visible = false
			
			a.MouseButton1Click:Connect(function()
				if(script.Parent.SelectedData.Value == v1) then -- Если уже выбрана дата (снять цвет)
					script.Parent.SelectedData.Value = ""
					a.TextColor3 = e3.TextColor3
					a.BackgroundColor3 = e3.BackgroundColor3
				else -- А если нет, то иди нахуй
					if(script.Parent.SelectedData.Value ~= nil and script.Parent.SelectedData.Value ~= "") then
						script.Parent.DataFrame[script.Parent.SelectedData.Value].TextColor3 = e3.TextColor3
						script.Parent.DataFrame[script.Parent.SelectedData.Value].BackgroundColor3 = e3.BackgroundColor3
					end
					script.Parent.SelectedData.Value = a.Name
					a.TextColor3 = Color3.fromRGB(255, 217, 0)
					a.BackgroundColor3 = Color3.fromRGB(255, 183, 15)
				end
			end)
		end
	end
end
LoadData()

script.Parent.Enter.MouseButton1Click:Connect(function()
	local Data = script.Parent.SelectedData.Value
	local Category = script.Parent.SelectedCategory.Value
	local Player2 = script.Parent.SelectedPlayer.Value
	local Type = "Set"
	local Value = script.Parent.Box.Text
	
	if(Player2 ~= nil and Player2 ~= "" and Category ~= nil and Category ~= "" and Data ~= nil and Data ~= "" and Value ~= nil and Value ~= "") then
		game.ReplicatedStorage.Remotes.SetData:FireServer(Player2, Category, Data, Type, Value)
	end
end)