
extends Node2D

signal mana_changed(value)
signal health_changed(value)

enum Magic { FIRE, WATER, ELETRIC, PHYSICAL }

# Mana and health regen per second
export(int) var mana_regen = 33.0
export(int) var health_regen = 2.0

var max_health = 200.0
var health = 100.0
var max_mana = 100.0
var mana = 0.0
var speed = Vector2(120, 100)

var element_mult = {
	FIRE: 1,
	WATER: 1,
	ELETRIC: 1,
	PHYSICAL: 1
}
var equipment_power = 1

var direction = Vector2()


func _physics_process(delta):
	direction = Vector2()
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if Input.is_action_pressed("skill1"):
		$MagicBook.cast_fireball()

	elif Input.is_action_pressed("skill2"):
		$MagicBook.cast_firedash()

	elif Input.is_action_pressed("skill3"):
		$MagicBook.cast_fire_punch()

	if direction.x != 0:
		$Sprite.flip_h = (direction.x <= -1)

	$Anim.play_walk(direction)

	move_and_collide(direction * speed * delta)

	health_tick()
	mana_tick()


func health_tick():
	var old_health = health
	health = clamp(health + tick(health_regen), 0, max_health)

	if old_health != health:
		emit_signal("health_changed", health)

func mana_tick ():
	var old_mana = mana
	mana = clamp(mana + tick(mana_regen), 0, max_mana)

	if old_mana != mana:
		emit_signal("mana_changed", mana)

func tick(regen):
	return regen * get_physics_process_delta_time()

func my_magic_dmg(mana_spent, element):
	return calc_magic_damage(mana_spent, element, equipment_power)

func calc_magic_damage (mana_spent, element, equip_power):
	return pow(mana_spent, equip_power) * get_element_mult(element)

func get_mana():
	return mana

func get_equipment_power():
	return equipment_power

func get_element_mult (element):
	return element_mult[element]

func get_health():
	return health

func get_face():
	return -1 if $Sprite.flip_h == true else 1