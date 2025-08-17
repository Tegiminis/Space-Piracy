extends RigidBody2D

@export var health : ComponentHealth

func _ready() -> void:
	health._ready()
	health.connect("injured", _on_injured)
	health.connect("died", _on_died)

func _on_injured(amount, crit, source):
	print("Debug Target Damage: " + str(amount))

func _on_died(killer):
	queue_free()
