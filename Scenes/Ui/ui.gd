extends CanvasLayer

var life_texture = preload("res://Assets/Player/Player.png")
@onready var life_container = $HUD/Lifes

func set_points(points: int):
	%Points.text = "SCORE: " + str(points)
	
func on_win():
	# $DarkBackground.visible = true
	%Win.visible = true
	
func on_game_over():
	$DarkBackground.visible = true
	%GameOver.visible = true


func _on_reset_pressed():
	print("clicked")
	get_tree().reload_current_scene()
	
func set_lifes(lifes: int):
	for n in life_container.get_children():
		n.queue_free()
	for i in lifes:
		var life = TextureRect.new()
		life.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		life.texture = life_texture
		life.custom_minimum_size = Vector2(40, 25)
		life.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		life_container.add_child(life)
