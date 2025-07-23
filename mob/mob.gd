extends RigidBody3D
class_name Mob

signal died()

@export var points: int = 10
@export var damage: int = 1

@onready var hurt_sound: AudioStreamPlayer2D = %HurtSound
@onready var die_sound: AudioStreamPlayer2D = %DieSound

@onready var bat_model: Node3D = %bat_model
@onready var player = get_node("/root/Game/Player") 
@onready var timer: Timer = %Timer


var speed:float = randf_range(2.0,4.0)
var health: int = 3

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)	
	direction.y = 0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI


func take_damage() -> void:
	if health: 
		bat_model.hurt()
		health -= 1		
		if health == 0:
			set_physics_process(false)
			gravity_scale = 1.0
			var direction = global_position.direction_to(player.global_position) * -1.0
			var random_upward_force = Vector3.UP * randf_range(0.5,1.0)
			apply_central_impulse(direction * 10.0 + random_upward_force)
			lock_rotation = false
			timer.start()			
			die_sound.play()
		else:
			hurt_sound.play()
			
			
func _on_timer_timeout() -> void:
	queue_free()
	died.emit()
