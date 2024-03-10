extends CharacterBody2D


@export var speed: float = .2  # Speed of rotation
@export var health: float = 100
@export var radius: float = 400  # Radius of the circle
@export var circle_center: Vector2 = Vector2(-100, 30)  # Center of the circle
@onready var finder: RayCast2D = $RayCast2D
@onready var progress_bar: ProgressBar = $ProgressBar
@export var rotation_speed: float = 2

var angle: float = 0
var found_raft: bool = false
var target

func _ready():
	
	progress_bar.max_value = health
	progress_bar.value = health

func _physics_process(delta):
	
	angle += speed * delta  # Increment the angle based on the speed and delta time
	
	if not found_raft:
		search_for_raft()
	else:
		circle_boat()
		
func search_for_raft():
	finder.rotate(.1)  # Assuming finder is accessible within the scope
	if finder.is_colliding() and finder.get_collider().is_in_group("friendly"):
		target = finder.get_collider()
		found_raft = true
			
func take_damage(damage:float):
	health -= damage
	progress_bar.value = health
	
	if health <= 0:
		queue_free()
		
func circle_boat():
	var x = target.global_position.x + cos(angle) * radius 
	var y = target.global_position.y + sin(angle) * radius 
	position = Vector2(x, y)
	


