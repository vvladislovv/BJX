-- Services
--local TS = game:GetService("TweenService")
--local Remotes = game.ReplicatedStorage.Remotes
-- Modules
-- Constants

-- Variables

-- Functions
function Format(Int)
	return string.format("%02i", Int)
end

-- Module Object

local Utilities = {} do
	
	function Utilities:RandomNumber(Number)
		if typeof(Number) == "table" then
			return math.random(Number[1], Number[2])
		else
			return Number
		end
	end
	
	function Utilities:GetPercent(Number, Percent)
		if Percent > 0 then
			return Number * (Percent / 100)
		else
			return 0
		end
	end
	
	function Utilities:FormatTime(Seconds)
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
	
	function Utilities:DeepCopy(Table)
		local Clone = {}

		for key, value in pairs(Table) do
			if typeof(value) == "table" then
				Clone[key] = Utilities:DeepCopy(value)
			else
				Clone[key] = value
			end
		end

		return Clone
	end
	
	function Utilities:Random(Percent, Type, Table)
		local Rand = math.random(1, 100)

		if Type == "Bool" then
			if Rand <= Percent then
				return true
			else
				return false
			end
		elseif Type == "Table" and Table then
			local Counter = 0

			for Object, Weight in pairs(Table) do
				Counter += Weight

				if Rand <= Counter then
					return Object
				end
			end
		else
			warn(Type.."not valid random type")
		end
	end
end

------
return Utilities