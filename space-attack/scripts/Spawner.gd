extends Node

export(PackedScene) var formation

var center
var offset = 100

func _ready():
	center = get_viewport().get_visible_rect().size.x / 2
	_spawn_formation()

func _spawn_formation():
	randomize()
	var position_x = rand_range(center - offset, center + offset)
	var position_y = -150
	var new_formation = formation.instance()
	new_formation.position = Vector2(position_x, position_y)
	add_child(new_formation)
	
	new_formation.connect("formation_defeated", self, "_on_formation_defeated")

func _on_formation_defeated():
	_spawn_formation()
