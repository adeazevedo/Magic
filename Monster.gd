
extends "res://BaseMonster.gd"

var speed = 100


func _physics_process (delta):

	direction = Vector2()

	if direction.x != 0:
		$Sprite.flip_h = (direction.x <= -1)

	#$Anim.play_walk(dir)
	position += direction * speed * delta