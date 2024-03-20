extends RigidBody3D

## Will be null if not picked up
var carrier = Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# TODO add check on collision to check if not picked up and player passed over it.
# The player itself has to handle dropping the ball and call the drop_ball method

func on_collision(player: Player):
	if linear_velocity.length() > 10:
		if player.can_catch:
			pickup(player)
		else:
			player.ragdoll(linear_velocity)
	else:
		pickup(player)

func drop_ball():
	carrier = null
	reparent(get_node("/root"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pickup(player: Player):
	carrier = Player
	player.add_child(self, true)
