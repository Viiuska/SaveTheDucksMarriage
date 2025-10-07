extends Control

@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var scoreLabel : Label = $Label

var animation_played : bool = false

func _ready():
	if get_tree().current_scene == self:
		_play_animation()
		scoreLabel.text= "Total score: " + str(PlayerCollects.finalScore) + "/19"
	
func _play_animation():
	if animation_played:
		return
	animation_played = true
	
	if PlayerCollects.finalScore == 19:
		anim.play("4_end_anim")
	elif 19 > PlayerCollects.finalScore and PlayerCollects.finalScore > 15:
		anim.play("3_end_anim")
	elif  15 > PlayerCollects.finalScore and PlayerCollects.finalScore> 10:
		anim.play("2_end_anim")
	else:
		anim.play("1_end_anim")
		

func _on_skip_button_pressed() -> void:
	_load_scene()



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_load_scene()


func _load_scene():
	PlayerCollects.finalScore = 0
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
