extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.tiradas_1 = Global.max_tiradas
	Global.tiradas_2 = Global.max_tiradas
	Global.g_caramboles_1 = 0
	Global.g_caramboles_2 = 0
	Global.g_punts_1 = 0
	Global.g_punts_2 = 0
	$TurnoJugador.text = str("Turno jugador: ", Global._jugadorAct)
	$TiradasA.text = str("Tiros jugador A: ", Global.tiradas_1)
	$TiradasB.text = str("Tiros jugador B: ", Global.tiradas_2)
	$PuntsA.text = str("Puntos jugador A: ", Global.g_punts_1)
	$PuntsB.text = str("Puntos jugador B: ", Global.g_punts_2)
	$CarambolesA.text = str("Caramboles jugador A: ", Global.g_caramboles_1)
	$CarambolesB.text = str("Caramboles jugador B: ", Global.g_caramboles_2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$TurnoJugador.text = str("Turno jugador: ", Global._jugadorAct)
	$TiradasA.text = str("Tiros jugador A: ", Global.tiradas_1)
	$TiradasB.text = str("Tiros jugador B: ", Global.tiradas_2)
	$PuntsA.text = str("Puntos jugador A: ", Global.g_punts_1)
	$PuntsB.text = str("Puntos jugador B: ", Global.g_punts_2)
	$CarambolesA.text = str("Caramboles jugador A: ", Global.g_caramboles_1)
	$CarambolesB.text = str("Caramboles jugador B: ", Global.g_caramboles_2)
	
