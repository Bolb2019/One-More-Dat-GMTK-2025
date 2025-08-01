extends Area2D

var time = 0
var switch = false
var start = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../../CanvasLayer".visible = true
	if name != "Home" && name != "Exit":
		start = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	
	if Input.is_action_just_pressed("E"):
		time = 0
	
	if time <= 1.1 && start:
		$"../../CanvasLayer/ColorRect".color.a -= delta
	else:
		start = false
	
	if time <= 1.1 && switch:
		$"../../CanvasLayer/ColorRect".color.a += delta
		if time >= 1:
			switch = false
			if name == "Home":
				get_tree().change_scene_to_file("res://Scenes/Rooms/House.tscn")
			if name == "Basement":
				get_tree().change_scene_to_file("res://Scenes/Rooms/Basement.tscn")
			if name == "Inn":
				get_tree().change_scene_to_file("res://Scenes/Rooms/Inn.tscn")
			if name == "Shop":
				get_tree().change_scene_to_file("res://Scenes/Rooms/Shop.tscn")
			if name == "Office":
				get_tree().change_scene_to_file("res://Scenes/Rooms/Office.tscn")
			if name == "Kitchen":
				get_tree().change_scene_to_file("res://Scenes/Rooms/Kitchen.tscn")
			elif name == "Exit":
				get_tree().change_scene_to_file("res://Scenes/Main.tscn")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && time >= 1.2:
		$"../../Player/Sprite2D".visible = true
		switch = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player" && time >= 1.2:
		$"../../Player/Sprite2D".visible = false
		switch = false
