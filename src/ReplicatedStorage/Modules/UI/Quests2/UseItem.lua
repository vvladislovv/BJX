local module = {}

function module.Get(Label, StAm, NdAm, Info)
	Label.Text = "Use "..StAm.."/"..NdAm.." "..Info.Item.."."
end

return module
