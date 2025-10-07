extends Area2D

func _on_body_entered(body):
	if not body.is_in_group("Player"):
		return
	
	body.collected_items("dpink")
	queue_free()
