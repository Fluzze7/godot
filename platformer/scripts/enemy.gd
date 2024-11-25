extends CharacterBody2D
class_name Enemy

@export_category("Config")

@export_group("Options")
@export var health : int = 1
@export var score : int = 100
@export var spawned : bool = false

@export_group("Motion")
@export var speed : int = 16
@export var gravity : int = 16

var direction : int = 1

func _ready() -> void:
	if not spawned:
		$Sprite.play("not_spawned")
		
func _process(_delta):
	if health > 0 and spawned:
		motion_ctrl()


func motion_ctrl() -> void:
	$".".scale.x = direction
	if not $Sprite/RayGround.is_colliding() or is_on_wall():
		direction *= -1
	
	velocity.x = direction * speed
	velocity.y += gravity
	move_and_slide()

func damage_ctrl(damage : int) -> void:
	health -= damage
	
	if health <= 0:
		$Sprite.play("death")
		$CollisionShape2D.set_deferred("disabled", true)
		gravity = 0
		GLOBAL.enemies += 1


func _on_sprite_animation_finished():
	if $Sprite.animation == "death":
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player" and health > 0:
		body.damage_ctrl()

func _on_spawnear_body_entered(body: Node2D) -> void:
	if not spawned and body.name == "player":
		spawned = true
		$Sprite.play("spawn") 
		await $Sprite.animation_finished
		if health > 0:
			$Sprite.play("walk")
