local Players = game:GetService("Players")
local SSS = game:GetService("ServerScriptService")
local Rep = game.ReplicatedStorage
local Remotes = Rep.Remotes
local Modules = Rep.Modules
local Items = require(Modules.Items)
local ts = game:GetService("TweenService")
local Player = game.Players.LocalPlayer

--[[поднимается]]local TweenForCollect = TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)
--[[сужается]]local TweenForCollect2 = TweenInfo.new(0.75, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false)

local A = 1

function Animation(part)
	spawn(function()
		ts:Create(part.AtDecal.BI.Decal, TweenForCollect, {Rotation = 359}):Play()
		wait(1)
		part:Destroy()
	end)
end

function VisualBoosts(TokenName)
	for _,Bee in pairs(game.Workspace.Bees:FindFirstChild(Player.Name):GetChildren()) do
		spawn(function()
			local P1 = script.Boost:Clone()
			local P2 = script.Boost:Clone()
			local P3 = script:FindFirstChild(TokenName):Clone()
			P3.Parent = Bee:FindFirstChild("Body")
			P2.Color = ColorSequence.new(Color3.fromRGB(131, 255, 124))
			P1.Parent = Bee:FindFirstChild("Body")
			P2.Parent = Bee:FindFirstChild("Body")
			wait(1)
			P3.Enabled = false
			P2.Enabled = false
			P1.Enabled = false
			wait(1.5)
			P3:Destroy()
			P2:Destroy()
			P1:Destroy()
		end)
	end
end

_G.PData = Remotes.GetPlayerData:InvokeServer()

--spawn(function()
--for _,Token in pairs(game.Workspace.Treasures:GetChildren()) do
--	local Deb = false
--	if _G.PData.Treasures[Token.Name] then
--		Token.Transparency = 0.5
--		Token:FindFirstChild("BackDecal").Transparency = 0.5
--		Token:FindFirstChild("FrontDecal").Transparency = 0.5
--		Token:FindFirstChild("ParticleEmitter").Enabled = false
--		Token:FindFirstChild("ParticleEmitter2").Enabled = false
--	end
--	ts:Create(Token, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {CFrame = Token.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)}):Play()
--	Token.Touched:Connect(function(Hit)
--		if Hit.Parent.Name == Player.Name and Hit.Parent:FindFirstChild("Humanoid") and Deb == false and not _G.PData.Treasures[Token.Name] then
--			Deb = true
--			Token.CanTouch = false
--			Token:FindFirstChild("Sound"):Play()
--			Animation(Token)
--		end
--	end)
--	end
--end)

Remotes.Token.OnClientEvent:Connect(function(Token)
	local Deb = false
	if Token then
		spawn(function()
			local T1 = ts:Create(Token.AtDecal.BI.Decal, TweenInfo.new(4), {ImageTransparency = 1})
			ts:Create(Token.AtDecal.BI.Decal, TweenInfo.new(0.65, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out,0.3), {Size = UDim2.new(1,0,1,0)}):Play()
			--ts:Create(Token, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {CFrame = Token.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)}):Play()
			spawn(function()
				wait(15)
				if Token then
					T1:Play()
				end
				wait(4)
				if Token then
					Token:Destroy()
				end
			end)
			Token.Touched:Connect(function(Hit)
				if Hit.Parent:FindFirstChild("Humanoid") and game.Players:FindFirstChild(Hit.Parent.Name) and Deb == false then
					Deb = true
					Token.CanTouch = false
					--if Token:FindFirstChild("TokenCollect") then
					--	Token.TokenCollect:Play()
					--else
					--	Token.Sound:Play()
					--end
					T1:Pause()
					Token.AtDecal.BI.Decal.ImageTransparency = 0
					Animation(Token)
				end
			end)
		end)
	end
end)

--Remotes.SpawnBeeToken.OnClientEvent:Connect(function(Pos, Info)
--	if Pos and Info then
--	local Deb = false
--	spawn(function()
--	local Token = script.Token:Clone()
--	Token.Position = Pos.Position + Vector3.new(0,0.8,0)
--	Token.Color = Info.TKColor
--	Token.Name = Info.TokenType
--	Token.BackDecal.Texture = Info.Image
--	Token.FrontDecal.Texture = Info.Image
--	Token.Parent = game.Workspace.Tokens[Info.Player.Name]
--	Token.ColorT.Value = Info.ColorT
--	Token.Type.Value = Info.Type
--	Token.Bee.Value = Info.Bee

--		local TD = ts:Create(Token, TweenInfo.new(3), {Transparency = 1})
--		local TD1 = ts:Create(Token:FindFirstChild("BackDecal"), TweenInfo.new(4), {Transparency = 1})
--		local TD2 = ts:Create(Token:FindFirstChild("FrontDecal"), TweenInfo.new(4), {Transparency = 1})

--		local TokenName = Token.Name
--		local Position = Token.Position
--		local Type = Token:FindFirstChild("Type").Value

--		local Particle = game:GetService("ReplicatedStorage").Effect.Tokens:Clone()
--		Particle.Parent = Token

--		ts:Create(Token, TweenInfo.new(0.65, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out,0.3), {Size = Vector3.new(0.5, 3, 3)}):Play()
--		ts:Create(Token, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {CFrame = Token.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)}):Play()

--		spawn(function()
--			wait(Info.Time)
--			if Token then
--				TD:Play()
--				TD1:Play()
--				TD2:Play()
--			end
--			wait(3)
--			if Token then
--				Token:Destroy()
--			end
--		end)

--		Token.Touched:Connect(function(Hit)
--			if Hit.Parent.Name == Player.Name and Hit.Parent:FindFirstChild("Humanoid") and Deb == false then
--				Deb = true
--				Token.CanTouch = false
--				Token:FindFirstChild("Sound"):Play()
--				TD:Pause()
--				TD2:Pause()
--				TD1:Pause()
--				Token.Transparency = 0
--				Token:FindFirstChild("BackDecal").Transparency = 0
--				Token:FindFirstChild("FrontDecal").Transparency = 0
--				Animation(Token)
--				if string.find(TokenName, "Link", 2) then
--					if #game.Workspace.Tokens[Player.Name]:GetChildren() > 0 then
--						local AllTokens = {}
--						for i,v in pairs(game.Workspace.Tokens:FindFirstChild(Player.Name):GetChildren()) do
--							if not string.find(v.Name, "Link") then
--							AllTokens[i] = {Pos = v.Position, TName = v.Name, Bee = v.Bee.Value, Collision = v.CanTouch}
--							end
--						end
--						Remotes.BeeTokenData:FireServer(TokenName, Position, Info.ID, Info.ColorT, Type, Token.Bee.Value, AllTokens)
--					end
--						for i,v in pairs(game.Workspace.Tokens[Player.Name]:GetChildren()) do
--							if not string.find(v.Name, "Link", 2) then
--								TD:Pause()
--								TD2:Pause()
--								TD1:Pause()
--								v.Transparency = 0
--								v:FindFirstChild("BackDecal").Transparency = 0
--								v:FindFirstChild("FrontDecal").Transparency = 0
--								Animation(v)
--								v:FindFirstChild("Sound"):Play()
--								v.CanTouch = false

--								local a = Token.Position
--								local b = v.Position
--								local distance = (a-b).magnitude
--								local midPosition = (a+b)/2
--								local UP = Vector3.new(0,1,0)
--								local thickness = 0.3
--								local part = Instance.new("Part")
--								part.Anchored = true
--								part.CanCollide = false
--								part.Material = Enum.Material.Neon
--								part.Size = Vector3.new(thickness, thickness, distance)
--								part.CFrame = CFrame.lookAt(midPosition, b, UP)
--								part.Parent = workspace

--								spawn(function()
--									wait(0.5)
--									part:Destroy()
--								end)
--							end
--					end
--				else
--				if string.find(TokenName, "Bomb") then
--					spawn(function()
--						local Bomb = Instance.new("Explosion")
--						Bomb.Parent =  Token
--						Bomb.Position = Token.Position
--						Bomb.BlastPressure = 0
--						Bomb.BlastRadius = 0
--						Bomb.DestroyJointRadiusPercent = 0
--						Bomb.ExplosionType = Enum.ExplosionType.NoCraters
--						wait(2)
--						Bomb:Destroy()
--					end)
--				elseif string.find(TokenName, "Boost") then
--					VisualBoosts(TokenName)
--				end
--				Remotes.BeeTokenData:FireServer(TokenName, Position, Info.ID, Info.ColorT, Type, Token.Bee.Value)
--				end
--			end
--		end)
--		end)
--	end
--end)