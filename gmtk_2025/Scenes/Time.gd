extends Label

var tick = 0.1
var noon = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalPlayer.mins_elapsed += delta
	GlobalPlayer.hrs_elapsed += delta
	
	if GlobalPlayer.mins_elapsed >= tick:
		GlobalPlayer.minutes += 1
		GlobalPlayer.mins_elapsed = 0
	if GlobalPlayer.hrs_elapsed >= (tick * 60):
		if GlobalPlayer.hours != 12:
			GlobalPlayer.hours += 1
			if GlobalPlayer.hours >= 5 && noon:
				GlobalPlayer.night += 0.25
				$"../ColorRect".color.a = GlobalPlayer.night
		else:
			GlobalPlayer.hours = 1
			noon = true
		GlobalPlayer.minutes = 0
		GlobalPlayer.hrs_elapsed = 0
		
	if GlobalPlayer.hours >= 8 && noon:
		GlobalPlayer.X_pos = -180
		GlobalPlayer.Y_pos = 90
		GlobalPlayer.in_house = true
		GlobalPlayer.intro = true
		GlobalPlayer.hours = 8
		GlobalPlayer.minutes = 0
		get_tree().change_scene_to_file("res://Scenes/Rooms/House.tscn")
	
	if GlobalPlayer.minutes <= 9:
		text = str(GlobalPlayer.hours) + ":0" + str(GlobalPlayer.minutes)
	else:
		text = str(GlobalPlayer.hours) + ":" + str(GlobalPlayer.minutes)
