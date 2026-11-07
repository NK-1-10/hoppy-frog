extends Node2D
var moving = true

@onready var one = $one
@onready var two = $two
@onready var three = $three

func _ready() -> void:
	var logs = [one, two ,three]
	var pick = randi_range(0, 2)
	for i in 3:
		if i != pick:
			logs[i].queue_free()
	logs[pick].add_to_group("avoidable")

func _physics_process(delta: float) -> void:
	position.y += Global.speed*delta
	if position.y >= 700:
		queue_free()
