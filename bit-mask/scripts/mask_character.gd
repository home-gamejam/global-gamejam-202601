extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = %Sprite

const SPEED = 140.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x:
		velocity.x = direction.x * SPEED
		sprite.flip_h = direction.x < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if velocity.length():
		if not sprite.is_playing():
			print("play")
			sprite.play("walk")
	elif sprite.is_playing():
		print("stop")
		sprite.stop()
		sprite.frame = 1

	move_and_slide()
