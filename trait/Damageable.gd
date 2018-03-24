
extends Node

export(bool) var disabled = false

onready var body = get_parent()


func apply_dmg (obj):

	if disabled: return
	if body.health <= 0: return
	if obj.damage <= 0: return

	body.health -= obj.damage
	body.emit_signal("damage_received", obj.damage)

	var pop_dmg
	match obj.distance_modifier < 0.75:
		true:  pop_dmg = PopFactory.create(PopFactory.SMALL_DAMAGE)
		false: pop_dmg = PopFactory.create(PopFactory.NORMAL_DAMAGE)

	pop_dmg.arc_direction = "Right" if obj.impulse_direction.x == 1 else "Left"
	pop_dmg.arc_width = 10
	pop_dmg.init(obj, $Head.position)
	add_child(pop_dmg)

