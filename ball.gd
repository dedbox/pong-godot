extends Node2D

export var color = Color(1, 1, 1)

func _draw():
	draw_circle(Vector2(0, 0), 5, color)
