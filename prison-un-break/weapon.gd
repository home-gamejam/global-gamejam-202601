extends Node2D

@onready var muzzle: Marker2D = $Marker2D

const BULLET = preload("res://bullet.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lmb"):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = muzzle.rotation
