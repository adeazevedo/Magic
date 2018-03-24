
extends Node
enum POP_TYPE {
	SMALL_DAMAGE, NORMAL_DAMAGE, HEAL
}

var factory = {
	SMALL_DAMAGE : preload("res://gui/SmallPopDamage.tscn"),
	NORMAL_DAMAGE : preload("res://gui/NormalPopDamage.tscn"),
	HEAL: preload("res://gui/PopHeal.tscn"),
}

func create (type):
	return factory[type].instance()