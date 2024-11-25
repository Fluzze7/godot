extends Area2D
var exploted = false
func _process(_delta: float) -> void:
	pass
	

func _on_animated_sprite_2d_animation_finished() -> void:
	exploted = true
