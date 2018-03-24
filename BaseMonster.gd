
extends KinematicBody2D
var PopFactory = preload("res://gui/PopFactory.gd").new()

export(String) var monster_name = "Shadow"
export(float) var max_health = 100

var health = 100 setget set_health

export(bool) var impulse_disabled = false setget set_impulse_disable

signal damage_received (damage)
signal impulsed (direction, force)
signal die

func set_impulse_disable (b):
	if has_node("Impulsable"):
		impulse_disabled = b
		$Impulsable.disabled = b


### Damage Methods
func apply_dmg (obj):

	$Damageable.apply_dmg(obj)
	$Impulsable.apply_impulse(obj.impulse_direction, obj.impulse_force)


func set_health (hp):

	print("%s took %d damage" % [monster_name, (health - hp)])

	health = hp
	health = clamp(health, 0, max_health)

	if health <= 0:
		die()


func die ():

	print("%s died" % monster_name)
	emit_signal("die")