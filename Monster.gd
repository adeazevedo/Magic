
extends "res://BaseMonster.gd"
var PopupDamage = preload("res://PopupDamage.tscn")

export(bool) var impulse_disable = false setget set_impulse_disable

var health = 100
var speed = 100

var dir = Vector2()

signal damage_received (damage)

func _physics_process (delta):
	dir = Vector2()

	if dir.x != 0:
		$Sprite.flip_h = true if dir.x <= -1 else false

	#$Anim.play_walk(dir)
	position += dir * speed * delta


func die():
	print("%s died" % monster_name)

### Damage Methods
func apply_dmg (obj):
	if has_node("Damageable"):
		$Damageable.apply_dmg(obj)

		var popup_dmg = PopupDamage.instance()
		popup_dmg.init(obj.damage, $HeadPosition.position)
		add_child(popup_dmg)

		#emit_signal("damage_received", damage)

	if has_node("Impulsable"):
		$Impulsable.apply_impulse(obj.impulse_direction, obj.impulse_force)


### Impulse Methods
func set_impulse_disable (b):
	if has_node("Impulsable"):
		impulse_disable = b
		$Impulsable.disabled = b
