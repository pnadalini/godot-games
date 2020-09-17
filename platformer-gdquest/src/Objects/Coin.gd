extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

export var score: = 100

func _ready() -> void:
	pass

func _on_Coin_body_entered(body: Node) -> void:
	picked()

func picked() -> void:
	PlayerData.score += score
	anim_player.play("fade_out")
