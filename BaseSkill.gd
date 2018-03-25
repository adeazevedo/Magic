
extends Node

export(String) var _skill_name = "Unknown Skill"
export(String, MULTILINE) var _description = "Skill without description"
export(float) var min_mana_cost = 100
export(float) var cooldown_time = 1 setget set_cooldown
export(PackedScene) var skill_instance

# Base Skill is counting that is child of SkillList Node
onready var caster = get_parent().get_caster()

signal casted

# _cast is where subclass will create the instance and put in world
func _cast():
	pass


func cast():

	if !cooldown_is_active():
		_cast()
		spent_mana()
		cooldown_start()

		emit_signal("casted")


func spent_mana():

	if caster.has_method("get_mana"):
		caster.mana -= min_mana_cost


### Cooldown methods
func set_cooldown (time):

	if has_node("Cooldown"):
		cooldown_time = time
		$Cooldown.wait_time = time


func cooldown_start ():

	$Cooldown.start()


func cooldown_is_active ():

	return !$Cooldown.is_stopped()


func private():

	print("Private variable")