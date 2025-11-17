class_name Car

extends RigidBody2D

enum AccelerationState {
	ACCELERATING,
	DECELERATING,
}

enum Variant {
	UNSET = -1,
	GREEN,
	RED,
	YELLOW,
}

const BODY_MASS = 50.0
const LINEAR_DAMP_DEFAULT = 1.0
const LINEAR_DAMP_BRAKE = 5.0
const VELOCITY_MAX = 100.0

const VARIANT_TEXTURES: Dictionary = {
	Variant.GREEN: "res://graphics/cars/green.png",
	Variant.RED: "res://graphics/cars/red.png",
	Variant.YELLOW: "res://graphics/cars/yellow.png",
}

var acceleration_state: AccelerationState = AccelerationState.ACCELERATING
var direction: Vector2 = Vector2.ZERO
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
	gravity_scale = 0.0
	linear_damp_mode = RigidBody2D.DAMP_MODE_REPLACE
	lock_rotation = true
	mass = BODY_MASS
	if variant != Variant.UNSET:
		sprite_renderer.texture = load(
			VARIANT_TEXTURES.get(variant, "res://graphics/cars/red.png")
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body


# Called once on each physics tick
func _physics_process(_delta: float) -> void:
	match acceleration_state:
		AccelerationState.ACCELERATING:
			constant_force = direction * VELOCITY_MAX * BODY_MASS
			linear_damp = LINEAR_DAMP_DEFAULT
			# If an obstacle is detected in the stop area, start decelerating
			if stop_area.is_colliding() == true:
				acceleration_state = AccelerationState.DECELERATING
		AccelerationState.DECELERATING:
			constant_force = Vector2.ZERO
			linear_damp = LINEAR_DAMP_BRAKE
			# If no obstacle is detected in the go area, start accelerating
			if go_area.is_colliding() == false:
				acceleration_state = AccelerationState.ACCELERATING
			# If nearly stopped, fully stop
			elif linear_velocity.x >= -2.0:
				linear_damp = LINEAR_DAMP_DEFAULT
				set_axis_velocity(Vector2.ZERO)
