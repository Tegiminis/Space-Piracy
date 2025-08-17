extends Node2D
class_name Hardpoint

const PLAYER : int = 2

@export var projectile : PackedScene

func fire():
	var _obj : Projectile
	_obj = projectile.instantiate()
	_obj.source = owner
	_obj.add_collision_exception_with(owner)
	_obj.global_position = global_position
	_obj.global_rotation = global_rotation
	_obj.apply_impulse(-_obj.transform.y * _obj.speed)
	get_tree().root.get_child(0).add_child(_obj)
