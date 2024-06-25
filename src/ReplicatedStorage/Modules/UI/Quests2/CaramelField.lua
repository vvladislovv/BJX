local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Collect "..StAm.."/"..NdAm.." Caramel from "..Info.Field.." Field."
end
function module:QuestUpdate(Gui, Info, State)
	if Gui then
		require(script:FindFirstChild(State)).Get(Gui:FindFirstChild("TextLabel"), Utils:AbNumber(Info.StartAmount), Utils:AbNumber(Info.NeedAmount), Info)
	end
end
return module
