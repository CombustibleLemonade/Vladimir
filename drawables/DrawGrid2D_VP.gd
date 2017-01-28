extends Control

var scale_ratio = 1.1

func _ready():
	set_process_input(true)

func _input(event):
	var c = get_node("Viewport/Camera")
	
	if event.type == InputEvent.MOUSE_MOTION and Input.is_action_pressed("move_view"):
		var d = c.get_node("DrawGrid2D")
		d.set_pos(d.get_pos() + event.relative_pos / c.get_scale().x)
	if event.is_action_pressed("zoom_in"):
		c.scale(Vector2(1, 1) * scale_ratio)
	if event.is_action_pressed("zoom_out"):
		c.scale(Vector2(1, 1) / scale_ratio)
	
	# Pass the event to the viewport
	var vp = get_node("Viewport")
	var r = vp.get_rect()
	
	get_node("Viewport").input(event)

# Gets called when the viewport size changes
func viewport_size_changed():
	var vp = get_node("Viewport")
	var p = vp.get_rect().size / 2
	get_node("Viewport/Camera").set_pos(p)
