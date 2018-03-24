
extends Node

export(bool) var disabled = false
export(float) var damage = 0.0
export(int, "Fire", "Water", "Electric", "Physical") var element = 0
export(float) var impulse_force = 0.0
export(Vector2) var impulse_direction = Vector2()
var distance_modifier = 1