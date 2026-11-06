extends Node2D

@onready var car_timer = $addCar
@onready var marks = [Vector2(222.0, -170.0), Vector2(384.0, -170.0), Vector2(546.0, -172.0) , Vector2(708.0, -170.0), Vector2(870.0, -170.0)]
const it = preload("res://objects/obsticle.tscn")
@onready var h1 = $ui/Bean3
@onready var h2 = $ui/Bean2
@onready var h3 = $ui/Bean

@onready var death_screen = $ui/death/ColorRect
@onready var r = $ui/death/Button



func _ready() -> void:
	Global.playing = true
	Signals.hp.connect(heartChange)
	h1.visible = true; h2.visible = true; h3.visible = true
	death_screen.visible = false
	r.visible = false

func _process(delta: float) -> void:
	pass

func _on_add_car_timeout() -> void:
	add_car()
	car_timer.start()

func add_car():
	var roll = randi_range(0, 4)
	var car = it.instantiate()
	car.position = marks[roll]
	car.reset_physics_interpolation()
	car.add_to_group("avoidable")
	add_child(car)

func heartChange():
	h1.visible = Global.hearts >=1
	h2.visible = Global.hearts >=2 
	h3.visible = Global.hearts >=3
	if Global.hearts == 0:
		death_screen.visible = true
		r.visible= true
		#await get_tree().create_timer(0.3).timeout 
		get_tree().paused = true

func _on_button_pressed() -> void: #this is the restart button
	Global.restart()
	get_tree().paused = false
	death_screen.visible = false
	r.visible= false
	get_tree().call_group("avoidable", "queue_free")
	$frog.position = Vector2(546, 557.0)
	
