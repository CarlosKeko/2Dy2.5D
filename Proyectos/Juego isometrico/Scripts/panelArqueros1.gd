extends Panel

# En el ready modificaremos el label actualizando el precio
func _ready():
	$Label.text = str(Global.PRECIOARCHER)
