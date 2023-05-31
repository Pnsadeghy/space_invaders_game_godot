extends Node

class_name life_manager

signal life_lost(lifes_left: int)

@export var lifes = 3

func _on_player_dead():
	lifes -= 1
	life_lost.emit(lifes)
