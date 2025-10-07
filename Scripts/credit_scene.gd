extends Control


func _on_back_button_pressed():
	_load_scene()
	

func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
