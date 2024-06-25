wait(1)

local BoxCode = script.Parent.Code.BoxCode
local BoxUses = script.Parent.Uses.BoxUses
local CreateButton = script.Parent.Create.CreateButton

local ItemsFrame = script.Parent.ItemsFrame.ItemsFrame
local BoostsFrame = script.Parent.BoostsFrame.BoostsFrame
local CodeFrame = script.Parent.CodesFrame.CodesFrame

local BoostExample = game.ReplicatedStorage.Assets.BoostExample
local ItemExample = game.ReplicatedStorage.Assets.ItemExample
local CodeExample = game.ReplicatedStorage.Assets.CodeExample

local ItemsModule = require(game.ReplicatedStorage.Modules.Items)
local CodeRemote = game.ReplicatedStorage.Remotes.GetAllCodes


local Blacklist = {
	["Hydrant Builder"] = true,
	["Glitch Error"] = true,
	["Speed Boost"] = true,
	["x2 Convert Rate Pass"] = false,
	["x2 Pollen from Bees Pass"] = false,
	["x2 Pollen from Tools Pass"] = false,
	["Resin Aura"] = false,
	["Weekend Boost"] = false,
}

local function addFrame(Parent, Name, Color, Image, LayoutOrder)
	if(not Blacklist[Name]) then
		local new = ItemExample:Clone()
		new.Parent = Parent
		new.Name = Name
		new.ItemName.Text = Name
		new.ItemName.TextColor3 = Color
		new.ItemImage.Image = Image
		new.LayoutOrder = LayoutOrder
	end
end

if(script.Parent.Parent.Parent.Name ~= "Equipment") then
	for value, boost in pairs(game.ReplicatedStorage:WaitForChild("Boosts"):GetChildren()) do
		local BoostModule = require(game.ReplicatedStorage.Boosts[boost.Name])
		if(not Blacklist[BoostModule.Name]) then
			local new = BoostExample:Clone()
			new.Parent = BoostsFrame
			new.Name = BoostModule.Name
			new.BoostName.Text = BoostModule.Name
			new.BoostName.TextColor3 = BoostModule.Color
			new.BoostImage.Image = BoostModule.BoostImage
			new.LayoutOrder = BoostModule.Layout
		end
	end

	for item, value in pairs(ItemsModule.Eggs) do
		if(not Blacklist[item]) then
			local new = ItemExample:Clone()
			new.Parent = ItemsFrame
			new.Name = ItemsModule.Eggs[item].Name
			new.ItemName.Text = ItemsModule.Eggs[item].Name
			new.ItemImage.Image = ItemsModule.Eggs[item].Image
			new.LayoutOrder = ItemsModule.Eggs[item].Layout
		end
	end

	addFrame(ItemsFrame, "Honey", Color3.fromRGB(234, 169, 39), "rbxassetid://11895777875", 1)

	local example = {
		{"IStats", "Honey", 1000},
		{"Inventory", "ITEM_NAME", 1},
		{"Boost", "BOOST_NAME", 1}
	}

	CreateButton.MouseButton1Click:Connect(function()
		local code = tostring(BoxCode.Text)
		local uses
		if BoxUses.Text == nil or BoxUses.Text == "0" or BoxUses.Text == "" then
			uses = 999999
		else
			uses = tonumber(BoxUses.Text)
		end
		local items = {}

		for _,boost in pairs(script.Parent.BoostsFrame.BoostsFrame:GetChildren()) do
			if(boost.Name ~= "l") then
				if(boost.AmountBox.Text ~= "0" and boost.AmountBox.Text ~= nil and boost.AmountBox.Text ~= "") then
					table.insert(items, {"Boost", boost.Name, boost.AmountBox.Text})
				end
			end
		end

		for _,item in pairs(script.Parent.ItemsFrame.ItemsFrame:GetChildren()) do
			if(item.Name ~= "l") then
				if(item.AmountBox.Text ~= "0" and item.AmountBox.Text ~= nil and item.AmountBox.Text ~= "") then
					if(item.Name == "Honey") then
						table.insert(items, {"IStats", item.Name, item.AmountBox.Text})
					else
						table.insert(items, {"Inventory", item.Name, item.AmountBox.Text})
					end
				end
			end
		end
		game.ReplicatedStorage.Remotes.CreateCode:FireServer(code, uses, items)
		
	end)

	if(game.Players.LocalPlayer.UserId == 3797367313 or game.Players.LocalPlayer.UserId == 3547173204) then
		CodeRemote:FireServer()
	end

	CodeRemote.OnClientEvent:Connect(function(codes, uses)
		if(script.Parent.Parent.Name ~= "Equipment") then
			for index,code in pairs(codes) do
				local use
				if(uses[code] == nil) then 
					use = "Infinity uses" 
				else 
					use = uses[code].." uses left" 
				end
				local new = CodeExample:Clone()
				new.Parent = CodeFrame
				new.Name = code
				new:WaitForChild("CodeName").Text = code
				new:WaitForChild("CodeUses").Text = use
			end
		end
	end)
end