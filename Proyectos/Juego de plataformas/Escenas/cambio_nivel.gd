extends CanvasLayer

func cambio_nivel():
	Global.nivelActual += 1
	get_tree().paused = true
	if Global.nivelActual >= 3:
		$ColorRect/HBoxContainer2/Label.text = "¡FELICIDADES HAS COMPLETADO EL JUEGO!"
		$ColorRect/HBoxContainer/SiguienteNivel.text = "Menu princiapl"
		$ColorRect/HBoxContainer3/Puntuacion.text = "Has terminado con una puntuacion de: " + str(Global.score)
		$ColorRect/HBoxContainer/SiguienteNivel.grab_focus()
		$AudioStreamPlayer2D2.play()

		
	else:
		$ColorRect/HBoxContainer3/Puntuacion.text = "SCORE ACTUAL: " + str(Global.score)
		$ColorRect/HBoxContainer/SiguienteNivel.grab_focus()
		$AudioStreamPlayer2D.play()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0.8), 1.0)
	


func _on_siguiente_nivel_pressed():
	if Global.nivelActual == 1:
		Global.g_canvi_escena("SegundoNivel")
		Global.nivelActual += 1
		
	elif Global.nivelActual == 2:
		Global.g_canvi_escena("TercerNivel")
		
	elif Global.nivelActual >= 3:
		Global.nivelActual = 1
		Global.life = 3
		Global.score = 0
		Global.g_canvi_escena("Menu")
