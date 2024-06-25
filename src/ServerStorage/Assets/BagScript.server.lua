local Data = require(game.ServerScriptService.Server.Data)

repeat wait() until script.Parent.Parent.Parent == workspace
local Indicator = script.Parent:WaitForChild("Display")
local Utils = require(game.ReplicatedStorage.Modules.Utils)

local Player = game.Players:GetPlayerFromCharacter(script.Parent.Parent)
Indicator.Gui.ProgressBar.UICorner.CornerRadius = UDim.new(0.2,0)
Indicator.Gui.RedBar.UICorner.CornerRadius = UDim.new(0.2,0)
local Grad = script.UIGradient:Clone()
Grad.Parent = Indicator.Gui.ProgressBar
local Grad2 = script.UIGradient:Clone()
Grad2.Parent = Indicator.Gui.RedBar
while script.Parent.Parent:FindFirstChild("Humanoid") do wait(0.1)
	local PData = Data:Get(Player)
	 
	Indicator.Gui.ProgressLabel.Text = Utils:CommaNumber(math.round(PData.IStats.Pollen)).."/"..Utils:CommaNumber(math.round(PData.IStats.Capacity))
	Indicator.Gui.ProgressLabel.ProgressLabel.Text = Utils:CommaNumber(math.round(PData.IStats.Pollen)).."/"..Utils:CommaNumber(math.round(PData.IStats.Capacity))
	Indicator.Gui.ProgressBar.Size = UDim2.new(PData.IStats.Pollen / PData.IStats.Capacity, 0, 1, 0)
end