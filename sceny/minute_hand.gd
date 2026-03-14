extends Node2D

var hand_length := 85.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var minute = Time.get_time_dict_from_system().minute
	var second = Time.get_time_dict_from_system().second
	rotation_degrees = minute * 6.0 + second*0.1
	queue_redraw()

func _draw() -> void:
	draw_line(Vector2.ZERO, Vector2(0, -hand_length), Color.RED, 5.0)
