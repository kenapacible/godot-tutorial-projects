extends CharacterBody2D

# Current movement direction
var direction: Vector2 = Vector2.DOWN

# Speed in pixels per second
var speed: float = 100

@onready var sprite_renderer: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var new_direction = Input.get_vector("left", "right", "up", "down")
	handle_direction_change(direction, new_direction)
	direction = new_direction


# Called once on each physics tick
func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()


# Handle changes in direction, or stopping
func handle_direction_change(_old_direction: Vector2, new_direction: Vector2):
	# If no movement, stop the animation at the first frame, otherwise start or continue playing it
	if new_direction == Vector2.ZERO:
		sprite_renderer.stop()
		sprite_renderer.frame = 0
	else:
		sprite_renderer.play()

	# Set animation based on direction. When moving diagonally, vertical movement takes precedence
	if new_direction.y > 0:
		sprite_renderer.animation = "down"
	elif new_direction.y < 0:
		sprite_renderer.animation = "up"
	elif new_direction.x > 0:
		sprite_renderer.animation = "right"
	elif new_direction.x < 0:
		sprite_renderer.animation = "left"
