extends Actor


func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	#if direction x is greater than 0 it starts animationplayertest walk animation
	if direction.x > 0:
		get_node("AnimationPlayertest").play("walk")
	if direction.x < 0:
		get_node("AnimationPlayertest").play_backwards("walk")
	if direction.x == 0:
		get_node("AnimationPlayertest").stop()
	if direction.y == -1.0:
		out.y = speed.y * direction.y 
	if is_jump_interrupted:
		out.y = 0.0
	return out
