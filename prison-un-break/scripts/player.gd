class_name Player
extends CharacterBody2D

@onready var mask: Mask = $Mask
@onready var collision_area: Area2D = $Area2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $"."

@export var masks : Array[MaskResource]

var current_mask_index : int = 0

var colliding_mask: MaskItem = null
var health : int = 20

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
	
	if Input.is_action_just_pressed("switch_mask"):
		_select_next_item()
	if Input.is_action_just_pressed("back_mask"):
		_select_previous_item()
	
func _select_next_item():
	if masks.size() == 0:
		return
	
	current_mask_index = (current_mask_index + 1) % masks.size()
	_update_current_mask()
	
func _select_previous_item():
	if masks.size() == 0:
		return
	current_mask_index = (current_mask_index - 1) % masks.size()
	_update_current_mask()
	
func _update_current_mask():
	var selcted_mask = masks[current_mask_index]
	mask.mask_resource = masks[current_mask_index]
	#print("Current Mask:", selcted_mask)
	
func _swap_items(index_a: int, index_b: int):
	if index_a >= 0 and index_a < masks.size() and index_b >=0 and index_b < masks.size():
		var buffer = masks[index_a]
		masks[index_a] = masks[index_b]
		masks[index_b] = buffer
		#print("Swapped Masks:", masks)
	
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
		
func take_damage(amount:int):
	print("damaged")
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	_hand_rotations()
	_update_animations()
	_handle_input()
