extends Control

@onready var anim : AnimationPlayer = $AnimationPlayer

var animation_played : bool = false

func _ready():
	if get_tree().current_scene == self:
		_play_animation()
	
func _play_animation():
	if animation_played:
		return
	animation_played = true
	
	_flower_animation()
	await anim.animation_finished
	
	_diamond_animation()
	await anim.animation_finished

	_load_scene()

func _flower_animation():
	match PlayerCollects.score:
		4: anim.play("4_final_flower_anim")
		3: anim.play("3_final_flower_anim")
		2: anim.play("2_final_flower_anim")
		1: anim.play("1_final_flower_anim")
		_: anim.play("0_final_flower_anim")
	

func _diamond_animation():
	match PlayerCollects.secondScore:
		3: anim.play("3_final_diamond_anim")
		2: anim.play("2_final_diamond_anim")
		1: anim.play("1_final_diamond_anim")
		_: anim.play("0_final_diamond_anim")
	

func _on_skip_button_pressed() -> void:
	anim.stop()
	_load_scene()

func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/CutScenes/end_scene.tscn")
