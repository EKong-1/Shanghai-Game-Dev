extends Node2D

onready var window_size = OS.get_window_size()	# Window size should be 1024x608
onready var player = get_node("Player")
onready var player_world_pos = get_player_world_pos()
onready var positions = Array()
var rooms_list = []
var room = preload("res://Scenes/Room.xml")
var screenWidth = 1024
var screenHeight = 608
var numRooms = 0

func _ready():
	randomize()
	OS.set_window_position(Vector2(0,0))
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)
	positions.append(Vector2(0,0))
	new_room(Vector2(0,0))
	set_process(true)

func _process(delta):
	update_camera()

func get_player_world_pos():
	var pos = player.get_pos() - (player.size / 1.5)
	var x = floor(pos.x / window_size.x)
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)

func update_camera():
	var new_player_grid_pos = get_player_world_pos()
	var transform  = Matrix32()
	
	if new_player_grid_pos != player_world_pos:
		player_world_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		var temp = Vector2(player_world_pos.x, player_world_pos.y)
		if (!(temp in positions)):
			positions.append(temp)
			new_room(temp)
		get_viewport().set_canvas_transform(transform)
	return transform

# list contains position of rooms
func new_room(list):
	numRooms += 1
	var node = room.instance()
	node.set_pos(Vector2((list[0] * screenWidth), (list[1] * screenHeight)));
	node.setDoors(generateDoors(list))
	rooms_list.push_back(node)
	add_child(node, false)
	
func generateDoors(list):
	var doors = [false, false, false, false] # North, South, East, West
	var changed = [false, false, false, false]
	for i in rooms_list:
		var pos = i.get_pos()
		if(pos == Vector2(list[0] * screenWidth, (list[1] - 1) * screenHeight)):
			doors[0] = i.getOpen("south")
			changed[0] = true
		elif(pos == Vector2(list[0] * screenWidth, (list[1] + 1) * screenHeight)):
			doors[1] = i.getOpen("north")
			changed[1] = true
		elif(pos == Vector2((list[0] + 1) * screenWidth, list[1] * screenHeight)):
			doors[2] = i.getOpen("west")
			changed[2] = true
		elif(pos == Vector2((list[0] - 1) * screenWidth, list[1] * screenHeight)):
			doors[3] = i.getOpen("east")
			changed[3] = true
	
	for i in range(changed.size()):
		if (changed[i] == false):
			if (numRooms < 5 && randf() > .30):
				doors[i] = true
			elif(numRooms > 10):
				if (randf() > .75):
					doors[i] = true
			elif(randf() > .50):
				doors[i] = true
	return doors