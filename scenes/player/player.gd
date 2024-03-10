extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var raft = get_tree().get_first_node_in_group("raft")
@onready var cannonBall: Sprite2D = $cannonBall

var speed: int = 100  # Change this value to adjust the movement speed
var direction : Vector2 = Vector2.ZERO
var raft_velocity := Vector2(0,0)
var carrying: bool = false
var resource: int = 0

func _ready():
	animation_tree.active = true
	
func _process(_delta):
	update_animation_parameters()
	direction = Input.get_vector("left", "right", "up" ,"down")
	velocity = direction * speed
	velocity += raft.velocity
	move_and_slide()

	if resource >= 1:
		cannonBall.show()
		carrying = true
	else:
		cannonBall.hide()
		carrying = false

func update_animation_parameters():
	var is_idle = (velocity - raft.velocity == Vector2.ZERO)

	animation_tree["parameters/conditions/idle"] = is_idle
	animation_tree["parameters/conditions/is_moving"] = not is_idle
	animation_tree["parameters/conditions/swing"] = Input.is_action_just_pressed("attack")
	animation_tree["parameters/conditions/carrying"] = carrying
	animation_tree["parameters/conditions/not_carrying"] = not carrying

	if(direction != Vector2.ZERO):
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Swing/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		animation_tree["parameters/IdleCarry/blend_position"] = direction
		animation_tree["parameters/RunCarry/blend_position"] = direction

func post_interaction(interaction_result):
	resource += interaction_result
	print(resource)

func _on_hotbar_item_selected(item):
	ObjectManager.handle_item_selection(item)
	
