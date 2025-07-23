extends Node3D

signal mob_spawned(mod)

@export var mob_to_spawn: PackedScene = null
@export var min_spawn_delay: int = 5
@export var max_spawn_delay: int = 10

@onready var marker_3d: Marker3D = %Marker3D
@onready var timer: Timer = %Timer


func _ready() -> void:
	set_spawn_time()
	timer.start()
	

func set_spawn_time() -> void:
	timer.wait_time = randi_range(min_spawn_delay, max_spawn_delay)
	

func _on_timer_timeout() -> void:
	var new_mob = mob_to_spawn.instantiate()
	add_child(new_mob)
	new_mob.global_position = marker_3d.global_position
	mob_spawned.emit(new_mob)
	set_spawn_time()
