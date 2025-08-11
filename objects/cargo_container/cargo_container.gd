extends RigidBody2D
class_name CargoContainer

@onready var animator = $Sprite2D/AnimationPlayer
@export var item : Item
@export var stacks : int = 1

func _ready() -> void:
	animator.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	var cargo : CargoInventory = body.get("cargo")
	if cargo != null:
		stacks = cargo.add_item(item, stacks)
	
	if stacks <= 0:
		queue_free()
