extends CharacterBody3D
class_name Player

@onready var camera_yaw = $CameraRoot/CameraYaw
@onready var staminabar = $Staminabar

# game variables
@export var walk_speed: float = 5
@export var jump_velocity: float = 4.5
@export var fall_acceleration: float = 75
@export var player_deceleration: float = 0.08
@export var player_acceleration: float = 0.5
@export var health: int = 100
@export var stamina: float = 100
@export var catch_stamina: int = 1
@export var can_catch: bool = false
@export var stamina_loss: float = 0.05
@export var stamina_regen: float = 0.1
@export var stamina_jump_cost: float = 10
@export var sprint_speed: float = 7

var is_regenerating_stamina: bool = true

# y-rotation variables 
var yaw : float = 0
var yaw_sensitivity : float = 0.002
var yaw_acceleration : float = 15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func ragdoll(force: Vector3):
	pass
	
func _set_stamina(value):
	stamina += value
	stamina = clamp(stamina, 0, 100)
	staminabar.stamina = stamina
	
func _ready():
	staminabar.init_stamina(stamina)

func _process(delta):
	if catch_stamina <= 0:
		can_catch = false
	else:
		catch_stamina -= delta

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	# Change yaw using same method as changing camera pitch
	if event is InputEventMouseMotion:
		yaw += -event.relative.x * yaw_sensitivity

func _physics_process(delta):
	is_regenerating_stamina = true
	
	# Rotate player yaw
	rotation_degrees.y = rad_to_deg(lerp_angle(rotation.y, yaw, yaw_acceleration * delta))
	
	# Add gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and stamina > stamina_jump_cost:
		velocity.y = jump_velocity
		_set_stamina(-stamina_jump_cost)

	# Get the input direction and handle the movement/deceleration mechanics.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	
	if direction:
		var speed: float = 0
		
		if Input.is_key_pressed(KEY_SHIFT) and stamina > 0:
			speed = sprint_speed
			is_regenerating_stamina = false
			_set_stamina(-stamina_loss)
		else:
			speed = walk_speed
			
		velocity.x = move_toward(velocity.x, direction.x * speed, abs(direction.x * player_acceleration))
		velocity.z = move_toward(velocity.z, direction.z * speed, abs(direction.z * player_acceleration)) 
	else:
		velocity.x = move_toward(velocity.x, 0, abs(velocity.x * player_deceleration))
		velocity.z = move_toward(velocity.z, 0, abs(velocity.z * player_deceleration))
		
		# Stop deceleration calculations when velocity is negligible
		if abs(velocity.x) < 0.05:
			velocity.x = 0
		if abs(velocity.z) < 0.05:
			velocity.z = 0
			
	if (is_regenerating_stamina):
		_set_stamina(stamina_regen)
		
	move_and_slide()
