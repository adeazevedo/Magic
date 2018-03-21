
extends KinematicBody2D
var PopupDamage = preload("res://PopupDamage.tscn")

export(String) var monster_name = "Shadow"
export(float) var max_health = 100
export(bool) var impulse_disable = false setget set_impulse_disable
export(bool) var invulnarable = false setget set_damage_disable

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
func set_damage_disable (b):
	if has_node("Damageable"):
		invulnarable = b
		$Damageable.disabled = b

func apply_dmg (dmg):
	if has_node("Damageable"):
		$Damageable.apply_dmg(dmg)

		var popup_dmg = PopupDamage.instance()
		popup_dmg.init(dmg, $HeadPosition.position)
		add_child(popup_dmg)

		emit_signal("damage_received", dmg, dir)


### Impulse Methods
func set_impulse_disable (b):
	if has_node("Impulsable"):
		impulse_disable = b
		$Impulsable.disabled = b

func apply_impulse (direction, force):
	if has_node("Impulsable"):
		$Impulsable.apply_impulse(direction, force)
