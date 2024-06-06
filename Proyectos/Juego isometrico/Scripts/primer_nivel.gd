extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click"):
		var mouse_pos = get_global_mouse_position()
		var tile_mouse_pos = local_to_map(mouse_pos)
		var idCela = get_cell_source_id(0, tile_mouse_pos, false)
		ponerTorre(idCela, tile_mouse_pos)
		
func ponerTorre(idCela, tile_mouse_pos):
	if idCela == 17:
		set_cell(1, tile_mouse_pos, 22, Vector2i(0, 0))
