
extends Area2D

export(float) var expire_time = 3
var time = 0

func _physics_process (delta):
	if time >= expire_time:
		destroy()

	time += delta


func destroy():
	queue_free()