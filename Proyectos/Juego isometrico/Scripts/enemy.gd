class_name enemigo_nivel_1 extends CharacterBody2D

@export var speed = 300
var vida = 40

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed * delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
		
	if vida < 10:
		get_parent().get_parent().queue_free()
