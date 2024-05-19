extends Area2D

@export var impuls : float = 0

func _on_body_entered(body):
	if body.name == "PersonajePrincipal":
		$AnimatedSprite2D.play("jump")
		body.salta(impuls)
		$AudioStreamPlayer2D.play()

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")
