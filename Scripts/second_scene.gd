extends Control

signal OnUpdateScore(score: int)
signal OnUpdateView(score : int, typeAmount : int, type: String)

@onready var anim : AnimationPlayer = $AnimationPlayer

var animation_played : bool = false

func _ready():
	if get_tree().current_scene == self:
		_play_animation()
	
func _play_animation():
	if animation_played:
		return
	animation_played = true
	
	match PlayerCollects.score:
		3: anim.play("3_second_anim")
		2: anim.play("2_second_anim")
		1: anim.play("1_second_scene")
		_: anim.play("0_second_scene")
	
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_emit_update_signals()
	_load_scene()
	


func _on_skip_button_pressed():
	_emit_update_signals()
	_load_scene()


func _emit_update_signals():
	PlayerCollects.score = 0
	PlayerCollects.typeAmount = 4
	PlayerCollects.type = "pDiamond"
	OnUpdateView.emit(PlayerCollects.score, PlayerCollects.typeAmount, PlayerCollects.type)

	
func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
