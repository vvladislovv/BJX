local RunService = game:GetService("RunService")
local Camera = workspace.Camera

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Debug = false

local Utils = {} do
	Utils.LoadScripts = {}
	--Replicated
	local u1 = nil
	local u2 = 0
	local u3 = 0.75 * math.pi
	
	function Utils.GetFieldZone(Field)
		local Table = {
			["0"] = {"Blue Flowers", "Daisy", "Fungus", "Red Flowers"},
			["5"] = {"Lemon", "Strawberry", "Cabbage"},
			["10"] = {"Pine Tree", "Rose", "Clover"},
			["15"] = {"Dandelion", "Tomato"},
			["20"] = {"Sunflower", "Cattail"},
			["25"] = {},
		}
		for Zone, Fields in Table do
			if table.find(Fields, Field) then
				return Zone
			end
		end
		return "0"
	end

	function Utils.CountBees(Tab)
		local t = 0
		for i,v in pairs(Tab) do
			if v.BeeName ~= "" then
				t += 1
			end
		end
		return t
	end
	
	function Utils.GetTableNum(Table, Type)
		local v1 = 0

		for i, Challenge in pairs(Table) do
			v1 += Challenge[Type]
		end

		return v1 
	end
	
	function Utils.CheckMag(p1, p2, r1)
		if (p1.Position - p2.Position).Magnitude <= r1 then
			return true
		else
			return false
		end
	end
	
	function Utils.MakeBeam(p9, p10, p11, p12, p13, p14)
		local v2 = Instance.new("Part")
		v2.BrickColor = BrickColor.new("Bright red")
		v2.FormFactor = "Custom"
		v2.Material = "Neon"
		v2.Transparency = 0.35
		v2.Anchored = true
		v2.CanCollide = false
		local v19 = v2:Clone()
		v19.Parent = workspace.Particles
		if p12 then
			v19.Color = p12
		end
		local l__magnitude__20 = (p10 - p11).magnitude
		v19.Size = Vector3.new(0.3, 0.3, l__magnitude__20)
		v19.CFrame = CFrame.new(p10, p11) * CFrame.new(0, 0, -l__magnitude__20 / 2)
		if p14 then
			v19.Material = p14
		end
		if not p13 then
			p13 = 0.1
		end
		game:GetService("Debris"):AddItem(v19, p13)
		return v19
	end
	
	function Utils.MakeWarningDisk(CFVal, Radius, Time, Color)
		if not Radius then
			Radius = 10
		end
		if not Time then
			Time = 2
		end
		local v84 = script.WarningDisk:Clone()
		v84.CFrame = CFrame.new(CFVal)
		local v85 = Radius + Radius
		v84.Size = Vector3.new(v85, 0.4, v85)
		v84.Transparency = 1
		v84.Parent = workspace.Particles
		print("Created")
		if Color then
			v84.Color = Color
		end
		game:GetService("TweenService"):Create(v84, TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
			Transparency = 0
		}):Play()
		game:GetService("Debris"):AddItem(v84, Time)
		return v84
	end
	function Utils.PlaySoundAtPos(pos,sound)
		if sound and sound:IsA("Sound") then
			local p = Instance.new("Part",workspace)
			p.CanCollide = false
			p.Transparency = 1
			p.Size = Vector3.new(1,1,1)
			p.Position = pos
			p.Massless = true
			local s = sound:Clone()
			s.Parent = p
			s:Play()
			game.Debris:AddItem(p,s.TimeLength+0.1)
		end
	end
	--function Utils.MakeText(p40, p41, p42, p43, p44, p45, p46, p47, p48)
	--	local v32 = v4:Clone();
	--	if not p48 then
	--		p48 = l__TextRoot__3;
	--	end;
	--	v32.Parent = p48;
	--	v32.StudsOffsetWorldSpace = p41 - p48.Position;
	--	v32.TextLabel.Text = p42;
	--	if p44 then
	--		v32.TextLabel.Size = UDim2.new(p44 * l__TextLabel__7.Size.X.Scale, 0, p44 * l__TextLabel__7.Size.Y.Scale, 0);
	--	end;
	--	if p43 then
	--		v32.TextLabel.TextColor3 = p43;
	--	end;
	--	if not p45 then
	--		p45 = 1;
	--	end;
	--	if p46 then
	--		for v33, v34 in ipairs(p46) do
	--			v1.ApplyTextEffect(v32.TextLabel, v34);
	--		end;
	--	end;
	--	v32.TextLabel:TweenSize(UDim2.new(0.25 * v32.TextLabel.Size.X.Scale, 0, 0.25 * v32.TextLabel.Size.Y.Scale, 0), "In", "Back", p45, true, function()
	--		if p46 then
	--			for v35, v36 in ipairs(p46) do
	--				v1.RemoveTextEffect(v32.TextLabel, v36);
	--			end;
	--		end;
	--		if p47 then
	--			p47(v32);
	--		end;
	--		v32:Destroy();
	--	end);
	--	return v32;
	--end;
	
	--function Utils.PollenText(p51, p52)
	--	local l__Pos__38 = p52.Pos
	--	if not l__Pos__38 then
	--		return
	--	end
	--	if p52.RawAmount then
	--		local v39 = p52.RawAmount
	--	else
	--		v39 = p52.Amount
	--	end
	--	local v40 = nil
	--	if p52.Color ~= nil then
	--		if p52.Color == "Red" then
	--			v40 = Color3.fromRGB(253, 95, 52)
	--		elseif p52.Color == "Blue" then
	--			v40 = Color3.fromRGB(77, 156, 255)
	--		end
	--	end
	--	local v41 = v39
	--	if v41 < 1 then
	--		v41 = 1
	--	end
	--	local v42 = math.pow(v41, 0.16666666666666666)
	--	if u8 < v42 then
	--		v42 = u8 + math.pow(v42 - u8, 0.8)
	--	end
	--	if v39 < 1000 then
	--		local v43 = "+" .. v39
	--	else
	--		v43 = "+" .. u9(v39)
	--	end
	--	local v44 = 1
	--	local v45 = nil
	--	if p52.Crit then
	--		v44 = 1.25
	--		v45 = { "Crit" }
	--	end;
	--	local v46 = Utils:MakeText(l__Pos__38, v43, v40, 0.4 + v42, v44, v45);
	--	if p52.Crit then
	--		v46.TextLabel.Font = "SourceSansBold"
	--	end
	--	return v46
	--end
	
	function Utils.RotatePoint(p1, p2, p3, p4, p5)
		local v1 = math.cos(p5)
		local v2 = math.sin(p5)
		local v3 = p3 - p1
		local v4 = p4 - p2
		return p1 + v1 * v3 - v2 * v4, p2 + v2 * v3 + v1 * v4
	end
	
	local prefixes = {
		"","k","M","B","T","qd","Qn","Sx","Sp","Oc","N"
	}
	function Utils:AbNumber(Num)
		for i = 1, #prefixes do
			if tonumber(Num) < 10 ^ (i * 3) then
				return math.floor(Num / ((10 ^ ((i - 1) * 3)) / 100)) / (100) .. prefixes[i]
			end
		end
	end
	
	function Utils:CommaNumber(Num)
		Num = tostring(Num)
		return Num:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
	end
	
	function Utils:MakeShockwave(p25, p26, p27, p28, p29, p30, p31)
		if not p29 then
			p29 = script.Shockwave
		end
		if not p28 then
			p28 = 4
		end
		local v29 = p29:Clone()
		if not p30 then
			p30 = Vector3.new(0.01, p27, 0.01)
		end
		if not p31 then
			p31 = Vector3.new(p26, p27 * 0.3, p26)
		end
		v29.Size = p30
		v29.Position = p25
		v29.Parent = workspace.Particles
		game:GetService("TweenService"):Create(v29, TweenInfo.new(p28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = p31,
			Transparency = 1
		}):Play()
		game:GetService("Debris"):AddItem(v29, p28)
		return v29
	end
	
	function Utils:TweenCam(camPart, cframe)
		Camera.CameraType = Enum.CameraType.Scriptable
		TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {FieldOfView = 55}):Play()
		local cf

		if camPart then cf = camPart.CFrame else cf = cframe end
		local Info = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

		local Tween = TweenService:Create(Camera, Info, {CFrame = cf})
		Tween:Play()
		--Tween.Completed:Wait()
	end
	
	function Utils:DeepCopy(Original)
		local Copy = {}

		for Key, Value in pairs(Original) do
			if type(Value) == "table" then
				Value = Utils:DeepCopy(Value)
			end

			Copy[Key] = Value
		end

		return Copy
	end
	--Gui
	function Utils:PerSecond(u56, Label) -- u56 = {Value = 100, Name = "Honey"}
		local u1 = {
			Stats = {

			},
		}
		function u1:Update(p1, p2)
			local v3 = u1.Stats[p1]
			if not v3 then
				u1.Stats[p1] = {
					LastTime = tick(),
					LastUpTime = tick(),
					Buffer = 0,
					Value = p2
				}
				return --v3
			end
			local v4 = tick()
			local v5 = (v4-v3.LastTime) * 1
			if v3.Value <= p2 then
				v3.Buffer = (v3.Buffer * 9 + math.max(p2 - v3.Value, 0) * v5 * 1) / (9 + v5 * 1)
			end
			if v3.Value < p2 then
				v3.LastUpTime = v4
			elseif v4-v3.LastUpTime > 5 then
				v3.Buffer = 0
			end

			v3.Value = p2
			v3.LastTime = v4
		end
		function u1:Get(p3)
			local v6 = u1.Stats[p3]
			if not v6 then
				return 0
			end
			if tick() - v6.LastUpTime > 6 then
				return 0
			end
			return v6.Buffer * 2
		end
		local v9 = function(num)
			local f, k = num, nil
			while true do
				f, k = string.gsub(f, "^(-?%d+)(%d%d%d)", "%1,%2")
				if k == 0 then
					break
				end
			end
			return f
		end
		local u2 = u56.Value
		local function v12(p4)
			local v13 = math.floor(u1:Get(u56.Name) + 0.5)
			if v13 > 0 then
				Label.Text = "<i>"..u56.Name.."</i> Per Second: "..v9(v13)
			else
				Label.Text = "<i>"..u56.Name.."</i> Per Second: 0"
			end
		end
		u56:GetPropertyChangedSignal("Value"):Connect(function()
			u2 = u56.Value
		end)
		coroutine.wrap(function()
			while true do
				u2 = u56.Value
				u1:Update(u56.Name, u2)
				v12()
				wait(1)
			end
		end)()
	end
	Utils.Colors = {
		Green = {Color = Color3.fromRGB(62, 193, 82), Drop = Color3.fromRGB(70, 217, 94)},
		Red = {Color = Color3.fromRGB(209, 69, 69), Drop = Color3.fromRGB(254, 86, 86)},
		Blue = {Color = Color3.fromRGB(50, 131, 255), Drop = Color3.fromRGB(80, 147, 255)},
		Orange = {Color = Color3.fromRGB(220, 175, 61), Drop = Color3.fromRGB(255, 203, 71)},
		Silver = {Color = Color3.fromRGB(165, 165, 175), Drop = Color3.fromRGB(199, 199, 212)},
		Bronze = {Color = Color3.fromRGB(163, 87, 46), Drop = Color3.fromRGB(213, 115, 61)},
		White = {Color = Color3.fromRGB(210, 210, 210), Drop = Color3.fromRGB(250, 250, 250)},
		Dark = {Color = Color3.fromRGB(40, 40, 40), Drop = Color3.fromRGB(54, 54, 54)},
		Error = {Color = Color3.fromRGB(156, 39, 43), Drop = Color3.fromRGB(180, 46, 50)},
	}
	function Utils:FadeBlackBox(BlackBox,Type)
		if Type == "In" then
			TweenService:Create(BlackBox, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
		else
			TweenService:Create(BlackBox, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0}):Play()
		end
	end
	function Utils:GetTime(Type)
		local Date = os.date("*t")
		
		if Type == "12H" then
			local Hour = Date.hour
			local Time = ("%02d:%02d"):format(((Date.hour % 24) - 1) % 12 + 1, Date.min)
			
			if Hour < 12 or Hour == 24 then
				Time = Time.." AM"
			else
				Time = Time.." PM"
			end
			
			return Time
		elseif Type == "24H" then
			local Hours = Date.hour
			if Hours < 10 then Hours = "0"..Hours end
			
			local Minutes = Date.min
			if Minutes < 10 then Minutes = "0"..Minutes end
			
			return Hours..":"..Minutes
		else
			warn("Error: Given TimeType is not valid!")
		end
	end
	function Utils.PickRandom(Table)
		local TotalWeight = 0

		for i,v in Table do
			TotalWeight += type(v) == "number" and v or v.Chance and v.Chance or 0
		end
		local Chance = math.random(1, TotalWeight)
		local coun = 0
		for i,v in Table do
			coun += type(v) == "number" and v or v.Chance and v.Chance or 0
			if coun >= Chance then
				return type(v) == "table" and v.Name and v.Name or i
			end
		end
	end
	function GetType()
		if RunService:IsClient() then
			return "Client"
		else
			return "Server"
		end
	end
	function Format(Int)
		return string.format("%02i", Int)
	end
	function Utils:FormatTime(Seconds)
		local Minutes = (Seconds - Seconds%60)/60
		Seconds = Seconds - Minutes*60

		local Hours = (Minutes - Minutes%60)/60
		Minutes = Minutes - Hours*60

		local Days = (Hours - Hours%24)/24
		Hours = Hours - Days*24

		if Days > 0 and Hours > 0 and Minutes > 0 then
			return Format(Days)..":"..Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
		elseif Days <= 0 and Hours > 0 and Minutes > 0 then
			return Format(Hours)..":"..Format(Minutes)..":"..Format(Seconds)
		elseif Days <= 0 and Hours <= 0 and Minutes > 0 then
			return Format(Minutes)..":"..Format(Seconds)
		else
			return Format(Minutes)..":"..Format(Seconds)
		end
	end
	function Utils:TweenModel(model, CF, info)
		if model:IsA("Model") then
			local CFrameValue = Instance.new("CFrameValue")
			CFrameValue.Value = model:GetPrimaryPartCFrame()

			CFrameValue:GetPropertyChangedSignal("Value"):Connect(function()
				if model.PrimaryPart ~= nil then
					model:SetPrimaryPartCFrame(CFrameValue.Value)
				end
			end)

			local tween = TweenService:Create(CFrameValue, info, {Value = CF})
			tween:Play()

			tween.Completed:Connect(function()
				CFrameValue:Destroy()
			end)
		else
			warn("Error: Provided Object is not Model!")
		end
	end
	--Load Scripts
	local GameName = "Cool Game"
	
	function Utils:Load(Script, One)
		local Start = tick()
		print(GetType().." / Start Loading")
		if not One then
			for i,v in pairs(Script:GetDescendants()) do
				if v:IsA("ModuleScript") then
					if GetType() == "Server" and v.Name ~= "AlertBoxes" and v.Name ~= "Equipment" then
						spawn(function()
						--print(v.Name.." / Requiering...")
							local Module = require(v)
							Utils.LoadScripts[v.Name] = require(v)
						--print(v.Name.." / Loaded")
						end)
					end
				end
			end
		else
			--spawn(function()
			--print(Script.Name.." / Requiering...")
			Utils.LoadScripts[Script.Name] = require(Script)
			--print(Script.Name.." / Loaded")
			--end)
		end
		print(GetType().." / Loaded / Time Elapsed: "..tick() - Start)
	end
end

return Utils
