tool
extends Node2D
var Ease = preload("res://Easing.gd").new() # to contour singleton scripts not loading in tool mode

export(Color) var _color = Color(1, 0.5, 0.5, 1)
export(float) var _max_time = .7
export(float) var _arc_height = 35
export(float) var _arc_width = 0
export(String, "Right", "Left") var _arc_direction = "Right" setget set_arc_direction

var initial_pos = Vector2()
var arc_direction = 1
var time = 0

func _ready():
	$Label.modulate = _color

# move in upwards arc
func _physics_process (delta):
	position.x = initial_pos.x + arc_direction * lerp(0, _arc_width, time)
	position.y = initial_pos.y - lerp(0, _arc_height, Ease.inverse_parabola(time * 0.75))

	modulate.a = lerp(1, 0, Ease.smooth_start_N(time, 5))

	time += delta / _max_time

	if time >= 1:
		if !Engine.editor_hint:
			hide()
			queue_free()

	if Engine.editor_hint:
		if time >= 2:
			time = 0


func init (dmg, pos, dir = "Right"):
	$Label.text = str( floor(dmg) )

	_arc_direction = dir
	initial_pos = pos
	show()


func set_arc_direction (dir):
	_arc_direction = dir
	if dir == "Right":
		arc_direction = 1

	elif dir == "Left":
		arc_direction = -1

