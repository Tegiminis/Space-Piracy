extends RigidBody2D
class_name Projectile

var source
@export var speed = 100.0
@export var damage = 10
@export var lifetime = 5.0

@onready var animator : AnimationPlayer = $AnimationPlayer

func _init() -> void:
	source = null

func _ready() -> void:
	animator.play("idle")

func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0: queue_free()

func _projectile_collided(object:Node):
	print(object)
	var _health : ComponentHealth = object.get("health")
	if _health != null:
		var taken = _health.injure(damage, false, 0, false, source)
	linear_velocity = Vector2.ZERO
	var anim_randomizer = randf()
	animator.play("impact")
