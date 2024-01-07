extends CharacterBody2D

@onready var NodeScene = global.Game
@onready var NodeSprite := $Sprite2D
@onready var NodeSprite2 := $Sprite2D2
@onready var NodeArea2D := $Area2D
@onready var NodeAudio := $Audio
@onready var NodeAnim := $AnimationPlayer
@onready var NodeAnim2 := $AnimationPlayer2
@onready var NodeTileMap = get_node("/root/Game/TileMap")
 
var BulletScene = load("res://Scene/Arrow.tscn")
var canShoot = true
var vel := Vector2.ZERO
var spd := 60.0
var termVel := 400.0
var health = 3
var damageCooldown = 0
var btnx = 0
var btny = 0
var shootCooldown = 0
var timeHeld = 0


var onFloor := false
var jump := false

func _ready():
	pass
	#get_node("/root/Game").GetXP()
	#get_node("/root/Game").SetXP(33)
	#get_node("/root/Game").GetXP()

func _physics_process(delta):
	#if(btnx != 0): get_node("/root/Game/HUD/Hotbar_items/TextureRect").texture = load("res://Image/item_bow.png")
	if(shootCooldown>0):shootCooldown-=1
	if(global.level != 0):
		# horizontal input
		btnx = int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A))
		# vertical input
		btny = int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	
	if(btny != 0 && btnx != 0):
		spd = 50
	else:
		spd = 60
		
	vel.x = btnx * spd
	vel.y = btny * spd


	
	# apply movementNodeSprite2.hide()
	velocity = vel
	move_and_slide()
	# check for Goobers
	Overlap()
	var hit = Overlap()
	if !hit:
		if velocity.y == 0:
			vel.y = 0
		# check for floor 0.1 pixel down		onFloor = test_move(transform, Vector2(0, 0.1))
	
	# sprite flip
	if btnx != 0:
		NodeSprite.flip_h = btnx < 0
		NodeSprite2.flip_h = btnx < 0
	
	# animation
	if btnx == 0 && btny == 0:
		TryLoop("Idle")
		TryLoop2("Idle_2")
	else:
		TryLoop("Run")
		TryLoop2("Run_2")
		
	if(damageCooldown > 0):
		damageCooldown -= delta
		if(damageCooldown <= 0.8):
			NodeSprite2.hide()
		if(damageCooldown < 0):
			damageCooldown = 0
			
	if(canShoot && shootCooldown == 0 && global.level != 0):
		if(Input.is_mouse_button_pressed(2)):
			get_node("/root/Game/Player/Bow Bar").show()
			if(timeHeld < 3):
				timeHeld += 0.1
				get_node("/root/Game/Player/Bow Bar").value += timeHeld
				print(timeHeld)
				
		elif(timeHeld>=0.1):
			get_node("/root/Game/Player/Bow Bar").value = 0
			get_node("/root/Game/Player/Bow Bar").hide()
			shootCooldown = 20
			var b = BulletScene.instantiate()
			b.global_position = global_position
			b.speed = ((timeHeld/2)+1.5)
			get_node("/root/Game").add_child(b)
			timeHeld = 0
		else:
			get_node("/root/Game/Player/Bow Bar").value = 0
			get_node("/root/Game/Player/Bow Bar").hide()
			
		if(Input.is_mouse_button_pressed(1)):
			if(get_tile(get_node("/root/Game").to_local(get_global_mouse_position())) == 0):
				set_tile(get_node("/root/Game").to_local(get_global_mouse_position()),3)
	
	
func set_tile(input_pos,tile_id):
	var pos = NodeTileMap.local_to_map(input_pos)
	NodeTileMap.set_cell(0, pos, tile_id, Vector2(0,0))

func get_tile(input_pos):
	var pos = NodeTileMap.local_to_map(input_pos)
	return(NodeTileMap.get_cell_source_id(0,pos)) 

func DamageEfect():
	NodeScene.Explode(position)

func Overlap():
	var hit = false
	
	for o in NodeArea2D.get_overlapping_areas():
		var par = o.get_parent()
		#print ("Overlapping: ", par.name)
		
		if par is Zombie:
			#ar above = position.y - 1 < par.position.y
			
			#if onFloor or (vel.y < 0.0 and !above):
			if(damageCooldown == 0):
				damageCooldown = 1
				health -= 1
				NodeSprite2.show()
				if(health == 2):
					get_node("/root/Game/HUD/Hearts/Heart3").hide()
					
				if(health == 1):
					get_node("/root/Game/HUD/Hearts/Heart2").hide()
					
				if(health == 0):
					get_node("/root/Game/HUD/Hearts/Heart").hide()
					var game = get_node("/root/Game")
					game.Lose()
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
