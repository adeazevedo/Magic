
extends Node2D
var Ease = preload("res://Easing.gd").new() # to contour singleton scripts not loading in tool mode

export(float) var max_time = .7
export(float) var arc_height = 35
export(float) var arc_width = 0
export(String, "Right", "Left") var arc_direction = "Right" setget set_arc_direction

var initial_pos = Vector2()
var _arc_direction_mod = 1
var time = 0
var text = null setget set_text, get_text


func _ready():

	if Engine.editor_hint:
		Engine.target_fps = 25


# move in upwards arc
func _physics_process (delta):

	position.x = initial_pos.x + _arc_direction_mod * lerp(0, arc_width, time)
	position.y = initial_pos.y - lerp(0, arc_height, Ease.inverse_parabola(time * 0.75))

	if $Label.theme != null:
		var base_alpha = $Label.theme.get_color("font_color", "Label").a
		modulate.a = lerp(base_alpha, 0, Ease.smooth_start_N(time, 5))
	else:
		modulate.a = lerp(1, 0, Ease.smooth_start_N(time, 5))

	time += delta / max_time

	if time >= 1:
		if !Engine.editor_hint:
			hide()
			queue_free()

	if Engine.editor_hint:
		if time >= 2:
			time = 0


func init (obj, pos = Vector2(), dir = "Right"):

	set_text(str(floor(obj.damage)))

	arc_direction = dir
	initial_pos = pos
	show()


func set_arc_direction (dir):

	arc_direction = dir
	if dir == "Right":
		_arc_direction_mod = 1

	elif dir == "Left":
		_arc_direction_mod = -1


func set_text (t):

	if typeof(t) == TYPE_STRING:
		text = t
		$Label.text = text


func get_text ():
	pass