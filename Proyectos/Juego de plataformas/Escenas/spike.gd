extends Area2D

func _on_body_entered(body):
	if body.name == "PersonajePrincipal":
		body.damage_ctrl()
		body.pinchado()
