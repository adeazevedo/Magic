
extends Node

onready var player = get_parent().get_parent()

var first_pass = true
var state_changed = false


func change_state_condition (condition, state, params = {}):

	if condition:
		player.current_state = state
		player.state_params = params

		state_changed = true


func execute (params = {}):

	if first_pass:
		_on_enter()
		first_pass = false

	_on_process(params)

	transition_conditions()

	if state_changed:
		_on_exit()

		# Resetting vars
		first_pass = true
		state_changed = false


func _on_enter(): pass
func _on_process(params = {}): pass
func _on_exit(): pass
func transition_conditions(): pass