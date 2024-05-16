extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Variable para saber la ultima direccion que ha mirado el personaje true = derecha, left izquierda
var direccion = true 


func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	if direccion and direction == 0 and is_on_floor():
		anim.play("Idle")
		
	elif !direccion and direction == 0 and is_on_floor():
		anim.play("Idle left")
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if direction == 0 and direccion:
			anim.play("Jump")
			
		elif direction == 0 and !direccion:
			anim.play("Jump left")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction == -1:
		direccion = false
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.play("Run left")
		
		else:
			anim.play("Jump left")
			
	elif direction == 1:
		direccion = true
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.play("Run")
		
		else:
			anim.play("Jump")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
