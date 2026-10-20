extends CanvasLayer

var skor := 0

@onready var score_label: Label = %ScoreLabel


func _ready() -> void:
	add_to_group("hud")
	_perbarui()


func tambah_skor(jumlah: int = 1) -> void:
	skor += jumlah
	_perbarui()


func _perbarui() -> void:
	score_label.text = "Skor: " + str(skor)
