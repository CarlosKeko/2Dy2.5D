extends Area2D

var Speed = 170
var velocity = Vector2()
var dir_proyec = 1
var proyectilMuerto = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!proyectilMuerto):
		velocity.x = Speed * delta * dir_proyec
		translate(velocity)
		$AnimatedSprite2D.play("Tirar")


func _on_visible_on_screen_notifier_2d_screen_exited():
	$Timer.start()
	
func direccion_proyectil(dir):
	dir_proyec = dir
	$AnimatedSprite2D.flip_h = (dir == -1)


func _on_body_entered(body):
	if body.name != "PersonajePrincipal":
		proyectilMuerto = true
		$AnimatedSprite2D.play("AirAttack2")
		
		if body is CharacterBody2D:
			body.dead()
			$ImpactoEnemigo.play()

		else:
			$ImpactoPared.play()
			

func _on_timer_timeout():
	queue_free()

func _on_impacto_enemigo_finished():
	queue_free()

func _on_impacto_pared_finished():
	queue_free()
