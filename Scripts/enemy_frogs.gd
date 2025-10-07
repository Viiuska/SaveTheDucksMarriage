extends Area2D

@export var jump_height : float = 50
@export var move_speed : float = 40
@export var ground_pause : float = 0.5

@onready var start_pos : Vector2 = global_position
@onready var target_pos : Vector2 = start_pos + Vector2(0, -jump_height)
@onready var pause_timer : Timer = $PauseTimer

var is_paused : bool = false

func _ready():
	$AnimationPlayer.play("jump")
	pause_timer.wait_time = ground_pause
	pause_timer.one_shot = true
	pause_timer.stop()
	

#Movement physics
func _physics_process(delta):
	if is_paused:
		$AnimationPlayer.play("ground")
		return
	
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if target_pos == start_pos:
			is_paused = true
			pause_timer.start()
		else:
			target_pos = start_pos
			

func _on_pause_timer_timeout():
	is_paused = false
	target_pos = start_pos + Vector2(0, -jump_height)
	$AnimationPlayer.play("jump")
	

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	body.collected_items("steal") 
	body.take_damage(0)
