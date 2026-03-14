extends Button

@export var onTopIcon: Texture2D
@export var onBottomIcon: Texture2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_toggled(button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		icon = onTopIcon
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, true)
	else :
		icon = onBottomIcon
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_ALWAYS_ON_TOP, false)
