
extends AnimationPlayer

var current_anim = ""


func choose_animation (dir):

	current_anim = "idle"

	if dir != Vector2():
		current_anim = "walk"

	if current_anim != self.current_animation:
		play(current_anim)