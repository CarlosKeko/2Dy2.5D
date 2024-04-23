extends Node

const ESC_MENU:= preload("res://Escenas/Menu.tscn")
const ESC_TAULER:= preload("res://Escenas/Tauler.tscn")
const ESC_TUTORIAL:= preload("res://Escenas/Tutorial.tscn")
#const ESC_BOLA:= preload("res://Escenas/Bola.tscn")

# metodes globals
func g_canvi_escena(nomEscenaAnar):
	if (nomEscenaAnar == "Tutorial"):
		get_tree().change_scene_to_packed(ESC_TUTORIAL)
		
	elif (nomEscenaAnar == "Tauler"):
		get_tree().change_scene_to_packed(ESC_TAULER)
		
	elif (nomEscenaAnar == "Menu"):
		get_tree().change_scene_to_packed(ESC_MENU)
