extends Sprite

export var lifetime := 0.5

onready var _tween := $Tween

func _ready() -> void:
	fade()

func fade(duration := lifetime) -> void:
	# This makes a full transparent color
	var transparent := modulate
	transparent.a = 0.0
	
	# It changes from the current property to the transparent version
	_tween.interpolate_property(self, "modulate", modulate, transparent, duration)
	_tween.start()
	
	# This waits for the interpolation to finish and then deletes itself
	yield(_tween, "tween_all_completed")
	queue_free()
