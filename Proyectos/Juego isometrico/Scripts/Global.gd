extends Node

const TOWERS:= preload("res://Scenes/towerArcher1.tscn")
const LUGARLIBRE:= 17
const TIEMPO = 600 #segundos contador

var dinero = 0
var vida = 100
var enemigosEliminados = 0

var coordenadas : Vector2i
var lugarValido := false
