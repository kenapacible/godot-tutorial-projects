class_name Car

extends CharacterBody2D

enum CarVariant {
	UNSET = -1,
	GREEN,
	RED,
	YELLOW,
}

const VARIANT_TEXTURES: Dictionary = {
	CarVariant.GREEN: "res://graphics/cars/green.png",
	CarVariant.RED: "res://graphics/cars/red.png",
	CarVariant.YELLOW: "res://graphics/cars/yellow.png",
}

var direction: Vector2 = Vector2.ZERO
var speed_current: float = 100.0
var variant: CarVariant:
	get:
		return variant
	set(value):
		variant = value
		if sprite_renderer and value != CarVariant.UNSET:
			sprite_renderer.texture = load(
				VARIANT_TEXTURES.get(value, "res://graphics/cars/red.png")
			)

@onready var sprite_renderer: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if variant != CarVariant.UNSET:
		sprite_renderer.texture = load(
			VARIANT_TEXTURES.get(variant, "res://graphics/cars/red.png")
		)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body


# Called once on each physics tick
func _physics_process(_delta: float) -> void:
	velocity = direction * speed_current
	move_and_slide()
