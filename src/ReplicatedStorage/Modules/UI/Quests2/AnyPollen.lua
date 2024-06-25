local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text =  "Collect "..StAm.."/"..NdAm.." Pollen."
end

return module
