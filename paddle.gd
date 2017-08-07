extends Node2D

export var color = Color(1, 1, 1)

func _draw():
	var area = Rect2(0, 0, 10, 60)
	draw_rect(area, color)

func move_to(c, c_max, aspect=1):
	var pos = get_pos()
	var offset = max(0, 60 * min(c, c_max) / c_max)
	pos.y = min(max(c, 0), c_max) / aspect - offset
	set_pos(pos)
