extends MenuBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_show_hide_menu_toggled(toggled_on: bool) -> void:
	if toggled_on:
		show()
	elif !toggled_on:
		hide()
