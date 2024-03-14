extends RigidBody2D

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = Global.TIEMPO_PAJARO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Timer.is_stopped():
		freeze = false
		apply_central_impulse(Vector2(rng.randf_range(Global.IMPULSO_MINIMO, Global.IMPULSO_MAXIMO), rng.randf_range(Global.ANGLE_MINIM, Global.ANGLE_MAXIM)))
		$Timer.start()


func _on_timer_timeout():
	$Timer.stop()
