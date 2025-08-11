extends Area2D
class_name CargoInventory

signal added_item(item, stacks)

var inventory : Dictionary
var weight : int:
	get:
		var _weight = 0
		for item in inventory:
			_weight += item["ref"].weight * item["stacks"]
		return _weight
	set(value):
		push_error(str(self) +": You cannot set an inventory's weight directly!")
@export var weight_max : int = 10

func add_item(item:Item, stacks:int = 1) -> int:
	print("Inventory component function invoked: add_item")
	var stacks_left = stacks
	var item_dict : Dictionary = {"ref": item, "stacks": stacks}
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
	
	return stacks_left
