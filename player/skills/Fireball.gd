
extends "res://BaseSkill.gd"

func _cast():
	var i = skill_instance.instance()
	i.init(self.get_owner())
	i.show()

	get_tree().root.add_child(i)