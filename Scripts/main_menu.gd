extends Control


func _on_play_button_pressed():
	PlayerCollects.score = 0
	get_tree().change_scene_to_file("res://Scenes/CutScenes/start_scene.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_credit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/CutScenes/credit_scene.tscn")
