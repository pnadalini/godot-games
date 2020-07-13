extends ProgressBar

onready var player = $"../Player"

func _ready():
	max_value = player.health
	value = player.health

func _on_Player_took_damage():
	value = player.health
