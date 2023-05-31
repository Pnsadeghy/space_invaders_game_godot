extends Node2D

@export var ufo_scene: PackedScene

var sceen_width

func _ready():
	sceen_width = get_viewport_rect().size.x / 2

func _on_spawn_timer_timeout():
	var ufo = ufo_scene.instantiate()
	if randf() > 0.5:
		ufo.move_direction = -1
	ufo.position.y = position.y
	ufo.position.x = sceen_width * -ufo.move_direction
	get_tree().root.add_child(ufo)

func _on_player_dead():
	$SpawnTimer.stop()
