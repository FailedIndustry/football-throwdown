extends TextureProgressBar

var charge = 0 : set = _set_charge

func _set_charge(new_charge):
	charge = min(max_value, new_charge)
	value = charge
	
func init_charge(max_charge, starting_charge):
	charge = starting_charge
	max_value = max_charge
	value = charge
