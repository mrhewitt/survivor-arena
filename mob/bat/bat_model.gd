extends Node3D

@onready var animation_tree: AnimationTree = %AnimationTree


func hurt() -> void:
	animation_tree.set("parameters/OneShot/request", true)
