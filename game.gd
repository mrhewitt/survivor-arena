extends Node3D

@export var survival_time: int = 120

@onready var player: Player = %Player
@onready var score_label: Label = %ScoreLabel
@onready var time_label: Label = %TimeLabel
@onready var game_timer: Timer = %GameTimer
@onready var survive_logo: ActionLogo = %SurviveLogo
@onready var dead_logo: ActionLogo = %DeadLogo
@onready var win_logo: ActionLogo = %WinLogo
@onready var spawners: Node = %Spawners

var score: int = 0
var time_left: int = 0


func _ready() -> void:
	play_start()


func play_start() -> void:
	time_left = survival_time
	show_time_left(time_left)

	get_tree().paused = false
	await survive_logo.appear()
	for spawner in spawners.get_children():
		spawner.start()
	game_timer.start()


func player_won() -> void:
	get_tree().paused = true
	await win_logo.appear()
	get_tree().call_deferred("reload_current_scene")
	

func player_died() -> void:
	player.visible = false
	get_tree().paused = true
	await dead_logo.appear()
	get_tree().call_deferred("reload_current_scene")


func show_time_left(_time_left: int) -> void:
	time_label.text = "Time left: " + str(_time_left) 


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
	player_died()


func _on_game_timer_timeout() -> void:
	time_left -= 1
	show_time_left(time_left)
	if time_left == 0:
		player_won()


func _on_player_player_died() -> void:
	player_died()
