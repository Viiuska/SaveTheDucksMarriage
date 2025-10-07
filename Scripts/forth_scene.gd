extends Control

signal OnUpdateScore(score: int)
signal OnUpdateView(score : int, typeAmount : int, type: String)
signal OnUpdateSecondView(score : int, typeAmount : int, secondType : String)

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
		5: anim.play("5_forth_anim")
		4: anim.play("4_forth_anim")
		3: anim.play("3_forth_anim")
		2: anim.play("2_forth_anim")
		1: anim.play("1_forth_anim")
		_: anim.play("0_forth_anim")
	
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_emit_update_signals()
	_load_scene()
	


func _on_skip_button_pressed():
	_emit_update_signals()
	_load_scene()


func _emit_update_signals():
	PlayerCollects.score = 0
	PlayerCollects.typeAmount = 4 
	PlayerCollects.type = "pFlower" 
	OnUpdateView.emit(PlayerCollects.score, PlayerCollects.typeAmount, PlayerCollects.type)
	
	PlayerCollects.secondScore = 0
	PlayerCollects.secondTypeAmount = 3 
	PlayerCollects.secondType = "bDiamond" 
	OnUpdateSecondView.emit(PlayerCollects.score, PlayerCollects.typeAmount, PlayerCollects.secondType)

	
func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/level_4.tscn")
