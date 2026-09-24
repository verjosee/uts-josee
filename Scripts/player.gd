extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var spawn_position := Vector2.ZERO


func _ready() -> void:
	spawn_position = position


func respawn() -> void:
	position = spawn_position
	velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump (hanya saat menyentuh tanah).
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)

	move_and_slide()

	# Batasi player agar tidak keluar dari ujung layar (screen boundary)
	var viewport_rect := get_viewport_rect()
	var half_width := 24.0 # estimasi setengah lebar collision player
	position.x = clamp(position.x, half_width, viewport_rect.size.x - half_width)

	# Update arah sprite dan animasi setelah move_and_slide agar is_on_floor() akurat
	update_animation(direction)


func update_animation(direction: float) -> void:
	# Balik sprite (flip_h) sesuai arah gerak
	if direction > 0.0:
		animated_sprite.flip_h = false
	elif direction < 0.0:
		animated_sprite.flip_h = true

	# Prioritas animasi: jump -> run -> idle
	if not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0.0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
