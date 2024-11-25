extends Control
var settings = {}
func _ready() -> void:
	load_settings(GLOBAL.username)
	
func _on_confirm_pressed() -> void:
	settings = {"username":$VBoxContainer/LineEdit.text.strip_edges(),"fullscreen":$VBoxContainer/Fullscreen_checkbox.button_pressed,"volume":$VBoxContainer/volume_slider.value,"difficulty":$VBoxContainer/TabBar.get_tab_title($VBoxContainer/TabBar.get_current_tab())}
	GLOBAL.username = settings["username"]
	GLOBAL.lives = {"Easy":3,"Medium":2,"Hard":1,}.get(settings["difficulty"])
	if settings["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),settings["volume"]/100)
		
	
	


	get_tree().change_scene_to_file(GLOBAL.prev_scene)


func _on_cancel_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.prev_scene)


func save_data():
	pass
	
func load_settings(username: String):
	pass
	
