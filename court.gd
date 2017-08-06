extends Node2D

func _draw():
	var W = get_viewport().get_rect().size.width - 1
	var H = get_viewport().get_rect().size.height - 1
	var C = Color(1.0, 1.0, 1.0)
	draw_line(Vector2(0, 1), Vector2(W, 1), C)
	draw_line(Vector2(0, H), Vector2(W, H), C)
	draw_line(Vector2(1, 0), Vector2(1, H), C)
	draw_line(Vector2(W, 0), Vector2(W, H), C)