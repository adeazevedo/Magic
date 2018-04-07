
extends "res://player/states/PlayerState.gd"

onready var Controller = get_node('../../KeyboardController')
onready var Anim = get_node('../../Anim')


func _on_enter ():

	Anim.play("idle")


func _on_process (params = {}):

	player.direction = Controller.get_direction_vector()


func _on_exit ():
	pass


func transition_conditions():

	change_state_condition( player.direction != Vector2(), "walk" )
	change_state_condition( Controller.attack_key.just_pressed, "attack" )
	change_state_condition( Controller.skill1_key.just_pressed, "cast", {"skill" : "Fireball"} )
	change_state_condition( Controller.skill2_key.just_pressed, "cast", {"skill" : "Fire Dash"} )
