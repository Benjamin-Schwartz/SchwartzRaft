extends Control

signal item_selected(item)

@onready var grid_container : GridContainer = $GridContainer


var item_slots: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	register_item_slots()
			
func register_item_slots():
	var children = grid_container.get_children()
	for i in range(len(children)):
		var button = children[i]
		if button is ItemButton:
			button.item.item_slot = i

func _input(event):
	var children = grid_container.get_children()
	var hotbar_length = children.size()
	var item

	for i in range(1,hotbar_length + 1): 
		var action_name = "hotbar_" + str(i)
		if event.is_action_pressed(action_name) and i <= hotbar_length:
			item = children[i - 1].item #actions start from 1
			item_selected.emit(item)
			break

		
		
