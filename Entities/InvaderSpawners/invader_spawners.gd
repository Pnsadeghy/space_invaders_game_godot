extends Node2D

class_name invader_spawner

signal invader_destroyed(point: int)
signal all_invaders_destroyed

# spawner config
const ROWS = 5
const COLUMNS = 11
const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POSITION = -50
const INVADER_POSITION_X_INCREMENT = 10
const INVADER_POSITION_Y_INCREMENT = 20

var movement_direction = 1

var invader_scene = preload("res://Entities/Invader/invader.tscn")
var invader_shot_scene = preload("res://Entities/InvaderShot/invader_shot.tscn")

var invader_destoyed_count = 0
var invader_total_count = ROWS * COLUMNS

var is_active = true

func _ready():
	var invader_1_res = preload("res://Resources/invader_1.tres")
	var invader_2_res = preload("res://Resources/invader_2.tres")
	var invader_3_res = preload("res://Resources/invader_3.tres")
	
	var invader_config
	
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		if row == 1 || row == 2:
			invader_config = invader_2_res
		if row == 3 || row == 4:
			invader_config = invader_3_res
		
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		var start_x = (position.x - row_width) / 2
		for col in COLUMNS:
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x, y)
			
			spawn_invader(invader_config, spawn_position)
			
			
func spawn_invader(config, position: Vector2):
	if !is_active: return
	var invader = invader_scene.instantiate() as Invader
	invader.config = config
	invader.global_position = position
	invader.on_destroyed.connect(on_invader_destroyed)
	add_child(invader)

func _on_movement_timer_timeout():
	if !is_active: return
	position.x += INVADER_POSITION_X_INCREMENT * movement_direction


func _on_left_wall_area_entered(area):
	if !is_active: return
	if movement_direction == 1: return
	position.y += INVADER_POSITION_Y_INCREMENT
	movement_direction = 1


func _on_right_wall_area_entered(area):
	if !is_active: return
	if movement_direction == -1: return
	position.y += INVADER_POSITION_Y_INCREMENT
	movement_direction = -1

func _on_shot_timer_timeout():
	if !is_active: return
	var random_pos = get_children().filter(func (child): return child is Invader).pick_random().global_position
	var shot = invader_shot_scene.instantiate()
	shot.global_position = random_pos
	get_tree().root.add_child(shot)
	$ShootAudio.play()


func _on_player_dead():
	is_active = false
	$ShotTimer.stop()
	$MovementTimer.stop()

func on_invader_destroyed(point: int):
	$DeadAudio.play()
	invader_destoyed_count += 1
	invader_destroyed.emit(point)
	if invader_destoyed_count == invader_total_count:
		all_invaders_destroyed.emit()
