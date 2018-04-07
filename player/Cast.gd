
extends "res://player/states/PlayerState.gd"

func _on_enter ():
	pass


func _on_process (params = {}):

	player.cast_skill(params.skill)



func _on_exit ():
	pass


func transition_conditions():

	change_state_condition( true, "idle" )