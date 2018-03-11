
extends Node
var FireDash = preload("res://player/skills/FireDash.tscn")

export(float) var length_of_dash = 130
export(int) var mana_cost = 100
export(float) var cooldown = 1

var cooldown_count = 0

var casted = false

func cast():
	if casted: return

	var player = get_parent().get_parent()

	var direction = determinate_direction(player)
	var firedash = FireDash.instance()
	firedash.init(player, direction, length_of_dash, 0.3)
	firedash.show()

	add_child(firedash)
	casted = true


func _physics_process(delta):
	if !casted: return

	if cooldown_count >= cooldown:
		casted = false
		cooldown_count = 0

	cooldown_count += delta


func determinate_direction(player):
	if player.direction == Vector2(0, 0):
		return Vector2(player.get_face(), 0)

	return player.direction


