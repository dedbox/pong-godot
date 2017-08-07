extends Node2D

export var courtColor = Color(0, 0, 0)
export var goalColor = Color(0.5, 0.5, 0.5)

var size
var aspect

func _ready():
	size = get_viewport_rect().size
	aspect = size.width / size.height
	set_process_input(true)

func _draw():
	var W = size.width - 1
	var H = size.height - 1
	draw_rect(Rect2(1, 1, size.width, size.height), courtColor)
	draw_rect(Rect2(0, 0, 60, size.height), goalColor)
	draw_rect(Rect2(size.width - 60, 0, size.width, size.height), goalColor)

func _input(ev):
	if ev.type == InputEvent.MOUSE_MOTION:
		move_left_paddle_to(ev.pos.y)
		move_right_paddle_to(ev.pos.x)

func move_left_paddle_to(y):
	var pad = get_node("paddle/left")
	var pos = pad.get_pos()
	var ofs = max(0, 60 * min(y, size.height) / size.height)
	pos.y = min(max(y, 0), size.height) - ofs
	pad.set_pos(pos)

func move_right_paddle_to(x):
	var pad = get_node("paddle/right")
	var pos = pad.get_pos()
	var ofs = max(0, 60 * min(x, size.width) / size.width)
	pos.y = min(max(x, 0), size.width) / aspect - ofs
	pad.set_pos(pos)