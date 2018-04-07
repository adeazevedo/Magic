
extends "res://player/states/PlayerState.gd"

onready var Controller = get_node('../../KeyboardController')
onready var Anim = get_node('../../Anim')

var time = 0

func _on_enter ():

	Anim.play("attack")
	time = 0


func _on_process (params = {}):

	time += get_physics_process_delta_time()


func _on_exit ():
	pass


func transition_conditions():

	change_state_condition( time >= 1, "idle" )
