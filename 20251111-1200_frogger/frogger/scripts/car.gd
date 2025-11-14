class_name Car

extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var speed_current: float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass # Replace with function body


# Called once on each physics tick
func _physics_process(_delta: float) -> void:
	velocity = direction * speed_current
	move_and_slide()
