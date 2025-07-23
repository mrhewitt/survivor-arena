extends TextureRect
class_name ActionLogo

@export var wait_time:int = 3

@onready var logo_animation: AnimationPlayer = %LogoAnimation

func appear() -> void:
	modulate.a = 1
	visible = true
	logo_animation.play("wobble")
	await get_tree().create_timer(3).timeout
	await disappear()


func disappear() -> void:
	await fade(0)
	logo_animation.stop()
	visible = false
	
	
# async func to fade image to a target value in specified delay in secs
func fade(target: float, delay: float = 0.5) -> void:
	var tween = get_tree().create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# start a tween to fade scene to target value
	tween.tween_property(self,"modulate:a",target,delay)
	# wait immediatly for it to finish, funcs that call this one
	# should also use "await fade(...)" to prevent the code running on 
	await tween.finished
