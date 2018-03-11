
extends Node
var FirePunch = preload("res://player/skills/FirePunch.tscn")

export(int) var mana_cost = 100
export(float) var cooldown = 1

var cooldown_count = 0

var casted = false


func _physics_process (delta):
	if !casted: return

	if cooldown_count >= cooldown:
		casted = false
		cooldown_count = 0

	cooldown_count += delta


func cast():
	if casted: return

	var player = get_parent().get_parent()

	var firepunch = FirePunch.instance()
	firepunch.init(player)
	firepunch.show()

	add_child(firepunch)
	casted = true