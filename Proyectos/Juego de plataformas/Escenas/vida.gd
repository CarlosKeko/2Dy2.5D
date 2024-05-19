extends Area2D

func _on_body_entered(body):
	if body.name == "PersonajePrincipal" and Global.life < 3:
		$AnimatedSprite2D.play("efecto")
		$AudioStreamPlayer2D.play()
		Global.life += 1
		$CollisionShape2D.set_deferred("disabled", true)

func _on_sonido_finished():
	queue_free()
	$AnimatedSprite2D.stop()
