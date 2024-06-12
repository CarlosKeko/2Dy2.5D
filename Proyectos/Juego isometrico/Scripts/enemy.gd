class_name enemigo_nivel_1 extends CharacterBody2D

@export var speed = 300
var vida = 10 
var dinero = 10

func _ready():
	Global.calcularFase()
	var nivelEnemigo = elegirEnemigo()
	vida = randi_range(Global.vidaEnemigos[nivelEnemigo - 1][0], Global.vidaEnemigos[nivelEnemigo - 1][1])
	cambiarValores(nivelEnemigo)
	$ProgressBar.max_value = vida

func _process(delta):
	$ProgressBar.value = vida
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	if get_parent().get_progress_ratio() == 1:
		Global.vida -= 10
		queue_free()
		
	if vida <= 0:
		Global.dinero += dinero
		get_parent().get_parent().queue_free()

func elegirEnemigo():
	var probabilidadAcumulativa = []
	var total = 0.0
	
	for prob in Global.probabilidades:
		total += prob
		probabilidadAcumulativa.append(total)
	
	var rand = randf() * total
	
	for i in range(probabilidadAcumulativa.size()):
		if rand < probabilidadAcumulativa[i]:
			return i + 1
			
	return 1

func cambiarValores(nivelEnemigo):
	if nivelEnemigo == 1:
		$Sprite2D.texture = load("res://Assets/UFO/UFO(1).png")
		dinero = 10
		
	elif nivelEnemigo == 2:
		$Sprite2D.texture = load("res://Assets/UFO/UFO(4).png")
		dinero = 20
		
	elif nivelEnemigo == 3:
		$Sprite2D.texture = load("res://Assets/UFO/UFO(7).png")
		dinero = 30

func randi_range(min_value, max_value):
	return randi() % (max_value - min_value + 1) + min_value
