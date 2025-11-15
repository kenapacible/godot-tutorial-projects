class_name Car

extends CharacterBody2D

enum AccelerationState {
	ACCELERATING,
	DECELERATING,
	NONE,
}

enum Variant {
	UNSET = -1,
	GREEN,
	RED,
	YELLOW,
}

const VARIANT_TEXTURES: Dictionary = {
	Variant.GREEN: "res://graphics/cars/green.png",
	Variant.RED: "res://graphics/cars/red.png",
	Variant.YELLOW: "res://graphics/cars/yellow.png",
}

var acceleration_rate: float = 150.0
var acceleration_state: AccelerationState = AccelerationState.NONE
var deceleration_rate: float = 200.0
var direction: Vector2 = Vector2.ZERO
var speed_current: float = 0
var speed_max: float = 100.0
var variant: Variant:
	get:
		return variant
	set(value):
		variant = value
		if sprite_renderer and value != Variant.UNSET:
			sprite_renderer.texture = load(
				VARIANT_TEXTURES.get(value, "res://graphics/cars/red.png")
			)

@onready var go_area: ShapeCast2D = $GoArea
@onready var sprite_renderer: Sprite2D = $Sprite2D
@onready var stop_area: ShapeCast2D = $StopArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if variant != Variant.UNSET:
		sprite_renderer.texture = load(
			VARIANT_TEXTURES.get(variant, "res://graphics/cars/red.png")
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body


# Called once on each physics tick
func _physics_process(delta: float) -> void:
	# If accelerating and an obstacle is detected in the stop area, start decelerating
	if acceleration_state == AccelerationState.ACCELERATING and stop_area.is_colliding() == true:
		acceleration_state = AccelerationState.DECELERATING
	# If stopped, and no obstacle is detected in the go area, start accelerating
	elif acceleration_state == AccelerationState.NONE and go_area.is_colliding() == false:
		acceleration_state = AccelerationState.ACCELERATING

	# If there's an ongoing acceleration transition
	if acceleration_state == AccelerationState.ACCELERATING:
		speed_current = move_toward(speed_current, speed_max, acceleration_rate * delta)
	elif acceleration_state == AccelerationState.DECELERATING:
		speed_current = move_toward(speed_current, 0, deceleration_rate * delta)
		if speed_current == 0:
			acceleration_state = AccelerationState.NONE

	velocity = direction * speed_current
	move_and_slide()
