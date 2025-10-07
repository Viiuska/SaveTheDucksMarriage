extends Area2D

@onready var bg : Node2D = $"../../Background"
@onready var player : CharacterBody2D = $"../../Player"
@onready var meadow1 : Sprite2D = $"../../Background/meadow1"
@onready var meadow2 : Sprite2D = $"../../Background/meadow2"
@onready var meadow3 : Sprite2D = $"../../Background/meadow3"
@onready var meadow4 : Sprite2D = $"../../Background/meadow4"

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return	
		
	_teleport_player()


func _teleport_player():
	if player:
		player.global_position = Vector2(2211, -2)
		meadow1.show()
		meadow2.show()
		meadow3.show()
		meadow4.show()
