extends Node2D

export var move_speed = 100

const MIN_RANGE = -168
const MAX_RANGE = 16
const PIPES_PATH = "res://scenes/Pipes.tscn"

onready var sprite = $Sprite
onready var pipe1 := $Pipe1
onready var pipe2 := $Pipe2

var bird_position
var parent

var width
var is_moving = true
var show_pipes = false
var game_started = false
var score_added = 0

func _ready():
	parent = get_parent()
	width = sprite.texture.get_size().x

func _process(delta):
	if is_moving:
		if position.x <= -width:
			# Move the base to the back
			position.x += width * 2 - move_speed * delta
			score_added = 0
			if game_started:
				add_pipes()
		else:
			position.x -= move_speed * delta
			if show_pipes && (position.x + pipe1.position.x < bird_position.x) && score_added == 0:
				parent.add_score()
				score_added += 1
			if show_pipes && (position.x + pipe2.position.x < bird_position.x) && score_added == 1:
				parent.add_score()
				score_added += 1

func stop_movement():
	is_moving = false
	pass

func add_pipes():
	show_pipes = true
	randomize()
	
	pipe1.position.y = rand_range(MIN_RANGE, MAX_RANGE)
	pipe2.position.y = rand_range(MIN_RANGE, MAX_RANGE)
	
	if pipe1.get_child_count() == 0:
		var pipes = load(PIPES_PATH).instance()
		pipe1.add_child(pipes)
		var pipes2 = load(PIPES_PATH).instance()
		pipe2.add_child(pipes2)
