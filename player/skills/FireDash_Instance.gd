
extends Node2D

export(float) var max_time = .4

var caster
var casted = false
var time = 0
var speed = 150.0
var direction = Vector2()
var initial_pos = Vector2()
var final_pos = Vector2()


func init (c):

	caster = c
	casted = true

	direction.x = caster.direction.x if caster.direction != Vector2() else caster.get_face()
	direction.y = caster.direction.y
	direction = direction.normalized()

	initial_pos = caster.global_position
	final_pos = initial_pos + (direction * speed)


func _physics_process (delta):

	if !casted: return

	caster.position = process_dash_position(initial_pos, final_pos)

	var fire_patch = process_new_fire_patch()
	if fire_patch:
		add_child(fire_patch)

	time += delta / max_time

	if time >= 1:
		casted = false
		time = 0


var fire_count = 0.0
var space_between = 14
func process_new_fire_patch():

	var progress = fire_count * space_between / speed
	if time >= progress:
		fire_count += 1
		var pos = caster.get_node("Foot").position + initial_pos + (direction * speed * progress)
		var fire_patch = create_firepatch(pos)

		return fire_patch


func process_dash_position (initial_position, final_position):

	return Vector2(
		lerp(initial_position.x, final_position.x, time),
		lerp(initial_position.y, final_position.y, time)
	)


func create_firepatch (pos):

	var fire_patch = $FirePatch.duplicate(DUPLICATE_USE_INSTANCING)
	fire_patch.global_position = pos
	fire_patch.show()

	return fire_patch