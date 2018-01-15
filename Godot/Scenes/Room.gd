extends Node2D

onready var doorN = get_node("DoorN")
onready var collideN = get_node("BlockedDoorN")
onready var doorS = get_node("DoorS")
onready var collideS = get_node("BlockedDoorS")
onready var doorE = get_node("DoorE")
onready var collideE = get_node("BlockedDoorE")
onready var doorW = get_node("DoorW")
onready var collideW = get_node("BlockedDoorW")

var open = [true, true, true, true]
var coords

func getOpen(direction):
	if (direction == "north"):
		return open[0]
	elif (direction == "south"):
		return open[1]
	elif (direction == "east"):
		return open[2]
	elif (direction == "west"):
		return open[3]

func setCoords(c):
	coords = c

func setDoors(list):
	open = list

func _ready():
	if (open[0]):
		collideN.hide()
	if (open[1]):
		collideS.hide()
	if (open[2]):
		collideE.hide()
	if (open[3]):
		collideW.hide()
	
	
	doorN.connect("body_enter", self, "_on_player_body_enter_doorN")
	doorS.connect("body_enter", self, "_on_player_body_enter_doorS")
	doorE.connect("body_enter", self, "_on_player_body_enter_doorE")
	doorW.connect("body_enter", self, "_on_player_body_enter_doorW")
	
func _on_player_body_enter_doorN(body):
	if (body.get_name() == "Player" && open[0] == true):
		doorN.hide()
		doorN.queue_free()
		collideN.hide()
		collideN.queue_free()
		
func _on_player_body_enter_doorS(body):
	if (body.get_name() == "Player" && open[1] == true):
		doorS.hide()
		doorS.queue_free()
		collideS.hide()
		collideS.queue_free()
		
func _on_player_body_enter_doorE(body):
	if (body.get_name() == "Player" && open[2] == true):
		doorE.hide()
		doorE.queue_free()
		collideE.hide()
		collideE.queue_free()
		
func _on_player_body_enter_doorW(body):
	if (body.get_name() == "Player" && open[3] == true):
		doorW.hide()
		doorW.queue_free()
		collideW.hide()
		collideW.queue_free()