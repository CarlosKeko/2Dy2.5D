extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if get_node("Sprite2D").is_visible():
		get_node("Sprite2D").hide()
	
	else:
		get_node("Sprite2D").show()
			
		
