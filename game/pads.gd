extends Node2D

var locations = [222,384, 546,708, 870 ]
@export var c = [Color(), Color(), Color(), Color(), Color()]
@onready var point_txt = $"../ui/p"
@onready var lilies = [$first, $second, $third, $forth, $fifth]
@onready var add = $"../ui/added"

signal beat

@export var bpm = 88.0
@export var offset =  0
var window = 0.1
var last_beat = -1

@onready var music = $"../sounds/loop"

var weight = [50, 70, 85, 95, 100]
var points = [1, 3, 6 , 10, 20,]

var pitch = [1.0 , 1.12, 1.26, 1.5, 1.68]

func _ready() -> void:
	Signals.restart.connect(restart)
	beat.connect(func(): for p in lilies: bobble(p))
	add.position.y = 557
	add.position.x = 546
	add.visible = false
	Signals.jumped.connect(on_jump)
	Signals.landed.connect(change)
	for n in 5:
		lilies[n].frame = 0
		lilies[n].position.x = locations[n]

func restart():
	ttt.text = "mul = 1" + " Total: 0"
	point_txt.text = "Points : 0" 

func roll():
	var r = randi_range(1, 100)
	for i in weight.size():
		var num  = weight[i]
		if num >= r:
			return i
	return 0

func change():
	if hop_on_beat:
		Global.streak += 1
	else:
		Global.streak = 0
	var pos = $"../frog".position.x
	var pad
	for n in 5:
		if pos == locations[n]:
			pad = lilies[n]
	var old = pad.frame
	var poi = points[old]
	
	var gained = calc_point(poi)
	txt(old, gained)
	
	play_note(old)
	
	pad.frame = roll()
	
	bobble(pad)

@onready var ttt = $"../ui/ttt"

func calc_point(p):
	var mul = 1.0 + min(Global.streak, 4)*0.5
	print(mul)
	var total = roundi(p*mul)
	print(total)
	ttt.text = "mul = "+ str(mul) + " Total: "+str(total)
	Global.points += total
	point_txt.text = "Points : "+ str(Global.points)
	return total

func txt(frame, p):
	add.text = "+"+str(p)
	add.modulate = c[frame]
	add.modulate.a = 1.0
	add.position.y = $"../frog".position.y - 70
	add.position.x = $"../frog".position.x - 18
	add.visible = true
	
	var tween = create_tween().set_parallel()
	tween.tween_property(add, "position:y", add.position.y - 80, 0.5)
	tween.tween_property(add, "modulate:a", 0.0, 0.5)
	await tween.finished
	add.visible = false
	add.position.y = 557

func play_note(which):
	$"../sounds/lily".pitch_scale = pitch[which]
	$"../sounds/lily".play()

func bobble(pad):
	var tween = create_tween()
	tween.tween_property(pad, "scale", Vector2(2.15, 2.15), 0.08).set_ease(Tween.EASE_OUT)
	tween.tween_property(pad, "scale", Vector2(2, 2), 0.08).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
var hop_on_beat = false
func on_jump():
	hop_on_beat = is_on_beat()

func song_pos() -> float:
	return music.get_playback_position() + AudioServer.get_time_since_last_mix() - AudioServer.get_output_latency() - offset

func beat_len() -> float:
	return 60.0/bpm

func is_on_beat()-> bool:
	var phase = fmod(song_pos(), beat_len())
	return phase  <window or phase> beat_len() - window

func _process(delta: float) -> void:
	var b = int(song_pos()/beat_len())
	if b!= last_beat:
		last_beat = b
		beat.emit()
		
