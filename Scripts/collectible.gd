extends Area2D

@export var nilai := 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite.play("idle")
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body.has_method("respawn"):
		return
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		hud.tambah_skor(nilai)
	queue_free()
