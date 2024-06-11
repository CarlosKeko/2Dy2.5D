class_name mapa extends TileMap

@onready var towerArcher = preload("res://Scenes/towerArcher1.tscn")
@onready var towerWizard = preload("res://Scenes/towerWizard1.tscn")

var cords = null
var torrePuesta = false

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
		if torrePuesta:
			$Interfaz/Panel/FlowContainer/PanelArcher1.hide()
			$Interfaz/Panel/FlowContainer/PanelWizard1.hide()
			$Interfaz/Panel/Mejorar.show()
			$Interfaz/Panel/Vender.show()
			
		else:
			$Interfaz/Panel/FlowContainer/PanelArcher1.show()
			$Interfaz/Panel/FlowContainer/PanelWizard1.show()
			$Interfaz/Panel/Mejorar.hide()
			$Interfaz/Panel/Vender.hide()
	
	else:
		Global.lugarValido = false
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

func _on_panel_wizard_1_gui_input(event):
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			set_cell(1, Global.coordenadas, 5, Vector2i(0, 0))
			var new_tower = towerWizard.instantiate()
			new_tower.scale = Vector2(1, 1)
			$Towers.add_child(new_tower)
			new_tower.global_position = map_to_local(Global.coordenadas)
			new_tower.hide()
