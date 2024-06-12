class_name towerWizard1 extends towerArcher1

# En la funcion ready como es una clase heredada ponemos los valore que queramos
func _ready():
	flecha = preload("res://Scenes/magia.tscn")
	flechaDamage = 40
	damageE1 = 40
	damageE2 = 70
	damageE3 = 100
	precio = [100, 500, 1000]
	$Temporizador.wait_time = 3
