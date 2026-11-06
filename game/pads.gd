extends Node2D
@onready var lilies = [$first, $second, $third, $forth, $fifth]
var locations = [222,384, 546,708, 870 ]

func _ready() -> void:
	Signals.landed.connect(change)
	for n in 5:
		lilies[n].frame = 0
		lilies[n].position.x = locations[n]

func _process(delta: float) -> void:
	pass

func change():
	var roll = randi_range(1,5)
	var pos = $"../frog".position.x
	var pad
	for n in 5:
		if pos == locations[n]:
			pad = lilies[n]
	if  roll == 2 || roll == 4:
		pad.frame = 0
		bobble(pad)
	else: 
		var r = randi_range(1, 4)
		pad.frame = r
		bobble(pad)
		

func bobble(pad):
	var tween = create_tween()
	tween.tween_property(pad, "scale", Vector2(2.15, 2.15), 0.08).set_ease(Tween.EASE_OUT)
	tween.tween_property(pad, "scale", Vector2(2, 2), 0.08).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
