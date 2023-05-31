extends Area2D

class_name Player

signal dead

@export var speed := 200

@onready var collision = $CollisionShape2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var direction = Vector2.ZERO
var screen_size
var bounding_x
var start_bound
var end_bound
var initial_pos

var is_alive = true

func _ready():
	# get half with of player
	bounding_x = collision.shape.get_rect().size.x * transform.get_scale().x
	
	var rect = get_viewport().get_visible_rect()
	var camera = get_viewport().get_camera_2d()
	var camera_pos = camera.position
	start_bound = (camera_pos.x - rect.size.x) / 2
	end_bound = (camera_pos.x + rect.size.x) / 2
	
	initial_pos = global_position
	

func _process(delta):
	if !is_alive: return
	
	var input = Input.get_axis("move_left", "move_right")
	
	if input > 0:
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
		
	var delta_movement = speed * delta * direction.x
	
	# check screen
	if position.x + delta_movement < start_bound + bounding_x:
		return
	if position.x + delta_movement > end_bound - bounding_x:
		return
	
	position.x += delta_movement


func _on_area_entered(area):
	if !is_alive: return
	if area is InvaderShot:
		$DeadAudio.play()
		is_alive = false
		animation.play("destroy")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "destroy":
		dead.emit()
		
func stop():
	is_alive = false
		
func reset():
	global_position = initial_pos
	animation.play("RESET")
	is_alive = true
