extends CanvasLayer

func cambio_nivel():
	$ColorRect/HBoxContainer3/Puntuacion.text = "SCORE ACTUAL: " + str(Global.score)
	get_tree().paused = true
	$ColorRect/HBoxContainer/SiguienteNivel.grab_focus()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0.8), 1.0)
	
	$AudioStreamPlayer2D.play()

func _on_siguiente_nivel_pressed():
	if Global.nivelActual == 1:
		Global.g_canvi_escena("SegundoNivel")
		Global.nivelActual += 1
		
	elif Global.nivelActual == 2:
		Global.g_canvi_escena("TercerNivel")
