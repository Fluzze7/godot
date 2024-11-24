extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("hallo")
	if body is Player:
		body.damage_ctrl()
