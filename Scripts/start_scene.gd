extends Control

@onready var anim : AnimationPlayer = $AnimationPlayer

var animation_played : bool = false

func _ready():
	if animation_played:
		return
	animation_played = true
	
	anim.play("first_scene")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	call_deferred("_load_scene")

func _on_skip_button_pressed():
	call_deferred("_load_scene")

func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	
