extends StaticBody2D
class_name Pipe

onready var collision := $Collision

func disable_collision() -> void:
	collision.disabled = true
