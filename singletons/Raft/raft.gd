extends CharacterBody2D

@export var health: float = 1000
@export var speed: float =  100

@onready var health_bar = %HealthBar
@onready var camera = %Camera
@onready var interaction_area: InteractionArea = $InteractionArea
@onready var raft_image: Sprite2D = $raftImage

var zoom_minimum = Vector2(.100001, .1000001)
var zoom_maximum = Vector2(2.5, 2.5)
var zoom_speed = Vector2(.3, .3)
var direction = Vector2(0, -1) # Move North
var driving = true
var sail_orientation = 0 # Sail's orientation angle in degrees

func _ready():
	health_bar.max_value = health
	health_bar.value = health
	interaction_area.interact = Callable(self, "drive")
	
func _process(_delta):
	if driving:
		if Input.is_action_pressed("sail_up"):
			sail_orientation += 1
			self.rotation_degrees += 1
			 
		elif Input.is_action_pressed("sail_down"):
			sail_orientation -= 1
			self.rotation_degrees -= 1
	
		# Ensure the sail orientation stays within 0-360 degrees
		sail_orientation = fmod(sail_orientation, 360)

		# Convert sail orientation to a direction vector, with 0 degrees being upwards
		direction = Vector2(cos(deg_to_rad(sail_orientation - 90)), sin(deg_to_rad(sail_orientation - 90)))
	velocity = direction * speed 
	# Move the boat in the direction of the sail
	move_and_slide()
	
func _on_area_2d_body_entered(_body):
	speed  = 0

func _on_area_2d_body_exited(_body):
	speed = 0

func take_damage(damage:float):
	health -= damage
	health_bar.value = health
	
	if health <= 0:
		queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if camera.zoom > zoom_minimum:
					camera.zoom -= zoom_speed
					pass
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if camera.zoom < zoom_maximum:
					camera.zoom += zoom_speed
	pass

func drive():
	driving = true
	return 0
