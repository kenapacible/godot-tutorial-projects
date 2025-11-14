extends Node2D

@onready var car_spawners_container: Node2D = $CarSpawners

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var car_spawner = car_spawners_container.get_children().pick_random() as CarSpawner
	car_spawner.spawn()


func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
