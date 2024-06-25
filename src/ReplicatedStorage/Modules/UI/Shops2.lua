local module = {}
local Items = require(game.ReplicatedStorage.Modules.Items).Eggs
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local ShopModule = require(game.ReplicatedStorage.Modules.Shops)
local Remotes = game.ReplicatedStorage.Remotes
local UserInputService = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Camera = workspace.Camera

local Player
local UI
local ShopUI
local shopmod

local Load = false

local index = 1

function module.Init(Player)
	UI = Player.PlayerGui.UI
	ShopUI = UI.Shop
	Load = true
	local listdeb = false
	local listdebR = false
	ShopUI.Info.Functions.Left.Shadow.MouseButton1Click:Connect(function()
		if not listdeb then
			listdeb = true
			if index == 1 then
				index = #shopmod.Items
			elseif index > 1 then
				index -= 1
			end
			ShopUI.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
			spawn(function()
				wait(0.3)
				ShopUI.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
				listdeb = false
			end)
			module.UpdateShop()
		end
	end)
	ShopUI.Info.Functions.Left.MouseButton1Click:Connect(function()
		if not listdeb then
			listdeb = true
			if index == 1 then
				index = #shopmod.Items
			elseif index > 1 then
				index -= 1
			end
			ShopUI.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
			spawn(function()
				wait(0.3)
				ShopUI.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
				listdeb = false
			end)
			module.UpdateShop()
		end
	end)
	ShopUI.Info.Functions.Right.Shadow.MouseButton1Click:Connect(function()
		if not listdebR then
			listdebR = true
			if index == #shopmod.Items then
				index = 1
			elseif index < #shopmod.Items then
				index += 1
			end
			ShopUI.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
			spawn(function()
				wait(0.3)
				ShopUI.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0.05,0,-0.05,0), "Out", "Back", 0.33, true)
				listdebR = false
			end)
			module.UpdateShop()
		end
	end)
	ShopUI.Info.Functions.Right.MouseButton1Click:Connect(function()
		if not listdebR then
			listdebR = true
			if index == #shopmod.Items then
				index = 1
			elseif index < #shopmod.Items then
				index += 1
			end
			ShopUI.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
			spawn(function()
				wait(0.3)
				ShopUI.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0.05,0,-0.05,0), "Out", "Back", 0.33, true)
				listdebR = false
			end)
			module.UpdateShop()
		end
	end)

	ShopUI.Info.Buy.Txt.MouseEnter:Connect(function()
		script.Enter:Play()
	end)
	ShopUI.Info.Buy.Txt.MouseLeave:Connect(function()
		ShopUI.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
		script.Enter:Play()
	end)
	
	ShopUI.Info.Buy.Txt.MouseButton1Down:Connect(function()
		ShopUI.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.15, true)
		script.Click:Play()
	end)
	
	ShopUI.Info.Buy.Txt.MouseButton1Up:Connect(function()
		ShopUI.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
		Remotes.Shop:FireServer(shopmod.RealName, index)
		--script.Buy:Play()
	end)
	--Remotes.UpdateFleas.OnClientEvent:Connect(function(tab)
	--	require(game.ReplicatedStorage.Modules.Shops.FleaMarket).Items = tab
	--end)
end

function module:Freeze()
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Disable()
end
function module:Unfreeze()
	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
	controls:Enable()
end
function module:checkIngridients(Ingridients)
	local ingridientsCompleted = 0
	for Type, amount in pairs(Ingridients) do
		if _G.PData.Inventory[Type] >= amount[1] then
			ingridientsCompleted += 1
		end
	end
	return ingridientsCompleted
end

local function HaveExBee(Bee)
	for i,v in pairs(_G.PData.Bees) do
		if v.BeeName == Bee then
			return true
		end
	end
end

function module.GetOfferStatus()
	local Cost = shopmod.Items[index].Cost
	local Type = shopmod.Items[index].Type
	local Item = shopmod.Items[index].Item
	local Category = shopmod.Items[index].Category
	local CN = shopmod.Items[index].CraftNum
	local Craft = shopmod.Items[index].Craft
	local Result = ""
	local function CheckCost()
		if CN > 0 then
			if _G.PData.IStats.Honey >= Cost and module:checkIngridients(Craft) >= CN then
				Result = "Purchase"
			else
				Result = "Can't afford"
			end
		else
			if _G.PData.IStats.Honey >= Cost then
				Result = "Purchase"
			else
				Result = "Can't afford"
			end
		end
	end
	if Category == "Equipment" then
		if _G.PData[Category][Type.."s"][Item] then
			if Item == _G.PData[Category][Type] then
				return "Equipped"
			else
				return "Equip"
			end
		else
			CheckCost()
		end
	else
		if Type ~= "Exclusive Bee" then
			CheckCost()
		else
			if HaveExBee(shopmod.Items[index].Bee) or _G.PData.Inventory[shopmod.Items[index].Bee.." Bee Egg"] > 0 then
				Result = "Not For Sale"
			else
				CheckCost()
			end
		end
		if Type == "Hive Slot" then
			if _G.PData.IStats.TotalSlots < 50 then
				CheckCost()
			else
				Result = "Not For Sale"
			end
		end
	end
	return Result
end

function module.GetOfferColor()
	local Cost = shopmod.Items[index].Cost
	local Type = shopmod.Items[index].Type
	local Item = shopmod.Items[index].Item
	local Category = shopmod.Items[index].Category
	local CN = shopmod.Items[index].CraftNum
	local Craft = shopmod.Items[index].Craft
	
	if Category == "Equipment" then
		if _G.PData[Category][Type.."s"][Item] then
			if Item == _G.PData[Category][Type] then
				return Color3.fromRGB(93, 158, 69)
			else
				return Color3.fromRGB(124, 212, 92)
			end
		else
			if CN == 0 then
				if Cost <= _G.PData.IStats.Honey then
					return Color3.fromRGB(124, 212, 92)
				else
					return Color3.fromRGB(212, 82, 82)
				end
			else
				if Cost <= _G.PData.IStats.Honey and module:checkIngridients(Craft) >= CN then
					return Color3.fromRGB(124, 212, 92)
				else
					return Color3.fromRGB(212, 82, 82)
				end
			end
		end
	else
		if CN == 0 then
			if Cost <= _G.PData.IStats.Honey then
				return Color3.fromRGB(124, 212, 92)
			else
				return Color3.fromRGB(212, 82, 82)
			end
		else
			if Cost <= _G.PData.IStats.Honey and module:checkIngridients(Craft) >= CN then
				return Color3.fromRGB(124, 212, 92)
			else
				return Color3.fromRGB(212, 82, 82)
			end
		end
	end
end

function module.UpdateShop()
	local Infp = ShopUI.Info
	
	local Cost = shopmod.Items[index].Cost
	if _G.PData.IStats[shopmod.Items[index].Item] then
		Cost = _G.PData.IStats[shopmod.Items[index].Item]
	end
	if shopmod.Items[index].CostMult then
		Cost = math.round(Cost * _G.PData.CostsMults[shopmod.Items[index].CostMult]["X"])
	end
	local part = workspace.Map.Shops[shopmod.RealName].Items[index]
	Utils:TweenCam(nil, CFrame.new(part.View.WorldPosition, part.Position))
	
	Infp.Type.Text = "{"..shopmod.Items[index].Type.."}"
	Infp.Type.TypeS.Text = "{"..shopmod.Items[index].Type.."}"

	Infp.Cost.Text = Utils:AbNumber(Cost).." Honey"
	Infp.Cost.CostS.Text = Utils:AbNumber(Cost).." Honey"
	if Cost <= _G.PData.IStats.Honey then
		Infp.Cost.CostS.TextColor3 = Color3.fromRGB(219, 255, 225)
	else
		Infp.Cost.CostS.TextColor3 = Color3.fromRGB(255, 138, 138)
	end

	Infp.Item.Text = shopmod.Items[index].Item
	Infp.Item.ItemS.Text = shopmod.Items[index].Item
	if shopmod.Items[index].Type == "Boot" then
		Infp.Item.Text = Infp.Item.Text.." Boots"
		Infp.ItemS.Text = Infp.ItemS.Text.." Boots"
	end
	
	Infp.Desc.Text = shopmod.Items[index].Description
	Infp.Desc.DescS.Text = shopmod.Items[index].Description

	Infp.Buy.Txt.Text = module.GetOfferStatus()
	Infp.Buy.Txt.BackgroundColor3 = module.GetOfferColor()
	
	for i,v in pairs(Infp.Items:GetChildren()) do
		if not v:IsA("UIListLayout") and not v:IsA("UICorner") then
			v:Destroy()
		end
	end
	if shopmod.Items[index].CraftNum > 0 then
		Infp.Items.Visible = true
		local Ysize = (0.06 * shopmod.Items[index].CraftNum) + (0.018 * (shopmod.Items[index].CraftNum - 1))
		Infp.Items:TweenSize(UDim2.new(0.934,0,Ysize,0), "Out", "Back", 0.3, true)

		for item,amount in pairs(shopmod.Items[index].Craft) do
			local temp = script.Item:Clone()
			temp.Icon.Image = Items[item].Image
			temp.LayoutOrder = amount[2]
			local stringam
			if amount[1] > 1 then
				stringam = Utils:CommaNumber(amount[1]).." "..item--.."s"
			else
				stringam = Utils:CommaNumber(amount[1]).." "..item
			end
			temp.Desc.Text = stringam
			temp.DescS.Text = stringam
			temp.Parent = Infp.Items
		end
	else
		Infp.Items:TweenSize(UDim2.new(0.934,0,0,0), "Out", "Back", 0.3, true)
		spawn(function()
			wait(0.3)
			Infp.Items.Visible = false
		end)
	end
end

function module.CloseShop()
	module:Unfreeze()
	ShopUI.Info:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
	ShopUI.BackInfo:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
	--ShopUI.Info.Functions:TweenPosition(UDim2.new(0.5,0,1.75,15), "Out", "Back", 0.5, true)

	ShopUI.ShopName:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
	ShopUI.ShopNameS:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
	ShopUI.ShadowSN:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)

	ShopUI.Visible = false
	Camera.CameraType = Enum.CameraType.Custom
	TS:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
end

function module.OpenShop(ShopType)
	module:Freeze()

	UserInputService.MouseIconEnabled = true
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	
	ShopUI.Visible = true
	ShopUI.Info:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)
	ShopUI.BackInfo:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)
	
	ShopUI.ShopName:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
	ShopUI.ShopNameS:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
	ShopUI.ShadowSN:TweenSize(UDim2.new(0,615,0,90), "Out", "Back", 0.5, true)
	
	shopmod = ShopModule[ShopType.Name]
	index = 1
	
	ShopUI.ShopName.Text = shopmod.ShopName
	ShopUI.ShopNameS.Text = shopmod.ShopName
	
	module.UpdateShop()
end



return module
