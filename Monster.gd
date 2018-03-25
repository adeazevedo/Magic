
extends "res://BaseMonster.gd"

var speed = 100
var dir = Vector2()


func _physics_process (delta):

	dir = Vector2()

	if dir.x != 0:
		$Sprite.flip_h = true if dir.x <= -1 else false

	#$Anim.play_walk(dir)
	position += dir * speed * delta