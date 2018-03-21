
extends Node2D

signal destroyed

export(float) var travel_speed = 400
export(float) var max_impulse_force = 200

var my_owner
var initial_pos = Vector2()
var direction = Vector2()
var angle
var mana_spent = 0
var fire_mult = 1
var element = 0


func _ready():
	connect("body_entered", self, "hit")
	$VisibilityNotifier.connect("screen_exited", self, "destroy")

func _physics_process (delta):
	global_position.x += cos(angle) * travel_speed * delta
	global_position.y += sin(angle) * travel_speed * delta

func init (player):
	my_owner = player
	initial_pos = player.global_position
	element = player.FIRE
	mana_spent = player.mana
	fire_mult = player.get_element_mult(element)

	direction.x = player.direction.x if player.direction != Vector2() else player.get_face()
	direction.y = player.direction.y

	angle = direction.angle()
	rotate(angle)

	global_position = player.global_position
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
	if obj == my_owner: return

	play_hit_anim()

	var dmg = calc_damage()
	$Damager.apply_dmg(obj, dmg)

	var distance_from_initial_pos = floor(position.distance_to(initial_pos) / 75) + 1
	var force = max_impulse_force / distance_from_initial_pos * mana_spent / my_owner.max_mana
	$Impulser.impulse(obj, direction, force)


func play_hit_anim():
	travel_speed = 50
	$AnimPlayer.play("Hit")
	# Destroy command is triggered by Anim node

func calc_damage():
	var power = my_owner.equipment_power
	var magic_dmg = my_owner.calc_magic_damage(mana_spent, element, power)

	# a cada 75 pixels = 1 (uma) unidade de distancia. Usada para diminuir o dano conforme mais tempo viaja
	var distance_from_initial_pos = floor(position.distance_to(initial_pos) / 75) + 1
	return magic_dmg / pow(distance_from_initial_pos, 2)


func destroy():
	hide()
	reset_particles_settings()
	emit_signal("destroyed")
	queue_free()