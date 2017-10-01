extends Node2D

onready var window_size = OS.get_window_size()	# Window size should be 1024x608
onready var player = get_node("Player")
onready var player_world_pos = get_player_world_pos()
onready var rooms = Array()

func _ready():
	OS.set_window_position(Vector2(0,0))
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = player_world_pos * window_size
	get_viewport().set_canvas_transform(canvas_transform)
	rooms.append(Vector2(0,0))
	set_process(true)

func _process(delta):
	update_camera()

func get_player_world_pos():
	var pos = player.get_pos() - (player.size / 2)
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
		if (!(temp in rooms)):
			rooms.append(temp)
			new_room(temp)
		get_viewport().set_canvas_transform(transform)
	return transform

# list contains position of rooms
func new_room(list):
	var room = load("res://Scenes/Room.xml")
	var node = room.instance()
	node.set_pos(Vector2((list[0] * 1024), (list[1] * 608)));
	add_child(node)