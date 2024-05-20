extends CanvasLayer


func final_de_juego():
	get_tree().paused = true
	$Colorete/HBoxContainer2/Label.text = "Has terminado con una puntuacion de: " + str(Global.score)
	$Colorete/HBoxContainer3/menuPrincipal.grab_focus()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($Colorete, "modulate", Color(1, 1, 1, 0.8), 1.0)

	$AudioStreamPlayer2D.play()


func _on_menu_principal_pressed():
	Global.g_canvi_escena("Menu")
