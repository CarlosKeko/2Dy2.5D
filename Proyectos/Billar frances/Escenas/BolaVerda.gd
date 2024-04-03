extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$texturaBola.texture =  load("res://Sprites/sphere-14.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
