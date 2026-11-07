extends CanvasLayer

@onready var time = $tim
var min = 0 ; var sec = 0

func _ready() -> void:
	Signals.restart.connect(restart)
	Global.time = 0
	min = 0 ; sec = 0

func restart():
	time.text = "00:00"

func _process(delta: float) -> void:
	if Global.playing:
		Global.time += delta
		update_time()

func update_time():
	var total = int(Global.time)
	time.text = "%02d:%02d" % [total / 60, total % 60]
