extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if $Viewport:
		if $Viewport.render_target:
			print("Viewport está configurado correctamente.")
		else:
			print("Render Target no está activado en el Viewport.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	pass # Replace with function body.


func _on_scoreboard_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	get_tree().quit()