extends CanvasLayer

@onready var health_container = $HealthContainer
var hearts : Array = []

@onready var player = get_parent()
@onready var collectedItems : Label = $CollectedItems
@onready var scoreLabel : Label= $CollectedItemsScore
@onready var collectedItems2 : Label = $CollectedItems2
@onready var scoreLabel2 : Label= $CollectedItemsScore2


func _ready ():
	hearts = health_container.get_children()
	
	player.OnUpdateHealth.connect(_update_hearts)
	player.OnUpdateScore.connect(_update_score)
	player.OnUpdateSecondScore.connect(_update_second_score)
	player.OnUpdateFinalScore.connect(_update_final_score)
	
	_update_hearts(player.health)
	_update_score(PlayerCollects.score)
	_update_final_score(PlayerCollects.finalScore)
	_update_score_view(PlayerCollects.score, PlayerCollects.typeAmount, PlayerCollects.type)
	_update_second_score_view(PlayerCollects.secondScore, PlayerCollects.secondTypeAmount, PlayerCollects. secondType)
	

func _update_hearts (health : int):
	for i in len(hearts):
		hearts[i].visible = i < health
	
var amount : String = "3"

func _update_score (score: int):
	if score < 0:
		score = 0
	else:
		scoreLabel.text = (str(score))

func _update_second_score (secondScore: int):
	if secondScore < 0:
		secondScore = 0
	else:
		scoreLabel2.text = (str(secondScore))


func _update_final_score (finalScore: int):
	if finalScore < 0:
		finalScore = 0


func _update_score_view (score : int, typeAmount : int, type: String):
	if score < 0:
		score = 0
	else:
		collectedItems.text = collectedItems.text + "/" + str(typeAmount)
		
	collectedItems.text = "/"+str(typeAmount)
	match type:
		"pDiamond":
			$DiamondPink.show()
			$FlowerBlue.hide()
			$FlowerYellow.hide()
			$FlowerPink.hide()
			$DiamondBlue.hide()
		"bFlower":
			$DiamondPink.hide()
			$FlowerBlue.show()
			$FlowerYellow.hide()
			$FlowerPink.hide()
			$DiamondBlue.hide()
		"yFlower":
			$DiamondPink.hide()
			$FlowerBlue.hide()
			$FlowerYellow.show()
			$FlowerPink.hide()
			$DiamondBlue.hide()
		"pFlower":
			$DiamondPink.hide()
			$FlowerBlue.hide()
			$FlowerYellow.hide()
			$FlowerPink.show()
			$DiamondBlue.hide()
		_:
			$DiamondPink.hide()
			$FlowerBlue.hide()
			$FlowerYellow.hide()
			$FlowerPink.hide()
			$DiamondBlue.hide()


func _update_second_score_view (secondScore : int, secondTypeAmount : int, secondType : String):
	if secondScore < 0:
		secondScore = 0
	else:
		collectedItems2.text = collectedItems2.text + "/" + str(secondTypeAmount)
		
	collectedItems2.text = "/"+str(secondTypeAmount)
	match secondType:
		"bDiamond":
			$DiamondBlue.show()
			$CollectedItems2.show()
			$CollectedItemsScore2.show()
