extends RayCast2D
class_name GridMovementComponent
## WHEN YOU ADD THIS CLASS, MAKE SURE "up", "down", "left", AND "right"
## ARE IN THE INPUT MAP


## Tile size (if a tile was 16x16 this'd be 16)
@export var tile_size := 8

## Player, defaults to parent but should be set
@export var plr: CharacterBody2D = get_parent()


var inputs = {
	"W": Vector2.UP,
	"S": Vector2.DOWN,
	"A": Vector2.LEFT,
	"D": Vector2.RIGHT
}

func _input(_event):
	for dir in inputs.keys():
		if Input.is_action_just_pressed(dir):
			target_position = inputs[dir] * tile_size
			
			request_move()

func _ready():
	plr.position = plr.position.snapped(Vector2.ONE * tile_size)
	plr.position += Vector2.ONE * tile_size/2

func request_move():
	force_raycast_update()
	if not is_colliding():
		plr.position += target_position
