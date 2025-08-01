extends CharacterBody2D

var MOVE_SPEED_Y = 0
var MOVE_SPEED_X = 0
var mult = GlobalPlayer.max_speed
var moving = 0
var squish = 33
var slow = false

func _ready() -> void:
	print(GlobalPlayer.intro)
	if get_tree().current_scene.name == "Main":
		position = Vector2(GlobalPlayer.X_pos, GlobalPlayer.Y_pos)
	if GlobalPlayer.intro:
		GlobalPlayer.intro = false
		position = Vector2(-50, 12)

func _physics_process(delta: float) -> void:
	if get_tree().current_scene.name == "Main":
		GlobalPlayer.X_pos = position.x
		GlobalPlayer.Y_pos = position.y
		GlobalPlayer.in_house = false
	else:
		GlobalPlayer.in_house = true
	
	$Camera2D.zoom.x = 4.75
	$Camera2D.zoom.y = 4.75
	if GlobalPlayer.in_house:
		slow = true
		$Camera2D.zoom.x *= 2
		$Camera2D.zoom.y *= 2
	
	moving = 0
	
	# Update player scale based on movement direction
	if MOVE_SPEED_X == 0 && MOVE_SPEED_Y == 0:
		scale = Vector2(1, 1).normalized() * 1.3
	elif MOVE_SPEED_Y == 0:
		scale = Vector2(abs(MOVE_SPEED_X / squish), 1).normalized() * 1.3
	elif MOVE_SPEED_X == 0:
		scale = Vector2(1, abs(MOVE_SPEED_Y / squish)).normalized() * 1.3
	else:
		scale = Vector2(abs(MOVE_SPEED_X / squish), abs(MOVE_SPEED_Y / squish)).normalized() * 1.3
	
	var directionX := Input.get_axis("A", "D")
	if directionX != 0:
		moving += 1
		# Reset speed if changing direction
		if sign(MOVE_SPEED_X) != sign(directionX):
			MOVE_SPEED_X = 0
		MOVE_SPEED_X += directionX * GlobalPlayer.acceleration
		MOVE_SPEED_X = clamp(MOVE_SPEED_X, -GlobalPlayer.max_speed, GlobalPlayer.max_speed)
	else:
		moving -= 1
		MOVE_SPEED_X = move_toward(MOVE_SPEED_X, 0, GlobalPlayer.acceleration)


	var directionY := Input.get_axis("W", "S")
	if directionY != 0:
		moving += 1
		if sign(MOVE_SPEED_Y) != sign(directionY):
			MOVE_SPEED_Y = 0
		MOVE_SPEED_Y += directionY * GlobalPlayer.acceleration
		MOVE_SPEED_Y = clamp(MOVE_SPEED_Y, -GlobalPlayer.max_speed, GlobalPlayer.max_speed)
	else:
		moving -= 1
		MOVE_SPEED_Y = move_toward(MOVE_SPEED_Y, 0, GlobalPlayer.acceleration)
		
	if moving >= 0:
		$AnimatedSprite2D.play("Walking")
	else:
		$AnimatedSprite2D.play("Idling")
	
	if !slow:
		velocity = Vector2(MOVE_SPEED_X, MOVE_SPEED_Y).normalized() * mult
	else:
		velocity = (Vector2(MOVE_SPEED_X, MOVE_SPEED_Y).normalized() * mult) / 1.5
	move_and_slide()
