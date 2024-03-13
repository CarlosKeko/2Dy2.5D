extends Node2D

#Variables
var tiempo: float
var tiempoRestante: float
var contador: float
var segundos: float
var loop: bool

#Escenas
var escena_estadisticas = preload("res://Escenas/Estadisticas.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	tiempo = 3
	loop = true
	segundos = 1
	tiempoRestante = segundos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tiempoRestante -= delta
	
	if tiempoRestante <= 0:
		if loop:
			contador += 1
			tiempoRestante = segundos
			print ("La cantidad del timer es: " + str(contador) + " y el limite de tiempo es: " + str(tiempo))
			
			if contador == tiempo:
				loop = false
		
		else:
			print ("El timer ha acabado")
			get_tree().change_scene_to_packed(escena_estadisticas)
