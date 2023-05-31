extends Node

func _ready():
	$UI.set_lifes($LifeManager.lifes)

func _on_life_manager_life_lost(lifes_left):
	if lifes_left == 0:
		stop_game()
		$Player.queue_free()
		$UI.on_game_over()
	else:
		$Player.reset()
	$UI.set_lifes(lifes_left)

func _on_game_over_area_area_entered(area):
	stop_game()
	$UI.on_game_over()

func _on_invader_spawners_all_invaders_destroyed():
	stop_game()
	$UI.on_win()

func _on_points_counter_on_points_increased(points):
	$UI.set_points(points)

func stop_game():
	if $Player:
		$Player.stop()
	$InvaderSpawners._on_player_dead()
	$UfoSpawner._on_player_dead()
