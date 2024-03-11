class_name Placeable extends Area2D

@export var parent_collision: CollisionShape2D
@onready var footprint_collision = %CollisionPolygon2D


var on_raft : bool = false
var colliding : bool = false
const RAFT_GROUP : String = "raft"


func _ready():
	set_parent_collision(false)
	set_footprint_collision(true)

func _process(delta):
	var bodies = get_overlapping_bodies()

	colliding = len(bodies) > 1
	
	
func _on_body_entered(body):
	if body.is_in_group(RAFT_GROUP):
		on_raft = true

	
func _on_body_exited(body):
	if body.is_in_group(RAFT_GROUP):
		on_raft = false

		
func check_valid_placement():
	print("On Raft: ", on_raft, ", Colliding: ", colliding)
	return on_raft and not colliding
	
func set_parent_collision(collision_flag : bool):
		parent_collision.disabled = not collision_flag
	
func set_footprint_collision(collision_flag : bool):
		footprint_collision.disabled = not collision_flag
		
	
	

	
	

