@tool
extends Button

class_name ItemButton


@export var item : Item :
	set(item_to_slot):
		item = item_to_slot
		icon = item.texture
		

	
	
