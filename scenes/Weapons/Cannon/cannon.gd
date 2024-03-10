extends Turret

@onready var cannon_image = %CannonImage
@onready var start_position = %StartPosition
@onready var interaction_area = $InteractionArea
@onready var ammo_display = %AmmoDisplay
@onready var cannon_animation = %CannonAnimation

@export_category("Raycast Parameters")
@export var angle_cone_of_vision := deg_to_rad(10)
@export var max_view_distance := 800.0
@export var angle_between_rays := deg_to_rad(10)
@export var rotation_speed := 2

@export_category("Ammo")
@export var cannon_ball : PackedScene
@export var ammo: int = 0
@export var max_ammo: int = 1
@export var ammo_load_amount: int = 1

@export_category("Target")
@export var target_group = "enemy"



var rays := []

func _ready():
	var start = start_position.position
	rays = generate_raycasts(angle_cone_of_vision, max_view_distance, angle_between_rays, start)

	ammo_display.max_value = max_ammo
	ammo_display.value = ammo

	interaction_area.interact = Callable(self, "load_cannon")
	
func _physics_process(delta: float) -> void:
	var target = find_target(rays)
	
	if target:
		rotateToTarget(cannon_image,  target, delta, rotation_speed)
		if ammo >= 1:
			shoot(target.global_position, cannon_ball,target_group, start_position.global_position)
			cannon_animation.play("shoot")
			ammo  -= 1
			ammo_display.value = ammo
	
	if ammo >= 1:
		ammo_display.show()
	else:
		ammo_display.hide()

func load_cannon():
	if ammo < max_ammo:
		ammo += 1
		ammo_display.value = ammo
		return -1
	return 0
								
