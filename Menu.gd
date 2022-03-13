extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	$VboxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_New_Game_pressed():
	get_tree().change_scene("res://World.tscn")


func _on_Load_Game_pressed():
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
