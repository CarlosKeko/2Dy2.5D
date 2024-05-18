extends Area2D

func _on_body_entered(body):
	if body.name == "PersonajePrincipal":
		$AnimatedSprite2D.play("Cogida")
		$Sonido.play()
		Global.score += 100
		$CollisionShape2D.set_deferred("disabled", true)

func _on_sonido_finished():
	queue_free()
