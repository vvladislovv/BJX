wait(3)
local Remotes = game.ReplicatedStorage.Remotes
local Items = require(game.ReplicatedStorage.Modules.Items)

local Modules = game.ReplicatedStorage.Modules

local One = script.Parent.One
local LvUp = script.Parent.Level
local Two = script.Parent.Pisat
local Three = script.Parent.Dvapisat
local Levels = require(Modules.BeeLevels)
local Amount = 0

Remotes.OpenFoodGui.OnClientEvent:Connect(function(ItemName)
	_G.ItemName = ItemName
	_G.PData = Remotes.GetPlayerData:InvokeServer()
	game.Lighting.Blur.Enabled = true
	local TreatQuest = script.Parent.Parent.Parent.Parent.TreatQuest
	TreatQuest.Visible = true
	script.Parent.Parent.Parent.Main:TweenSize(UDim2.new(0.281, 0,0.248, 0), "Out", "Back", 0.5)
	local Am = Items.Eggs[_G.ItemName].Settings.Amount
	local BeeData = _G.PData.Bees[tonumber(_G.CSlot.Name)]
	script.Parent.Text.Text = "How many ".._G.ItemName.." are you going to feed the Bee"

	if _G.PData.Inventory[_G.ItemName] >= math.round(Levels[BeeData.Level] / Am) then
		script.Parent.Level.Text = "Level Up \n".."("..math.round(Levels[BeeData.Level] / Am)..")"
		script.Parent.Level.BackgroundColor3 = Color3.fromRGB(97, 241, 97)
		Amount = math.round(Levels[BeeData.Level] / Am)
	else
		script.Parent.Level.BackgroundColor3 = Color3.fromRGB(241, 67, 67)
		script.Parent.Level.Text = "Feed All \n".."(".._G.PData.Inventory[_G.ItemName]..")"
		Amount = _G.PData.Inventory[_G.ItemName]
	end
	if _G.PData.Inventory[_G.ItemName] >= 1 then
		One.BackgroundColor3 = Color3.fromRGB(97, 241, 97)
	else
		One.BackgroundColor3 = Color3.fromRGB(241, 67, 67)
	end
	if _G.PData.Inventory[_G.ItemName] >= 50 then
		Two.BackgroundColor3 = Color3.fromRGB(97, 241, 97)
	else
		Two.BackgroundColor3 = Color3.fromRGB(241, 67, 67)
	end
	if _G.PData.Inventory[_G.ItemName] >= 250 then
		Three.BackgroundColor3 = Color3.fromRGB(97, 241, 97)
	else
		Three.BackgroundColor3 = Color3.fromRGB(241, 67, 67)
	end
end)

function Feed()
	Remotes.FoodBee:FireServer(_G.ItemName, _G.CSlot, "Food", Amount)
end

One.MouseButton1Click:Connect(function()
	Amount = 1
	if _G.PData.Inventory[_G.ItemName] >= Amount then
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	else
		Amount = _G.PData.Inventory[_G.ItemName]
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	end
end)

Two.MouseButton1Click:Connect(function()
	Amount = 50
	if _G.PData.Inventory[_G.ItemName] >= Amount then
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	else
		Amount = _G.PData.Inventory[_G.ItemName]
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	end
end)

Three.MouseButton1Click:Connect(function()
	Amount = 250
	if _G.PData.Inventory[_G.ItemName] >= Amount then
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	else
		Amount = _G.PData.Inventory[_G.ItemName]
		Feed()
		script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
		game.Lighting.Blur.Enabled = false
	end
end)

local all = false

script.Parent.Parent.Close.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
	game.Lighting.Blur.Enabled = false
end)

LvUp.MouseButton1Click:Connect(function()
	_G.PData = Remotes.GetPlayerData:InvokeServer()
	local Am = Items.Eggs[_G.ItemName].Settings.Amount
	local BeeData = _G.PData.Bees[tonumber(_G.CSlot.Name)]
	if BeeData.Level < Levels[BeeData.Level] then
		if _G.PData.Inventory[_G.ItemName] >= math.round(Levels[BeeData.Level] / Am) then
			script.Parent.Level.Text = "Level Up \n".."("..math.round(Levels[BeeData.Level] / Am)..")"
			script.Parent.Level.BackgroundColor3 = Color3.fromRGB(97, 241, 97)
			Amount = math.round(Levels[BeeData.Level] / Am)
			Feed()
		elseif _G.PData.Inventory[_G.ItemName] < math.round(Levels[BeeData.Level] / Am) then
			script.Parent.Level.BackgroundColor3 = Color3.fromRGB(241, 67, 67)
			script.Parent.Level.Text = "Feed All \n".."(".._G.PData.Inventory[_G.ItemName]..")"
			Amount = _G.PData.Inventory[_G.ItemName]
			Feed()
			script.Parent.Parent.Parent.Parent.TreatQuest.Visible = false
			game.Lighting.Blur.Enabled = false
		end
	else
		script.Parent.Level.Text = "Your Bee reached Max Level"
		script.Parent.Level.BackgroundColor3 = Color3.fromRGB(67, 67, 67)
	end
end)