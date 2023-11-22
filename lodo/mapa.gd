extends Node

# Referencia al nodo del jugador
var Player : KinematicBody2D
var lodoArea :Area2D

# Llamado cuando el nodo entra en el árbol de escenas
func _ready():
	# Obtén una referencia al área de lodo
	lodoArea = $lodo
	# Obtén una referencia al nodo del jugador
	Player = $Player
	Player.connect_signals()

	# Conecta la señal body_entered al método _on_lodo_body_entered
	lodoArea.connect("body_entered", self, "_on_lodo_body_entered")
	lodoArea.connect("entered_lodo_area", Player, "set_lodo_speed")
	lodoArea.connect("exited_lodo_area", Player, "restore_normal_speed")
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
#func _process(delta):
	# Verifica la posición del jugador
#	if Player:
#		var player_position = Player.position
#		print("Posición del jugador:", player_position)

# Método llamado cuando un cuerpo entra en el área de lodo.
func _on_lodo_body_entered(body):
	print(body, "entró en el área de lodo")
	if body.get_name() == "Player":
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Menu Principal.tscn")
