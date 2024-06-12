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

func _process(delta):
	if incoldown:
		$DisparoColdown.show()
		$DisparoColdown.value = $Temporizador.time_left
	
	if is_instance_valid(curr):
		pass 
	
	else:
		for i in get_node("FlechaContainer").get_child_count():
			get_node("FlechaContainer").get_child(i).queue_free()

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

func _on_area_2d_body_exited(body):
	currTargets = get_node("Area2D").get_overlapping_bodies()

func subirTorre():
	if nivelActual == 1:
		towerArcher2()
		nivelActual = 2
		valorActual = precio[nivelActual - 1]
		Global.dinero -= valorActual
		
		
	elif nivelActual == 2:
		towerArcher3()
		nivelActual = 3
		valorActual = precio[nivelActual - 1]
		mejorable = false
		Global.dinero -= valorActual
	
func mejorar(damage):
	flechaDamage = damage
	
func towerArcher2():
	mejorar(damageE2)
	
func towerArcher3():
	mejorar(damageE3)

func obtenerPrecioMejora():
	return precio[nivelActual]
	
func obtenerPrecioVender():
	return valorActual
	
func torreMejorable():
	return mejorable

func _on_temporizador_timeout():
	incoldown = false
	$DisparoColdown.hide()
