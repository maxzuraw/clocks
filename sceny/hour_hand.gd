extends Node2D

var hand_length := 70.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = Time.get_time_dict_from_system()
	var hour: int = time.hour
	var minute: int = time.minute
	var second: int = time.second
	rotation_degrees = (hour % 12) * 30.0 + minute * 0.5
	queue_redraw()
	

func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(0, -hand_length), Color.RED, 10.0)
