class_name Billar extends Node2D

var _bolaActiva = null #La bola del jugador que tira
var _jugadorAct: String #A o B
var _iniVector: Vector2
var _fiVector: Vector2
var _estat: int #maquina d'estats
var bolasMoviendose : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	_bolaActiva = $BolaGroga
	_jugadorAct = "A"
	_estat = 1
	bolasMoviendose = false
	$Tempus.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !bolasMoviendose:
		$ProgressBar.position.x = _bolaActiva.position.x - (0.5 * $ProgressBar.size.x)
		$ProgressBar.position.y = _bolaActiva.position.y + $ProgressBar.size.y
		$ProgressBar.show()
		$ProgressBar.value = Global.power * (100 / Global.max_power)
		$Pal.position = _bolaActiva.position
		$Pal.show()
	
	else:
		$ProgressBar.hide()
		$Pal.hide()
	
	if $BolaGroga.linear_velocity.length() >= 1 || $BolaVermella.linear_velocity.length() >= 1 || $BolaVerda.linear_velocity.length() >= 1:
		bolasMoviendose = true
		
	else:
		bolasMoviendose = false

func _on_pal_shoot(power):
	#print(power)
	if (!bolasMoviendose):
		_bolaActiva.apply_central_impulse(power)