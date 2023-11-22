extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text
#signal cofreConected
var tecla = false
var allow_interaction = true 
onready var animation_player = $AnimationPlayer
var current_animation = "cerrado"
var is_colliding = true
signal cofreConected
var estado_actual = 0 
var transiciones = [
		[0.8, 0.2],  # Probabilidades de pasar de 0 a 0 y de 0 a 1
		[0.4, 0.6],  # Probabilidades de pasar de 1 a 0 y de 1 a 1
	]


 # Estado inicial

# Estado inicial: representa la probabilidad de obtener cada arma al principio.


func _on_Cofre2D_body_entered(body):
	print(estado_actual, "   ", body.get_name())
	if tecla:
		if allow_interaction == true && body.get_name() == "Player":
			wait_for_some_time(1.1)
			play_animation("abierto")
			print(ejecute())
			mensaje(ejecute())
			var node = get_tree().get_root().find_node("Player", true, false).get_child(4)
			node.mode(ejecute())
			#$emit_signal("cofreConected", ejecute())
			allow_interaction = false

	
		#emit_signal(generate_weapon())
	#play_animation("abierto")
	#var receptor = get_node("res://cofffrrre/cofre/nodeco")
		#var rec = get_parent().get_parent().get_parent().get_node("nodeco").get_child(0)
		#rec.emit_signal("senal_desde_escena_a", "Información desde EscenaA")
		#rec.holaa()
		#print(receptor)
		#print(rec)
	#ejecute()
		#receptor.emit_ddddsignal("senal_desde_escena_a", "dd")
		#emit_signal(generate_weapon())

		#print(generate_weapon())

	#pass # Replace with function body.
	
func play_animation(animation_name):
	# Asegúrate de que la animación exista en el AnimationPlayer.
	if animation_player.has_animation(animation_name):
		# Inicia la animación.
		animation_player.play(animation_name)
	else:
		# Si la animación no existe, muestra un mensaje de error.
		print("La animación '" + animation_name + "' no se encontró en el AnimationPlayer.")

func transicion_arma():
		# Realiza la transición de estado basada en la cadena de Markov
	var siguiente_estado = rand_range(0, 1)
	var acumulado = 0.0
	for i in range(transiciones[estado_actual].size()):
		acumulado += transiciones[estado_actual][i]
		if siguiente_estado < acumulado:
			estado_actual = i
			return estado_actual

func ejecute():
	var nuevo_estado = null
	for i in range(5):
			# Realizar la transición y obtener el nuevo estado (tipo de arma)
		nuevo_estado = transicion_arma()
		#print("estado actaul", estado_actual)
		#print("Se seleccionó el arma:", nuevo_estado)
	if (nuevo_estado == 0):
		return "SubmachineGun"
	else:
		return "Shotgun"

func _ready():
	print("hola")

	animation_player.play("cerrado")
	
	
func _input(event):
	# Manejar eventos de teclado
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_D || event.scancode == KEY_S:
				#print("Derecha presionada")
				tecla = true
		
		

func wait_for_some_time(seconds):
	# Utilizar yield para esperar un tiempo
	yield(get_tree().create_timer(seconds), "timeout")
	# Este código se ejecutará después de que haya pasado el tiempo especificado

func mensaje(message):
	var node = get_tree().get_root().find_node("CanvasLayer", true, false)
	node.holaH(message)




	# Puedes cambiar "ui_right" y "ui_left" a otras acciones según tus necesidades
