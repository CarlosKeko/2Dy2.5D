class_name flecha extends CharacterBody2D

var target
var speed = 800
var pathName = ""
var flechaDamage

func _physics_process(delta):
	var pathSpawner = get_tree().get_root().get_node("Primer_nivel/PathSpawner")
	
	for i in pathSpawner.get_child_count():
		if pathSpawner.get_child(i).name == pathName:
			if pathSpawner.get_child(i).get_child(0).get_child(0) != null:
				target = pathSpawner.get_child(i).get_child(0).get_child(0).global_position
	
	velocity = global_position.direction_to(target) * speed
	look_at(target)
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body is enemigo_nivel_1:
		body.vida -= flechaDamage
		queue_free()
