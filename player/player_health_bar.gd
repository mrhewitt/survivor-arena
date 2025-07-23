extends ProgressBar

const PLAYER_HEALTH_BAR_FULL = preload("res://player/player_health_bar_full.tres")
const PLAYER_HEALTH_BAR_MEDIUM = preload("res://player/player_health_bar_medium.tres")
const PLAYER_HEALTH_BAR_LOW = preload("res://player/player_health_bar_low.tres")


func set_max_health(max_health: int) -> void:
	max_value = max_health
	set_color()


func adjust_health(health: float) -> void:
	value = health
	set_color()


func set_color() -> void:
	var percent:float = value/max_value 
	if percent >= 0.75:
		add_theme_stylebox_override("fill", PLAYER_HEALTH_BAR_FULL)
	elif percent >= 0.25:			
		add_theme_stylebox_override("fill", PLAYER_HEALTH_BAR_MEDIUM)
	else:
		add_theme_stylebox_override("fill", PLAYER_HEALTH_BAR_LOW)
