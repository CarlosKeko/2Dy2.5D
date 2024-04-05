extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.partidaCompletada:
		if Global.g_punts_1 > Global.g_punts_2:
			$Guanyador.text = "Guanyador jugador A"
			
		elif Global.g_punts_1 < Global.g_punts_2:
			$Guanyador.text = "Guanyador jugador B"
		
		else: 
			$Guanyador.text = "Es un empat"
		
		$Punts.text = str("Punts jugador A: ", Global.g_punts_1, " - Punts jugador B: ", Global.g_punts_2)
		$Caramboles.text = str("Caramboles jugador A: ", Global.g_caramboles_1, " - Caramboles jugador B: ", Global.g_caramboles_2)
		
		$Guanyador.show()
		$Caramboles.show()
		$Punts.show()
		Global.partidaCompletada = false
	
	else:
		$Guanyador.hide()
		$Caramboles.hide()
		$Punts.hide()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_pressed():
	Global.g_canvi_escena("Inicio")


func _on_exit_pressed():
	get_tree().quit()
