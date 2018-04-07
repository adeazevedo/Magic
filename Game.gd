
extends Node2D

onready var Player = $YSort/Player


func _ready():

	$GUI/Container/LifeBar.register_player(Player)
	$GUI/Container/ManaBar.register_player(Player)

	$GUI/Container/Skill1Rect.texture = Player.get_skill("Fireball").icon.texture