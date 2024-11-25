extends Control

func _draw():
	var rect = Rect2(20, 20, 300, 200)  # Posición y tamaño del rectángulo
	var corner_radius = 30  # Tamaño de las esquinas redondeadas
	var fill_color = Color(1, 0.5, 0)  # Color de relleno
	var border_color = Color(0, 0, 0)  # Color del borde
	var border_width = 4  # Grosor del borde
