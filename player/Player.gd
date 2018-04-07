
extends KinematicBody2D

enum Magic { FIRE, WATER, ELETRIC, PHYSICAL }

# Mana and health regen per second
export(int) var mana_regen = 33.0
export(int) var health_regen = 2.0

var max_health = 200.0
var health_regen_mod = 1
var health = 100.0 setget , get_health
var max_mana = 100.0
var mana_regen_mod = 1
var mana = 0.0 setget , get_mana
var speed = 100.0
var direction = Vector2()
var face_direction setget , get_face_direction

var element_mult = {
	FIRE: 1,
	WATER: 1,
	ELETRIC: 1,
	PHYSICAL: 1
}

var equipment_power = 1

onready var Anim = $Anim
onready var Controller = $KeyboardController
onready var _Sprite = $Sprite

signal mana_changed(value)
signal health_changed(value)

var current_state = "idle"
var state_params = {}

onready var state = {
	"idle" : $FSM/Idle,
	"walk" : $FSM/Walk,
	"attack" : $FSM/Attack,
	"cast" : $FSM/Cast,
}

func _physics_process (delta):

	state[current_state].execute(state_params)

	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	health_tick()
	mana_tick()


func health_tick ():

	var old_health = health
	health = clamp(health + tick(health_regen * health_regen_mod), 0, max_health)

	if old_health != health:
		emit_signal("health_changed", health)


func mana_tick ():

	var old_mana = mana
	mana = clamp(mana + tick(mana_regen * mana_regen_mod), 0, max_mana)

	if old_mana != mana:
		emit_signal("mana_changed", mana)


func tick (regen):

	return regen * get_physics_process_delta_time()


func my_magic_dmg (mana_spent, element):

	return calc_magic_damage(mana_spent, element, equipment_power)


func calc_magic_damage (mana_spent, element, equip_power):

	return pow(mana_spent, equip_power) * get_element_mult(element)


func get_mana ():

	return mana


func get_health ():

	return health


func get_equipment_power ():

	return equipment_power


func get_element_mult (element):

	return element_mult[element]


func get_face_direction ():

	return Vector2(_Sprite.scale.x, 0)


func active_global_cooldown():

	if !is_global_cooldown_activated():
		$GlobalCooldown.start()


func is_global_cooldown_activated():

	return !$GlobalCooldown.is_stopped()


func get_skill (skill):

	return $SkillList.get_skill(skill)


func cast_skill (skill_name):

	var skill = get_skill(skill_name)

	if skill == null: return

	if !is_global_cooldown_activated():
		print("%s casted" % skill_name)
		skill.cast()
		active_global_cooldown()


func disable_movement (b = true):

	Controller.disable_movement(b)
