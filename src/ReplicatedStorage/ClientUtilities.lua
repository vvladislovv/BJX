-- Services
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Modules

-- Constants
local Player = game.Players.LocalPlayer

-- Variables

-- Functions

-- Module Object
--if not Player then warn("Attempt to call СlientUtilities from server") return end

local ClientUtilities = {} do
	ClientUtilities.Colors = {
		Red = Color3.fromRGB(247, 63, 66),
		Green = Color3.fromRGB(126, 255, 119),
		Blue = Color3.fromRGB(82, 151, 255)
	}
	
	function ClientUtilities:PopupNotification(Text, Color)
		Color = self.Colors[Color] or self.Colors.Blue
		
		local NewNotification = script.Notification:Clone()
		NewNotification.Text = Text
		NewNotification.Parent = Player:WaitForChild("PlayerGui"):WaitForChild("UI").Notifications
		
		coroutine.wrap(function()
			wait(3.5)
			TweenService:Create(NewNotification, TweenInfo.new(3.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
			wait(3.5)
			NewNotification:Destroy()
		end)()
	end
	--ReplicatedStorage.Remotes.PopupNotification.OnClientEvent:Connect(function(...) ClientUtilities:PopupNotification(...) end)
end

------
return ClientUtilities