
extends KinematicBody2D

export(String) var monster_name = "Shadow"
export(float) var max_health = 100
export(bool) var impulse_disabled = false setget set_impulse_disable

var health = 100 setget set_health

var direction = Vector2()
var face_direction = Vector2() setget , get_face_direction

signal damage_received (damage)
signal impulsed (direction, force)
signal die


func apply_dmg (obj):

	$Damageable.apply_dmg(obj)
	$Impulsable.apply_impulse(obj.impulse_direction, obj.impulse_force)


func die ():

	print("%s died" % monster_name)

	emit_signal("die")


func set_health (hp):

	print("%s took %d damage" % [monster_name, (health - hp)])

	health = hp
	health = clamp(health, 0, max_health)

	if health <= 0:
		die()


func set_impulse_disable (b):

	if has_node("Impulsable"):

		impulse_disabled = b
		$Impulsable.disabled = b


func get_face_direction():

	return Vector2( int($Sprite.flip_h), 0 )
