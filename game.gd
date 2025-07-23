extends Node3D

@onready var score_label: Label = %ScoreLabel

var score: int = 0


func increase_score(points: int) -> void:
	score += points
	score_label.text = "Score: " + str(score)


func do_poof(_position: Vector3) -> void:
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var smoke_instance = SMOKE_PUFF.instantiate()
	smoke_instance.global_position = _position
	add_child(smoke_instance)
	

func _on_mob_spawner_3d_mob_spawned(mob: Mob) -> void:
	mob.died.connect(func mob_died():
		increase_score(mob.points)
		do_poof(mob.global_position)
	)
	do_poof(mob.global_position)


func _on_kill_plane_body_entered(body: Node3D) -> void:
	get_tree().call_deferred("reload_current_scene")
