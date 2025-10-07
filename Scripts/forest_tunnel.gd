extends Area2D

@onready var bg : Node2D = $"../../Background"
@onready var player : CharacterBody2D = $"../../Player"
@onready var forest1 : Sprite2D = $"../../Background/forest1"
@onready var forest2 : Sprite2D = $"../../Background/forest2"
@onready var forest3 : Sprite2D = $"../../Background/forest3"
@onready var forest4 : Sprite2D = $"../../Background/forest4"

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return	
		
	_teleport_player()


func _teleport_player():
	if player:
		player.global_position = Vector2(4746, 0)
		forest1.show()
		forest2.show()
		forest3.show()
		forest4.show()
