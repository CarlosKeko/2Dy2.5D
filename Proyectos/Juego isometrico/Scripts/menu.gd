extends Control

# Funcion para que cuando acabe la musica de fondo, vuelva a empezar.
func _on_musica_finished():
	$Node/Musica.play()

# Boton para empezar el juego
func _on_start_pressed():
	Global.g_canvi_escena("PrimerNivel")

# Boton para salir del juego
func _on_exit_pressed():
	get_tree().quit()
