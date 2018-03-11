
extends Node2D

signal destroyed

var initial_position = Vector2()
var my_owner = null
var dash_length = 0
var dash_direction = Vector2()
var dash_time = 0.3
var element = 1
var element_mult = 1
var mana_spent = 0

var fire_particle_length = 15.0

func init (caster, direction, length, time):
	my_owner = caster
	dash_length = length
	dash_direction = direction
	dash_time = time

	initial_position = caster.global_position
	element = caster.FIRE
	element_mult = caster.get_element_mult(element)
	mana_spent = caster.mana

	set_physics_process(false)

	$Anim.play("cast")


var time = 0
var fire_counter = 0

func _physics_process (delta):
	var final_position = initial_position + (dash_direction.normalized() * dash_length)

	time += delta
	time = clamp(time, 0, dash_time)

	var x = time / dash_time
	var w = x * x * (3 - 2 * x)

	var pos = initial_position.linear_interpolate(final_position, w)
	my_owner.position = pos

	var amount_of_fire = dash_length / fire_particle_length
	if time/dash_time > fire_counter/amount_of_fire:
		fire_counter += 1
		var new_particle = create_fire_patch(pos)
		add_child(new_particle)



func create_fire_patch (pos):
	var particle_duplicate = $FirePatch.duplicate(DUPLICATE_USE_INSTANCING)
	particle_duplicate.global_position = pos
	particle_duplicate.show()

	return particle_duplicate


func cast_dash():
	set_physics_process(true)


func destroy():
	emit_signal("destroyed")
	queue_free()