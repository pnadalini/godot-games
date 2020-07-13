extends Node

onready var score_text = $Score

var score = 0

func _ready():
	score_text.text = str(score)


func _on_Hammer_nail_hit():
	score += 1
	score_text.text = str(score)


func _on_Hammer_game_end():
	$"/root/LevelManager".load_end_game(score)

func game_end():
	$"/root/LevelManager".load_end_game(score)
	
func _on_Plank_game_end():
	$"/root/LevelManager".load_end_game(score)

func _on_Plank2_game_end():
	$"/root/LevelManager".load_end_game(score)
