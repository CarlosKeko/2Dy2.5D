class_name towerArcher1 extends StaticBody2D 

var flecha = preload("res://Scenes/flecha.tscn")
var flechaDamage = 10
var pathName
var currTargets = []
var curr
var nivelActual = 1
var damageE1 = 10
var damageE2 = 20
var damageE3 = 30
var valorActual = 50
var precio = [50, 300, 500]
var mejorable = true
var incoldown = false

# En esta funcion calculamos el coldown de disparo para que no haya una metrelleta en la torreta. Despues ve
# en el container de flechaContainer si hay proyectiles, para que no se queden por mitad del mapa
func _process(delta):
	if incoldown:
		$DisparoColdown.show()
		$DisparoColdown.value = $Temporizador.time_left
	
	if is_instance_valid(curr):
		pass 
	
	else:
		for i in get_node("FlechaContainer").get_child_count():
			get_node("FlechaContainer").get_child(i).queue_free()

# Funcion para detectar cuando un enemigo entra en el rango de la torreta, creara un proyectil y lo disparara hacia el
# tambien iniciara el coldown de la torreta
func _on_area_2d_body_entered(body):
	if body is enemigo_nivel_1 and !incoldown:
		var tempArray = []
		currTargets = get_node("Area2D").get_overlapping_bodies()
		
		for i in currTargets:
			if "Enemy" in i.name:
				tempArray.append(i)
				
		var currentTarget = null
		
		for i in tempArray:
			if currentTarget == null:
				currentTarget = i.get_node("../")
			
			else:
				if i.get_parent().get_progress() > currentTarget.get_progress():
					currentTarget = i.get_node("../")
					
		curr = currentTarget
		pathName = currentTarget.get_parent().name
		
		var tempFlecha = flecha.instantiate()
		tempFlecha.pathName = pathName
		tempFlecha.flechaDamage = flechaDamage
		get_node("FlechaContainer").add_child(tempFlecha)
		tempFlecha.global_position = $Area.global_position
		$Temporizador.start()
		$DisparoColdown.max_value = $Temporizador.wait_time
		incoldown = true

# Funcion para dejar a los enemigos que salgan del alcance y que no se buguee el juego
func _on_area_2d_body_exited(body):
	currTargets = get_node("Area2D").get_overlapping_bodies()

# Funcion para subir de nivel la torre, esto cambiara los valores y se usara cuando lo llamemos desde el scrip 
# de nivel
func subirTorre():
	if nivelActual == 1:
		towerArcher2()
		nivelActual = 2
		valorActual = precio[nivelActual - 1]
		Global.dinero -= valorActual
		$Mejora.play()
		
	elif nivelActual == 2:
		towerArcher3()
		nivelActual = 3
		valorActual = precio[nivelActual - 1]
		mejorable = false
		Global.dinero -= valorActual
		$Mejora.play()

# Funcion para cambiar el damage de la flecha
func mejorar(damage):
	flechaDamage = damage

# Funcion para mejorar a 2
func towerArcher2():
	mejorar(damageE2)

# Funcion para mejorar a 3
func towerArcher3():
	mejorar(damageE3)

# Funcion para obtener el precio de la siguiente mejora
func obtenerPrecioMejora():
	return precio[nivelActual]
	
# Funcion para obtener el precio de venta de la torreta
func obtenerPrecioVender():
	return valorActual
	
# Funcion para obtener si la torreta es mejorable o no
func torreMejorable():
	return mejorable

# Funcion para saber cuando acaba el coldown
func _on_temporizador_timeout():
	incoldown = false
	$DisparoColdown.hide()
