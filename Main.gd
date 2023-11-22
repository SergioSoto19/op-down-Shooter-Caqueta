extends Node2D


onready var bullet_manager = $BulletManager
#onready var player: Player = $Player
onready var gui=$GUI
onready var pseudorandomNumbers = $pseudorandomNumbers


# Called when the node enters the scene tree for the first time.
var pseudorandom_numbers:	Array = []
func _ready() -> void:
	$audiofondo.playing=true
	randomize()
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_bullet_spawned")
	get_pseudorandom_numbers()
	
func spawn_player():
	var player = Player.instance()  # Corregido aquí
	add_child(player)  # Añadir al árbol de escenas
	gui.set_player(player)
	
func get_pseudorandom_numbers():
	var numer_list_str = pseudorandomNumbers.nose()
	# Convertir la cadena JSON a un arreglo
	var numer_list = JSON.parse(numer_list_str).result as Array
	pseudorandom_numbers = numer_list

func get_kk():
	return pseudorandom_numbers
