extends Node # Script global (Autoload) En aquest cas no cal class_name

const ESC_INICI:= preload("res://Escenas/Inicio.tscn")
const ESC_BILLAR:= preload("res://Escenas/Billar.tscn")
const ESC_BOLA:= preload("res://Escenas/Bola.tscn")

# variables globals del joc
var partidaCompletada = false
var _jugadorAct = "A"
var max_tiradas = 10
var power = 0.0
var max_power = 2
var tiradas_1: int
var tiradas_2: int
var g_caramboles_1:int # nombre de caramboles jugador 1
var g_punts_1:int # nombre de punts jugador 1
var g_caramboles_2:int # nombre de caramboles jugador 2
var g_punts_2:int # nombre de punts jugador 2

# metodes globals
func g_canvi_escena(nomEscenaActual):
	if (nomEscenaActual == "Inicio"):
		get_tree().change_scene_to_packed(ESC_BILLAR)
		
	elif (nomEscenaActual == "Billar"):
		get_tree().change_scene_to_packed(ESC_INICI)
