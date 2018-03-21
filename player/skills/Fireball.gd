
extends Node
onready var fireball_instance = preload("res://player/skills/FireballInstance.tscn")

export(String) var skill_name = "Fireball"
export(float) var disabled = false
export(float) var mana_cost = 100
export(float) var cooldown = 1 setget set_cooldown

onready var my_player = get_parent().get_player()

func cast():
	#Create instance
	#cast
	#spent mana
	#start cooldown
	if !is_in_cooldown():
		var instance = create_instance()
		get_tree().root.add_child(instance)
		spent_mana()

		$CooldownTimer.start()


func spent_mana():
	my_player.mana = 0


func create_instance():
	var instance = fireball_instance.instance()
	instance.init(my_player)
	instance.show()

	return instance


### Cooldown methods
func set_cooldown (time):
	if has_node("CooldownTimer"):
		cooldown = time
		$CooldownTimer.wait_time = cooldown

func is_in_cooldown():
	return !$CooldownTimer.is_stopped()