
extends Node

export(bool) var disabled = false
export(float) var damage = 100.0

func apply_dmg (target, dmg = damage):
	if disabled: return

	if target.has_method("apply_dmg"):
		target.apply_dmg(dmg)