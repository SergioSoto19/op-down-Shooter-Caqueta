extends Node2D


func handle_bullet_spawned(bullet: Bullet, team: int, position: Vector2, direction: Vector2):
	add_child(bullet)
	bullet.team = team
	bullet.global_position = position
	bullet.set_direction(direction)
	
#	add_child(bulletShotgun)
#	bulletShotgun.team = team
#	bulletShotgun.global_position = position
#	bulletShotgun.set_direction(direction)
