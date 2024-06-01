extends Node

const ESC_PRIMERNIVEL := preload("res://Scenes/primer_nivel.tscn")

#Metodos globales

# Metodo para cambiar de escena
func g_canvi_escena(nomEscenaAnar):
	if (nomEscenaAnar == "PrimerNivel"):
		get_tree().change_scene_to_packed(ESC_PRIMERNIVEL)
