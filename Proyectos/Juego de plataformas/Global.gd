extends Node

const ESC_INICI:= preload("res://Escenas/Inicio.tscn")
const ESC_PRIMERNIVEL:= preload("res://Escenas/primer_nivel.tscn")
const ESC_TUTORIAL:= preload("res://Escenas/tutorial.tscn")
const ESC_SEGUNDONIVEL:= preload("res://Escenas/segundo_nivel.tscn")
const ESC_TERCERNIVEL:= preload("res://Escenas/tercer_nivel.tscn")

var score = 0
var life = 3
var nivelActual = 1

# metodes globals
func g_canvi_escena(nomEscenaAnar):
	if (nomEscenaAnar == "PrimerNivel"):
		get_tree().change_scene_to_packed(ESC_SEGUNDONIVEL)
		
	elif (nomEscenaAnar == "Menu"):
		get_tree().change_scene_to_packed(ESC_INICI)
		
	elif (nomEscenaAnar == "Tutorial"):
		get_tree().change_scene_to_packed(ESC_TUTORIAL)
		
	elif nomEscenaAnar == "SegundoNivel":
		get_tree().change_scene_to_packed(ESC_SEGUNDONIVEL)
		
	elif nomEscenaAnar == "TercerNivel":
		get_tree().change_scene_to_packed(ESC_TERCERNIVEL)
		
