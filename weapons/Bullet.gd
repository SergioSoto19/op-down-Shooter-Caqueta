extends Area2D
class_name Bullet


export (int) var speed = 4


onready var kill_timer = $KillTimer


var direction := Vector2.ZERO
var team: int = -1
var distance_traveled: float = 0.0
export (int) var damage = 0

func _ready() -> void:
	kill_timer.start()


func _physics_process(delta: float) -> void:
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
		distance_traveled += velocity.length()

func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_KillTimer_timeout() -> void:
	queue_free()
	
#func get_damage() -> int:	
#	var base_damage = 10
#	var max_distance = 200.0  # La distancia máxima para el daño completo
#	var damage_modifier = clamp(1.0 - (distance_traveled / max_distance), 0.0, 1.0)
#	damage = base_damage * damage_modifier
#	return int(damage )

func set_bullet_properties(base_damage: int, max_distance: float) -> void:
	var damage_modifier = clamp(1.0 - (distance_traveled / max_distance), 0.0, 1.0)
	damage = int(base_damage * damage_modifier)



#func _on_Bullet_body_entered(body: Node) -> void:
#	if body.has_method("handle_hit"):
#		if body.has_method("get_team") and body.get_team() != team:
#			body.handle_hit()
#		queue_free()
#
#
func _on_Bullet_body_entered(body: Node) -> void:
	if body.has_method("handle_hit"):
		if body.has_method("get_team") and body.get_team() != team:
			body.handle_hit(damage)  # Pasa el daño al enemigo
		queue_free()


