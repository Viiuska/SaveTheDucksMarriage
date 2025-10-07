extends CharacterBody2D

signal OnUpdateHealth (health : int)
signal OnUpdateScore (score : int)
signal OnUpdateSecondScore (secondScore : int)
signal OnUpdateFinalScore(finalScore : int)

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var gravity : float = 400
@export var jump_force : float = 200

@export var health : int = 3

var move_input : float

@onready var sprite : Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var audio : AudioStreamPlayer2D = $AudioStreamPlayer2D

var take_damage_sfx : AudioStream = preload("res://Audio/damage_quack.wav")
var collect_item_sfx : AudioStream = preload("res://Audio/collect_item.wav")


#Movement physics
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_input = Input.get_axis("move_left", "move_right")
	
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force
	
	move_and_slide()
	
#Animation
func _process(delta):
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0
		
	if global_position.y > 200:
		game_over()

	_manage_animation()
	
func _manage_animation ():
	if not is_on_floor():
		anim.play("jump")
	elif move_input != 0:
		anim.play("move")
	else:
		anim.play("idle")
		
#Health
func take_damage (amount : int):
	health -= amount
	OnUpdateHealth.emit(health)
	_damage_flash()
	play_sound(take_damage_sfx)
	if health <= 0:
		call_deferred("game_over")
	
func _damage_flash ():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func play_sound (sound : AudioStream):
	audio.stream = sound
	audio.play()
		
func game_over ():
	get_tree().change_scene_to_file("res://Scenes/CutScenes/dead_scene.tscn")
	

func collected_items (type : String):
	if type == "fblue":
		PlayerCollects.score += 1
		OnUpdateScore.emit(PlayerCollects.score)
		play_sound(collect_item_sfx)
		
		PlayerCollects.finalScore += 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
		
	elif type == "steal": #Frog steals loot
		PlayerCollects.score -= 1
		OnUpdateScore.emit(PlayerCollects.score)
		
		PlayerCollects.finalScore -= 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
		
	elif type == "dpink":
		PlayerCollects.score += 1
		OnUpdateScore.emit(PlayerCollects.score)
		
		PlayerCollects.finalScore += 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
		
	elif type == "fyellow":
		PlayerCollects.score += 1
		OnUpdateScore.emit(PlayerCollects.score)
		
		PlayerCollects.finalScore += 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
		
	elif type == "fpink":
		PlayerCollects.score += 1
		OnUpdateScore.emit(PlayerCollects.score)
		
		PlayerCollects.finalScore += 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
		
	elif type == "dblue":
		PlayerCollects.secondScore += 1
		OnUpdateSecondScore.emit(PlayerCollects.secondScore)
		
		PlayerCollects.finalScore += 1
		OnUpdateFinalScore.emit(PlayerCollects.finalScore)
				
	else:
		pass
	
