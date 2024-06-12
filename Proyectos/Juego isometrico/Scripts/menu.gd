extends Control

func _on_start_pressed():
	Global.dinero = Global.DEFAULTDINERO
	Global.vida = Global.DEFAULTVIDA
	Global.enemigosEliminados = Global.DEFAULTENEMIGOSELIMINADOS
	Global.numFase = Global.DEFAULTFASE
	Global.g_canvi_escena("PrimerNivel")


func _on_exit_pressed():
	get_tree().quit()


func _on_background_finished():
	$Background.play()

