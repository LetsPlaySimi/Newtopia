extends Sprite2D

var loopAmount = 0

var frame_0 = load("res://Image/Animation/godot_1.png")
var frame_1 = load("res://Image/Animation/godot_2.png")
var frame_2 = load("res://Image/Animation/godot_3.png")
var frame_3 = load("res://Image/Animation/godot_4.png")
var frame_4 = load("res://Image/Animation/godot_5.png")
var frame_5 = load("res://Image/Animation/godot_6.png")
var frame_6 = load("res://Image/Animation/godot_7.png")
var frame_7 = load("res://Image/Animation/godot_8.png")
var frame_8 = load("res://Image/Animation/godot_9.png")
var frame_9 = load("res://Image/Animation/godot_9.png")
var frame_10 = load("res://Image/Animation/godot_11.png")
var frame_11 = load("res://Image/Animation/godot_12.png")
var frame_12 = load("res://Image/Animation/godot_13.png")
var frame_13 = load("res://Image/Animation/godot_14.png")
var frame_14 = load("res://Image/Animation/godot_15.png")
var frame_15 = load("res://Image/Animation/godot_16.png")
var frame_16 = load("res://Image/Animation/godot_17.png")
var frame_17 = load("res://Image/Animation/godot_18.png")
var frame_18 = load("res://Image/Animation/godot_19.png")
var frame_19 = load("res://Image/Animation/godot_20.png")
var frame_20 = load("res://Image/Animation/godot_21.png")
var frame_21 = load("res://Image/Animation/godot_22.png")
var frame_22 = load("res://Image/Animation/godot_23.png")
var frame_23 = load("res://Image/Animation/godot_24.png")
var frame_24 = load("res://Image/Animation/godot_25.png")
var frame_25 = load("res://Image/Animation/godot_26.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	loopAmount += delta*10
	if(int(loopAmount) == 0):
		texture = frame_0
	elif(int(loopAmount) == 1):
		texture = frame_1
	elif(int(loopAmount) == 2):
		texture = frame_2
	elif(int(loopAmount) == 3):
		texture = frame_3
	elif(int(loopAmount) == 4):
		texture = frame_4
	elif(int(loopAmount) == 5):
		texture = frame_5
	elif(int(loopAmount) == 6):
		texture = frame_6
	elif(int(loopAmount) == 7):
		texture = frame_7
	elif(int(loopAmount) == 8):
		texture = frame_8
	elif(int(loopAmount) == 9):
		texture = frame_9
	elif(int(loopAmount) == 10):
		texture = frame_10
	elif(int(loopAmount) == 11):
		texture = frame_11
	elif(int(loopAmount) == 12):
		texture = frame_12
	elif(int(loopAmount) == 13):
		texture = frame_13
	elif(int(loopAmount) == 14):
		texture = frame_14
	elif(int(loopAmount) == 15):
		texture = frame_15
	elif(int(loopAmount) == 16):
		texture = frame_16
	elif(int(loopAmount) == 17):
		texture = frame_17
	elif(int(loopAmount) == 18):
		texture = frame_18
	elif(int(loopAmount) == 19):
		texture = frame_19
	elif(int(loopAmount) == 20):
		texture = frame_20
	elif(int(loopAmount) == 21):
		texture = frame_21
	elif(int(loopAmount) == 22):
		texture = frame_22
	elif(int(loopAmount) == 23):
		texture = frame_23
	elif(int(loopAmount) == 24):
		texture = frame_24
	elif(int(loopAmount) == 25):
		texture = frame_25
	elif(int(loopAmount) >= 27):
		get_node("/root/Game").finishedSplashScreen()
		queue_free()
		
