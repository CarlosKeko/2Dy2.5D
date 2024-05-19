extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	$PersonajePrincipal.velocity = Vector2.ZERO
	$PersonajePrincipal.global_position = $Respawn.position
	get_tree().paused = false
	Global.score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_zona_mort_body_entered(body):
	if body.name == "PersonajePrincipal":
		body.instant_death()
