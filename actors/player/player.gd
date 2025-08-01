extends RigidBody2D

@export var acceleration = 200
@export var brake = 1

@onready var gui_speed = $Control/Speed
@onready var gui_torque = $Control/Rotation
@onready var camera = $Camera2D

func _input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	linear_damp = 0
	
	gui_speed.text = str(linear_velocity)
	gui_torque.text = str(angular_velocity)
	
	var direction = position.angle()
	
	if Input.is_action_pressed("thrust"):
		apply_force(-transform.y * acceleration)
	if Input.is_action_pressed("reverse"):
		apply_force(transform.y * acceleration)
	if Input.is_action_pressed("brake"):
		linear_damp = brake
	
	if Input.is_action_pressed("rotate_ccw"):
		apply_torque(-100)
		
	if Input.is_action_pressed("rotate_cw"):
		apply_torque(100)
	
	if Input.is_action_just_pressed("zoom_in"):
		camera.zoom *= 1.1
	if Input.is_action_just_pressed("zoom_out"):
		camera.zoom *= 0.9
	
