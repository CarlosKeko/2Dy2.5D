extends Sprite2D

signal shoot

#var power : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if Global.power < Global.max_power:		
			Global.power += 0.05
		
		elif Global.power >= Global.max_power:
			Global.power = 0
		
	else:
		if Global.power > 0:
			var dir = mouse_pos - position
			shoot.emit(Global.power * dir)
			Global.power = 0
