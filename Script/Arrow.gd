extends Node2D
class_name Arrow

var speed
var distanceTraveled = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	look_at(get_global_mouse_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var velocity = global_transform.x*speed
	distanceTraveled += 1
	if(distanceTraveled >= 100):
		queue_free()
	global_position = global_position + velocity
