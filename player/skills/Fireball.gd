
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
	$Cast.connect("body_entered", self, "hit")
	$Cast/VisibilityNotifier.connect("screen_exited", self, "destroy")

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
	$Anim.play("Cast")

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
	$Anim.play("Hit")
	# Destroy command is triggered by Anim node

func calc_damage():
	var power = my_owner.equipment_power
	var magic_dmg = my_owner.calc_magic_damage(mana_spent, element, power)

	# a cada 75 pixels = 1 (uma) unidade de distancia. Usada para diminuir o dano conforme mais tempo viaja
	var distance_from_initial_pos = floor(position.distance_to(initial_pos) / 75) + 1
	return magic_dmg / pow(distance_from_initial_pos, 2)


func destroy():
	emit_signal("destroyed")
	queue_free()