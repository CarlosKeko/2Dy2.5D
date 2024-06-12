extends Node

const TOWERS:= preload("res://Scenes/towerArcher1.tscn")
const LUGARLIBRE:= 17
const TIEMPO = 300 #segundos contador
const PRECIOARCHER = 50
const PRECIOWIZARD = 100

var dinero = 200
var vida = 100
var enemigosEliminados = 0
var tiempoRestante : int
var probabilidades = []
var vidaEnemigos = []

var coordenadas : Vector2i
var lugarValido := false
var numFase = 1

func calcularFase():
	if tiempoRestante < (TIEMPO * 25) / 100:
		probabilidades = [0.1, 0.4, 0.5]
		vidaEnemigos = [[25, 30], [35, 40], [40, 45]]
		numFase = 4
	
	elif tiempoRestante < (TIEMPO * 50) / 100:
		probabilidades = [0.3, 0.5, 0.2]
		vidaEnemigos = [[20, 25], [30, 35], [35, 40]]
		numFase = 3
		
	elif tiempoRestante < (TIEMPO * 75) / 100:
		probabilidades = [0.5, 0.4, 0.1]
		vidaEnemigos = [[15, 20], [25, 30], [30, 35]]
		numFase = 2
		
	else:
		probabilidades = [0.7, 0.3, 0.0]
		vidaEnemigos = [[10, 15], [20, 25], [0, 0]]
		numFase = 1
