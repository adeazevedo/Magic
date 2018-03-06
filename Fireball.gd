
extends Node2D

signal destroyed

export(Vector2) var speed = Vector2(400, 0)

var initial_pos = Vector2()
var my_player = null
var face = 1
var mana_spent = 0
var fire_mult = 1
var element = 0

func _ready():
	$Cast.connect("body_entered", self, "hit")
	$Cast/VisibilityNotifier.connect("screen_exited", self, "destroy")


func _physics_process(delta):
	position += face * speed * delta


func init(player):
	my_player = player
	initial_pos = player.global_position
	element = player.FIRE
	mana_spent = player.mana
	fire_mult = player.get_element_mult(element)
	face = 1

	if player.get_node("Sprite").flip_h == true:
		face = -1

	position = player.global_position
	scale.x = face
	$Anim.play("Cast")


func hit (obj):
	if obj == my_player: return

	play_hit_anim()


func play_hit_anim():
	speed = Vector2(50, 0)
	$Anim.play("Hit")
	# Destroy command is triggered by Anim node

func calc_damage():
	var power = my_player.equipment_power
	var magic_dmg = my_player.calc_magic_damage(mana_spent, element, power)

	# a cada 75 pixels eu conto a distancia como 1 (uma) unidade
	var distance_from_initial_pos = floor(position.distance_to(initial_pos) / 75) + 1
	print("dist: ", distance_from_initial_pos)
	return magic_dmg / pow(distance_from_initial_pos, 2)


func destroy():
	emit_signal("destroyed")
	queue_free()