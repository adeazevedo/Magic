
extends Node

export(bool) var disabled = false

onready var body = get_parent()


func apply_dmg (dmg):
	if disabled: return
	if body.health <= 0: return

	print("%s took %d damage" % [body.monster_name, dmg])
	body.health -= dmg
	body.health = clamp(body.health, 0, body.max_health)

	if body.health <= 0:
		body.die()

