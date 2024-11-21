extends CharacterBody2D
class_name Enemy

@export_category("Config")
@export_group("Options")
@export var health : int = 1
@export var score : int = 100

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

var direction : int = 1

func _process(delta: float) -> void:
	if health > 0:
		motion_ctrl()
			
func motion_ctrl() -> void:
	$AnimatedSprite2D.scale.x = direction
	
	if not $AnimatedSprite2D/RayCast2D.is_colliding() or is_on_wall():
		direction *= -1
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()

func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$AnimatedSprite2D.play("death")
		$CollisionShape2D.set_deferred("disabled",true)
		gravity = 0
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and health > 0:
		body.damage_ctrl()
		
		
