extends Node2D

func _ready() -> void:
	get_tree().paused = false
	GLOBAL.coins = 0
	GLOBAL.enemies = 0

func _on_lvl_end_body_entered(body: Node2D) -> void:
	if body.name == "player":
		call_deferred("end_run")

func end_run():
	GLOBAL.total_coins += GLOBAL.coins
	GLOBAL.coins = 0
	
	GLOBAL.total_enemies += GLOBAL.enemies
	GLOBAL.enemies = 0
	$gui.send_post_new_score()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
