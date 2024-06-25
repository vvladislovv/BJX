local module = {}

local AllTokens = require(game.ReplicatedStorage.Modules.AllTokens)
local BeeTokens = require(game.ReplicatedStorage.Modules.BeeTokens)
local DataModifier = require(game.ServerScriptService.Functions.DataModifier)
local TS = game:GetService("TweenService")
local Debris = game:GetService("Debris")

function module.ActionToken(Type, Token, CF, Player, Info)
	if Type == "Bee" then
		if not game.ReplicatedStorage.Boosts:FindFirstChild(Token) then
			if string.find(Token, "Bomb") then
				require(script.Parent.BeeAbils.Bomb).Run(Player, CF, Token)
			else
				require(script.Parent.BeeAbils:FindFirstChild(Token)).Run(Player, CF)
			end
		else
			game.ReplicatedStorage.Remotes.Boost:Fire(Player, Token, 1)
		end
	elseif Type == "Any" then
		local TokenType = AllTokens[Token].Type
		if TokenType == "Currency" then
			DataModifier.IStatsChange(Player, {"+", Info.Amount, Token, Info.Resource, Info.Resource ~= nil and true or false})
		elseif TokenType == "Item" then
			DataModifier.InventoryChange(Player, {"+", Info.Amount, Token, Info.Resource, Info.Resource ~= nil and true or false})
		end
	end
end

function module.SpawnToken(Type, Token, CF, Player, Info)
	local NewToken = script.Token:Clone()
	local TokenInfo
	local Public
	
	if Type == "Any" then
		TokenInfo = AllTokens[Token]
	else
		if Player then
			TokenInfo = BeeTokens[Token]
		end
	end

	NewToken.BackDecal.Texture = TokenInfo.Decal
	NewToken.FrontDecal.Texture = TokenInfo.Decal
	
	if Player then
		Public = false
	else
		Public = true
	end
	
	if Public then
		NewToken.Parent = workspace.Tokens
	else
		NewToken.Parent = workspace.PlayersE[Player.Name].Tokens
	end
	
	NewToken.Size = Vector3.new(0,0,0)
	NewToken.CFrame = CFrame.new(CF)
	
	TS:Create(NewToken, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = Vector3.new(0.5, 3, 3)}):Play()
	
	spawn(function()
		wait(TokenInfo.Timer)
		if NewToken and NewToken.Parent ~= nil then
			TS:Create(NewToken, TweenInfo.new(TokenInfo.Timer/5), {Transparency = 1}):Play()
			TS:Create(NewToken.BackDecal, TweenInfo.new(TokenInfo.Timer/5), {Transparency = 1}):Play()
			TS:Create(NewToken.FrontDecal, TweenInfo.new(TokenInfo.Timer/5), {Transparency = 1}):Play()
			wait(TokenInfo.Timer/5)
			if NewToken then
				NewToken:Destroy()
			end
		end
	end)
	
	NewToken.Touched:Connect(function(Hit)
		if game.Players:FindFirstChild(Hit.Parent.Name) and not NewToken.Tch.Value then
			NewToken.Tch.Value = true
			NewToken.CanTouch = false
			module.ActionToken(Type, Token, CF, game.Players:FindFirstChild(Hit.Parent.Name), Info)

			TS:Create(NewToken, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Orientation = Vector3.new(0,360,0)}):Play()
			TS:Create(NewToken, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			TS:Create(NewToken.BackDecal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			TS:Create(NewToken.FrontDecal, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			TS:Create(NewToken, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = NewToken.Position + Vector3.new(0,8,0)}):Play()
			spawn(function()
				wait(0.7)
				NewToken:Destroy()
			end)
			_G.CompleteQuest(game.Players:FindFirstChild(Hit.Parent.Name), "CollectToken", {Token = Token})
		end
	end)
end

return module
