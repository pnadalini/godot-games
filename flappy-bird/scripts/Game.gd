extends Node2D

onready var bird := $Bird
onready var menu := $Menu
onready var base1 := $Base
onready var base2 := $Base2
onready var animation := $Animation

var game_started := false

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("mouse_click") and !game_started:
		animation.stop(true)
		bird.start_game()
		game_started = true


func _on_Bird_game_start():
	menu.visible = false
	base1.game_started = true
	base2.game_started = true


func _on_Bird_game_over():
	base1.stop_movement()
	base2.stop_movement()
