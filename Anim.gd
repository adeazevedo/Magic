
extends AnimationPlayer

var current_anim = ""

func play_walk (dir):
	current_anim = "idle" if dir == Vector2() else "walk_right"

	if current_anim != self.current_animation:
		play(current_anim)