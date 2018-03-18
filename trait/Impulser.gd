
extends Node

export(bool) var disabled = false
export(float) var force = 150.0

func impulse (obj, direction, f = force):
	if disabled: return

	if obj.has_method("apply_impulse"):
		obj.apply_impulse(direction, f)
