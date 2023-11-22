extends KinematicBody2D
class_name Player


signal player_health_changed(new_health)
signal died


export (int) var speed = 150
export (int) var current_speed = speed

onready var collision_shape = $CollisionShape2D
onready var team = $Team
onready var weapon_manager = $WeaponManager
onready var health_stat = $Health
#onready var camera_transform = $CameraTransform


func _ready() -> void:
	weapon_manager.initialize(team.team)


func _physics_process(delta: float) -> void:
	var movement_direction := Vector2.ZERO

	if Input.is_action_pressed("up"):
		movement_direction.y = -1
	if Input.is_action_pressed("down"):
		movement_direction.y = 1
	if Input.is_action_pressed("left"):
		movement_direction.x = -1
	if Input.is_action_pressed("right"):
		movement_direction.x = 1

	movement_direction = movement_direction.normalized()
	move_and_slide(movement_direction * current_speed)
	look_at(get_global_mouse_position())


#func set_camera_transform(camera_path: NodePath):
#	camera_transform.remote_path = camera_path

func get_team() -> int:
	return team.team


	
func handle_hit(damage: int):
	health_stat.health -= damage
	health_stat.health = max(health_stat.health, 0)
	print(health_stat)
	emit_signal("player_health_changed", health_stat.health)
	if health_stat.health <= 0:
		die()


func die():
	emit_signal("died")
	queue_free()
	
#velocidad cambia cuendo entra a una area de lodo
# En el script del jugador
func set_lodo_speed(new_speed: int) -> void:
	current_speed = new_speed


func restore_normal_speed() -> void:
	current_speed = speed
	
# Conectar las señales después de que el jugador esté listo
func connect_signals():
	connect("entered_lodo_area", self, "_on_entered_lodo_area")
	connect("exited_lodo_area", self, "_on_exited_lodo_area")

# Métodos llamados cuando el jugador entra o sale del área de lodo.
func _on_entered_lodo_area(new_speed: int):
#	print("Player entró en el área de lodo")
	current_speed = new_speed

func _on_exited_lodo_area():
#	print("Player salió del área de lodo")
	current_speed = speed
