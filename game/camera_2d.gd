extends Camera2D

var shake = 0
var decay = 30

func _ready() -> void:
	Signals.landed.connect(add_shake)

func add_shake():
	var m = min(Global.streak, 4)
	shake = 2.0*pow(1.4,m)

func _process(delta):
	if shake > 0:
		offset = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
		shake = max(shake - decay * delta, 0)
	else:
		offset = Vector2.ZERO
