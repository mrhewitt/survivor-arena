extends CharacterBody3D
class_name Player

const SPEED: float = 5.5


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x  * 0.8	
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x - event.relative.y * 0.8 ,
			-60, 60
		)	
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _physics_process(delta: float) -> void:
	var input_direction_2d = Input.get_vector(
		"move_left", "move_right","move_forward","move_back"
	)
	var input_direction_3d = Vector3(
		input_direction_2d.x, 0.0, input_direction_2d.y
	)
	var direction = transform.basis * input_direction_3d  
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	velocity.y -= 20 * delta
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = 10.0
	elif Input.is_action_just_released("jump") && velocity.y > 0.0:
		velocity.y = 0.0
		
	move_and_slide()

	if Input.is_action_pressed("shoot") && %BulletTimer.is_stopped():
		shoot_bullet()
	
	
func shoot_bullet() -> void:
	const BULLET_3D = preload("res://player/bullet_3d.tscn")
	var new_bullet = BULLET_3D.instantiate()
	%Marker3D.add_child(new_bullet)
	
	new_bullet.global_transform = %Marker3D.global_transform
	
	%BulletTimer.start()
	%AudioStreamPlayer.play()


func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.
