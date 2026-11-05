extends Node
var hearts = 3
var speed = 350
var currentx = 546

func _ready() -> void:

	hearts = 3
	Signals.hp.emit()

func restart():
	hearts = 3
	Signals.hp.emit()
	speed = 350
	currentx = 546


func Loosehearts():
	hearts -= 1
	print(hearts)
	Signals.hp.emit()
	if hearts <= 0:
		die()

func die():
	pass
	
