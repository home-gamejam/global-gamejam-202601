extends CharacterBody2D

@onready var hurt_box: HurtBox = $HurtBox
@onready var hit_box: HitBox = $HitBox

@export var target: CharacterBody2D

var speed = 50.0
var health = 50


func _ready():
	hit_box.area_entered.connect(_damage_collision)

	
	
func _damage_collision(hurtbox: Area2D):
	if hurtbox == null:
		return
	
	if hurtbox.owner.has_method("take_damage"):
		hurtbox.owner.take_damage(hit_box.damage)
		
	if hurtbox.owner.health:
		hurtbox.owner.health -= hit_box.damage
		if hurtbox.owner.health <= 0:
			print("ded :(")
			
func _physics_process(delta):
	var distance = target.position - position
	if distance.length() < 100:
		velocity = distance.normalized() * speed
		
func take_damage(amount: int):
	print(amount)
