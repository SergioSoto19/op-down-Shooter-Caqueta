extends Area2D

# Velocidad para el jugador en el área de lodo
export (int) var lodo_speed = 50

signal entered_lodo_area
signal exited_lodo_area

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")

# Método llamado cuando un cuerpo entra en el área de lodo.
func _on_body_entered(body):
	print(body, "entró en el área de lodo")
	if body.get_name() == "Player":
		# Aplicar nueva velocidad al jugador
		body.set_lodo_speed(lodo_speed)
		print("Emitiendo entered_lodo_area")
		emit_signal("entered_lodo_area", lodo_speed)


# Método llamado cuando un cuerpo sale del área de lodo.
func _on_body_exited(body):
	print(body, "salió del área de lodo")
	if body.get_name() == "Player":
		# Restaurar velocidad normal al jugador
		body.restore_normal_speed()
		emit_signal("exited_lodo_area")
