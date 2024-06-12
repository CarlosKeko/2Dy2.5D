extends Control


# La funcion ready nos pondra si hemos ganado o perdido en una label y modifacara el resto con el dinero ganado
# y los enemigos eliminados
func _ready():
	if Global.resultado:
		$MarginContainer/Resultado.text = "¡VICTORIA!"
	
	else:
		$MarginContainer/Resultado.text = "DERROTA :("
		
	$VBoxContainer/DineroGanado.text = "Dinero    final:   " + str(Global.dinero) + "$"
	$VBoxContainer/EnemigosEliminados.text = "Enemigos    eliminados:   " + str(Global.enemigosEliminados)


func _on_menu_pressed():
	Global.g_canvi_escena("Menu")


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
