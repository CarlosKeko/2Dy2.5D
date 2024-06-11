class_name mapa extends TileMap

@onready var towerArcher = preload("res://Scenes/towerArcher1.tscn")
@onready var towerWizard = preload("res://Scenes/towerWizard1.tscn")

var cords = null
var torrePuesta = false
var torresColocadas = []
var torreSeleccionada = null
var cordsActualTower = null
var panelAbierto = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Interfaz/Panel.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = local_to_map(mouse_pos)
		var idCela = get_cell_source_id(0, tile_mouse_pos, false)
		var idCelaSuperior = get_cell_source_id(1, tile_mouse_pos, false)
		cords = mouse_pos
		torrePuesta = idCelaSuperior != -1
		ponerTorre(idCela, tile_mouse_pos, mouse_pos)

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
		

func _on_panel_archer_1_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			set_cell(1, Global.coordenadas, 22, Vector2i(0, 0))
			var new_tower = towerArcher.instantiate()
			new_tower.scale = Vector2(1, 1)
			$Towers.add_child(new_tower)
			new_tower.global_position = map_to_local(Global.coordenadas)
			new_tower.hide()
			torresColocadas.append(new_tower)

func _on_panel_wizard_1_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			set_cell(1, Global.coordenadas, 5, Vector2i(0, 0))
			var new_tower = towerWizard.instantiate()
			new_tower.scale = Vector2(1, 1)
			$Towers.add_child(new_tower)
			new_tower.global_position = map_to_local(Global.coordenadas)
			new_tower.hide()
			torresColocadas.append(new_tower)

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
				$Interfaz/Panel/Vender.show()
				panelAbierto = true
				#mejorarTorre(torreSeleccionada)
				

func mejorarTorre(currTower, pos):
	if currTower is towerArcher1:
		if get_cell_source_id(1, pos, false) == 22:
			set_cell(1, pos, 11, Vector2i(0, 0))
			currTower.mejorar()
			
		elif get_cell_source_id(1, pos, false) == 11:
			set_cell(1, pos, 12, Vector2i(0, 0))
			
		elif get_cell_source_id(1, pos, false) == 5:
			set_cell(1, pos, 23, Vector2i(0, 0))
			currTower.mejorar()
			
		elif get_cell_source_id(1, pos, false) == 23:
			set_cell(1, pos, 24, Vector2i(0, 0))

func venderTorre(currTower, pos):
	currTower.queue_free()
	set_cell(1, pos, -1, Vector2i(0, 0))
	torresColocadas.erase(currTower)

func _on_mejorar_button_down():
	if panelAbierto:
		mejorarTorre(torreSeleccionada, cordsActualTower)

func _on_vender_button_down():
	if panelAbierto:
		venderTorre(torreSeleccionada, cordsActualTower)
