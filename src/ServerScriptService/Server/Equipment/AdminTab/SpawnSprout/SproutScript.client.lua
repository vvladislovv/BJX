wait(3)
local Menu = script.Parent
local SF = script.Parent.SproutsFrame
local FF = script.Parent.FieldFrame
local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Rep = game.ReplicatedStorage
local c = Rep.Assets.SproutExample
local c1 = Rep.Assets.FieldExample
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local Items = require(Modules.Items)
local FieldsModule = require(game.ReplicatedStorage.Modules.Fields)

local FieldBlacklist = {
	["Termit Hollow"] = true,
}

local SproutTypes = {
	["Sprout"] = {
		[1] = {Name = "Sprout", Rarity = 7500, MinLevel = 1, MaxLevel = 3, LayoutOrder = 1,
			Color = Color3.fromRGB(66, 159, 64), TextColor = Color3.fromRGB(95, 218, 88)},
	},
	["Silver Sprout"] = {
		[1] = {Name = "Silver Sprout", Rarity = 10000, MinLevel = 1, MaxLevel = 3, LayoutOrder = 2,
			Color = Color3.fromRGB(188, 188, 188), TextColor = Color3.fromRGB(247, 247, 247)},
	},
	["Golden Sprout"] = {
		[1] = {Name = "Golden Sprout", Rarity = 10000, MinLevel = 1, MaxLevel = 3, LayoutOrder = 3,
			Color = Color3.fromRGB(214, 194, 78), TextColor = Color3.fromRGB(255, 231, 93)},
	},
	["Diamond Sprout"] = {
		[1] = {Name = "Diamond Sprout", Rarity = 10000, MinLevel = 1, MaxLevel = 3, LayoutOrder = 4,
			Color = Color3.fromRGB(43, 220, 223), TextColor = Color3.fromRGB(111, 255, 255)},
	},
	["Mythical Sprout"] = {
		[1] = {Name = "Mythical Sprout", Rarity = 10000, MinLevel = 1, MaxLevel = 3, LayoutOrder = 5,
			Color = Color3.fromRGB(121, 59, 159), TextColor = Color3.fromRGB(181, 89, 238)},
	},
}

for i,v in pairs(SproutTypes) do
	for i1,v1 in pairs(v) do
		local a = c:Clone()
		a.Parent = SF
		a.Name = v1.Name
		a.Text = v1.Name
		a.TextColor3 = v1.TextColor
		a.BackgroundColor3 = v1.Color
		a.LayoutOrder = v1.LayoutOrder

		a.MouseButton1Click:Connect(function()
			if(script.Parent.SelectedSprout.Value == v1.Name) then -- Если уже выбран росток
				script.Parent.SelectedSprout.Value = ""
				a.TextColor3 = v1.TextColor
				a.BackgroundColor3 = v1.Color
			else -- А если нет, то иди нахуй
				if(script.Parent.SelectedSprout.Value ~= nil and script.Parent.SelectedSprout.Value ~= "") then
					script.Parent.SproutsFrame[script.Parent.SelectedSprout.Value].TextColor3 = SproutTypes[script.Parent.SelectedSprout.Value][1].TextColor
					script.Parent.SproutsFrame[script.Parent.SelectedSprout.Value].BackgroundColor3 = SproutTypes[script.Parent.SelectedSprout.Value][1].Color
				end
				script.Parent.SelectedSprout.Value = v1.Name
				
				a.TextColor3 = Color3.fromRGB(255, 217, 0)
				a.BackgroundColor3 = Color3.fromRGB(255, 183, 15)
			end
		end)
	end
end

for i,v in pairs(FieldsModule.AllFields) do
	if(not FieldBlacklist[v.Name]) then
		local a = c1:Clone()
		a.Parent = FF
		a.Name = v.Name
		a.FieldName.Text = v.Name
		a.FieldImage.Image = v.FieldImage
		a.FieldName.TextColor3 = Color3.fromRGB(215, 255, 222)
		a.BackgroundColor3 = v.Color
		a.LayoutOrder = v.LayoutOrder
		
		a.Button.MouseButton1Click:Connect(function()
			if(script.Parent.SelectedField.Value == v.Name) then -- Если уже выбрано поле
				script.Parent.SelectedField.Value = ""
				a.FieldName.TextColor3 = Color3.fromRGB(215, 255, 222)
				a.BackgroundColor3 = v.Color
			else -- А если нет, то иди нахуй
				if(script.Parent.SelectedField.Value ~= nil and script.Parent.SelectedField.Value ~= "") then
					script.Parent.FieldFrame[script.Parent.SelectedField.Value].FieldName.TextColor3 = Color3.fromRGB(215, 255, 222)
					script.Parent.FieldFrame[script.Parent.SelectedField.Value].BackgroundColor3 = FieldsModule.AllFields[script.Parent.SelectedField.Value].Color
				end
				script.Parent.SelectedField.Value = v.Name
				a.FieldName.TextColor3 = Color3.fromRGB(255, 217, 0)
				a.BackgroundColor3 = Color3.fromRGB(255, 183, 15)
			end
		end)
	end
end

Menu.Enter.MouseButton1Click:Connect(function()
	if(script.Parent.SelectedSprout.Value ~= nil and script.Parent.SelectedSprout.Value ~= "" and 
		script.Parent.SelectedField.Value ~= nil and script.Parent.SelectedField.Value ~= "") then
		Remotes.MakeSprout:FireServer(script.Parent.SelectedSprout.Value, script.Parent.SelectedField.Value, Menu.Sender.Text)
	end
end)