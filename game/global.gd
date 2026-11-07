extends Node
var hearts = 3
var speed = 350
var currentx = 546
var time = 0
var playing = false
var points = 0
var streak = 0

func _ready() -> void:
	hearts = 3
	Signals.hp.emit()


func restart():
	hearts = 3
	Signals.hp.emit()
	Signals.restart.emit()
	speed = 350
	currentx = 546
	points = 0
	time = 0


func Loosehearts():
	hearts -= 1
	Signals.hp.emit()
	if hearts <= 0:
		die()

func die():
	pass
	
