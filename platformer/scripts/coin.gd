extends Area2D
var used = false
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$Sprite.play("off")
		$Sound.play()
		if not used:
			used = true
			GLOBAL.coins += 1
 

func _on_sound_finished():
	queue_free()
