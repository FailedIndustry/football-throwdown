extends Node

@onready var yaw_node = $CameraYaw
@onready var pitch_node = $CameraYaw/CameraPitch
@onready var camera = $CameraYaw/CameraPitch/Camera3D

@export var pitch : float = 0

# yaw is currently handled in Player script by player rotation

# var yaw_sensitivity : float = 0.07
var pitch_sensitivity : float = 0.07

# var yaw_acceleration : float = 15
var pitch_acceleration : float = 15

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		# yaw += -event.relative.x * yaw_sensitivity
		pitch += -event.relative.y * pitch_sensitivity


func _physics_process(delta):
	# yaw_node.rotation_degrees.y = lerp(yaw_node.rotation_degrees.y, yaw, yaw_acceleration * delta)
	pitch_node.rotation_degrees.x = lerp(pitch_node.rotation_degrees.x, pitch, pitch_acceleration * delta)
