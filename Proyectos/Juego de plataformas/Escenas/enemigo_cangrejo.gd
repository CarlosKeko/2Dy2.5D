extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -300.0
const WALL_TIMER = 0.2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1 #Dirección en la que va el enemigo
var wall_time = 0
var is_dead = false

func _physics_process(delta):
	if !is_dead:
		$AnimatedSprite2D.play("Run")
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
		
		velocity.x = direction * SPEED
		
		if direction == 1:
			$AnimatedSprite2D.flip_h = true
			
		else:
			$AnimatedSprite2D.flip_h = false
			
		#Detectar cambio de direccion enemigo
		if is_on_wall() and wall_time >= WALL_TIMER:
			direction = direction * -1	
			wall_time = 0
			
		elif wall_time < WALL_TIMER:
			wall_time += delta
	
	
	
	move_and_slide()

func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite2D.play("Dead")
	$Collision.set_deferred("disabled", true)
	$DesaparicionEnemigo.start()


func _on_desaparicion_enemigo_timeout():
	queue_free()

func damage_ctrl(damage):
	dead()


func _on_area_2d_body_entered(body):
	if body.name == "PersonajePrincipal" and !is_dead:
		body.damage_ctrl()
