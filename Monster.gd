
extends Node2D

var speed = Vector2(120, 100)

func _physics_process (delta):
	var dir = Vector2()
	dir.x = 0
	dir.y = 0

	if dir.x <= -1:
		$Sprite.flip_h = true
	elif dir.x >= 1:
		$Sprite.flip_h = false

	#$Anim.play_walk(dir)

	position += dir * speed * delta

