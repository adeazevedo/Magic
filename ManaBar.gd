
extends ProgressBar

var player_ref = null

func register_player (p):
	if p == null: return

	self.player_ref = p


func _physics_process (delta):
	self.value = player_ref.get_mana()