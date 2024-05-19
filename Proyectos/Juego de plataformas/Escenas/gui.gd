extends CanvasLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Container/Score.text = "SCORE: " + str(Global.score)
	$Container/TextureProgressBar.value = Global.life
	
func game_over():
	get_tree().paused = true
	$ColorRect/HBoxContainer2/Restart.grab_focus()
	
	var tween : Tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property($ColorRect, "modulate", Color(1, 1, 1, 0.8), 1.0)
	
	$ColorRect/AudioStreamPlayer2D.play()



func _on_restart_pressed():
	Global.life = 3
	Global.score = 0
	get_tree().reload_current_scene()


func _on_exit_pressed():
	get_tree().quit()
