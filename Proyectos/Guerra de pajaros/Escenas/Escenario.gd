extends Node2D

#Escenas
var pajaroJugador = preload("res://Escenas/PajaroJugador.tscn")
var pajaroOrdenador = preload("res://Escenas/PajaroOrdenador.tscn")
var escena_estadisticas = preload("res://Escenas/Estadisticas.tscn")
var pajaroEnemigo = null
var pajaro = null
var destrozandoPajaros = false
var primeraVez = true
var puntos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerMaquina.wait_time = Global.TIEMPO_PAJARO
	$TimerPajaro.wait_time = Global.TIEMPO_PAJARO
	$Timer.wait_time = Global.TIEMPO
	$Timer.start()
	pajaro = pajaroJugador.instantiate()
	add_sibling(pajaro)
	pajaro.global_position = Vector2(50, 50)
	pajaro.contact_monitor = true
	pajaro.max_contacts_reported = 1
	$Puntos.text = str("Puntos: ", Global.puntos)
	
	pajaroEnemigo = pajaroOrdenador.instantiate()
	add_sibling(pajaroEnemigo)
	pajaroEnemigo.global_position = Vector2(1100, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Contador.text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]
	
	if $TimerMaquina.is_stopped():
		$TimerMaquina.start()

	if (!destrozandoPajaros):
		if (pajaro.get_contact_count() > 0):
			if (!primeraVez): 
				destrozandoPajaros = true
				pajaro.queue_free()
				pajaroEnemigo.queue_free()
				Global.puntos += 1
				$Puntos.text = str("Puntos: ", Global.puntos)
			else:
				primeraVez = false
		
	
	
#Tiempo contador de partida
func _on_timer_timeout():
	destrozandoPajaros = true
	primeraVez = true
	get_tree().change_scene_to_packed(escena_estadisticas)
	
func _input(event:InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and $TimerPajaro.is_stopped():
			$TimerPajaro.start()

func _on_timer_pajaro_timeout():
	pajaro = pajaroJugador.instantiate()
	add_sibling(pajaro)
	pajaro.global_position = Vector2(50, 50)
	pajaro.contact_monitor = true
	pajaro.max_contacts_reported = 1
	destrozandoPajaros = false
	$TimerPajaro.stop()

func _on_timer_maquina_timeout():
	pajaroEnemigo = pajaroOrdenador.instantiate()
	add_sibling(pajaroEnemigo)
	pajaroEnemigo.global_position = Vector2(1100, 50)




