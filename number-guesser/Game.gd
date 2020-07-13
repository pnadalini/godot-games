extends Node2D

onready var message = $"Message"
onready var button_correct = $"Correct"

var guess
var min_guessed = 0
var max_guessed = 1000
var ended = true

func _ready():
	guess = (min_guessed + max_guessed) / 2
	print("---------------------")
	print("---------------------")
	print("---------------------")
	print("Hello from Number Guesser!")
	print("I'll guess any number that you think between 0 and 1000")
	print("Is " + str(guess) + " your number?")
	message.text = "Is " + str(guess) + " your number?"
	

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		_try_guess("up")
	elif Input.is_action_just_pressed("ui_down"):
		_try_guess("down")
	elif  Input.is_action_just_pressed("ui_accept"):
		if ended:
			_restart_game()
		else:
			_end_game()

func _try_guess(type):
	if type == "up":
		min_guessed = guess
	else:
		max_guessed = guess
	guess = (min_guessed + max_guessed) / 2
	print("Is " + str(guess) + " your number?")
	message.text = "Is " + str(guess) + " your number?"

func _end_game():
	message.text = "Yes! I knew your number was " + str(guess)
	button_correct.text = "Restart"
	ended = true
	
func _restart_game():
	get_tree().reload_current_scene()


func _on_Greater_pressed():
	_try_guess("up")


func _on_Lesser_pressed():
	_try_guess("down")


func _on_Correct_pressed():
	if ended:
		_restart_game()
	else:
		_end_game()
