extends StaticBody2D

#onready
@onready var interaction_area = $InteractionArea
@onready var placeable = %Placeable

#At the moment this is just an int representing how many of the resource (cannon_ball) is in the crate. Later resource should be a "resource" remember you watched that video and resources seemed cool
@export var resource: int = 10 


# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self, "give_resource")

func give_resource():
	print("giving cannonball")
	if resource > 0:
		resource -=1
	return 1






