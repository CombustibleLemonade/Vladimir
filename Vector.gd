extends VBoxContainer

signal expression_entered

var identifier
var vector_visualization setget set_vector_visualization

func set_name(name):
	get_node("NameContainer/Name").set_text(name)

func set_vector_visualization(v):
	vector_visualization = v

# TODO: implement
func vector_visualization_drag():
	var pos = vector_visualization.get_target_pos()
	set_coordinates_text(pos)
	expression_entered("")

func update_expression():
	var vec = identifier.result
	set_coordinates_text(vec)
	vector_visualization.set_target_pos(vec)

func set_coordinates_text(var vec):
	get_node("Coordinates/x").set_text(str(vec.x))
	get_node("Coordinates/y").set_text(str(vec.y))

func expression_entered(text):
	var x = get_node("Coordinates/x").get_text()
	var y = get_node("Coordinates/y").get_text()
	
	identifier.code = "Vector2(" + x + "," + y + ")"
	emit_signal("expression_entered")
