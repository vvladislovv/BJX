local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Craft "..StAm.."/"..NdAm.." "..Info.Item.."."
end

return module
