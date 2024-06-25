-- // чёт хуйня не работает нихуя // я тестил чёт поебота какая то
-- // через тоучед и тауч енд не работает тож, оно баганно
-- // а модуль с зонами я хз откуда должен брать те методы типо playerEntered, их там попросту нет
local ts = game:GetService("TweenService")
local totalclouds = 0

while true do
	for i = 1, math.random(3,8) do
		totalclouds += 1
		local Cloud = Instance.new("Part", workspace)
		local X = math.random(-1000,1400)
		Cloud.Name = "Cloud"..totalclouds
		Cloud.Color = Color3.fromRGB(255,255,255)
		Cloud.Anchored = true
		Cloud.CanCollide = false
		Cloud.Size = Vector3.new(math.random(100,300), math.random(15,35), math.random(100,300))
		Cloud.Position = Vector3.new(X, 1050, math.random(850,1150))
		ts:Create(Cloud, TweenInfo.new(100), {Position = Vector3.new(X, 1050, -1300)}):Play()
		spawn(function()
			wait(125)
			Cloud:Destroy()
		end)
		wait(0.5)
	end
	wait(math.random(10,25))
end