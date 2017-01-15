extends Node2D

var scale_ratio = 1.1

func _ready():
	set_process_input(true)
	set_process(true)
	set_pos(OS.get_window_size() / 2)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION and Input.is_action_pressed("move_view"):
		var d = get_node("DrawGrid2D")
		d.set_pos(d.get_pos() + event.relative_pos / get_scale().x)
	if event.is_action_pressed("zoom_in"):
		scale(Vector2(1, 1) * scale_ratio)
	if event.is_action_pressed("zoom_out"):
		scale(Vector2(1, 1) / scale_ratio)
