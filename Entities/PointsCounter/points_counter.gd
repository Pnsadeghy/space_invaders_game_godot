extends Node

class_name PointCounter

signal on_points_increased(points: int)

var points = 0




func _on_invader_spawners_invader_destroyed(point):
	points += point
	on_points_increased.emit(points)
