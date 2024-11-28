extends Node2D
var previous_position : Vector2 = Vector2.ZERO 
var displacement : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_position = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	displacement = position - previous_position
	GLOBAL.platform_position = displacement
	previous_position = position
