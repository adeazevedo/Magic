
extends Node
var PopFactory = preload("res://gui/PopFactory.gd").new()

export(bool) var disabled = false

onready var body = get_parent()


func apply_dmg (obj):

	if disabled: return
	if body.health <= 0: return
	if obj.damage <= 0: return

	body.health -= obj.damage
	body.emit_signal("damage_received", obj.damage)

	var pop_dmg = choose_popdmg(obj)
	body.add_child(pop_dmg)


func choose_popdmg (obj):

	var pop_type
	match obj.distance_modifier < 0.75:
		true:  pop_type = PopFactory.SMALL_DAMAGE
		false: pop_type = PopFactory.NORMAL_DAMAGE

	var pop = PopFactory.create(pop_type)
	pop.arc_direction = "Right" if obj.impulse_direction.x == 1 else "Left"
	pop.arc_width = 10
	pop.init(obj, body.get_node("Head").position)
	pop.show()

	return pop