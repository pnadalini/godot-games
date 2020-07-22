extends KinematicBody2D

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

const JUMP_SPEED = 250
const DIVIDER = 8.5
const MIN_ROTATION = -30
const MAX_ROTATION = 90
const MIN_FPS = 0
const MAX_FPS = 20

onready var rotate = $Rotate
onready var sprite = $Sprite

var is_playing = false
var is_alive = true
var velocity = Vector2()

signal game_start
signal game_over

func _ready():
	pass

func _process(delta):
	if is_playing:
		velocity.y += gravity
		
		if is_alive:
			if Input.is_action_just_pressed("mouse_click"):
				_fly()
		
		var new_divider = DIVIDER if velocity.y < 0 else (DIVIDER / 3.5)
		rotation_degrees = clamp(velocity.y / new_divider, MIN_ROTATION, MAX_ROTATION)		
		
		if velocity.y < 50 and is_alive:
			sprite.set_animation("flying")
			sprite.get_sprite_frames().set_animation_speed("flying", velocity.y / (-DIVIDER / 2))
		else:
			sprite.set_animation("idle")
		
		for i in get_slide_count():
			var collision := get_slide_collision(i)
			var collider := collision.collider
			if collider is Pipe:
				collider.disable_collision()
				_end_game()
			elif is_on_floor():
				_end_game()
				if rotation_degrees == MAX_ROTATION and !is_alive:
					is_playing = false
		
		move_and_slide(velocity, Vector2.UP)

func start_game() -> void:
	is_playing = true
	_fly()
	move_and_slide(velocity, Vector2.UP)
	emit_signal("game_start")

func _end_game():
	sprite.set_animation("idle")
	is_alive = false
	emit_signal("game_over")

func _fly():
	velocity.y = -JUMP_SPEED
	if position.y < 0:
		velocity.y = 0


