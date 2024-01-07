extends Node2D

var tmpath := "res://TileMap/"
enum {TILE_WALL = 0, TILE_PLAYER = 1, TILE_ZOMB = 2, TILE_SPAWN = 4, TILE_TREE = 5}
var NodeTileMap

var ScenePlayer = load("res://Scene/Player.tscn")
var SceneZomb = load("res://Scene/Zombie.tscn")
var SceneExplo = load("res://Scene/Explosion.tscn")
var SceneSpawn = load("res://Scene/Spawner.tscn")
var SceneTre = load("res://Scene/Tree.tscn")

@onready var NodeZombies := $Zombies
@onready var NodeAudioWin := $Audio/Win
@onready var NodeAudioLose := $Audio/Lose
@onready var NodeSprite := $Sprite2D

var clock := 0.0
var delay := 1.5
var check := false
var change := false
var xp = 0
var loopAmount = 0
var playedAnimation = false
var finisedSplashScreen = false

func _ready():
	global.update_items()
	global.Game = self
	
	if global.level == 0 or global.level == 21:
		NodeSprite.frame = 0 if global.level == 0 else 3
		NodeSprite.visible = true
		var p = ScenePlayer.instantiate()
		p.position = Vector2(72, 85)
		add_child(p)
	MapLoad()
	MapStart()
	get_node("/root/Game/HUD").hide()
	global.give("Bow",1)
func _process(delta):
	clock += delta
	# title and finish
	if Input.is_key_pressed(KEY_SPACE) and (global.level == 0 or (global.level == 21  and clock > 0.5)):
		global.level = posmod(global.level + 1, 22)
		DoChange()
	
	if(global.level != 0): get_node("/root/Game/HUD").show()
	
	MapChange(delta)
	

func MapLoad():
	var nxtlvl = min(global.level, global.lastLevel)
	var tm = load(tmpath + str(nxtlvl) + ".tscn").instantiate()
	tm.name = "TileMap"
	add_child(tm)
	NodeTileMap = tm

func MapStart():
	print("--- MapStart: Begin ---")
	print("global.level: ", global.level)
	for pos in NodeTileMap.get_used_cells(0):
		var id = NodeTileMap.get_cell_source_id(0, pos)
		if id == TILE_WALL:
			print(pos, ": Wall")
			var atlas = Vector2(randi_range(0, 2), 0)
			NodeTileMap.set_cell(0, pos, TILE_WALL, atlas)
		elif id == TILE_PLAYER or id == TILE_ZOMB:
			var p = id == TILE_PLAYER
			print(pos, ": Player" if p else ": Zombie")
			var inst = (ScenePlayer if p else SceneZomb).instantiate()
			inst.position = NodeTileMap.map_to_local(pos) + Vector2(4, 0 if p else 1)
			(self if p else NodeZombies).add_child(inst)
			# remove tile from map
			NodeTileMap.set_cell(0, pos, -1)
		elif id == TILE_SPAWN:
			var inst = SceneSpawn.instantiate()
			inst.position = NodeTileMap.map_to_local(pos)
			self.add_child(inst)
			# remove tile from map
			NodeTileMap.set_cell(0, pos, -1)
		elif id == TILE_TREE:
			var inst = SceneTre.instantiate()
			inst.position = NodeTileMap.map_to_local(pos)
			self.add_child(inst)
			# remove tile from map
			NodeTileMap.set_cell(0, pos, -1)
	print("--- MapStart: End ---")

func MapChange(delta):
	# if its time to change scene
	if change:
		delay -= delta
		if delay < 0:
			DoChange()
		return # skip the rest if change == true
	if(global.level != 0):
		get_node("/root/Game/HUD/XP Bar").show()
	get_node("/root/Game/HUD/Hearts").show()
	get_node("/root/Game/HUD/Hearts_bg").show()
	get_node("/root/Game/HUD/Hotbar").show()
	
	# should i check?
	if check:
		check = false
		var count = NodeZombies.get_child_count()
		print("Goobers: ", count)
		if count == 0:
			Win()

func Lose():
	change = true
	NodeAudioLose.play()
	NodeSprite.visible = true
	NodeSprite.frame = 2
	global.level = max(0, global.level - 1)

func Win():
	change = true
	NodeAudioWin.play()
	NodeSprite.visible = true
	global.level = min(global.lastLevel, global.level + 1)
	print("Level Complete!, change to level: ", global.level)

func DoChange():
	change = false
	get_tree().reload_current_scene()
	

func Explode(arg : Vector2):
	var xpl = SceneExplo.instantiate() 
	xpl.position = arg
	add_child(xpl)
	move_child(xpl,0)

func GetXP():
	return xp
	
func SetXP(input_xp : int):
	xp = input_xp
	get_node("/root/Game/HUD/XP Bar").value = xp
