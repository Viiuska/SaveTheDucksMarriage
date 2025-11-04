extends Control

signal OnUpdateView(score : int, typeAmount : int, type: String)

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
	_emit_update_signals()
	_load_scene()


func _emit_update_signals():
	PlayerCollects.score = 0
	PlayerCollects.typeAmount = 3
	PlayerCollects.type = "bFlower"
	OnUpdateView.emit(PlayerCollects.score, PlayerCollects.typeAmount, PlayerCollects.type)

func _load_scene():
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	
