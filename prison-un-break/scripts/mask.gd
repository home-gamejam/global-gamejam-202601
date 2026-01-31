class_name Mask
extends Node2D

@export var mask_resource : MaskResource:
	set(value):
		mask_resource = value
		if sprite:
			sprite.texture = mask_resource.texture
@export var is_active: bool = false

@onready var muzzle: Marker2D = $Marker2D
@onready var sprite: Sprite2D = $Sprite2D

const BULLET = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	if mask_resource:
		sprite.texture = mask_resource.texture

func _input(event: InputEvent) -> void:
	if not is_active:
		return
	if event.is_action_pressed("lmb"):
		var bullet_instance = BULLET.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.rotation = muzzle.rotation
