extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const PROYECTIL = preload("res://Escenas/proyectil.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") 
var death : bool = false

@export var gui : CanvasLayer

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	# Decidir dirección del sprite
	if direction != 0:
		$AnimatedSprite2D.flip_h = (direction == -1)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction == -1:
		velocity.x = direction * SPEED
			
	elif direction == 1:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	if !$AttackColdown.is_stopped():
		$TextureProgressBar.show()
		$TextureProgressBar.value = ($AttackColdown.wait_time - $AttackColdown.time_left) * (100 / $AttackColdown.wait_time)

	act_disparar()
	move_and_slide()
	act_animacio(direction)


#Funcion para las animaciones
func act_animacio(direction:int):
	if is_on_floor():
		if direction != 0:
			if $AttackColdown.is_stopped():
				anim.play("RunSword")
				
			else:
				anim.play("Run")
			
		else: 
			if $AttackColdown.is_stopped():
				anim.play("IdleSword")
				
			else:
				anim.play("Idle")
		
	else:
		if $AttackColdown.is_stopped():
			anim.play("JumpSword")
		
		else:
			anim.play("Jump")


#Funcion para disparar
func act_disparar():
	if Input.is_action_just_pressed("shoot") and $AttackColdown.is_stopped():
		$AttackColdown.start()
		$Disparar.play()
		var midisparo = PROYECTIL.instantiate()
		
		if ($AnimatedSprite2D.flip_h):
			midisparo.direccion_proyectil(-1)
			
		else:
			midisparo.direccion_proyectil(1)	
		
		get_parent().add_child(midisparo)
		midisparo.position = $Marker2D.global_position


func _on_attack_coldown_timeout():
	$TextureProgressBar.hide()
	
func death_ctrl():
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()

func damage_ctrl():
	Global.life -= 1
	
	if Global.life <= 0:
		death = true
		$AnimatedSprite2D.play("Death") 
	
	else:
		$AnimatedSprite2D.play("Hit")
		$Hit.play()
		

func _on_hit_point_body_entered(body):
	if body.name == "Cangrejo" and velocity.y >= 0:
		$Aplastar.play()
		body.damage_ctrl(1)
		velocity.y = -JUMP_VELOCITY * 0.75


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Death":
		gui.game_over()
