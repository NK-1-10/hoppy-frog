extends Camera2D

var shake = 0
var decay = 30

func _ready() -> void:
	Signals.landed.connect(add_shake)

func add_shake():
	shake = 1

func _process(delta):
	if shake > 0:
		offset = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
		shake = max(shake - decay * delta, 0)
	else:
		offset = Vector2.ZERO
