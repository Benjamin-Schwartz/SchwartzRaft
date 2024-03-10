extends Area2D

@onready var timer = %CannonBallTimer
@onready var hitbox = %hitbox
@onready var animation_player = %AnimationPlayer

@export_category("Stats")
@export var speed:float = 500
@export var damage:float = 1

@export_category("Target")
@export var target_group = "friendly"

var direction := Vector2.ZERO
var start_position := Vector2.ZERO

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	animation_player.play("ball")
	timer.start()

func _physics_process(delta):
	
	position += direction * (speed) * delta
	
func _on_body_entered(body):
	if body.has_method("take_damage") and body.is_in_group(target_group):
		body.take_damage(damage)
		animation_player.play("explode")
		speed = 0
	
func _on_timer_timeout():
	self.queue_free()




