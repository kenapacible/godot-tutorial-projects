extends Node2D

# Screen dimensions
var screen_height: int = 0
var screen_width: int = 0

# Speed of the sprite in pixels per second
var sprite_speed_x: float = 0.0
var sprite_speed_y: float = 0.0

@onready var godot_logo = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the screen dimensions
	screen_height = get_viewport().size.y
	screen_width = get_viewport().size.x

	# Initialize the sprite's speed based on the screen size
	sprite_speed_x = screen_width / 2.0  # Move half the screen width per second
	sprite_speed_y = screen_height / 3.0  # Move half of the screen height per second


# Called every frame. 'delta_seconds' is the elapsed time since the previous frame.
func _process(delta_seconds: float) -> void:
	# Make sure the screen dimensions are valid
	if screen_height == 0 or screen_width == 0:
		return

	# If the sprite reaches the right or left edge of the screen
	if godot_logo.position.x > screen_width or godot_logo.position.x < 0:
		# Reverse its horizontal direction
		sprite_speed_x = -sprite_speed_x
		# Change the sprite's color to a random color
		godot_logo.modulate = Color(randf(), randf(), randf())

	# If the sprite reaches the top or bottom edge of the screen
	if godot_logo.position.y > screen_height or godot_logo.position.y < 0:
		# Reverse its vertical direction
		sprite_speed_y = -sprite_speed_y
		# Change the sprite's color to a random color
		godot_logo.modulate = Color(randf(), randf(), randf())

	# Update the sprite's position based on its speed and the elapsed time
	godot_logo.position.x += sprite_speed_x * delta_seconds;
	godot_logo.position.y += sprite_speed_y * delta_seconds;
