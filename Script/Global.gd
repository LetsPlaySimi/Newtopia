extends Node2D

var level := 0
var lastLevel := 21
var Game

var OST = load("res://Audio/OST.ogg")
var audio

var playedAnim = false

var inv = []
var invCount = []

func has(searchItem, searchCount):
	return((inv.find(searchItem)>-1) && (invCount[inv.find(searchItem)] >= searchCount))
	
func give(item,count):
	if(inv.find(item) > -1):
		invCount[inv.find(item)] += count
	elif(inv.size() < 9):
		inv.append(item)
		invCount.append(count)
		
	update_items()

func remove(item, count):
	if(count < invCount[inv.find(item)]):
		invCount[inv.find(item)] -= count
	else:
		get_node("/root/Game/HUD/Hotbar_items").find_child(inv.find[item])
		invCount.remove_at(inv.find(item))
		inv.remove_at(inv.find(item))
		
	get_node("/root/Game/HUD/Hotbar_items/TextureRect" + str(len(inv)+1)).texture = load("res://Image/empty.png")
	update_items()

func _ready():
	await get_tree().create_timer(0.1).timeout
	
	audio = AudioStreamPlayer.new()
	add_child(audio)
	audio.stream = OST
	audio.play()
	audio.finished.connect(audio.play)
	
func update_items():
	print("help")
	for n in range(len(inv)):
		print(n)
		var itemTexture = load("res://Image/item_" + inv[n].to_lower() + ".png")
		get_node("/root/Game/HUD/Hotbar_items/TextureRect" + str(n)).texture = itemTexture
	
func _input(event):
	if(Input.is_key_pressed(KEY_F12)):
		var win_full = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		#DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE if win_full else DisplayServer.MOUSE_MODE_HIDDEN)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED if win_full else DisplayServer.WINDOW_MODE_FULLSCREEN)

func wrapp(pos := Vector2.ZERO):
	return Vector2(wrapf(pos.x, 0.0, 144.0), wrapf(pos.y, 0.0, 144.0))
