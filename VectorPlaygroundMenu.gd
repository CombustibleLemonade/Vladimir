extends VBoxContainer

onready var global = get_node("/root/Global")

var identifiers = []
var target_space

# Add a vector when the add vector button is pressed
func add_vector():
	var menu = get_node("AddConfig/Vector")
	
	var x = menu.get_node("Coordinates/x").get_text()
	var y = menu.get_node("Coordinates/y").get_text()
	
	var name = menu.get_node("Name/LineEdit").get_text()
	
	var vec = global.Variable.new()
	vec.name = name
	vec.code = "Vector2(" + x + ", " + y + ")"
	vec.result = Vector2()
	
	add_identifier(vec)

# Add an expression when the add expression button is pressed
func add_expression():
	var menu = get_node("AddConfig/Expression")
	
	var code = menu.get_node("Code").get_text()
	var name = menu.get_node("Name/LineEdit").get_text()
	
	var expr = global.Expression.new()
	expr.name = name
	expr.code = code
	
	add_identifier(expr)

# Add an identifier
func add_identifier(identifier):
	if identifiers.size() > 0:
		get_node("IdentifierList").add_child(HSeparator.new())
	
	identifiers.push_back(identifier)
	
	var node = get_identifier_node(identifier)
	get_node("IdentifierList").add_child(node)
	node.connect("expression_entered", self, "evaluate")
	
	evaluate()

# (re-)evaluates all expressions
func evaluate():
	global.evaluate(identifiers)
	handle_evaluation()

# Updates the evaluation result to all items in the menu
func handle_evaluation():
	var list = get_node("IdentifierList")
	var children = list.get_children()
	
	for c in children:
		if c.has_method("update_expression"):
			c.update_expression()

# Get the node for a certain identifier
func get_identifier_node(identifier):
	var node
	
	if identifier extends global.Expression:
		node = preload("res://Expression.tscn").instance()
		node.identifier = identifier
		
		#get_node("IdentifierList").add_child(node)
		
		node.set_name_text(identifier.name)
		node.set_code_text(identifier.code)
	
	if identifier extends global.Variable and typeof(identifier.result) == typeof(Vector2()):
		node = preload("res://Vector.tscn").instance()
		node.identifier = identifier
		
		node.get_node("NameContainer/Name").set_text(identifier.name)
	
	add_vector_visualizer(node)
	
	return node

# Add the visualizer for a vector
func add_vector_visualizer(node):
	var visualizer = target_space.add_vector(node.identifier)
	node.vector_visualization = visualizer
	
	if node.has_method("vector_visualization_drag"):
		visualizer.connect("target_change", node, "vector_visualization_drag")

