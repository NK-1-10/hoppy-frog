extends CharacterBody2D
@onready var frog = $"."
var moving = false
var can_hurt = true
var stunned = false

var y = 557

func _ready() -> void:
	frog.position = Vector2(546, 557.0)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right") and not moving and not stunned:
		if Global.currentx == 870:
			return
		else: 
			jump("right")
			$Sprite2D.flip_h = true
	elif Input.is_action_just_pressed("ui_left") and not moving and not stunned:
		if Global.currentx == 222:
			return
		else: 
			jump("left")
			$Sprite2D.flip_h = false
		
	

func jump(where):
	moving = true
	$Sprite2D.frame = 1
	var height = -40
	var how_much
	var s = 162
	if where == "right":
		how_much = s
	else: how_much = -s
	var tween = create_tween()
	var tween2 = create_tween()
	Global.currentx = Global.currentx + how_much
	tween2.tween_property(self, "position:y", y+height, 0.25)
	tween.tween_property(self, "position:x", Global.currentx , 0.5)
	tween2.tween_property(self, "position:y", y, 0.25)
	await tween.finished
	$Sprite2D.frame = 0
	print(Global.currentx)
	Signals.landed.emit()
	moving = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("avoidable") and can_hurt and not stunned:
		Global.Loosehearts()
		can_hurt = false
		stunned= true
		for i in 6:
			self.visible = false
			await get_tree().create_timer(0.08).timeout 
			self.visible = true
			await get_tree().create_timer(0.08).timeout 
		can_hurt = true
		stunned= false
		
