extends Timer

class_name SpawnTimer

@export var min_time = 5
@export var max_time = 10

func _ready():
	setup_timer()
	
func setup_timer():
	wait_time = randi_range(min_time, max_time)
	stop()
	start()



func _on_timeout():
	setup_timer()
