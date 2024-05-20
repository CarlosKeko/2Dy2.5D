extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Start.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_start_pressed():
	Global.g_canvi_escena("PrimerNivel")


func _on_tutorial_pressed():
	Global.g_canvi_escena("Tutorial")


func _on_exit_pressed():
	get_tree().quit()
