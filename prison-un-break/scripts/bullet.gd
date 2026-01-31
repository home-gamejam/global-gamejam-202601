extends Node2D

const SPEED = 300

@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	hit_box.area_entered.connect(_bullet_collision)
	
func _process(delta: float) -> void:
	position += transform.x * SPEED * delta
	
func _bullet_collision(hurtbox: Area2D):
	if hurtbox == null:
		return
	
	if hurtbox.owner.has_method("take_damage"):
		hurtbox.owner.take_damage(hit_box.damage)
		queue_free()
		
	if hurtbox.owner.health:
		hurtbox.owner.health -= hit_box.damage
		if hurtbox.owner.health <= 0:
			hurtbox.owner.queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
