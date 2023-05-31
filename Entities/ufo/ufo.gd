extends Area2D

class_name Ufo

@export var speed = 200
var move_direction = 1
var is_alive = true

var shot_scene = preload("res://Entities/InvaderShot/invader_shot.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_alive: return
	position.x += speed * move_direction * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_spawn_timer_timeout():
	if !is_alive: return
	var shot = shot_scene.instantiate()
	shot.global_position = $Marker2D.global_position
	shot.set_color(Color(0.67, 0.2, 0.2, 1))
	get_tree().root.add_child(shot)
	$ShootAudio.play()


func _on_area_entered(area):
	if !is_alive: return
	if area is Laser:
		is_alive = false
		$DeadAudio.play()
		$Sprite2D.texture = preload("res://Assets/Ufo/Ufo-explosion.png")
		await get_tree().create_timer(0.5).timeout
		queue_free()
