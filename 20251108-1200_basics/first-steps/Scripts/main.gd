extends Node2D

# Screen dimensions
var screen_height: int = 0
var screen_width: int = 0

# Speed of the sprite in pixels per second
var sprite_speed: Vector2 = Vector2.ZERO

@onready var godot_logo = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the screen dimensions
	screen_height = get_viewport().size.y
	screen_width = get_viewport().size.x

	# Initialize the sprite's speed based on the screen size
	sprite_speed = Vector2(
		screen_width / 2.0,  # Move half the screen width per second
		screen_height / 3.0,  # Move half of the screen height per second
	)


# Called every frame. 'delta_seconds' is the elapsed time since the previous frame.
func _process(delta_seconds: float) -> void:
	# Make sure the screen dimensions are valid
	if screen_height == 0 or screen_width == 0:
		return

	var did_hit_edge: bool = false

	# If the sprite reaches the left edge of the screen
	if godot_logo.position.x < 0:
		did_hit_edge = true
		# Change its horizontal direction to right
		sprite_speed.x = abs(sprite_speed.x)

	# If the sprite reaches the right edge of the screen
	if godot_logo.position.x > screen_width:
		did_hit_edge = true
		# Change its horizontal direction to left
		sprite_speed.x = -abs(sprite_speed.x)

	# If the sprite reaches the top edge of the screen
	if godot_logo.position.y < 0:
		did_hit_edge = true
		# Change its vertical direction to down
		sprite_speed.y = abs(sprite_speed.y)

	# If the sprite reaches the bottom edge of the screen
	if godot_logo.position.y > screen_height:
		did_hit_edge = true
		# Change its vertical direction to up
		sprite_speed.y = -abs(sprite_speed.y)

	# If the sprite hit any edge
	if did_hit_edge:
		# Change the sprite's color to a random color
		godot_logo.modulate = Color(randf(), randf(), randf())

	# Update the sprite's position based on its speed and the elapsed time
	godot_logo.position += sprite_speed * delta_seconds;
