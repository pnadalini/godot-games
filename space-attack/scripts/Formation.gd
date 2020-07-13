extends Node2D

export var speed = 100

var target_position
var left_bound
var right_bound
var is_in_position = false
var direction = 1

var enemies_count

signal formation_defeated

func _ready():
	target_position = rand_range(200, get_viewport_rect().size.y / 2)
	left_bound = position.x - 100
	right_bound = position.x + 100
	direction = 1 if rand_range(0, 100) > 50 else -1
	enemies_count = get_children().size()


func _process(delta):
	movement(delta)
	position.x += speed * direction * delta
	if position.x > right_bound:
		direction = -1
	elif position.x < left_bound:
		direction = 1


func movement(delta):
	if is_in_position:
		return
	
	position.y += speed * delta
	if position.y >= target_position:
		position.y = target_position
		is_in_position = true

func _defeated():
	emit_signal("formation_defeated")
	queue_free()

func _on_any_nemy_defeated():
	enemies_count -= 1
	if enemies_count <= 0:
		_defeated()

func _on_Enemy_was_defeated():
	_on_any_nemy_defeated()


func _on_Enemy2_was_defeated():
	_on_any_nemy_defeated()


func _on_Enemy3_was_defeated():
	_on_any_nemy_defeated()
