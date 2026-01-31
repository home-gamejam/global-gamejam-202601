class_name Player
extends CharacterBody2D

@onready var mask: Mask = $Mask
@onready var collision_area: Area2D = $Area2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $"."

@export var masks : Array[MaskResource]

var colliding_mask: MaskItem = null

const SPEED : int = 80

func _ready() -> void:
	collision_area.area_entered.connect(_on_area_entered)
	collision_area.area_exited.connect(_on_area_exited)
	
func _on_area_entered(area2d: Area2D):
	if area2d is MaskItem:
		colliding_mask = area2d
		
func _on_area_exited(area2d: Area2D):
	if area2d is MaskItem:
		colliding_mask = null

func _update_animations():
	if velocity.length() == 0:
		animation.play("RESET")
	else:
		animation.play("walk")
	
func _handle_input():
	var move_direction = Input.get_vector("left", "right", "up", "down")
	velocity = move_direction * SPEED
	
	if colliding_mask and Input.is_action_just_pressed("interact"):
		masks.append(colliding_mask.mask_resource)
		mask.mask_resource = colliding_mask.mask_resource
		colliding_mask.queue_free()
	
func _hand_rotations():
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - position
	direction = direction.normalized()
	mask.muzzle.look_at(mouse_pos)
	
	if mask.muzzle.global_rotation_degrees < -90 or mask.muzzle.global_rotation_degrees > 90:
		player.scale.y = -1 
		player.rotation_degrees = 180
		mask.scale.y = -1
		mask.rotation_degrees = 180
		mask.sprite.scale.y = -1
		mask.sprite.rotation_degrees = 180
	else:
		player.scale.y = 1
		player.rotation_degrees = 0
		mask.scale.y = 1
		mask.rotation_degrees = 0
		mask.sprite.scale.y = 1
		mask.sprite.rotation_degrees = 0
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	_hand_rotations()
	_update_animations()
	_handle_input()
