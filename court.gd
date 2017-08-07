extends Node2D

export var courtColor = Color(0, 0, 0)
export var goalColor = Color(0.5, 0.5, 0.5)

const INITIAL_SPEED = 80

var size
var aspect
var direction = Vector2(1, 0)
var speed = INITIAL_SPEED
var acceleration = 1.1

func _ready():
	size = get_viewport_rect().size
	aspect = size.width / size.height
	set_process(true)
	set_process_input(true)

func _process(delta):
	var ball = get_node("ball")
	var pos = ball.get_pos()
	# flip when touching roof or floor
	pos += direction * speed * delta
	if (pos.y < 5 and direction.y < 0) or (pos.y > size.height - 5 and direction.y > 0):
		direction.y = -direction.y
	# flip, change direction, and increase speed when touching paddles
	var left_rect = Rect2(get_node("paddle/left").get_pos(), Vector2(10, 60))
	var right_rect = Rect2(get_node("paddle/right").get_pos(), Vector2(10, 60))
	var ball_rect = Rect2(pos - Vector2(5, 5), Vector2(10, 10))
	if (left_rect.intersects(ball_rect) and direction.x < 0) or (right_rect.intersects(ball_rect) and direction.x > 0):
		direction.x = -direction.x
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		speed *= acceleration
	# check game over
	if pos.x < 60 or pos.x > size.width - 60:
		pos = size * 0.5
		speed = INITIAL_SPEED
		direction = Vector2(-sign(direction.x), 0)
	ball.set_pos(pos)

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