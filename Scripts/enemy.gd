extends Node2D

@export var speed := 100.0
@export var patrol_distance := 150.0

var start_x := 0.0
var direction := 1.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

func _ready() -> void:
	start_x = position.x
	animated_sprite.play("on")
	if not hitbox.body_entered.is_connected(_on_body_entered):
		hitbox.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	# Bergerak maju mundur
	position.x += direction * speed * delta
	
	if position.x > start_x + patrol_distance:
		direction = -1.0
	elif position.x < start_x - patrol_distance:
		direction = 1.0

func _on_body_entered(body: Node2D) -> void:
	# Nembus (tidak tabrakan fisik) tapi jika terkena player, langsung kembali ke posisi awal
	if body.has_method("respawn"):
		body.respawn()
	elif body.name == "Player":
		get_tree().reload_current_scene()
