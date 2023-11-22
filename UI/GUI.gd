extends CanvasLayer

onready var health_bar = $MarginContainer/Rows/BottonRows3/LifeContainer/health_bar
onready var current_ammo = $MarginContainer/Rows/BottonRows3/AmmonSection/currenAmonut
onready var max_ammo = $MarginContainer/Rows/BottonRows3/AmmonSection/maxAmmo
onready var health_tween = $MarginContainer/Rows/BottonRows3/LifeContainer/health_tween

onready var player: Player

func _ready():
	var node = get_tree().get_root().find_node("Player", true, false)
	var gui = get_tree().get_root().find_node("GUI", true, false)
	var weapon=get_tree().get_root().find_node("Weapon", true, false)
	node.connect("player_health_changed", self, "set_new_health_value")
	gui.connect("player_health_changed", self, "set_new_health_value")
	#weapon.connect("weapon_fired",self,"set_current_ammo")#blas del enemigo
	node.weapon_manager.current_weapon.connect("weapon_ammo_changed",self,"set_current_ammo")#las balas
	set_weapon(node.weapon_manager.get_current_weapon())
	node.weapon_manager.connect("weapon_changed",self,"set_weapon")
#	print(health_tween)
	
func set_weapon(weapon:Weapon):
#	print("entre a selecionar arma")
	set_current_ammo(weapon.current_ammo)
	set_max_ammo(weapon.max_ammo)
	if not weapon.is_connected("weapon_ammo_changed",self,"set_current_ammo"):
		weapon.connect("weapon_ammo_changed",self,"set_current_ammo")#las balas
		weapon.connect("total_weapon_ammo",self,"set_max_ammo")
	
func set_player(player: Player):
	
	var node = get_tree().get_root().find_node("GUI", true, false)
	player.connect("player_health_changed", self, "set_new_health_value")
	player.weapon_manager.connect("weapon_ammo_changed",self,"set_current_ammo")
	player.weapon_manager.connect("total_weapon_ammo",self,"set_max_ammo")
#	print(node)


# Método llamado cuando la vida del jugador cambia
func set_new_health_value(new_health: int):
	var original_color = Color("#5c1c1c")
	var highlight_color = Color("#ff7e7e")

	var bar_style = health_bar.get("custom_styles/fg")
	health_tween.interpolate_property(health_bar, "value", health_bar.value, new_health, 0.4,Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(bar_style, "bg_color", original_color, highlight_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	health_tween.interpolate_property(bar_style, "bg_color", highlight_color, original_color, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.2)
	health_tween.start()



# Métodos para configurar las municiones
func set_current_ammo(new_ammo: int):
#	print("entre a lo de la balas")
	current_ammo.text=str(new_ammo)

func set_max_ammo(new_max_ammo: int):
#	print("total balas")
	max_ammo.text=str(new_max_ammo)

