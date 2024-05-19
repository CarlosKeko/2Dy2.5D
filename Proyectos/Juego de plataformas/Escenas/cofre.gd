extends Area2D

func _on_body_entered(body):
		if body.name == "PersonajePrincipal":
			$AnimatedSprite2D.play("open")
			$AudioStreamPlayer2D.play()
			Global.score += 500
			$CollisionShape2D.set_deferred("disabled", true)
		

func _on_audio_stream_player_2d_finished():
	queue_free()
