local Remotes = game:GetService("ReplicatedStorage").Remotes
local Data = require(game.ServerScriptService.Server.Data)
local Players = game:GetService("Players")
local GetRealStats = require(game.ServerScriptService.Functions.GetRealStats)
local ts = game:GetService("TweenService")
local PopUp = script.BeePopUp
local Items = require(game.ReplicatedStorage.Modules.Items)
local module = {}

local function rankcolor(rank)
	if rank == "Common" then
		return {Color3.fromRGB(93, 75, 65), Color3.fromRGB(72, 58, 50)}
	elseif rank == "Rare" then
		return {Color3.fromRGB(234, 234, 234), Color3.fromRGB(168, 168, 168)}
	elseif rank == "Epic" then
		return {Color3.fromRGB(245, 205, 48), Color3.fromRGB(217, 179, 43)}
	elseif rank == "Legendary" then
		return {Color3.fromRGB(16, 217, 190), Color3.fromRGB(12, 177, 155)}
	elseif rank == "Mythic" then
		return Color3.fromRGB(147, 94, 238)
	elseif rank == "Limited" then
		return {Color3.fromRGB(223, 90, 150), Color3.fromRGB(186, 75, 127)}
	end
end

function module.PopUp2(BeeModule, pui)
	if pui:FindFirstChild("BeePopup") then
		pui:FindFirstChild("BeePopup"):Destroy()
	end
	local popup = script.BeePopup:Clone()
	local infos = popup.Frame
	infos.QName.Text = BeeModule.Name.." Bee!"
	if BeeModule.Rarity == "Rare" then
		infos.Rank.TextColor3 = Color3.fromRGB(13, 13, 13)
		infos.Desc.TextColor3 = Color3.fromRGB(13, 13, 13)
		infos.QName.TextColor3 = Color3.fromRGB(13, 13, 13)
	end
	infos.Desc.Text = BeeModule.Descriptio
	infos.Icon.Bee.Image = BeeModule.Thumb
	infos.Rank.Text = BeeModule.Rarity
	popup.BackgroundColor3 = rankcolor(BeeModule.Rarity)[2]
	infos.BackgroundColor3 = rankcolor(BeeModule.Rarity)[1]
	infos.Rank.BackgroundColor3 = rankcolor(BeeModule.Rarity)[1]
	popup.Parent = pui
	popup:TweenPosition(UDim2.new(0.5,0,0.5,0), "Out", "Back", 0.5, true)
	wait(0.25)
	popup:TweenSize(UDim2.new(0,480*1.33,0,250*1.33), "Out", "Back", 0.5, true)
	wait(0.02)
	ts:Create(popup, TweenInfo.new(0.33), {Rotation = -5}):Play()
	ts:Create(infos, TweenInfo.new(0.22), {Rotation = 4}):Play()
end

function module.PopUp(Player, Bee, Item, Gifted, Slot, New, PData)
	local PlayerGui = Players:FindFirstChild(Player.Name):FindFirstChild("PlayerGui")
	local OldBee = Slot.BeeN.Value
	local PopUpUI = PopUp:Clone()
	local BeeModule = require(game.ReplicatedStorage.Bees[Bee])
	
	if PlayerGui:FindFirstChild("UI"):FindFirstChild("BeePopUp") then
		PlayerGui:FindFirstChild("UI"):FindFirstChild("BeePopUp"):Destroy()
	end
	
	PopUpUI.Discovered.Visible = false
	PopUpUI.Parent = PlayerGui:FindFirstChild("UI")
	
	if not PData.DiscoveredBees[Bee] then
		PData.DiscoveredBees[Bee] = true
		PopUpUI.Discovered.Visible = true
	else
		PopUpUI.Discovered.Visible = false
	end
	
	if Gifted then
		Remotes.AlertClient:FireClient(Player, {
			Color = "Blue",
			Msg = "You Hatched a ⭐️Gifted "..Bee.." Bee!⭐️"
		})
	else
		Remotes.AlertClient:FireClient(Player, {
			Color = "Blue",
			Msg = "You Hatched a "..Bee.." Bee!"
		})
	end
	
	-- БИ ДЖАР
	local BeeName = BeeModule.Name
	
	--if Items.Eggs[Item].Type == "Jelly" then
	--	if PData.Inventory["Bee Jar"] > 0 then
	--		if not Gifted and BeeModule.Rarity ~= "Event" and BeeModule.Rarity ~= "Mythic" then
	--			PopUpUI.JellyReroll.Visible = true
	--		else
	--			PopUpUI.JellyReroll.Visible = false
	--		end
	--	else
	--		PopUpUI.JellyReroll.Visible = false
	--	end
	--	PopUpUI.JellyReroll.Item.Value = Item
	--	PopUpUI.JellyReroll.Slot.Value = Slot
		
	--	if Gifted then
	--		if(not PData.DiscoveredBees[BeeName].Gifted) then
	--			--PData.DiscoveredBees[BeeName].Gifted = true
	--			--PData.IStats.DiscoveredGiftedBeesValue += 1
	--			PopUpUI.Discovered.Visible = true
	--		else
	--			PopUpUI.Discovered.Visible = false
	--		end
			
	--		Remotes.AlertClient:FireClient(Player, {
	--			Color = "Blue",
	--			Msg = "Your "..OldBee.." Bee transformed into a ⭐️Gifted "..Bee.." Bee!⭐️"
	--		})
	--	else
	--		if(not PData.DiscoveredBees[BeeName].NotGifted) then
	--			--PData.IStats.DiscoveredValue += 1
	--			--PData.DiscoveredBees[BeeName].NotGifted = true
	--			PopUpUI.Discovered.Visible = true
	--		else
	--			PopUpUI.Discovered.Visible = false
	--		end

	--		Remotes.AlertClient:FireClient(Player, {
	--			Color = "Blue",
	--			Msg = "Your "..OldBee.." Bee transformed into a "..Bee.." Bee!"
	--		})
	--	end
	--end

	local CAR
	if BeeModule.Color ~= "Colorless" then
		CAR = BeeModule.Color.." "..BeeModule.Rarity
	else
		CAR = BeeModule.Rarity
	end
	PopUpUI.ColorAndRarity.TEXT.Text = CAR
	PopUpUI.ColorAndRarity.Text = CAR
	if BeeModule.Rarity == "Common" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(108, 88, 75)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(185, 144, 108)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(115, 89, 67)
	elseif BeeModule.Rarity == "Rare" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(255, 255, 255)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(131, 131, 131)
	elseif BeeModule.Rarity == "Epic" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(255, 208, 66)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(255, 208, 66)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(143, 116, 37)
	elseif BeeModule.Rarity == "Legendary" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(64, 255, 255)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(64, 255, 255)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(32, 127, 127)
	elseif BeeModule.Rarity == "Mythic" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(171, 124, 198)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(171, 124, 198)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(96, 69, 111)
	elseif BeeModule.Rarity == "Limited" then
		PopUpUI.ColorAndRarity.BackgroundColor3 = Color3.fromRGB(132, 221, 109)
		PopUpUI.TypeName.Back.TextColor3 = Color3.fromRGB(132, 221, 109)
		PopUpUI.TypeName.TextColor3 = Color3.fromRGB(84, 139, 68)
	end

	if BeeModule.Color == "Colorless" and BeeModule.Rarity == "Common" then
		PopUpUI.ColorAndRarity.TEXT.TextColor3 = Color3.fromRGB(185, 144, 108)
		PopUpUI.ColorAndRarity.TextColor3 = Color3.fromRGB(115, 89, 67)
		PopUpUI.TypeName.BackgroundColor3 = Color3.fromRGB(255, 228, 92)
	elseif  BeeModule.Rarity ~= "Rare" and BeeModule.Color == "Colorless" then
		PopUpUI.ColorAndRarity.TEXT.TextColor3 = Color3.fromRGB(255, 255, 255)
		PopUpUI.ColorAndRarity.TextColor3 = Color3.fromRGB(131, 131, 131)
		PopUpUI.TypeName.BackgroundColor3 = Color3.fromRGB(255, 228, 92)
	elseif  BeeModule.Rarity == "Rare" and BeeModule.Color == "Colorless" then
		PopUpUI.ColorAndRarity.TEXT.TextColor3 = Color3.fromRGB(198, 198, 198)
		PopUpUI.ColorAndRarity.TextColor3 = Color3.fromRGB(131, 131, 131)
		PopUpUI.TypeName.BackgroundColor3 = Color3.fromRGB(255, 228, 92)
	elseif BeeModule.Color == "Red" then
		PopUpUI.ColorAndRarity.TEXT.TextColor3 = Color3.fromRGB(255, 102, 102)
		PopUpUI.ColorAndRarity.TextColor3 = Color3.fromRGB(131, 52, 52)
		PopUpUI.TypeName.BackgroundColor3 = Color3.fromRGB(255, 102, 102)
	elseif BeeModule.Color == "Blue" then
		PopUpUI.ColorAndRarity.TEXT.TextColor3 = Color3.fromRGB(96, 181, 255)
		PopUpUI.ColorAndRarity.TextColor3 = Color3.fromRGB(50, 96, 134)
		PopUpUI.TypeName.BackgroundColor3 = Color3.fromRGB(96, 181, 255)
	end
	local TXT = Bee.." Bee"
	if Gifted then
		TXT = "⭐️Gifted "..Bee.." Bee!"
	end
	if Gifted then
		PopUpUI.TypeName.Text = TXT..BeeModule.Sim.."⭐️"
		PopUpUI.TypeName.Back.Text = TXT..BeeModule.Sim.."⭐️"
		PopUpUI.Thumbnail.Image = BeeModule.GiftedThumb
		--local Bee = game.ReplicatedStorage.GiftedBees:FindFirstChild(BeeModule.Name):Clone()
		--Bee.Parent = PopUpUI.Thumbnail
	else
		PopUpUI.TypeName.Text = TXT..BeeModule.Sim
		PopUpUI.TypeName.Back.Text = TXT..BeeModule.Sim
		PopUpUI.Thumbnail.Image = BeeModule.Thumb
		--local Bee = game.ReplicatedStorage.Bees:FindFirstChild(BeeModule.Name).Model:Clone()
		--Bee.Parent = PopUpUI.Thumbnail
		--Bee:SetPrimaryPartCFrame(CFrame.new(0,8.1,8) * CFrame.fromOrientation(-15,45,-15))
	end

	PopUpUI.Visible = true
	PopUpUI:TweenSize(UDim2.new(0.299, 0,0.618, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.325, true)
	PopUpUI.Discovered:TweenSize(UDim2.new(1.288, 0,0.182, 0),Enum.EasingDirection.Out, Enum.EasingStyle.Bounce, 0.4, true)
	PopUpUI.Thumbnail:TweenSize(UDim2.new(1.238, 0,0.571, 0),Enum.EasingDirection.Out, Enum.EasingStyle.Elastic, 1, true)

	--if Gifted then
	--	GetRealStats.GetRealStats(Player, PData)
	--end

	PopUpUI.CloseOverlay.MouseButton1Click:Connect(function()
		PopUpUI:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Back, 0.3, true)
		wait(0.27)
		PopUpUI:Destroy()
	end)

	--PopUpUI.JellyReroll.MouseButton1Click:Connect(function()
	--	if deb == false then
	--		deb = true
	--		local Item = PopUpUI.JellyReroll.Item
	--		game.ReplicatedStorage.Remotes.CreateBeeSlot:FireServer(Item.Value, PopUpUI.JellyReroll.Slot.Value)
	--		wait(0.3)
	--		deb = false
	--	end
	--end)

	local tweenInfo1 = TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local tween1 = game:GetService("TweenService"):Create(PopUpUI.Thumbnail, tweenInfo1, {Rotation=-2})
	local tweenInfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
	local tween2 = game:GetService("TweenService"):Create(PopUpUI.Thumbnail, tweenInfo2, {Rotation=2})
	spawn(function()
		while PopUpUI.Parent do
			tween1:Play()
			wait(0.1)
			tween2:Play()
			wait(0.1)
		end
	end)

	if Gifted then
		local deb = 0.5
		spawn(function()
			while PopUpUI.Parent do
				game:GetService("TweenService"):Create(PopUpUI.Back, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 166, 166)}):Play()
				game:GetService("TweenService"):Create(PopUpUI.Back.UIStroke, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Color = Color3.fromRGB(176, 115, 115)}):Play()
				wait(deb)
				if PopUpUI.Parent then
					game:GetService("TweenService"):Create(PopUpUI.Back, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(255, 252, 157)}):Play()
					game:GetService("TweenService"):Create(PopUpUI.Back.UIStroke, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Color = Color3.fromRGB(170, 168, 105)}):Play()
					wait(deb)
					if PopUpUI.Parent then
						game:GetService("TweenService"):Create(PopUpUI.Back, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(180, 255, 153)}):Play()
						game:GetService("TweenService"):Create(PopUpUI.Back.UIStroke, TweenInfo.new(deb, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Color = Color3.fromRGB(122, 172, 103)}):Play()
						wait(deb)
					else
						break
					end
				else
					break
				end
			end
		end)
	end
end


return module
