@tool
class_name MaskItem
extends Area2D

@export var mask_resource : MaskResource
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = mask_resource.texture
