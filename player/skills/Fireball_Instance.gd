
extends Node2D

signal destroyed

export(int, "Fire", "Water", "Electric", "Physical") var element = 0
export(float) var travel_speed = 400
export(float) var max_impulse_force = 200

var my_owner
var initial_pos = Vector2()
var direction = Vector2()
var angle
var mana_spent = 0
var element_multiplier = 1


func _ready():

	connect("body_entered", self, "hit")
	$VisibilityNotifier.connect("screen_exited", self, "destroy")


func _physics_process (delta):

	position.x += cos(angle) * travel_speed * delta
	position.y += sin(angle) * travel_speed * delta


func init (caster):

	my_owner = caster
	initial_pos = caster.global_position
	position = initial_pos
	mana_spent = caster.mana
	element_multiplier = my_owner.get_element_mult(element)

	direction = caster.face_direction
	direction = direction.normalized()

	angle = direction.angle()
	rotate(angle)

	reset_particles_settings()


func reset_particles_settings ():

	$Particles.process_material.linear_accel = 0
	$Particles.process_material.radial_accel = 0
	$Particles.process_material.emission_box_extents = Vector3(4, 4, 1)
	$Particles.process_material.trail_divisor = 1
	$Particles.process_material.gravity = Vector3(0, 0, 0)
	$Particles.preprocess = 0.8


# Destroy command is triggered by Anim node
func hit (obj):

	if obj.is_in_group("player"): return

	play_hit_anim()

	# Damage and impulse force varies as far the fireball travels
	var distance_from_initial_pos = floor(initial_pos.distance_to(global_position) / 75) + 1
	var force = max_impulse_force / distance_from_initial_pos * mana_spent / my_owner.max_mana

	$Damager.damage = calc_damage()
	$Damager.impulse_force = force
	$Damager.impulse_direction = direction
	$Damager.distance_modifier = 1 / distance_from_initial_pos

	if obj.has_method("apply_dmg"):
		obj.apply_dmg($Damager)


func play_hit_anim():

	travel_speed = 50
	$AnimPlayer.play("Hit")
	# Destroy command is triggered by Anim node


func calc_damage():

	var magic_dmg = my_owner.calc_magic_damage(mana_spent, element, my_owner.equipment_power)

	# a cada 75 pixels = 1 (uma) unidade de distancia. Usada para diminuir o dano conforme mais tempo viaja
	var distance_from_initial_pos = floor(initial_pos.distance_to(global_position) / 75) + 1
	return magic_dmg / pow(distance_from_initial_pos, 2)


func destroy():

	hide()
	reset_particles_settings()
	emit_signal("destroyed")
	queue_free()