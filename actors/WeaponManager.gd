extends Node2D

signal weapon_changed(new_weapon)

onready var current_weapon: Weapon = $Pistol

var weapons: Array = []
var pistol_found: bool = true
var shotgun_found: bool = false
var rifle_found: bool = false
var temp: Array = []
var arms : Array = []

var current_bullet_type: String = "Bullet"


func _ready() -> void:
	weapons.append(get_children()[0])
	temp = get_children()
#	$Cofre.connect("weapon_found", self, "_arma")


	for weapon in weapons:
		weapon.hide()

	current_weapon.show()


func _process(delta: float) -> void:
	if not current_weapon.semi_auto and Input.is_action_pressed("shoot"):
		current_weapon.shoot(current_bullet_type)


func mode(type:String):
	var count = 0
	print("hoal")
	for s in temp:
		if s.get_name() == type && validate_arms(type):
			arms.append(type)
			weapons.append(s)
			s.hide()
			print(s.get_name())
	current_weapon.show()
	print("dchhchchcbbb  dhdhdhshshe ee  e")
	for p in weapons:
		print(p)	
		
		
func validate_arms(arm : String):
	if(arms.size()!=0):
		for i in arms:
			if(i == arm):
				return false
		return true
	return true

func initialize(team: int) -> void:
	for weapon in weapons:
		weapon.initialize(team)

func _arma(weapon_type):
	print("weapon_type")

func get_current_weapon() -> Weapon:
	return current_weapon


func reload():
	current_weapon.start_reload()


func switch_weapon(weapon: Weapon):
	if weapon == current_weapon:
		return

	current_weapon.hide()
	weapon.show()
	current_weapon = weapon
	print("arma actual", current_weapon)
	match weapon.name:
		"Pistol":
			current_bullet_type = "Bullet"
#			print(current_bullet_type)
		"Shotgun":
			current_bullet_type = "BulletShotgun"
		"SubmachineGun":
			current_bullet_type = "Bullet"
#			print(current_bullet_type)
	emit_signal("weapon_changed", current_weapon)
	



func _unhandled_input(event: InputEvent) -> void:
#	if current_weapon.semi_auto and event.is_action_released("shoot"):
	if event.is_action_released("shoot"):
		current_weapon.shoot(current_bullet_type)
	elif event.is_action_released("reload"):
		current_weapon.start_reload()
	elif event.is_action_released("weapon_1") && weapons.size() > 0:
		switch_weapon(weapons[0])
	elif event.is_action_released("weapon_2") && weapons.size() > 1:
		switch_weapon(weapons[1])
	elif event.is_action_released("weapon_3") && weapons.size() > 2:
		switch_weapon(weapons[2])
