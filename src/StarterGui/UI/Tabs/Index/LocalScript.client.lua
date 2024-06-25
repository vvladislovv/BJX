wait(5)
local list = script.Parent.Icon.List
local bees = game.ReplicatedStorage.Bees

local ShadowColors = {
	["Colorless"] = Color3.fromRGB(0, 0, 0),
	["Blue"] = Color3.fromRGB(0, 0, 255),
	["Red"] = Color3.fromRGB(255, 0, 0),
}

repeat _G.PData = game.ReplicatedStorage.Remotes.GetPlayerData:InvokeServer() until _G.PData

local function CntBees()
	for i,v in pairs(_G.PData.Bees) do
		
	end
end

for i, v in pairs(bees:GetChildren()) do
	local BM = require(v)
	local Example = script.Bee:Clone()
	Example.Bee.Image = BM.Thumb
	Example.Shadow.ImageColor3 = ShadowColors[BM.Color]
	Example.LayoutOrder = BM.Layout
	Example.Parent = list
end