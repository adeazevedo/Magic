
extends "res://BaseSkill.gd"


func _cast():

	var i = skill_instance.instance()
	i.init(caster)
	i.show()

	get_node("/root/Game/YSort").add_child(i)