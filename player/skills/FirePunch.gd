
extends Node2D

var my_owner
var initial_position
var element
var element_mult
var mana_spent

func init (caster):
	my_owner = caster

	initial_position = caster.global_position
	element = caster.FIRE
	element_mult = caster.get_element_mult(element)
	mana_spent = caster.mana

	var face = 1
	if caster.get_node("Sprite").flip_h == true:
		face = -1

	scale.x = face

	$Anim.play("charge")



func _physics_process(delta):
	position = my_owner.global_position