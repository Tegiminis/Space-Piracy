extends Area2D
class_name CargoInventory

signal added(item, stacks)
signal jettisoned(container)

var inventory : Dictionary
var weight : int:
	get:
		var _weight = 0
		for key in inventory:
			_weight += inventory[key]["item"].weight * inventory[key]["stacks"]
		return _weight
	set(value):
		push_error(str(self) +": You cannot set an inventory's weight directly!")
@export var weight_max : int = 10

func add(item:Item, stacks:int = 1) -> int:
	print("Inventory component function invoked: add_item")
	var stacks_left = stacks
	var item_dict : Dictionary = {"item": item, "stacks": stacks}
	var weight_left : int = weight_max - weight
	var can_hold : bool = item.weight < weight_left
	print(str(inventory) + str(can_hold))

	if can_hold:
		var _item = inventory.get(item.name)
		var to_add : int = stacks
		if (item.weight * stacks) > weight_left:
			@warning_ignore("integer_division")
			to_add = weight_left / item.weight
		item_dict["stacks"] = to_add
		
		if _item:
			_item["stacks"] += to_add
		else:
			inventory[item.name] = item_dict
		stacks_left -= to_add
		added.emit(item, to_add)
		
	return stacks_left

## Jettisons the cargo with the specified key in the cargo inventory
func jettison_item(key:String):
	if key not in inventory:
		return
	var item_dict : Dictionary = inventory[key]
	var container : PackedScene = item_dict["item"].container
	var _obj = container.instantiate()
	var magnitude = randi_range(100,400)
	add_child(_obj)
	_obj.set_contents(item_dict)
	_obj.pickup_delay = 5.0
	_obj.linear_velocity = owner.linear_velocity
	_obj.apply_impulse(Vector2(randf(),randf()) * magnitude )
	inventory.erase(key)
	jettisoned.emit(_obj)
