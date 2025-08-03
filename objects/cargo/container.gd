extends RigidBody2D

@onready var animator = $Sprite2D/AnimationPlayer
@export var item : Item
@export var stacks : int = 1

func _ready() -> void:
	animator.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Cargo container touched")
	var cargo : Dictionary = body.get("cargo")
	var item_dict : Dictionary = {"ref": item, "stacks": stacks}
	var weight_left : int = body.get("weight_max") - body.get("weight")
	var can_hold : bool = item.weight < weight_left
	print(str(cargo) + str(can_hold))
	
	if cargo != null and can_hold:
		var _item = cargo.get(item.name)
		var to_add : int = stacks
		if (item.weight * stacks) > weight_left:
			@warning_ignore("integer_division")
			to_add = weight_left / item.weight
		item_dict["stacks"] = to_add
		
		if _item:
			_item["stacks"] += to_add
		else:
			cargo[item.name] = item_dict
		stacks -= to_add
		print(cargo)
		print("Container stacks left: " + str(stacks))
	
	if stacks <= 0:
		queue_free()
