local Module = {}; do
	local TweenService = game:GetService("TweenService")
	local Items = require(game.ReplicatedStorage.Modules.Items).Eggs
	local Utils = require(game.ReplicatedStorage.Modules.Utils)
	local Shops = require(game.ReplicatedStorage.Modules.Shops)
	local Remotes = game.ReplicatedStorage.Remotes
	local Player = game.Players.LocalPlayer
	local UI = Player.PlayerGui:WaitForChild("UI")
	local Frame = UI.Shop
	local Camera = workspace.CurrentCamera
	local Shop = nil
	local Debounce = false
	local Index = 1
	local IndexAmount = 1
	local Amount = 1

	function Module.Update()
		if not Shop then
			return
		end
		local ItemData = Shop.Items[Index]
		if not ItemData then
			return
		end
		
		local Type = Shops.Functions.GetStatus(_G.PData, ItemData, Amount)
		local ButtonText = ""
		local ButtonColor = Color3.fromRGB(124, 212, 92)
		if Type == "Purchase" then
			ButtonText = "Purchase!"
		elseif Type == "Can't afford" then
			ButtonColor = Color3.fromRGB(212, 82, 82)
		elseif Type == "Not For Sale" then
			ButtonColor = Color3.fromRGB(212, 82, 82)
		elseif Type == "Equipped" then
			ButtonColor = Color3.fromRGB(93, 158, 69)
		end
		if ButtonText == "" then
			ButtonText = Type
		end

		for _, IngredientFrame in Frame.Info.Items:GetChildren() do
			if IngredientFrame:IsA("ImageLabel") then
				IngredientFrame:Destroy()
			end
		end

		for i, Ingredient in ItemData.Craft do
			local IngredientFrame = Frame.Info.Items:FindFirstChild(i)
			if not IngredientFrame then
				IngredientFrame = script.Item:Clone()
				IngredientFrame.Name = i
				IngredientFrame.Desc.Text = string.format("%s %s%s", Utils:CommaNumber(Ingredient.Amount), Ingredient.Name, Ingredient.Amount ~= 1 and "s" or "")
				IngredientFrame.DescS.Text = IngredientFrame.Desc.Text
				IngredientFrame.Icon.Image = Items[Ingredient.Name] and Items[Ingredient.Name].Image or ""
				IngredientFrame.Parent = Frame.Info.Items
			end
		end
		local part = workspace.Map.Shops[Shop.RealName].Items[Index]
		Utils:TweenCam(nil, CFrame.new(part.View.WorldPosition, part.Position))
		Frame.Info.Cost.Text = Utils:AbNumber(Shops.Functions.GetCost(_G.PData, ItemData, Amount)).." "..(ItemData.CostName)
		Frame.Info.Cost.CostS.Text = Frame.Info.Cost.Text
		Frame.Info.Desc.Text = ItemData.Description
		Frame.Info.Desc.DescS.Text = ItemData.Description
		Frame.Info.Item.Text = ItemData.Item
		Frame.Info.Item.ItemS.Text = ItemData.Item
		Frame.Info.Type.Text = string.format("{%s}", ItemData.Type)
		Frame.Info.Type.TypeS.Text = Frame.Info.Type.Text
		Frame.Info.Buy.Text = ButtonText
		Frame.Info.Buy.Txt.Text = ButtonText
		Frame.Info.Buy.Txt.BackgroundColor3 = ButtonColor

		if ItemData.MultiBuy then
			--Frame.Info.Cost.Text = Utils:AbNumber(Shops.Functions.GetCost(_G.PData, ItemData) * ItemData.MultiBuy[IndexAmount]) .." "..(ItemData.CostName)
			--Frame.Info.Cost.CostS.Text = Frame.Info.Cost.Text
			Frame.Info.Amount.Visible = true
			--local MaxIndex2 = #ItemData.MultiBuy
			--Frame.Info.Amount.Visible = true
			--Frame.Info.Amount.Text = Utils:AbNumber(ItemData.MultiBuy[IndexAmount])
			--Frame.Info.Amount.Add.MouseEnter:Connect(function()
			--	Frame.Info.Amount.Add:TweenSize(UDim2.new(0.415 * 1.2, 0, 1.2, 0), "Out", "Back", 0.24, true)
			--end)
			--Frame.Info.Amount.Add.MouseLeave:Connect(function()
			--	Frame.Info.Amount.Add:TweenSize(UDim2.new(0.415, 0, 1, 0), "Out", "Back", 0.24, true)
			--end)
			--Frame.Info.Amount.Min.MouseEnter:Connect(function()
			--	Frame.Info.Amount.Min:TweenSize(UDim2.new(0.415 * 1.2, 0, 1.2, 0), "Out", "Back", 0.24, true)
			--end)
			--Frame.Info.Amount.Min.MouseLeave:Connect(function()
			--	Frame.Info.Amount.Min:TweenSize(UDim2.new(0.415, 0, 1, 0), "Out", "Back", 0.24, true)
			--end)

			--Frame.Info.Amount.Min.MouseButton1Up:Connect(function()
			--	IndexAmount -= 1
			--	if IndexAmount < 1 then
			--		IndexAmount = MaxIndex2
			--	end
			--	Frame.Info.Amount.Text = Utils:AbNumber(ItemData.MultiBuy[IndexAmount])
			--end)
			--Frame.Info.Amount.Add.MouseButton1Up:Connect(function()
			--	IndexAmount += 1
			--	if IndexAmount > MaxIndex2 then
			--		IndexAmount = 1
			--	end
			--	Frame.Info.Amount.Text = Utils:AbNumber(ItemData.MultiBuy[IndexAmount])
			--end)
		else
			Amount = 1
			IndexAmount = 1
			Frame.Info.Amount.Visible = false
			Frame.Info.Amount.Text = 1
		end
	end

	function Module.Open(ShopName: string)
		local ShopData = Shops[ShopName]
		if not ShopData then return end
		Shop = ShopData
		Frame.Visible = true
		Frame.Info:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)
		Frame.BackInfo:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)

		Frame.ShopName:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
		Frame.ShopNameS:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
		Frame.ShadowSN:TweenSize(UDim2.new(0,615,0,90), "Out", "Back", 0.5, true)

		Frame.ShopName.Text = Shop.ShopName
		Frame.ShopNameS.Text = Shop.ShopName
		Module.Update()
	end

	function Module.Close()
		Shop = nil
		Index = 1
		Frame.Info:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
		Frame.BackInfo:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
		--Frame.Info.Functions:TweenPosition(UDim2.new(0.5,0,1.75,15), "Out", "Back", 0.5, true)

		Frame.ShopName:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
		Frame.ShopNameS:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
		Frame.ShadowSN:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)

		Frame.Visible = false
		Camera.CameraType = Enum.CameraType.Custom
		TweenService:Create(Camera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
	end

	function Module.Init()
		Frame.Info.Functions.Left.MouseButton1Click:Connect(function()
			if Shop then
				if Debounce then
					return
				end
				Debounce = true
				Index = Index - 1
				if Index == 0 then
					Index = #Shop.Items
				end
				Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
				task.delay(0.3, function()
					Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
					Debounce = false
				end)
				Module.Update()
			end
		end)
		Frame.Info.Functions.Right.MouseButton1Click:Connect(function()
			if Shop then
				if Debounce then
					return
				end
				Debounce = true
				Index = Index + 1
				if Index > #Shop.Items then
					Index = 1
				end
				Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
				task.delay(0.3, function()
					Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
					Debounce = false
				end)
				Module.Update()
			end
		end)
		Frame.Info.Amount.Add.MouseEnter:Connect(function()
			Frame.Info.Amount.Add:TweenSize(UDim2.new(0.415 * 1.2, 0, 1.2, 0), "Out", "Back", 0.24, true)
		end)
		Frame.Info.Amount.Add.MouseLeave:Connect(function()
			Frame.Info.Amount.Add:TweenSize(UDim2.new(0.415, 0, 1, 0), "Out", "Back", 0.24, true)
		end)
		Frame.Info.Amount.Min.MouseEnter:Connect(function()
			Frame.Info.Amount.Min:TweenSize(UDim2.new(0.415 * 1.2, 0, 1.2, 0), "Out", "Back", 0.24, true)
		end)
		Frame.Info.Amount.Min.MouseLeave:Connect(function()
			Frame.Info.Amount.Min:TweenSize(UDim2.new(0.415, 0, 1, 0), "Out", "Back", 0.24, true)
		end)
		Frame.Info.Amount.Min.MouseButton1Up:Connect(function()
			if not Shop then
				return
			end
			local ItemData = Shop.Items[Index]
			if not ItemData.MultiBuy then
				return
			end
			local MaxIndex = #ItemData.MultiBuy
			IndexAmount -= 1
			if IndexAmount < 1 then
				IndexAmount = MaxIndex
			end
			Amount = ItemData.MultiBuy[IndexAmount]
			Frame.Info.Amount.Text = Utils:AbNumber(ItemData.MultiBuy[IndexAmount])
			Module.Update()
		end)
		Frame.Info.Amount.Add.MouseButton1Up:Connect(function()
			if not Shop then
				return
			end
			local ItemData = Shop.Items[Index]
			if not ItemData.MultiBuy then
				return
			end
			local MaxIndex = #ItemData.MultiBuy
			IndexAmount += 1
			if IndexAmount > MaxIndex then
				IndexAmount = 1
			end
			Amount = ItemData.MultiBuy[IndexAmount]
			Frame.Info.Amount.Text = Utils:AbNumber(ItemData.MultiBuy[IndexAmount])
			Module.Update()
		end)
		Frame.Info.Buy.Txt.MouseEnter:Connect(function()
			script.Enter:Play()
		end)
		Frame.Info.Buy.Txt.MouseLeave:Connect(function()
			Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
			script.Enter:Play()
		end)

		Frame.Info.Buy.Txt.MouseButton1Down:Connect(function()
			Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.15, true)
			script.Click:Play()
		end)

		Frame.Info.Buy.Txt.MouseButton1Up:Connect(function()
			Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
			Remotes.Shop:FireServer(Shop.RealName, Index, Shop.Items[Index].MultiBuy and IndexAmount or nil)
			--script.Buy:Play()
		end)
		--Remotes.UpdateFleas.OnClientEvent:Connect(function(tab)
		--	require(game.ReplicatedStorage.Modules.Shops.FleaMarket).Items = tab
		--end)
	end
end

return Module
--local module = {}
--local Items = require(game.ReplicatedStorage.Modules.Items).Eggs
--local Utils = require(game.ReplicatedStorage.Modules.Utils)
--local ShopModule = require(game.ReplicatedStorage.Modules.Shops)
--local Remotes = game.ReplicatedStorage.Remotes
--local UserInputService = game:GetService("UserInputService")
--local TS = game:GetService("TweenService")
--local Camera = workspace.Camera

--local Player
--local UI
--local Frame
--local shopmod

--local Load = false

--local index = 1

--function module.Init(Player)
--	UI = Player.PlayerGui.UI
--	Frame = UI.Shop
--	Load = true
--	local listdeb = false
--	local listdebR = false
--	Frame.Info.Functions.Left.Shadow.MouseButton1Click:Connect(function()
--		if not listdeb then
--			listdeb = true
--			if index == 1 then
--				index = #shopmod.Items
--			elseif index > 1 then
--				index -= 1
--			end
--			Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
--			spawn(function()
--				wait(0.3)
--				Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
--				listdeb = false
--			end)
--			module.UpdateShop()
--		end
--	end)
--	Frame.Info.Functions.Left.MouseButton1Click:Connect(function()
--		if not listdeb then
--			listdeb = true
--			if index == 1 then
--				index = #shopmod.Items
--			elseif index > 1 then
--				index -= 1
--			end
--			Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
--			spawn(function()
--				wait(0.3)
--				Frame.Info.Functions.Left.Shadow:TweenPosition(UDim2.new(0,0,-0.05,0), "Out", "Back", 0.33, true)
--				listdeb = false
--			end)
--			module.UpdateShop()
--		end
--	end)
--	Frame.Info.Functions.Right.Shadow.MouseButton1Click:Connect(function()
--		if not listdebR then
--			listdebR = true
--			if index == #shopmod.Items then
--				index = 1
--			elseif index < #shopmod.Items then
--				index += 1
--			end
--			Frame.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
--			spawn(function()
--				wait(0.3)
--				Frame.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0.05,0,-0.05,0), "Out", "Back", 0.33, true)
--				listdebR = false
--			end)
--			module.UpdateShop()
--		end
--	end)
--	Frame.Info.Functions.Right.MouseButton1Click:Connect(function()
--		if not listdebR then
--			listdebR = true
--			if index == #shopmod.Items then
--				index = 1
--			elseif index < #shopmod.Items then
--				index += 1
--			end
--			Frame.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0,0,0,0), "Out", "Back", 0.33, true)
--			spawn(function()
--				wait(0.3)
--				Frame.Info.Functions.Right.Shadow:TweenPosition(UDim2.new(0.05,0,-0.05,0), "Out", "Back", 0.33, true)
--				listdebR = false
--			end)
--			module.UpdateShop()
--		end
--	end)

--	Frame.Info.Buy.Txt.MouseEnter:Connect(function()
--		script.Enter:Play()
--	end)
--	Frame.Info.Buy.Txt.MouseLeave:Connect(function()
--		Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
--		script.Enter:Play()
--	end)

--	Frame.Info.Buy.Txt.MouseButton1Down:Connect(function()
--		Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Linear", 0.15, true)
--		script.Click:Play()
--	end)

--	Frame.Info.Buy.Txt.MouseButton1Up:Connect(function()
--		Frame.Info.Buy.Txt:TweenPosition(UDim2.new(0.5, 0, 0.38, 0), "Out", "Linear", 0.15, true)
--		Remotes.Shop:FireServer(shopmod.RealName, index)
--		--script.Buy:Play()
--	end)
--	--Remotes.UpdateFleas.OnClientEvent:Connect(function(tab)
--	--	require(game.ReplicatedStorage.Modules.Shops.FleaMarket).Items = tab
--	--end)
--end

--function module:Freeze()
--	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
--	controls:Disable()
--end
--function module:Unfreeze()
--	local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
--	controls:Enable()
--end
--function module:checkIngridients(Ingridients)
--	local ingridientsCompleted = 0
--	for Type, amount in pairs(Ingridients) do
--		if _G.PData.Inventory[Type] >= amount[1] then
--			ingridientsCompleted += 1
--		end
--	end
--	return ingridientsCompleted
--end

--local function HaveExBee(Bee)
--	for i,v in pairs(_G.PData.Bees) do
--		if v.BeeName == Bee then
--			return true
--		end
--	end
--end

--function module.GetOfferStatus()
--	local Cost = shopmod.Items[index].Cost
--	local Type = shopmod.Items[index].Type
--	local Item = shopmod.Items[index].Item
--	local Category = shopmod.Items[index].Category
--	local CN = shopmod.Items[index].CraftNum
--	local Craft = shopmod.Items[index].Craft
--	local Result = ""
--	local function CheckCost()
--		if CN > 0 then
--			if _G.PData.IStats.Honey >= Cost and module:checkIngridients(Craft) >= CN then
--				Result = "Purchase"
--			else
--				Result = "Can't afford"
--			end
--		else
--			if _G.PData.IStats.Honey >= Cost then
--				Result = "Purchase"
--			else
--				Result = "Can't afford"
--			end
--		end
--	end
--	if Category == "Equipment" then
--		if _G.PData[Category][Type.."s"][Item] then
--			if Item == _G.PData[Category][Type] then
--				return "Equipped"
--			else
--				return "Equip"
--			end
--		else
--			CheckCost()
--		end
--	else
--		if Type ~= "Exclusive Bee" then
--			CheckCost()
--		else
--			if HaveExBee(shopmod.Items[index].Bee) or _G.PData.Inventory[shopmod.Items[index].Bee.." Bee Egg"] > 0 then
--				Result = "Not For Sale"
--			else
--				CheckCost()
--			end
--		end
--		if Type == "Hive Slot" then
--			if _G.PData.IStats.TotalSlots < 50 then
--				CheckCost()
--			else
--				Result = "Not For Sale"
--			end
--		end
--	end
--	return Result
--end

--function module.GetOfferColor()
--	local Cost = shopmod.Items[index].Cost
--	local Type = shopmod.Items[index].Type
--	local Item = shopmod.Items[index].Item
--	local Category = shopmod.Items[index].Category
--	local CN = shopmod.Items[index].CraftNum
--	local Craft = shopmod.Items[index].Craft

--	if Category == "Equipment" then
--		if _G.PData[Category][Type.."s"][Item] then
--			if Item == _G.PData[Category][Type] then
--				return Color3.fromRGB(93, 158, 69)
--			else
--				return Color3.fromRGB(124, 212, 92)
--			end
--		else
--			if CN == 0 then
--				if Cost <= _G.PData.IStats.Honey then
--					return Color3.fromRGB(124, 212, 92)
--				else
--					return Color3.fromRGB(212, 82, 82)
--				end
--			else
--				if Cost <= _G.PData.IStats.Honey and module:checkIngridients(Craft) >= CN then
--					return Color3.fromRGB(124, 212, 92)
--				else
--					return Color3.fromRGB(212, 82, 82)
--				end
--			end
--		end
--	else
--		if CN == 0 then
--			if Cost <= _G.PData.IStats.Honey then
--				return Color3.fromRGB(124, 212, 92)
--			else
--				return Color3.fromRGB(212, 82, 82)
--			end
--		else
--			if Cost <= _G.PData.IStats.Honey and module:checkIngridients(Craft) >= CN then
--				return Color3.fromRGB(124, 212, 92)
--			else
--				return Color3.fromRGB(212, 82, 82)
--			end
--		end
--	end
--end

--function module.UpdateShop()
--	local Infp = Frame.Info

--	local Cost = shopmod.Items[index].Cost
--	if _G.PData.IStats[shopmod.Items[index].Item] then
--		Cost = _G.PData.IStats[shopmod.Items[index].Item]
--	end
--	if shopmod.Items[index].CostMult then
--		Cost = math.round(Cost * _G.PData.CostsMults[shopmod.Items[index].CostMult]["X"])
--	end
--	local part = workspace.Map.Shops[shopmod.RealName].Items[index]
--	Utils:TweenCam(nil, CFrame.new(part.View.WorldPosition, part.Position))

--	Infp.Type.Text = "{"..shopmod.Items[index].Type.."}"
--	Infp.Type.TypeS.Text = "{"..shopmod.Items[index].Type.."}"

--	Infp.Cost.Text = Utils:AbNumber(Cost).." Honey"
--	Infp.Cost.CostS.Text = Utils:AbNumber(Cost).." Honey"
--	if Cost <= _G.PData.IStats.Honey then
--		Infp.Cost.CostS.TextColor3 = Color3.fromRGB(219, 255, 225)
--	else
--		Infp.Cost.CostS.TextColor3 = Color3.fromRGB(255, 138, 138)
--	end

--	Infp.Item.Text = shopmod.Items[index].Item
--	Infp.Item.ItemS.Text = shopmod.Items[index].Item
--	if shopmod.Items[index].Type == "Boot" then
--		Infp.Item.Text = Infp.Item.Text.." Boots"
--		Infp.ItemS.Text = Infp.ItemS.Text.." Boots"
--	end

--	Infp.Desc.Text = shopmod.Items[index].Description
--	Infp.Desc.DescS.Text = shopmod.Items[index].Description

--	Infp.Buy.Txt.Text = module.GetOfferStatus()
--	Infp.Buy.Txt.BackgroundColor3 = module.GetOfferColor()

--	for i,v in pairs(Infp.Items:GetChildren()) do
--		if not v:IsA("UIListLayout") and not v:IsA("UICorner") then
--			v:Destroy()
--		end
--	end
--	if shopmod.Items[index].CraftNum > 0 then
--		Infp.Items.Visible = true
--		local Ysize = (0.06 * shopmod.Items[index].CraftNum) + (0.018 * (shopmod.Items[index].CraftNum - 1))
--		Infp.Items:TweenSize(UDim2.new(0.934,0,Ysize,0), "Out", "Back", 0.3, true)

--		for item,amount in pairs(shopmod.Items[index].Craft) do
--			local temp = script.Item:Clone()
--			temp.Icon.Image = Items[item].Image
--			temp.LayoutOrder = amount[2]
--			local stringam
--			if amount[1] > 1 then
--				stringam = Utils:CommaNumber(amount[1]).." "..item--.."s"
--			else
--				stringam = Utils:CommaNumber(amount[1]).." "..item
--			end
--			temp.Desc.Text = stringam
--			temp.DescS.Text = stringam
--			temp.Parent = Infp.Items
--		end
--	else
--		Infp.Items:TweenSize(UDim2.new(0.934,0,0,0), "Out", "Back", 0.3, true)
--		spawn(function()
--			wait(0.3)
--			Infp.Items.Visible = false
--		end)
--	end
--end

--function module.CloseShop()
--	module:Unfreeze()
--	Frame.Info:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
--	Frame.BackInfo:TweenPosition(UDim2.new(1.75,0,0.5,0), "Out", "Back", 0.5, true)
--	--Frame.Info.Functions:TweenPosition(UDim2.new(0.5,0,1.75,15), "Out", "Back", 0.5, true)

--	Frame.ShopName:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
--	Frame.ShopNameS:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)
--	Frame.ShadowSN:TweenSize(UDim2.new(0,0,0,0), "Out", "Back", 0.5, true)

--	Frame.Visible = false
--	Camera.CameraType = Enum.CameraType.Custom
--	TS:Create(workspace.CurrentCamera, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 60}):Play()
--end

--function module.OpenShop(ShopType)
--	module:Freeze()

--	UserInputService.MouseIconEnabled = true
--	UserInputService.MouseBehavior = Enum.MouseBehavior.Default

--	Frame.Visible = true
--	Frame.Info:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)
--	Frame.BackInfo:TweenPosition(UDim2.new(1,0,0.5,0), "Out", "Linear", 0.5, true)

--	Frame.ShopName:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
--	Frame.ShopNameS:TweenSize(UDim2.new(0,620,0,70), "Out", "Back", 0.5, true)
--	Frame.ShadowSN:TweenSize(UDim2.new(0,615,0,90), "Out", "Back", 0.5, true)

--	shopmod = ShopModule[ShopType.Name]
--	index = 1

--	Frame.ShopName.Text = shopmod.ShopName
--	Frame.ShopNameS.Text = shopmod.ShopName

--	module.UpdateShop()
--end



--return module
