extends CanvasItem

var scale_ratio = 1.1

func _ready():
	set_process_input(true)

func _input(event):
	var c = get_node("Grid/Viewport/Camera")
	
	if event.type == InputEvent.MOUSE_MOTION and Input.is_action_pressed("move_view"):
		var d = c.get_node("DrawGrid2D")
		d.set_pos(d.get_pos() + event.relative_pos / c.get_scale().x)
	if event.is_action_pressed("zoom_in"):
		c.scale(Vector2(1, 1) * scale_ratio)
	if event.is_action_pressed("zoom_out"):
		c.scale(Vector2(1, 1) / scale_ratio)
	
	# Pass the event to the viewport
	var vp = get_node("Grid/Viewport")
	var r = vp.get_rect()
	
	get_node("Grid/Viewport").input(event)

# Gets called when the viewport size changes
func viewport_size_changed():
	var vp = get_node("Grid/Viewport")
	var p = vp.get_rect().size / 2
	get_node("Grid/Viewport/Camera").set_pos(p)

# Gets called when the add vector button is pressed
func on_add_vector_button_pressed():
	var x_str = get_node("Menu/AddVectorMenu/Values/x").get_text()
	var y_str = get_node("Menu/AddVectorMenu/Values/y").get_text()
	var vec = Vector2(float(x_str), float(y_str))
	
	var name = get_node("Menu/AddVectorMenu/Name").get_text()
	
	var vec_obj = get_node("Grid/Viewport/Camera/DrawGrid2D").add_vector(vec, name)
	
	var vector_listing_class = preload("res://gui/VectorListing.tscn")
	var vector_listing = vector_listing_class.instance()
	
	get_node("Menu").add_child(vector_listing)
	vector_listing.set_vector(vec_obj)
