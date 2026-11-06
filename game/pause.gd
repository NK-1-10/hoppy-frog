extends Control
var paused = false

func _ready() -> void:
	paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and Global.hearts > 0:
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
