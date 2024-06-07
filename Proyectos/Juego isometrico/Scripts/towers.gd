class_name towerArcher1 extends StaticBody2D 

var flecha = preload("res://Scenes/flecha.tscn")
var flechaDamage = 10
var pathName
var currTargets = []
var curr

func _on_area_2d_body_entered(body):
	if body is enemigo_nivel_1:
		var tempArray = []
		currTargets = get_node("Area2D").get_overlapping_bodies()
		print(currTargets)
		
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

func _on_area_2d_body_exited(body):
	pass # Replace with function body.
