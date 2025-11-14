class_name CarSpawner

extends Marker2D

const car_scene: PackedScene = preload("res://scenes/car.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn():
	var new_car = car_scene.instantiate() as Car
	new_car.direction = Vector2.LEFT
	add_child(new_car)
