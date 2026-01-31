extends CharacterBody2D

const SPEED : int = 80

func _handle_input():
	var move_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = move_direction * SPEED
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	_handle_input()
