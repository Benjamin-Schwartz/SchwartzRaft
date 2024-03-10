class_name Turret extends StaticBody2D

func generate_raycasts(
	angle_cone_of_vision: float = deg_to_rad(30.0),
	max_view_distance: float = 800.0,
	angle_between_rays: float = deg_to_rad(5.0),
	start_position: Vector2 = Vector2(0,0)
) -> Array:
	#diving the angle by the angle between rays gives us the number of rays
	var ray_count := angle_cone_of_vision / angle_between_rays
	var rays = []

	for index in ray_count:
		var ray := RayCast2D.new()
		var angle: float = angle_between_rays * (index - ray_count / 2) + (angle_between_rays / 2)
		ray.target_position = Vector2.RIGHT.rotated(angle) * max_view_distance
		ray.position = start_position
		ray.enabled = true
		rays.append(ray)
		add_child(ray)
	return rays
		
func find_target(rays):		
	var target
	for ray in rays:
		if ray.is_colliding() and ray.get_collider():
			target = ray.get_collider()
			return target
						  
func shoot(target, ammunition_scene: PackedScene, target_group, start_position):
	var ball = ammunition_scene.instantiate()
	ball.target_group = target_group
	ball.position = start_position
	ball.direction = (target - start_position).normalized()
	get_tree().current_scene.add_child(ball)

func rotateToTarget(sprite: Sprite2D, target, delta, rotation_speed):
	# Calculate the direction from the sprite to the target
	var direction = (target.global_position - sprite.global_position).normalized()

	# Calculate the angle from the sprite's current forward vector to the direction vector.
	# Assuming the sprite's forward vector is along the x-axis (which is common in 2D),
	# you can use the sprite's global_transform basis vector (x-axis) to represent its current facing direction.
	var sprite_forward = sprite.global_transform.x.normalized()
	var angleTo = sprite_forward.angle_to(direction)

	# Rotate the sprite by the smaller of the calculated angle or the maximum rotation speed,
	# ensuring we rotate in the correct direction (sign of angleTo).
	sprite.rotate(sign(angleTo) * min(delta * rotation_speed, abs(angleTo)))
	



	
