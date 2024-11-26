extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GLOBAL.lives = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	print(GLOBAL.username)
	if GLOBAL.username.is_empty():
		$Popup.show()  
		while(GLOBAL.username.is_empty()):
			await $Popup/VBoxContainer/Button.pressed
			GLOBAL.username = $Popup/VBoxContainer/LineEdit.text.strip_edges()
			
		$Popup.hide()
		
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")



func _on_scoreboard_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	GLOBAL.prev_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://scenes/settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
