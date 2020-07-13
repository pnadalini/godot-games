extends Node2D

const MOVE_SPEED = 500
const OFFSET = 64

onready var top = $TopBackground
onready var bottom = $BottomBackground

var top_position
var bottom_position

func _ready():
	top_position = top.position.y
	bottom_position = get_viewport_rect().size.y
	

func _process(delta):
	top.position.y += MOVE_SPEED * delta
	bottom.position.y += MOVE_SPEED * delta
	if top.position.y >= bottom_position + OFFSET:
		top.position.y = top_position
	elif bottom.position.y >= bottom_position + OFFSET:
		bottom.position.y = top_position

