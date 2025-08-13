extends RigidBody2D

@export var acceleration = 200
@export var brake = 1

@export var hud : CanvasLayer
@onready var camera = $Camera2D
@onready var cargo = $CargoInventory

func _ready() -> void:
	hud.cargo_list.item_activated.connect(_cargo_jettison_button_pressed)

func _input(event: InputEvent) -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	linear_damp = 0
	
	var int_speed = snapped(linear_velocity.length(), 1)
	hud.speed.text = "Speed: " + str(int_speed) + "u/s"
	hud.angular.text = "Torque: " + str(snapped(angular_velocity,0.01)) + "arcsec"
	
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
	
	if Input.is_action_just_pressed("jettison"):
		cargo.jettison("Debug")

func _update_cargo_hud():
	var inv_debug_str : String = ""
	for key in cargo.inventory:
		var value = cargo.inventory[key]
		inv_debug_str += "Item: " + str(value["item"].name) + " | " + "Stacks: " + str(value["stacks"]) + "\n"
	hud.cargo.text = inv_debug_str

func _on_cargo_inventory_added(item: Variant, stacks: Variant) -> void:
	# _update_cargo_hud()
	hud.cargo_list.add_item(item.name)

func _on_cargo_inventory_jettisoned(container: Variant) -> void:
	# _update_cargo_hud()
	pass

func _cargo_jettison_button_pressed(indx:int):
	var _item = hud.cargo_list.get_item_text(indx)
	cargo.jettison(_item)
	hud.cargo_list.remove_item(indx)
