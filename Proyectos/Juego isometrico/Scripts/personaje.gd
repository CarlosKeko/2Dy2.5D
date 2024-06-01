class_name Personaje extends CharacterBody2D

const JUMP_VELOCITY = -400.0

@export var speed = 100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	move(delta)
	move_and_slide()
	
	
	
	
func move(delta):
	var direction = Input.get_vector("izquierda", "derecha", "arriba", "abajo")

	if direction:
		direction = Personaje.cart_to_iso(direction)
		velocity = direction * speed
		print(str(direction))
		$AnimatedSprite2D.play("Run")
		
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("Idle")
		
		
static func cart_to_iso(dir:Vector2) -> Vector2:
	return Vector2(dir.x-dir.y, (dir.x+dir.y)/2)

	#if Input.is_action_just_pressed("derecha"):
		
	
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
