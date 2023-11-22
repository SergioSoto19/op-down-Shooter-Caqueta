extends Node2D


func _ready():
	$audioFondo.playing=true
	pass

func _on_Start_pressed():
	$AudioStreamPlayer.playing =true
	get_tree().change_scene("res://Main.tscn")
	



func _on_Credits_pressed():
	$AudioStreamPlayer2.playing = true


func _on_Start2_pressed():
	$AudioStreamPlayer.playing =true
	get_tree().quit()

