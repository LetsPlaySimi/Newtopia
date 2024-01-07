extends Node2D

var SceneZomb = load("res://Scene/Zombie.tscn")

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(get_child_count() == 1):
		var player = get_node("/root/Game/Player")
		if(position.distance_to(player.global_position) < 110):
			spawn(4)

func spawn(amount):
	for i in range(amount): 
		var inst = SceneZomb.instantiate()
		inst.position = position#  + Vector2(-20,0) #+ Vector2(randf_range(-1,1),randf_range(-1,1))
		self.add_child(inst)
	print(self.get_children())
