extends Sprite

const FadingSprite: PackedScene = preload("res://src/GhostTrail/FadingSprite.tscn")

export var amount := 10

export var is_emitting := false setget set_is_emitting

onready var _timer := $GhostSpawnTimer

func _spawn_ghost() -> void:
	var ghost := FadingSprite.instance()
	
	ghost.texture = texture
	ghost.offset = offset
	ghost.flip_h = flip_h
	ghost.flip_v = flip_v
	ghost.global_position = global_position
	
	add_child(ghost)
	
	ghost.set_as_toplevel(true)

func set_is_emitting(value: bool) -> void:
	is_emitting = value
	if not is_inside_tree():
		yield(self, "ready")
	
	if is_emitting:
		_spawn_ghost()
		
		_timer.start(1.0 / amount)
	else:
		_timer.stop()


func _on_GhostSpawnTimer_timeout() -> void:
	_spawn_ghost()
