extends TextureProgressBar


@onready var timer = $Timer
@onready var loss_bar = $Lossbar

var stamina = 0 : set = _set_stamina

func _set_stamina(new_stamina):
	var prev_stamina = stamina
	stamina = min(max_value, new_stamina)
	value = stamina
	
	if stamina < 0:
		queue_free()
		
	if stamina < prev_stamina:
		timer.start()
	else:
		loss_bar.value = stamina

func init_stamina(_stamina):
	stamina = _stamina
	max_value = stamina
	value = stamina
	loss_bar.max_value = stamina
	loss_bar.value = stamina


func _on_timer_timeout():
	loss_bar.value = stamina
