class_name Player
extends CharacterBody2D

@onready var weapon: Node2D = $Weapon

const SPEED : int = 80

func _handle_input():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction * SPEED
	
func _hand_rotations():
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - position
	direction = direction.normalized()
	weapon.look_at(mouse_pos)
	
	weapon.scale.y = -1 if weapon.global_rotation_degrees < -90 or weapon.global_rotation_degrees > 90 else 1
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	_hand_rotations()
	_handle_input()
