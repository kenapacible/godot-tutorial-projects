extends Node2D

const CAR_SCENE: PackedScene = preload("res://scenes/car.tscn")

@export var spawn_parent: Node2D

@onready var car_spawners_container: Node2D = $CarSpawners

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if !spawn_parent:
		return
	var spawn_marker = car_spawners_container.get_children().pick_random() as Marker2D
	var new_car = CAR_SCENE.instantiate() as Car
	new_car.acceleration_state = Car.AccelerationState.ACCELERATING
	new_car.direction = Vector2.LEFT
	new_car.position = spawn_marker.position
	new_car.speed_current = new_car.speed_max
	new_car.variant = [
		Car.CarVariant.GREEN,
		Car.CarVariant.RED,
		Car.CarVariant.YELLOW,
	].pick_random()
	spawn_parent.add_child(new_car)


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
