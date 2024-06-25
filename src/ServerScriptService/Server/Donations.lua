local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
local Modules = game.ReplicatedStorage:WaitForChild("Modules")
local Donations = require(Modules.Donations)
local Data = require(game.ServerScriptService.Server.Data)
local function FindPassById(ID, Donations)
	for _, Donation in pairs(Donations) do
		if Donation.ID == ID then
			return Donation
		end
	end
end

local module = {} do
	MarketplaceService.ProcessReceipt = function(Info)
		local BPlayer = Players:GetPlayerByUserId(Info.PlayerId)
		local DonationInfo = FindPassById(Info.ProductId, Donations)
		local PData = Data:Get(BPlayer)
		if DonationInfo and BPlayer then
			DonationInfo.Func(BPlayer, PData)
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end
	
	MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(Player, PassID, Purchased)
		local DonationInfo = FindPassById(PassID, Donations)
		local PData = Data:Get(Player)
		if DonationInfo and Player and Purchased then
			DonationInfo.Func(Player, PData)
		end
	end)
end

return module
