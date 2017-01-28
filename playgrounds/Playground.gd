extends CanvasItem

var vector_listing_class = preload("res://gui/VectorListing.tscn")

# Gets called when the add vector button is pressed
func add_vector(vec):
	var v_listing = vector_listing_class.instance()
	var v_obj = get_node("Grid/Viewport/Camera/DrawGrid2D").add_vector(vec.vec, vec.name)
	
	get_node("Menu").add_child(v_listing)
	v_listing.set_vector(v_obj)

