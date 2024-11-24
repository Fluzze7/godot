extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("hola")
	if body is Player:
		$Sprite.play("off")
		$Sound.play()
		GLOBAL.score += 100


func _on_sound_finished():
	queue_free()
