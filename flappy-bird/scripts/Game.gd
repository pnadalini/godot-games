extends Node2D

onready var bird := $Bird
onready var menu := $Menu
onready var base1 := $Base
onready var base2 := $Base2
onready var animation := $Animation
onready var scoreContainer := $Score
onready var gameOverContainer := $GameOver
onready var medalContainer := $GameOver/Container/VBoxContainer/Panel/Medal
onready var finalScoreContainer := $GameOver/Container/VBoxContainer/Panel/Score
onready var highScoreContainer := $GameOver/Container/VBoxContainer/Panel/BestScore
onready var background := $Background

var game_started := false
var score := 0
var visualScore := 0
var scoreNumbers = []
var medals = [
	preload("res://sprites/media/medal_bronze.png"),
	preload("res://sprites/media/medal_gold.png"),
	preload("res://sprites/media/medal_platinum.png"),
]

func _ready():
	_add_score_numbers()
	base1.bird_position = bird.position
	base2.bird_position = bird.position
	randomize()
	var isDay = rand_range(0, 100) > 50
	background.get_child(0).visible = isDay
	background.get_child(1).visible = !isDay

func _process(delta):
	if Input.is_action_pressed("mouse_click") and !game_started:
		animation.stop(true)
		bird.start_game()
		game_started = true
		_change_score()

func add_score():
	score += 1
	_change_score()

func _change_score():
	scoreContainer.get_child(0).queue_free()
	var boxContainer := HBoxContainer.new()
	_set_score_number(boxContainer)
	scoreContainer.add_child(boxContainer)

func _set_score_number(container: HBoxContainer):
	for digit in str(score):
		var texture := TextureRect.new()
		texture.set_texture(scoreNumbers[int(digit)])
		container.add_child(texture)
	return container

func _add_score_numbers():
	for i in range(10):
		scoreNumbers.append(load("res://sprites/texts/" + str(i) + ".png"))

func _on_Bird_game_start():
	menu.visible = false
	base1.game_started = true
	base2.game_started = true

func _on_Bird_game_over():
	var current_position = gameOverContainer.get_position()
	current_position.x = 0
	gameOverContainer.set_position(current_position)
	_set_results()

func _set_results():
	if score > 10:
		var num = score / 10 * 10
		medalContainer.visible = true
		
		if num % 30 < 10:
			medalContainer.set_texture(medals[2])
		elif num % 20 < 10:
			medalContainer.set_texture(medals[1])
		else:
			medalContainer.set_texture(medals[0])
	_set_score_number(finalScoreContainer)
	_set_score_number(highScoreContainer)

func _on_Restart_pressed():
	get_tree().reload_current_scene()

func _on_Bird_stop_platforms():
	base1.stop_movement()
	base2.stop_movement()
