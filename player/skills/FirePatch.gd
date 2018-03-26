
extends Area2D


func _ready():

	connect("body_entered", self, "hit")

	$Timer.connect("timeout", self, "destroy")
	$Timer.start()


func hit (obj):

	if obj.is_in_group("player"): return

	$Damager.impulse_direction = (obj.position - position).normalized()

	if obj.has_method("apply_dmg"):
		obj.apply_dmg($Damager)


func destroy ():
	queue_free()