extends CanvasLayer

func _ready() -> void:
	$GameOver/Container/Buttons/Restart.disabled = false
	$GameOver.visible = false
func _process(_delta):
	$VBoxContainer/HBoxContainer2/coins.text = "X" + str(GLOBAL.coins + GLOBAL.total_coins)
	$VBoxContainer/HBoxContainer/lives.text = "X" + str(GLOBAL.lives)
	$VBoxContainer/HBoxContainer3/enemies.text = "X" + str(GLOBAL.enemies+ GLOBAL.total_enemies)


func game_over():
	
	$GameOver.visible = true
	GLOBAL.lives -=1
	get_tree().paused = true
	if not $GameOver/Container/Buttons/Restart.disabled:
		$GameOver/Container/Buttons/Restart.grab_focus()
	else:
		$GameOver/Container/Buttons/Quit.grab_focus()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($GameOver, "modulate", Color(1, 1, 1, 0.8), 1.0)
	
	$GameOver/Sound.play()
	
	if GLOBAL.lives == 0:
		get_tree().paused = false
		send_post_new_score()
		await get_tree().create_timer(1).timeout
		
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func send_post_new_score():
	if GLOBAL.username.is_empty():
		printerr("Will NOT send POST data with score due to invalid username")
		printerr("There might have been an error loading user_data file")
		return
	# Username OK. Let's send the request
	var http_request = HTTPRequest.new()
	add_child(http_request)
	var body = JSON.stringify({"username": GLOBAL.username, "score": (GLOBAL.coins*100 + GLOBAL.lives * 50  + GLOBAL.enemies *150)})
	var headers = ["Content-Type: application/json", "Client-Secret: abc"] 
	http_request.request("http://127.0.0.1:8000/score", headers, HTTPClient.METHOD_POST,body)
