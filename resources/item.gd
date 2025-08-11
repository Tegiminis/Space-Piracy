extends Resource
class_name Item

@export var name = "Debug"
@export var weight : int = 1
@export var size : int = 1
@export var base_value : float = 1.0
#todo: add "unique item" logic
@export var can_stack : bool = true
@export var unique : bool = false
