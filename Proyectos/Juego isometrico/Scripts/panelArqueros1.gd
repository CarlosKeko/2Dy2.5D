extends Panel

@onready var tower = preload("res://Scenes/towerArcher1.tscn")
var tile

func _on_gui_input(event):
	var tempTower = tower.instantiate()
	
	if event is InputEventMouseButton and event.button_mask == 1:
		if Global.lugarValido:
			add_child(tempTower)
			var path = get_tree().get_root().get_node("Primer_nivel/Towers")
			path.add_child(tempTower)
			tempTower.global_position = Global.coordenadas
			print("valido")
			
		else:
			print("Invalido")
