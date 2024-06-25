local module = {}

function module.Get(Label, StAm, NdAm, Info)
	if Info.Color then
		Label.Text = "Collect "..StAm.."/"..NdAm.." "..Info.Color.." Pollen from "..Info.Field.." Field."
	else
		Label.Text = "Collect "..StAm.."/"..NdAm.." Pollen from "..Info.Field.." Field."
	end
end

return module
