extends Area2D

@export var gui : CanvasLayer
@export var guiFinal : CanvasLayer

func _on_body_entered(body):
	$AudioStreamPlayer2D.play()
	gui.cambio_nivel()
		
