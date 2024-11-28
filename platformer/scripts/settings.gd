extends Control
var game_settings = {}
var txt_route = "res://settings.txt"
func _ready() -> void:
	load_settings()

	
func _on_confirm_pressed() -> void:
	game_settings = {"username":$VBoxContainer/LineEdit.text.strip_edges(),"fullscreen":$VBoxContainer/Fullscreen_checkbox.button_pressed,"volume":$VBoxContainer/volume_slider.value,"difficulty":$VBoxContainer/TabBar.get_tab_title($VBoxContainer/TabBar.get_current_tab())}
	GLOBAL.username = game_settings["username"]
	GLOBAL.lives = {"Easy":3,"Medium":2,"Hard":1,}.get(game_settings["difficulty"],3)
	GLOBAL.difficulty = {"Easy": 1, "Medium": 2, "Hard": 3}.get(game_settings["difficulty"], 1)

	if game_settings["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	var volume = int(game_settings["volume"]) - 25
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),volume)

	save_settings()
	get_tree().change_scene_to_file(GLOBAL.prev_scene)


func _on_cancel_pressed() -> void:
	get_tree().change_scene_to_file(GLOBAL.prev_scene)


func save_settings() -> void:
	var file = FileAccess.open(txt_route, FileAccess.WRITE)
	if file:
		file.store_line("fullscreen="+str(game_settings["fullscreen"]))
		file.store_line("volume=" +str(game_settings["volume"]))
		file.store_line("difficulty="+game_settings["difficulty"])
		file.close()
		print("Configuraciones guardadas en", txt_route)
	else:
		print("No se pudo abrir el archivo para escritura")


func load_settings():
	if FileAccess.file_exists(txt_route):
		var settings = {}
		var file = FileAccess.open(txt_route, FileAccess.READ)
		if file:
			while not file.eof_reached():
				var line = file.get_line()
				var parts = line.split("=")
				if parts.size() == 2:
					var key = parts[0]
					var value = parts[1]
					if key == "fullscreen":
						settings["fullscreen"]=value
					if key == "volume":
						settings["volume"]=value
					if key == "difficulty":
						settings["difficulty"]=value
			file.close()
			game_settings = settings

			print(settings)
			if settings.has("fullscreen"):
				print(settings["fullscreen"])
				if settings["fullscreen"]:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
					$VBoxContainer/Fullscreen_checkbox.button_pressed=true
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
					$VBoxContainer/Fullscreen_checkbox.button_pressed=false

				if settings.has("volume"):
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), int(settings["volume"]) - 25)

				if settings.has("difficulty"):
					for i in range($VBoxContainer/TabBar.get_tab_count()):
						if $VBoxContainer/TabBar.get_tab_title(i) == settings["difficulty"]:
							$VBoxContainer/TabBar.set_current_tab(i)
							break
		else:
			print("El archivo no existe:", txt_route)
			return
