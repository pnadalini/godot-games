extends Node2D

onready var sprite = $Sprite
onready var left_axe = $LeftAxe
onready var right_axe = $RightAxe
onready var timer = $Timer

var sprite_height
var direction = 1
var speed = 1500

func _ready():
	sprite_height = sprite.texture.get_height() * scale.y
	set_process(false)

func _process(delta):
	position.x += speed * direction * delta
	
func initialize_trunk(axe, right):
	if axe:
		if right:
			left_axe.queue_free()
		else:
			right_axe.queue_free()
	else:
		left_axe.queue_free()
		right_axe.queue_free()

func remove(from_right):
	if from_right:
		direction = -1
	else:
		direction = 1
	timer.start()
	set_process(true)


func _on_Timer_timeout():
	queue_free()
