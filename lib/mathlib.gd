extends Resource
class_name MathLib

static func radian_to_vector2(radian : float):
	var direction = Vector2(cos(radian), sin(radian))
	direction = direction.normalized()
	return direction
