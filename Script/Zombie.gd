extends CharacterBody2D
class_name Zombie

@onready var NodeSprite := $Sprite2D
@onready var NodeSprite2 := $Sprite2D2
@onready var NodeAnim := $AnimationPlayer
@onready var NodeAnim2 := $AnimationPlayer2
@onready var NodeArea2D := $Area2D


var spd := 30.0
var flip_clock = 0.0
var has_flipped = false
var damageCooldown = 0
var health = 3

func _physics_process(delta):
	Overlap()
	if(damageCooldown > 0):
		damageCooldown -= delta
	if(damageCooldown == 0):
		NodeSprite2.hide()
	if(damageCooldown < 0):
		damageCooldown = 0
	flip_clock += delta
	var player = get_node("/root/Game/Player")
	if(global_position.distance_to(player.global_position) < 110):
		TryLoop("Run")
		TryLoop2("Run")
		get_child(0).look_at(player.global_position)
		
		velocity = get_child(0).global_transform.x*spd
	
		if(cos(deg_to_rad(get_child(0).rotation_degrees)) < 0.0):
			NodeSprite.flip_h = true
			NodeSprite2.flip_h = true
		else:
			NodeSprite.flip_h = false
			NodeSprite2.flip_h = false
	
		#if(((int(get_child(0).rotation_degrees) % 360) >= 90) && ((int(get_child(0).rotation_degrees) % 360) <= 280) || ((int(get_child(0).rotation_degrees) % -360) >= -90) && ((int(get_child(0).rotation_degrees) % -360) <= -280)):
		#	NodeSprite.flip_h = true
		#	NodeSprite2.flip_h = true
		#else:
		#	NodeSprite.flip_h = false
		#	NodeSprite2.flip_h = false
	
		move_and_slide()
		
		
		
	else:
		TryLoop("Idle")
		TryLoop2("Idle")
	

func flip():
	if flip_clock < 0.1: return
	NodeSprite.flip_v = !NodeSprite.flip_v
	flip_clock = 0.0
	
func Overlap():
	var hit = false
	
	for o in NodeArea2D.get_overlapping_areas():
		var par = o.get_parent()
		print ("Overlapping: ", par.name)
		
		if par is Arrow:
			#ar above = position.y - 1 < par.position.y
			par.queue_free()
			#if onFloor or (vel.y < 0.0 and !above):
			if(damageCooldown == 0):
				damageCooldown = 0.25
				health -= 1
				NodeSprite2.show()
				if(health == 0):
					get_node("/root/Game").SetXP(get_node("/root/Game").GetXP() + 1)
					queue_free()
			#else:
			#	hit = true
			#	
			#	par.queue_free()
			#	NodeScene.Explode(par.position)
			#	NodeScene.check = true
			#	print("Goober destroyed")
	return hit

func TryLoop(arg : String):
	if arg == NodeAnim.current_animation:
		return false
	else:
		NodeAnim.play(arg)
		return true

func TryLoop2(arg : String):
	if arg == NodeAnim2.current_animation:
		return false
	else:
		NodeAnim2.play(arg)
		return true	
