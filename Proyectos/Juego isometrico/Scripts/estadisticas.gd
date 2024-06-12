extends Control


# Called when the node enters the scene tree for the first time.
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
