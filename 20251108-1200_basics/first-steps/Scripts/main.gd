extends Node2D

# Screen dimensions
var screenHeight: int = 0
var screenWidth: int = 0

# Speed of the sprite in pixels per second
var spriteSpeedX: float = 0.0
var spriteSpeedY: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the screen dimensions
	screenHeight = get_viewport().size.y
	screenWidth = get_viewport().size.x

	# Initialize the sprite's speed based on the screen size
	spriteSpeedX = screenWidth / 2.0  # Move half the screen width per second
	spriteSpeedY = screenHeight / 3.0  # Move half of the screen height per second


# Called every frame. 'deltaSeconds' is the elapsed time since the previous frame.
func _process(deltaSeconds: float) -> void:
	# Make sure the screen dimensions are valid
	if screenHeight == 0 or screenWidth == 0:
		return

	# If the sprite reaches the right or left edge of the screen, reverse its horizontal direction
	if $Sprite2D.position.x > screenWidth or $Sprite2D.position.x < 0:
		spriteSpeedX = -spriteSpeedX

	# If the sprite reaches the top or bottom edge of the screen, reverse its vertical direction
	if $Sprite2D.position.y > screenHeight or $Sprite2D.position.y < 0:
		spriteSpeedY = -spriteSpeedY

	# Update the sprite's position based on its speed and the elapsed time
	$Sprite2D.position.x += spriteSpeedX * deltaSeconds;
	$Sprite2D.position.y += spriteSpeedY * deltaSeconds;
