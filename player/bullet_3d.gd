extends Area3D

const SPEED = 20.0
const RANGE = 40.0

var travelled_distance: float = 0.0


func _physics_process(delta: float) -> void:
	var distance:float = SPEED * delta
	position += -transform.basis.z * distance
	travelled_distance += distance
	if travelled_distance > RANGE:
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
