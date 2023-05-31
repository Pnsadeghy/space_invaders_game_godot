extends Area2D

class_name Invader

signal on_destroyed(point: int)

var config: Resource

@onready var animation = $AnimationPlayer

var is_alive = true

func _ready():
	$Sprite2D.texture = config.sprite
	animation.play(config.animation_name)


func _on_area_entered(area):
	if !is_alive: return
	if area is Laser:
		is_alive = false
		animation.play("destroy")
		area.queue_free()
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()
		
func _exit_tree():
	on_destroyed.emit(config.points)
