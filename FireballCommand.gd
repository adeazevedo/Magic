
extends Node

var FireballPreload = preload("res://Fireball.tscn")

export(float) var cooldown = 1
export(float) var mana_cost = 100

var cooldown_count = 0
var casted = false

var my_player

func _physics_process(delta):
	if casted:
		cooldown_count += delta

		if cooldown_count > cooldown:
			casted = false
			cooldown_count = 0

func cast():
	if !casted:
		var fireball = create_instance()
		get_parent().add_child(fireball)
		spent_mana()

		casted = true


func spent_mana():
	my_player.mana = 0


func create_instance():
	my_player = get_parent().get_parent()
	var fireball = FireballPreload.instance()
	fireball.init(my_player)
	fireball.show()

	return fireball