extends Area2D
class_name InteractionArea


@export var action_name: String = "interact"
@export var input: String = "E"

var interact: Callable = func():
	pass

func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
	
func _on_body_entered(_body):
	InteractionManager.register_area(self)


