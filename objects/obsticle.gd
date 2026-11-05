extends AnimatableBody2D
var moving = true
var speed = 350

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position.y += speed*delta
	if position.y >= 700:
		queue_free()
