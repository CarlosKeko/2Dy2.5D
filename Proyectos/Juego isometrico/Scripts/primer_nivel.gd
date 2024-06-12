class_name mapa extends TileMap

@onready var towerArcher = preload("res://Scenes/towerArcher1.tscn")
@onready var towerWizard = preload("res://Scenes/towerWizard1.tscn")

var cords = null
var torrePuesta = false
var torresColocadas = []
var torreSeleccionada = null
var cordsActualTower = null
var panelAbierto = false
var vidaAnterior = null

# En el metodo ready ocultaremos la interfaz y pondremos todos los timers y la vida apunto para empezar la partida
func _ready():
	$Interfaz/Panel3/TimerNotificacion.wait_time = 2
	$Interfaz/Panel3.hide()
	$Interfaz/Panel.hide()
	$Interfaz/Panel2/Timer.wait_time = Global.TIEMPO
	$Interfaz/Panel2/Timer.start()
	$Interfaz/Panel2/Vida.max_value = Global.vida
	vidaAnterior = Global.vida
	
# Aquin actualizaremos los valores como la vida, dinero y contadores, tambien reproduciremos sonido y comprobaremos
# que la vida no nos llegue a 0 y tengamos que acabar la partida. Tambien comprobaremos si el jugador clica sobre
# una casilla para colocar una torre
func _process(delta):
	$Interfaz/Panel2/Vida.value = Global.vida
	$Interfaz/Panel2/Dinero.text = str(Global.dinero) + " $"
	$Interfaz/Panel2/Contador.text = "%d:%02d" % [floor($Interfaz/Panel2/Timer.time_left / 60), int($Interfaz/Panel2/Timer.time_left) % 60]
	Global.tiempoRestante = $Interfaz/Panel2/Timer.time_left
	
	if Global.vida != vidaAnterior:
		$DamageRecibido.play()
		vidaAnterior = Global.vida
	
	if Global.vida == 0:
		Global.resultado = false
		Global.g_canvi_escena("Estadisticas")
		
	if Global.tiempoRestante == 0:
		Global.resultado = true
		Global.g_canvi_escena("Estadisticas")		
	
	if Input.is_action_just_pressed("Click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = local_to_map(mouse_pos)
		var idCela = get_cell_source_id(0, tile_mouse_pos, false)
		var idCelaSuperior = get_cell_source_id(1, tile_mouse_pos, false)
		cords = mouse_pos
		torrePuesta = idCelaSuperior != -1
		ponerTorre(idCela, tile_mouse_pos, mouse_pos)

# Esta funcion recibe diferentes parametros para ver si es un lugar valido y mostrar la interfaz correspondiente
func ponerTorre(idCela, tile_mouse_pos, mouse_pos):
	if idCela == Global.LUGARLIBRE:
		Global.lugarValido = true
		Global.coordenadas = tile_mouse_pos
		$Interfaz/Panel.show()
		if !torrePuesta:
			$Interfaz/Panel/FlowContainer/PanelArcher1.show()
			$Interfaz/Panel/FlowContainer/PanelWizard1.show()
			$Interfaz/Panel/Mejorar.hide()
			$Interfaz/Panel/Vender.hide()
	
	else:
		Global.lugarValido = false
		panelAbierto = false
		$Interfaz/Panel.hide()

# Si pulsamos sobre el boton de colocar torreta se ejecutara estaa funcion, la cual creara un hijo torreta y lo 
# colocara, despues en el tilemap tambien se colocara y se ocultara el sprite del hijo para que solo quede lo demas
func _on_panel_archer_1_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			if Global.PRECIOARCHER <= Global.dinero:
				set_cell(1, Global.coordenadas, 22, Vector2i(0, 0))
				var new_tower = towerArcher.instantiate()
				new_tower.scale = Vector2(1, 1)
				$Towers.add_child(new_tower)
				new_tower.global_position = map_to_local(Global.coordenadas)
				new_tower.hide()
				torresColocadas.append(new_tower)
				Global.dinero -= Global.PRECIOARCHER
				$construir.play()				
				
			else:
				$Interfaz/Panel3/TimerNotificacion.start()
				$Interfaz/Panel3.show()

# Si pulsamos sobre el boton de colocar torreta se ejecutara esta funcion, la cual creara un hijo torreta y lo 
# colocara, despues en el tilemap tambien se colocara y se ocultara el sprite del hijo para que solo quede lo demas
func _on_panel_wizard_1_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			if Global.PRECIOWIZARD <= Global.dinero:
				set_cell(1, Global.coordenadas, 5, Vector2i(0, 0))
				var new_tower = towerWizard.instantiate()
				new_tower.scale = Vector2(1, 1)
				$Towers.add_child(new_tower)
				new_tower.global_position = map_to_local(Global.coordenadas)
				new_tower.hide()
				torresColocadas.append(new_tower)
				Global.dinero -= Global.PRECIOWIZARD
				$construir.play()
				
			else:
				$Interfaz/Panel3/TimerNotificacion.start()
				$Interfaz/Panel3.show()

# Esta funcion detecta si clicamos sobre el mapa en una torreta, nos comprueba gracias a un bucle si la coordenada
# que estamos pulsando hay una torreta, despues nos muestra la interfaz correspondiente
func _input(event):
	var encontrado = false
	
	if event is InputEventMouseButton and event.button_mask == 1:
		for i in torresColocadas:
			if local_to_map(get_global_mouse_position()) == local_to_map(i.global_position):
				torreSeleccionada = i
				cordsActualTower = local_to_map(i.global_position)
				encontrado = true
				
		if encontrado:
				$Interfaz/Panel.show()
				$Interfaz/Panel/FlowContainer/PanelArcher1.hide()
				$Interfaz/Panel/FlowContainer/PanelWizard1.hide()
				$Interfaz/Panel/Mejorar.show()
				
				if !torreSeleccionada.torreMejorable():
					$Interfaz/Panel/Mejorar.text = "MAXIMO"
				
				else:
					$Interfaz/Panel/Mejorar.text = "Mejorar: " + str(torreSeleccionada.obtenerPrecioMejora()) + "$"
				
				$Interfaz/Panel/Vender.show()
				$Interfaz/Panel/Vender.text = "Vender: " + str(torreSeleccionada.obtenerPrecioVender()) + "$"
				panelAbierto = true

# Esta funcion mejora la torre y modifica el tile correspondiente, despues llama a la funcion subirTorre() del hijo
func mejorarTorre(currTower, pos):
	if currTower is towerArcher1:
		if get_cell_source_id(1, pos, false) == 22:
			set_cell(1, pos, 11, Vector2i(0, 0))
			currTower.subirTorre()
			
		elif get_cell_source_id(1, pos, false) == 11:
			set_cell(1, pos, 12, Vector2i(0, 0))
			currTower.subirTorre()
			
		elif get_cell_source_id(1, pos, false) == 5:
			set_cell(1, pos, 23, Vector2i(0, 0))
			currTower.subirTorre()
			
		elif get_cell_source_id(1, pos, false) == 23:
			set_cell(1, pos, 24, Vector2i(0, 0))
			currTower.subirTorre()
			
# Funcion para vender la torre y liberar el tile correspondiente
func venderTorre(currTower, pos):
	Global.dinero += currTower.obtenerPrecioVender()
	currTower.queue_free()
	set_cell(1, pos, -1, Vector2i(0, 0))
	torresColocadas.erase(currTower)

# Funcion para mejorar la torre al pulsar el boton, si no tenemos dinero nos notificara
func _on_mejorar_button_down():
	if panelAbierto and torreSeleccionada.torreMejorable():
		if torreSeleccionada.obtenerPrecioMejora() > Global.dinero:
			$Interfaz/Panel3/TimerNotificacion.start()
			$Interfaz/Panel3.show()
			
		else:
			mejorarTorre(torreSeleccionada, cordsActualTower)

# Boton para vender la torre
func _on_vender_button_down():
	if panelAbierto:
		venderTorre(torreSeleccionada, cordsActualTower)

func _on_timer_notificacion_timeout():
	$Interfaz/Panel3.hide()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
