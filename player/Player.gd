extends CharacterBody3D
class_name Player

@onready var camera_yaw = $CameraRoot/CameraYaw

# game variables
@export var speed = 14
@export var jump_velocity = 4.5
@export var fall_acceleration = 75
@export var walk_deceleration = 8
@export var health: int = 100
@export var stamina: int = 100
@export var catch_stamina: int = 1
@export var can_catch: bool = false

# y-rotation variables 
var yaw : float = 0
var yaw_sensitivity : float = 0.002
var yaw_acceleration : float = 15

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func ragdoll(force: Vector3):
	pass

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
	# Rotate player yaw
	rotation_degrees.y = rad_to_deg(lerp_angle(rotation.y, yaw, yaw_acceleration * delta))
	
	# Add gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration mechanics.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, abs(velocity.x/walk_deceleration))
		velocity.z = move_toward(velocity.z, 0, abs(velocity.z/walk_deceleration))
		
		# Stop deceleration calculations when velocity is negligible
		if abs(velocity.x) < 0.05:
			velocity.x = 0
		if abs(velocity.z) < 0.05:
			velocity.z = 0
		
	print(velocity.x)
	print(velocity.z)

	move_and_slide()
