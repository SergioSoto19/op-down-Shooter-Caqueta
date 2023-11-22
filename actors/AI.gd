extends Node2D


signal state_changed(new_state)


enum State {
	PATROL,
	ENGAGE
}


onready var patrol_timer = $PatrolTimer


var current_state: int = -1 setget set_state
var actor: KinematicBody2D = null
var target: KinematicBody2D = null
var weapon: Weapon = null
var team: int = -1

# PATROL STATE
var origin: Vector2 = Vector2.ZERO
var patrol_location: Vector2 = Vector2.ZERO
var patrol_location_reached: bool = false
var actor_velocity: Vector2 = Vector2.ZERO
var pseudorandom_numbers: Array = []

func _ready() -> void:
	set_state(State.PATROL)
	while pseudorandom_numbers.empty(): #valida si esta vacia
		yield(get_tree().create_timer(1.0), "timeout") # espera un segundo
		pseudorandom_numbers = get_parent().get_parent().get_kk()


func _physics_process(delta: float) -> void:
	match current_state:
		State.PATROL:
			if not patrol_location_reached:
				if actor_velocity == Vector2.ZERO:
					actor_velocity = actor.velocity_toward(patrol_location)
				actor.move_and_slide(actor_velocity)
				actor.rotate_toward(patrol_location)
				if actor.global_position.distance_to(patrol_location) < 5:
					patrol_location_reached = true
					actor_velocity = Vector2.ZERO
					patrol_timer.start()
		State.ENGAGE:
			if target != null and weapon != null:
				actor.rotate_toward(target.global_position)
				var angle_to_target = actor.global_position.direction_to(target.global_position).angle()
				if abs(actor.rotation - angle_to_target) < 0.1:
					weapon.shoot("Bullet")
#					print("")
			else:
				print("In the engage state but no weapon/target")
		_:
			print("Error: found a state for our enemy that should not exist")


func initialize(actor: KinematicBody2D, weapon: Weapon, team: int):
	self.actor = actor
	self.weapon = weapon
	self.team = team

	weapon.connect("weapon_out_of_ammo", self, "handle_reload")


func set_state(new_state: int):
	if new_state == current_state:
		return

	if new_state == State.PATROL:
		origin = global_position
		patrol_timer.start()
		patrol_location_reached = true

	current_state = new_state
	emit_signal("state_changed", current_state)


func handle_reload():
	weapon.start_reload()


#func _on_PatrolTimer_timeout() -> void:
#	var patrol_range = 50
#	var random_x = rand_range(-patrol_range, patrol_range)
#	var random_y = rand_range(-patrol_range, patrol_range)
#	patrol_location = Vector2(random_x, random_y) + origin
#	patrol_location_reached = false
#	actor_velocity = actor.velocity_toward(patrol_location)

func _on_PatrolTimer_timeout() -> void:
	var patrol_range = 50
	
	var indice_aleatoriox = rand_range(0, pseudorandom_numbers.size() - 1)
	var indice_aleatorioy = rand_range(0, pseudorandom_numbers.size() - 1)
	# Obtener el número pseudoaleatorio de la lista de numeros pseudoaleatorios 
	var numero_pseudoaleatoriox = pseudorandom_numbers[indice_aleatoriox]
	var numero_pseudoaleatorioy = pseudorandom_numbers[indice_aleatorioy]
	patrol_location = actor.global_position + Vector2(numero_pseudoaleatoriox, numero_pseudoaleatorioy)
	patrol_location_reached = false
	actor_velocity = Vector2.ZERO



func _on_DetectionZone_body_entered(body: Node) -> void:
	if body.has_method("get_team") and body.get_team() != team:
		set_state(State.ENGAGE)
		target = body


func _on_DetectionZone_body_exited(body: Node) -> void:
	if target and body == target:
		set_state(State.PATROL)
		target = null
