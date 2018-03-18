
extends Node

###
# Scene with this trait are game objects that accepts impulse force through a Pusher object.
# Good to represent knockbacks from attacks
###

export(bool) var disabled = false setget set_disable
export(float) var max_impulse_time = 1

onready var body = get_parent()
onready var friction_func = funcref(Easing, "smooth_end_4")

var impulse_force = 0
var max_impulse_force = 0
var impulse_direction = Vector2()
var time = 0

func _physics_process (delta):
	if floor(impulse_force) == 0:
		impulse_force = 0.0
		time = 0.0
		return

	#print("Direction: %s; Impulse: %s; Time: %s; Easing Func: %s" % [impulse_direction, impulse_force,	time, friction_func.call_func(time)])

	body.move_and_collide(impulse_direction * impulse_force * delta)

	impulse_force = max_impulse_force * (1 - friction_func.call_func(time))
	time += delta / max_impulse_time
	time = clamp(time, 0, 1)

	impulse_force = max(0, impulse_force)


func apply_impulse (direction, force):
	impulse_direction = direction
	max_impulse_force = force
	impulse_force = force


func set_disable (b):
	disabled = b
	set_physics_process(b)