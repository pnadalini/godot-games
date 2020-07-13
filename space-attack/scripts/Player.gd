extends KinematicBody2D

const SPEED = 500

export(PackedScene) var projectile
export var health = 100

onready var sprite = $Sprite
onready var timer = $Timer
onready var deathTimer = $DeathTimer
onready var audio = $Audio

var screen_size
var half_sprite_size
var can_shoot = true
var dead = false

signal took_damage

func _ready():
	screen_size = get_viewport_rect().size.x
	half_sprite_size = sprite.texture.get_width() * scale.x / 2

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= SPEED * delta
	if Input.is_action_pressed("ui_right"):
		position.x += SPEED * delta
	
	if can_shoot and Input.is_action_pressed("ui_accept"):
		can_shoot = false
		var new_proyectile = projectile.instance()
		new_proyectile.position = position
		get_parent().add_child(new_proyectile)
		timer.start()
		audio.play()
	
	position.x = clamp(position.x, 0 + half_sprite_size, screen_size - half_sprite_size)


func _on_Timer_timeout():
	can_shoot = true

func add_damage(damage):
	health -= damage
	emit_signal("took_damage")
	if health <= 0:
		dead = true
		health = 0
		deathTimer.start()
		set_process(false)
		sprite.queue_free()


func _on_DeathTimer_timeout():
	get_tree().reload_current_scene()
