extends RigidBody2D
class_name CargoContainer

@onready var animator = $Sprite2D/AnimationPlayer
@export var item:Item
@export var stacks:int = 1
var pickup_delay:float = 5.0

func _ready() -> void:
	animator.play("idle")

func _process(delta: float) -> void:
	pickup_delay -= delta

func set_contents(contents:Dictionary):
	item = contents["item"]
	stacks = contents["stacks"]

func _on_area_2d_body_entered(body: Node2D) -> void:
	var cargo : CargoInventory = body.get("cargo")
	if cargo != null and pickup_delay <= 0:
		stacks = cargo.add(item, stacks)
	
	if stacks <= 0:
		queue_free()
