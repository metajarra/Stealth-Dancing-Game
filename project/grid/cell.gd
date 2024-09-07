extends Node2D
class_name Cell

# object occupying tile
@export var occupant : Node
@onready var is_occupied = occupant != null

func add_occupant(new_occupant : Node) -> void:
	if occupant != null:
		printerr("Cell %s attempted to add occupant to already occupied cell" % name)
		return
	
	occupant = new_occupant
	is_occupied = true
	
	call_modifiers()

func remove_occupant() -> void:
	if occupant == null:
		printerr("Cell %s attempted to remove occupant from unoccupied cell" % name)
		return
	
	occupant = null
	is_occupied = false

func call_modifiers() -> void:
	for child in get_children():
		if not (child is CellModifier):
			continue
		
		child.alert()

# coordinates
var coordinates : Vector2

func _ready() -> void:
	# coordinate setup from name
	if name == "x,y":
		printerr("Cell does not have name configured")
		return
	
	var string_components := name.split(",")
	coordinates = Vector2(	\
		string_components[0].to_int(),	\
		string_components[1].to_int()	\
	)
