extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var node = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelText.text= ""
	#node = get_tree().get_root().find_node("cofre", true, false).get_child(0)
	#node.connect("cofreConected",self,"holaH")
#	print("jjsjdhhhh")
	
	
func holaH(message):
	$LabelText.text= "obtuviste  "+ message
#	print("hoal")
	wait_and_execute_action(3.0)

func wait_and_execute_action(seconds):
	# Crear un temporizador que emitirá la señal "timeout" después de esperar el tiempo especificado
	var timer = Timer.new()
	timer.wait_time = seconds
	add_child(timer)

	# Conectar la señal "timeout" a una función que realizará la acción deseada
	timer.connect("timeout", self, "_on_timeout")

	# Iniciar el temporizador
	timer.start()

func _on_timeout():
	# Esta función se ejecutará después de esperar el tiempo especificado (2 segundos en este caso)
	print("Han pasado 2 segundos, ejecutando la acción ahora.")
	$LabelText.text= ""
	# Agrega aquí tu lógica 
