extends RigidBody2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if (get_contact_count() > 0):
	#print(str(get_colliding_bodies()))
	pass
	
func _input(event:InputEvent):
	$Timer.wait_time = Global.TIEMPO_PAJARO
	if event is InputEventMouseButton:
		if event.pressed and $Timer.is_stopped():
			freeze = false
			var mousePos:= get_viewport().get_mouse_position()
			apply_central_impulse(Vector2(mousePos.x, rng.randf_range(Global.ANGLE_MINIM, Global.ANGLE_MAXIM)))
			$Timer.start()

func _on_timer_timeout():
	$Timer.stop()
