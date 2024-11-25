extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($".".collision_layer)



func _on_body_entered(body: Node2D) -> void:
	print("El juegador ha entrado?")
