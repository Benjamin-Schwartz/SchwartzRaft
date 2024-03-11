extends Node2D

@onready var raft = get_tree().get_first_node_in_group("raft")

var active_items = []
var item_instance

var footprint : Placeable


func _physics_process(_delta):
	if item_instance != null:
		var mouse_position = get_global_mouse_position()
		var rounded_position = Vector2(int(round(mouse_position.x)), int(round(mouse_position.y)))
		item_instance.global_position = rounded_position
		
		place_item()

func place_item():
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var valid_placement = footprint.check_valid_placement()
		if valid_placement:
			#Want it to now be a child of raft rather than object manager
			self.remove_child(item_instance)
			active_items.push_back(item_instance)
			item_instance.global_position -= raft.global_position
			footprint.set_parent_collision(true)
			footprint.set_footprint_collision(false)
			raft.add_child(item_instance)
			clear_item_selection()
		
func unregister_item(item: Item):
	var index = active_items.find(item)
	if index != -1:
		active_items.remove_at(index)
		
func handle_item_selection(item: Item) -> void:
	if item == null:
		return 
	
	###Placeable Item Selection
	if item.placeable:	
		item_instance = item.scene.instantiate()
		self.add_child(item_instance)
		
		footprint = item_instance.placeable
		
func clear_item_selection():
	if item_instance == null:
		return 
	else:
		
		item_instance = null
		

	
	
		
	


	

	
		
	
		

	
