extends Node2D

onready var doorN = get_node("DoorN")
onready var doorS = get_node("DoorS")
onready var doorW = get_node("DoorW")
onready var doorE = get_node("DoorE")

func _ready():
	doorN.connect("body_enter", self, "_on_player_body_enter_doorN")
	doorS.connect("body_enter", self, "_on_player_body_enter_doorS")
	doorW.connect("body_enter", self, "_on_player_body_enter_doorW")
	doorE.connect("body_enter", self, "_on_player_body_enter_doorE")
	
func _on_player_body_enter_doorN(body):
	if (body.get_name() == "Player"):
		doorN.hide()
		doorN.queue_free()
		
func _on_player_body_enter_doorS(body):
	if (body.get_name() == "Player"):
		doorS.hide()
		doorS.queue_free()
		
func _on_player_body_enter_doorW(body):
	if (body.get_name() == "Player"):
		doorW.hide()
		doorW.queue_free()
		
func _on_player_body_enter_doorE(body):
	if (body.get_name() == "Player"):
		doorE.hide()
		doorE.queue_free()