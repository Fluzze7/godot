extends CharacterBody2D
class_name Player

var axis: Vector2 = Vector2.ZERO
var isdead = false
var SCORE  = 0
@export_category("Config")
@export_group("Required References")
@export var gui : CanvasLayer

@export_group("Motion")
@export var speed : int = 128
@export var gravity : int = 0
@export var jump : int = 368

func _process(delta: float) -> void:
	match isdead:
		true:
			death_ctrl()
		false:
			motion_ctrl()
			
func _input(event):
	if not isdead and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)
		
func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis.normalized()
	
func motion_ctrl() -> void:
	if not get_axis().x == 0:
		$Animations.scale.x = get_axis().x
		
	velocity.x = get_axis().x * speed
	velocity.y += gravity
	move_and_slide()
	
	
	match is_on_floor():
		true:
			if not get_axis().x == 0:
				$Animations.play("run")
			else:
				$Animations.play("idle")
		false:
			if velocity.y < 0:
				$Animations.play("jump")
			else:
				$Animations.play("fall")
				
				
				
func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()
	
	
func jump_ctrl(power: float) -> void:
	velocity.y = -jump*power
	$Audio/Jump.play()
	
func damage_ctrl() -> void:
	isdead = true
	$Animations.play("death")
	
func _on_hit_point_body_entered(body: Node2D) -> void:
	if body is Enemy and velocity.y >= 0:
		$Audio/Hit.play()
		body.damage(1)
		jump_ctrl(0.75)


func _on_animations_animation_finished() -> void:
	if $Animations.animation== "death":
		gui.game_over()
	
