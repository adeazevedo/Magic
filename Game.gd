
extends Node2D

onready var Player = $Player

func _ready():

	$GUI/Container/LifeBar.register_player(Player)
	$GUI/Container/ManaBar.register_player(Player)