extends Area

onready var animation = $Animation
onready var audio = $Audio

var already_hit = false

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(area):
	if area.name == "Hammer" and !already_hit:
		audio.play()
		animation.play("hit")

func _on_VisibilityNotifier_screen_exited():
	if !already_hit:
		$"/root/Game".game_end()
