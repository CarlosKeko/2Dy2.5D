class_name Billar extends Node2D

var _bolaActiva = null #La bola del jugador que tira
var _iniVector: Vector2
var _fiVector: Vector2
var _estat: int #maquina d'estats
var bolasMoviendose : bool
var _estatCarambola : int
var toquesTaula : int
var nomPrimeraBola : String
var esperandoTurno : bool
var primeraVez : bool
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$BolaGroga.global_position = Vector2(rng.randf_range(100, 1075), rng.randf_range(100, 575))
	$BolaVerda.global_position = Vector2(rng.randf_range(100, 1075), rng.randf_range(100, 575))
	$BolaVermella.global_position = Vector2(rng.randf_range(100, 1075), rng.randf_range(100, 575))	
	primeraVez = false
	esperandoTurno = false
	nomPrimeraBola = ""
	toquesTaula = 0
	_estatCarambola = 0
	_bolaActiva = $BolaGroga
	Global._jugadorAct = "A"
	_estat = 1
	bolasMoviendose = false
	$Tempus.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Global.tiradas_1 <= 0 && Global.tiradas_2 <= 0):
		Global.partidaCompletada = true
		Global.g_canvi_escena("Billar")
	
	if !bolasMoviendose:
		if primeraVez:
			cambiar_turno()
			primeraVez = false
			
		$ProgressBar.position.x = _bolaActiva.position.x - (0.5 * $ProgressBar.size.x)
		$ProgressBar.position.y = _bolaActiva.position.y + $ProgressBar.size.y
		$ProgressBar.show()
		$ProgressBar.value = Global.power * (100 / Global.max_power)
		$Pal.position = _bolaActiva.position
		$Pal.show()
		esperandoTurno = false
		
	else:
		$ProgressBar.hide()
		$Pal.hide()
		primeraVez = true
	
	if $BolaGroga.linear_velocity.length() >= 1 || $BolaVermella.linear_velocity.length() >= 1 || $BolaVerda.linear_velocity.length() >= 1:
		bolasMoviendose = true
		
	else:
		bolasMoviendose = false

func _on_pal_shoot(power):
	#print(power)
	if (!bolasMoviendose):
		_bolaActiva.apply_central_impulse(power)


func cambiar_turno():
	if !esperandoTurno:
		calcularPuntuacion()
		if Global._jugadorAct == "A":
			Global.tiradas_1 -= 1
			Global._jugadorAct = "B"
			_bolaActiva = $BolaVerda
			
		else:
			Global.tiradas_2 -= 1
			Global._jugadorAct = "A"
			_bolaActiva = $BolaGroga
		
		esperandoTurno = true

func calcularPuntuacion():
	if _estatCarambola >= 3 && Global._jugadorAct == "A":
		Global.g_caramboles_1 += 1
		
		if toquesTaula == 1:
			Global.g_punts_1 += 3
			
		elif toquesTaula > 1:
			Global.g_punts_1 += 5
	
	elif _estatCarambola >= 3 && Global._jugadorAct == "B":
		Global.g_caramboles_2 += 2
		
		if toquesTaula == 1:
			Global.g_punts_2 += 3
			
		elif toquesTaula > 1:
			Global.g_punts_2 += 5
			
	_estatCarambola = 0
	nomPrimeraBola = ""
	toquesTaula = 0

func _on_bola_verda_body_entered(body):
	if Global._jugadorAct == "B":
		if _estatCarambola == 0:
			if body.name == $Mesa.name && toquesTaula == 0:
				toquesTaula += 1
				_estatCarambola += 1
				print("Carambola 1 Verde")
				
			elif body.name == $BolaVermella.name || body.name == $BolaGroga.name:
				_estatCarambola += 1
				nomPrimeraBola = body.name
				print("Carambola 1 Verde")
		
		if _estatCarambola == 1:
			if toquesTaula == 0 && body.name == $Mesa.name:
				toquesTaula += 1
				_estatCarambola += 1
				print("Carambola 2 Verde")
			
			elif toquesTaula >= 1 && body.name == $BolaVermella.name || toquesTaula >= 1 && body.name == $BolaGroga.name:
				_estatCarambola += 1
				nomPrimeraBola = body.name
				print("Carambola 2 Verde")
				
		if _estatCarambola == 2:
			if nomPrimeraBola != body.name && body.name != $Mesa.name && toquesTaula >= 1:
				_estatCarambola += 1
				print("Carambola level 3 verde")

func _on_bola_groga_body_entered(body):
	if Global._jugadorAct == "A":
		if _estatCarambola == 0:
			if body.name == $Mesa.name && toquesTaula == 0:
				toquesTaula += 1
				_estatCarambola += 1
				print("Carambola 1 Amarillo")
				
			elif body.name == $BolaVermella.name || body.name == $BolaVerda.name:
				_estatCarambola += 1
				nomPrimeraBola = body.name
				print("Carambola 1 Amarillo")
		
		if _estatCarambola == 1:
			if toquesTaula == 0 && body.name == $Mesa.name:
				toquesTaula += 1
				_estatCarambola += 1
				print("Carambola 2 Amarillo")
			
			elif toquesTaula >= 1 && body.name == $BolaVermella.name || toquesTaula >= 1 && body.name == $BolaVerda.name:
				_estatCarambola += 1
				nomPrimeraBola = body.name
				print("Carambola 2 Amarillo")
				
		if _estatCarambola == 2:
			if nomPrimeraBola != body.name && body.name != $Mesa.name && toquesTaula >= 1:
				_estatCarambola += 1
				print("Carambola level 3 amarillo")
