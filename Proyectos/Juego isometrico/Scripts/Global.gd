extends Node

const ESC_INICI:= preload("res://Scenes/menu.tscn")
const ESC_PRIMERNIVEL:= preload("res://Scenes/primer_nivel.tscn")
const TOWERS:= preload("res://Scenes/towerArcher1.tscn")
const ESC_ESTADISTICAS:= preload("res://Scenes/estadisticas.tscn")
const LUGARLIBRE:= 17
const TIEMPO = 300 #segundos contador
const PRECIOARCHER = 50
const PRECIOWIZARD = 100
const DEFAULTDINERO = 50
const DEFAULTVIDA = 100
const DEFAULTENEMIGOSELIMINADOS = 0
const DEFAULTFASE = 1

var dinero = DEFAULTDINERO
var vida = DEFAULTVIDA
var enemigosEliminados = DEFAULTENEMIGOSELIMINADOS
var tiempoRestante : int
var probabilidades = []
var vidaEnemigos = []
var coordenadas : Vector2i
var lugarValido := false
var numFase = DEFAULTFASE
var resultado = false

# metodes globals
func g_canvi_escena(nomEscenaAnar):
	if (nomEscenaAnar == "PrimerNivel"):
		get_tree().change_scene_to_packed(ESC_PRIMERNIVEL)
		
	elif (nomEscenaAnar == "Menu"):
		get_tree().change_scene_to_packed(ESC_INICI)
		
	elif (nomEscenaAnar == "Estadisticas"):
		get_tree().change_scene_to_packed(ESC_ESTADISTICAS)

		
func calcularFase():
	if tiempoRestante < (TIEMPO * 25) / 100:
		probabilidades = [0.1, 0.4, 0.5]
		vidaEnemigos = [[45, 60], [65, 100], [100, 120]]
		numFase = 4
	
	elif tiempoRestante < (TIEMPO * 50) / 100:
		probabilidades = [0.3, 0.5, 0.2]
		vidaEnemigos = [[35, 40], [45, 65], [75, 80]]
		numFase = 3
		
	elif tiempoRestante < (TIEMPO * 75) / 100:
		probabilidades = [0.5, 0.4, 0.1]
		vidaEnemigos = [[25, 30], [40, 60], [65, 70]]
		numFase = 2
		
	else:
		probabilidades = [0.7, 0.3, 0.0]
		vidaEnemigos = [[10, 15], [20, 25], [0, 0]]
		numFase = 1
