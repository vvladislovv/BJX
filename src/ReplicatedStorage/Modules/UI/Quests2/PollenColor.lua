local module = {}

function module.Get(Label, StAm, NdAm, Info)
	if Info.NColor then
		Label.Text = "Collect "..StAm.."/"..NdAm.." "..Info.NColor.." Pollen."
	else
		Label.Text = "Collect "..StAm.."/"..NdAm.." "..Info.Ncolor.." Pollen."
	end
end

return module
