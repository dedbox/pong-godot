extends Node2D

export var courtColor = Color(0, 0, 0)
export var goalColor = Color(0.5, 0.5, 0.5)

var width
var height
var aspect

func _ready():
	var size = get_viewport_rect().size
	width = size.width
	height = size.height
	aspect = width / height
	set_process_input(true)

func _draw():
	draw_rect(Rect2(1, 1, width, height), courtColor)
	draw_rect(Rect2(0, 0, 60, height), goalColor)
	draw_rect(Rect2(width - 60, 0, width, height), goalColor)

func _input(ev):
	if ev.type == InputEvent.MOUSE_MOTION:
		move_left_paddle_to(ev.pos.y)
		move_right_paddle_to(ev.pos.x)

func move_left_paddle_to(y):
	var pad = get_node("left-paddle")
	var pos = pad.get_pos()
	var ofs = max(0, 60 * min(y, height) / height)
	pos.y = min(max(y, 0), height) - ofs
	pad.set_pos(pos)

func move_right_paddle_to(x):
	var pad = get_node("right-paddle")
	var pos = pad.get_pos()
	var ofs = max(0, 60 * min(x, width) / width)
	pos.y = min(max(x, 0), width) / aspect - ofs
	pad.set_pos(pos)