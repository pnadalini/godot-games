extends Area2D

export var speed = 500
export var damage = 10

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	position.y -= speed * delta
	if position.y < -2000:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("Enemies"):
		area.add_damage(damage)
		queue_free()
