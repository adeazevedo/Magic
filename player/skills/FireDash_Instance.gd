
extends Node2D

export(float) var max_time = .4

var caster
var casted = false
var time = 0
var speed = 150.0
var direction = Vector2()
var initial_pos = Vector2()


func init (c):

	caster = c
	casted = true

	direction = caster.face_direction
	direction = direction.normalized()

	initial_pos = caster.global_position


func _physics_process (delta):

	if !casted: return

	caster.disable_movement()
	caster.direction = Vector2()
	var collision = caster.move_and_collide(direction * speed * delta / max_time)
	if collision:
		apply_impulse_to_collider(collision)
		stop_dash()

	var fire_patch = process_new_fire_patch()
	if fire_patch:
		add_child(fire_patch)

	time += delta / max_time

	if time >= 1:
		stop_dash()


func stop_dash ():

	casted = false
	time = 0
	caster.disable_movement(false)


var fire_count = 0.0
var space_between = 14
func process_new_fire_patch ():

	var progress = fire_count * space_between / speed

	if time >= progress:

		fire_count += 1
		var pos = caster.get_node("Foot").position + initial_pos + (direction * speed * progress)
		var fire_patch = create_firepatch(pos)

		return fire_patch


func create_firepatch (pos):

	var fire_patch = $FirePatch.duplicate(DUPLICATE_USE_INSTANCING | DUPLICATE_SCRIPTS)
	fire_patch.global_position = pos
	fire_patch.show()

	return fire_patch


func apply_impulse_to_collider (collision):

	var collider = collision.collider
	$Damager.impulse_direction = (collider.position - caster.position).normalized()
	collider.apply_dmg($Damager)
