extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Sprite.play("off")
		$Sound.play()
		body.SCORE += 100


func _on_sound_finished() -> void:
	queue_free()
