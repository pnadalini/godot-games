extends Node2D

onready var lightning := $LightningBeam

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_enter"):
		lightning.shoot()
