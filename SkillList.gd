
extends Node

var caster setget , get_caster


func get_caster():

	return get_parent()


func get_skill (skill_name):

	for skill in get_children():
		if skill.skill_name == skill_name:
			return skill

		return null


func cast_fireball():

	$Fireball.cast()


func cast_firedash():

	$FireDash.cast()


func cast_fire_punch():

	$FirePunch.cast()