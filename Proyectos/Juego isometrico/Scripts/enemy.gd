class_name enemigo_nivel_1 extends CharacterBody2D

@export var speed = 300
var vida = 10 
var dinero = 10

# En la funcion ready calculamos la fase de la partida para poder calcular el nivel del enemigo que sacaremos
# con esto calculamos, la vida que tendra y el dinero. Tambien ponemos la barra de vida del enemigo en su punto
func _ready():
	Global.calcularFase()
	var nivelEnemigo = elegirEnemigo()
	vida = randi_range(Global.vidaEnemigos[nivelEnemigo - 1][0], Global.vidaEnemigos[nivelEnemigo - 1][1])
	cambiarValores(nivelEnemigo)
	$ProgressBar.max_value = vida

# En el proces vamos actualizando la barra de vida del enemigo. Tambien vamos avanzando al enemigo por la ruta
# despues si llega al final de la ruta desaparaece y nos resta vida. Si la vida del enemigo llega a 0 se eliminara
# nos dara dinero y puntuacion
func _process(delta):
	$ProgressBar.value = vida
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	if get_parent().get_progress_ratio() == 1:
		Global.vida -= 10
		queue_free()
		
	if vida <= 0:
		Global.enemigosEliminados += 1
		Global.dinero += dinero
		get_parent().get_parent().queue_free()

# Esta funcion la usamos para elegir al tipo de enemigo, usamos la probabilidad acumulativa y calculamos con rand
# que tipo de enemigo saldra, nos devolvera uno de los tipo de enemigos y si falla nos devolvera 1, de 1 a 3 segun
# el tipo que salga. Cada numero representa uno diferente
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

# Esta funcion nos permite cambiar los valores del enemigo, la textura y el dinero que nos daa
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

# Esta funcion nos permite elegir un valor entre un minimo y un maximo aleatoriamente
func randi_range(min_value, max_value):
	return randi() % (max_value - min_value + 1) + min_value

