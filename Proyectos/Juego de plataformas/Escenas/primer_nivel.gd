extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	$PersonajePrincipal.velocity = Vector2.ZERO
	$PersonajePrincipal.global_position = $Respawn.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
