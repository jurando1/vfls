extends Control

func _on_Retry_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_Main_Menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
