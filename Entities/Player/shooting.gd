extends Marker2D

@export var laser_scene: PackedScene
@onready var shoot_audio = $"../PlayerShoot"

var can_player_shoot = true

func _input(event):
	if can_player_shoot and event.is_action_pressed("shoot"):
		can_player_shoot = false
		var laser = laser_scene.instantiate() as Laser
		laser.global_position = global_position
		get_tree().root.get_node("main_game").add_child(laser)
		
		# when laser destroyed use can shoot again
		laser.tree_exited.connect(on_laser_destroyed)
		shoot_audio.play()

func on_laser_destroyed():
	can_player_shoot = true
