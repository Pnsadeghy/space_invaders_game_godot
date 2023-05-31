extends CanvasLayer

var enemy_list = []

func _ready():
	enemy_list.append_array([%InvaderContainer_1, %InvaderContainer_2, %InvaderContainer_3])
	
	for enemy in enemy_list:
		(enemy as Control).modulate = Color.TRANSPARENT

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainGame/main_game.tscn")


func _on_timer_timeout():
	var enemy = enemy_list.pop_front() as Control
	if enemy == null:
		$Timer.queue_free()
	else:
		enemy.modulate = Color.WHITE
