extends HBoxContainer

var name = "name"
onready var x = get_node("x")
onready var y = get_node("y")

func set_vector(vec):
	name = vec.get_name()
	var v = vec.target
	
	x.set_text(str(v.x))
	y.set_text(str(v.y))
	get_node("name").set_text(name)
	
	if !vec.is_connected("change", self, "set_vector"):
		vec.connect("change", self, "set_vector", [vec])
