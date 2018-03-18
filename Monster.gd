
extends KinematicBody2D

export(String) var monster_name = "Shadow"
export(float) var max_health = 100
export(bool) var impulse_disable = false setget set_impulse_disable
export(bool) var invulnarable = false setget set_damage_disable

var health = 100
var speed = 100


func _physics_process (delta):
	var dir = Vector2()

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


### Impulse Methods
func set_impulse_disable (b):
	if has_node("Impulsable"):
		impulse_disable = b
		$Impulsable.disabled = b

func apply_impulse (direction, force):
	if has_node("Impulsable"):
		$Impulsable.apply_impulse(direction, force)
