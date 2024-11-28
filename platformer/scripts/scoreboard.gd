extends Control
var scores = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	download_scores()
	$ColorRect2.size.x = $VBoxContainer.size.x + 90
	center_rect()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func download_scores():
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_server_has_responded)
	var headers = ["Content-Type: application/json", "Client-Secret: abc"] 
	http_request.request("http://127.0.0.1:8000/score", headers, HTTPClient.METHOD_GET)
	
func _on_server_has_responded(_result, _response_code, _headers, body):
	scores = JSON.parse_string(body.get_string_from_utf8())
	if scores != null:
		show_scores()
		
func show_scores():
	var font := FontFile.new()
	font = load("res://styles/NokiaCellphoneFC.ttf")

	for score in scores:
		var label = Label.new()
		label.add_theme_font_override("font",font)
		label.add_theme_color_override("font_color", Color(0, 0, 0))
		label.text = "Usuario: %s - Puntuación: %d" % [score["username"], score["score"]]
		$VBoxContainer.add_child(label)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
	
func center_rect() -> void:
	var viewport_size = get_viewport().get_visible_rect().size
	$ColorRect2.position = (viewport_size - $ColorRect2.size) / 2
