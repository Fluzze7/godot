extends CharacterBody2D
class_name Player

var axis : Vector2 = Vector2.ZERO
var death : bool = false

var on_platform = false


@export_category(" Config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 128
@export var gravity : int = 16
@export var jump : int = 368

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()
	if on_platform:
		global_position += GLOBAL.platform_position



func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)


func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()


func motion_ctrl() -> void:
	if not get_axis().x == 0:
		$Sprite.scale.x = get_axis().x
	
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	
	move_and_slide()
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$Sprite.play("run")
			else:
				$Sprite.play("idle")
		false:
			if velocity.y < 0:
				$Sprite.play("jump")
			else:
				$Sprite.play("fall")


func death_ctrl() -> void:
	velocity.x = 0 
	velocity.y += gravity 
	move_and_slide()

func jump_ctrl(power : float) -> void:
	velocity.y = -jump * power
	$Audio/Jump.play()


func damage_ctrl() -> void:
	death = true
	$Sprite.play("death")



func _on_hit_point_body_entered(body):
	if  "enemy" in body.name and velocity.y >= 0:
		$Audio/Hit.play()
		body.damage_ctrl(1)
		jump_ctrl(0.75)



func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "death":
		gui.game_over()


func _on_platform_body_entered(_body: Node2D) -> void:
	on_platform = true


func _on_platform_body_exited(_body: Node2D) -> void:
	on_platform = false
