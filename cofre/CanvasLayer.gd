extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelText.text = "h"
	pass # Replace with function body.
	self.visible = true

	# Llamar a una función para cambiar la visibilidad después de un tiempo (por ejemplo, 2 segundos)
	wait_and_toggle_visibility(2.0)
	
	
func hola():
	print("hoal")
	$LabelText.text = "h"


func wait_and_toggle_visibility(seconds):
	yield(get_tree().create_timer(seconds), "timeout")
	# Esta función se ejecutará después de esperar el tiempo especificado

	# Cambiar la visibilidad después de esperar
	self.visible = !self.visible  # Invertir la visibilidad actual
	print("Visibilidad cambiada a: ", self.visible)
