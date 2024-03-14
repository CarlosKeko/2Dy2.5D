extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = str("Puntos ganados: ", Global.puntos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Global.puntos = 0
	var cambiar_escena = load("res://Escenas/Escenario.tscn")
	get_tree().change_scene_to_packed(cambiar_escena)


func _on_button_2_pressed():
	get_tree().quit()
