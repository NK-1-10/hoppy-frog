extends Control
var paused = false

@onready var layer = $CanvasLayer

func _ready() -> void:
	layer.visible = false
	paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and Global.hearts > 0:
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
		layer.visible = !layer.visible
