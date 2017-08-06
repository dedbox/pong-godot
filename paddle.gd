extends Node2D

export var color = Color(1, 1, 1)

func _draw():
	var area = Rect2(0, 0, 10, 60)
	draw_rect(area, color)