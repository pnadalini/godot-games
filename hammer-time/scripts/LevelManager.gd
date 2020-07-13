extends Node

const SCENE_PATH = "res://scenes/"
const MINIMUM_SCREEN_HEIGHT = -500

func change_scene(scene_name):
	call_deferred("_deffered_change_scene", scene_name)

func load_end_game(score):
	call_deferred("_deffered_load_end_game", score)

func _deffered_change_scene(scene_name):
	var path = SCENE_PATH + scene_name + ".tscn"
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	current.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)

func _deffered_load_end_game(score):
	var path = SCENE_PATH + "EndMenu.tscn"
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	current.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	new_scene.score = score
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
