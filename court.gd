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
		get_node("left/paddle").move_to(ev.pos.y, height)
		get_node("right/paddle").move_to(ev.pos.x, width, aspect)
