extends Node2D

func _ready() -> void:
	get_tree().paused = false
	GLOBAL.coins = 0
	GLOBAL.enemies = 0
