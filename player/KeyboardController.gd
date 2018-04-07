
extends Node

var h_axis = 0 setget , get_h_axis
var v_axis = 0 setget , get_v_axis

var up_key = ActionKey.new(self, "ui_up")
var down_key = ActionKey.new(self, "ui_down")
var right_key = ActionKey.new(self, "ui_right")
var left_key = ActionKey.new(self, "ui_left")
var attack_key = ActionKey.new(self, "attack")
var skill1_key = ActionKey.new(self, "skill1")
var skill2_key = ActionKey.new(self, "skill2")
var skill3_key = ActionKey.new(self, "skill3")

signal action_just_pressed (action)
signal action_just_released (action)
signal action_pressed (action)


func _process (delta):

	up_key.update()
	down_key.update()
	right_key.update()
	left_key.update()
	attack_key.update()
	skill1_key.update()
	skill2_key.update()
	skill3_key.update()


func get_direction_vector():

	return Vector2(get_h_axis(), get_v_axis())


func get_h_axis ():

	return int( right_key.pressed ) - int( left_key.pressed )


func get_v_axis ():

	return int( down_key.pressed ) - int( up_key.pressed )


class ActionKey:

	var controller = null
	var action = ""

	var just_pressed = false
	var just_released = false
	var pressed = false

	func _init (node, action_string):

		controller = node
		action = action_string


	func update ():

		just_pressed = Input.is_action_just_pressed(action)
		just_released = Input.is_action_just_released(action)
		pressed = Input.is_action_pressed(action)

		if just_pressed: controller.emit_signal("action_just_pressed", action)
		if just_released: controller.emit_signal("action_just_released", action)
		if pressed: controller.emit_signal("action_pressed", action)
