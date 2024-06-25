local Rep = game:GetService("ReplicatedStorage")
local Remotes = Rep.Remotes.VisualRemotes
local TS = game:GetService("TweenService")
local Player = game.Players.LocalPlayer
local Utils = require(game.ReplicatedStorage.Modules.Utils)
local Eggs = require(game.ReplicatedStorage.Modules.Items).Eggs

Remotes.FlowerUpd.OnClientEvent:Connect(function(Flower, NewPos)
	TS:Create(Flower, TweenInfo.new(0.22), {Position = NewPos}):Play()
end)

--Remotes.LootClaim.OnClientEvent:Connect(function(Box, Items)
--	local TL = script.TL:Clone()
--	TL.Parent = Box
--	for Item, Amount in pairs(Items) do
--		local Icon = script.Icon:Clone()
--		Icon.Image = Eggs[Item].Image
--		Icon.Am.Text = "x"..Amount
--		Icon.Parent = TL.Frame
--	end
--	spawn(function()
--		wait(2.5)
--		TL:Destroy()
--	end)
--end)

--Remotes.PTotem.OnClientEvent:Connect(function(p3, Flower, Bee, Totem)
--	TS:Create(Totem.Model.Circle, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = Vector3.new(0.25,25,25)}):Play()
--	TS:Create(Totem.Model.Index, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Totem.Primary.Position + Vector3.new(0,9,0)}):Play()
--	wait(0.4)
--	TS:Create(Totem.Model.Token, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Totem.Primary.Position + Vector3.new(0,13,0)}):Play()
--	local Bonus = 10 + math.round(_G.PData.Bees[tonumber(Bee.Name)].Level / 3)
--	spawn(function()
--		for i = 1, Bonus do
--			Totem.Model.Circle.Decal.Color3 = Color3.fromRGB(255,255,255)
--			wait(0.4)
--			Totem.Model.Circle.Decal.Color3 = Color3.fromRGB(21, 21, 21)
--			wait(1.6)
--			if i >= Bonus then
--				TS:Create(Totem.Model.Circle, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = Vector3.new(0.25,0,0)}):Play()
--				TS:Create(Totem.Model.Token, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Totem.Primary.Position - Vector3.new(0,20,0)}):Play()
--				wait(0.4)
--				TS:Create(Totem.Model.Index, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = Totem.Primary.Position - Vector3.new(0,20,0)}):Play()
--				wait(0.5)
--				Totem:Destroy()
--			end
--		end
--	end)
--	spawn(function()
--		while Totem do
--			if Totem:FindFirstChild("Model") then
--				Totem.Model.Token.Orientation += Vector3.new(0,2,0)
--			end
--			wait(0.03)
--		end
--	end)
--end)

--Remotes.BeeToken.OnClientEvent:Connect(function(Token, Table)
--	--local Token = script.Token:Clone()
--	--Token.Name = _G.PData.Vars.Tokens[ID].Name
--	--Token.Parent = workspace.Tokens[Player.Name]
--	--Token.Position = _G.PData.Vars.Tokens[ID].Position
--	Token.Color = Table.Color
--	Token.BackDecal.Texture = Table.Texture
--	Token.FrontDecal.Texture = Table.Texture
--	Token.Type.Value = Table.Type
	
--	spawn(function()
--		wait(Table.Timer)
--		if Token:FindFirstChild("BackDecal") and Token:FindFirstChild("FrontDecal") then
--			TS:Create(Token, TweenInfo.new(5), {Transparency = 1}):Play()
--			TS:Create(Token.BackDecal, TweenInfo.new(5), {Transparency = 1}):Play()
--			TS:Create(Token.FrontDecal, TweenInfo.new(5), {Transparency = 1}):Play()
--			wait(5)
--			Token:Destroy()
--		else
--			if Token then
--				Token:Destroy()
--			end
--		end
--	end)
--end)

--Remotes.UseItemVisual.OnClientEvent:Connect(function(Att, Item)
--	spawn(function()
--		local ui = script.ui:Clone()
--		ui.Parent = Att
--		ui.Icon.Image = Item
--		ui.Icon:TweenPosition(UDim2.new(0.5, 0, 0.575, 0), "Out", "Back", 0.5, true)
--		ui.Icon:TweenSize(UDim2.new(0.5, 0, 0.5, 0), "Out", "Back", 0.15, true)
--		wait(1.5)
--		ui.Icon:TweenPosition(UDim2.new(0.5, 0, 1, 0), "In", "Back", 0.5, true)
--		ui.Icon:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Back", 0.15, true)
--		ui:Destroy()
--	end)
--end)