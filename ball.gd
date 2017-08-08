extends Node2D

export var color = Color(1, 1, 1)

const INITIAL_SPEED = 80

var direction = Vector2(1, 0)
var speed = INITIAL_SPEED
var acceleration = 1.1
var court_size
var pos

func _ready():
	court_size = get_viewport_rect().size
	set_process(true)

func _process(delta):
	pos = get_pos() + direction * speed * delta
	try_collide_wall(delta)
	try_collide_paddles()
	try_goal()
	set_pos(pos)

func _draw():
	draw_circle(Vector2(0, 0), 5, color)
	
# flip when touching roof or floor
func try_collide_wall(delta):
	if (pos.y < 5 and direction.y < 0) or (pos.y > court_size.height - 5 and direction.y > 0):
		direction.y = -direction.y
	
# flip, change direction, and increase speed when touching paddles
func try_collide_paddles():
	try_collide_paddle("../left/paddle", -1)
	try_collide_paddle("../right/paddle", 1)

func try_collide_paddle(name, I):
	var paddle_rect = Rect2(get_node(name).get_pos(), Vector2(10, 60))
	var ball_rect = Rect2(pos - Vector2(5, 5), Vector2(10, 10))
	if paddle_rect.intersects(ball_rect) and direction.x * I > 0:
		direction.x = -direction.x
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
		speed *= acceleration

# reset after a goal
func try_goal():
	if pos.x < 60 or pos.x > court_size.width - 60:
		pos = court_size * 0.5
		speed = INITIAL_SPEED
		# winner serves
		direction = Vector2(-sign(direction.x), 0)
