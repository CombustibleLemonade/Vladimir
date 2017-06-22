extends VBoxContainer

onready var global = get_node("/root/Global")

var identifiers = []

func add_vector():
	var menu = get_node("AddConfig/Vector")
	
	var x = menu.get_node("Coordinates/x").get_text()
	var y = menu.get_node("Coordinates/y").get_text()
	
	var name = menu.get_node("Name/LineEdit").get_text()
	
	var vec = global.Variable.new()
	vec.name = name
	vec.value = "Vector2(" + x + ", " + y + ")"
	
	identifiers.push_back(vec)
	global.evaluate(identifiers)
	
	print(identifiers.back().result)

func add_expression():
	var menu = get_node("AddConfig/Expression")
	
	var code = menu.get_node("Code").get_text()
	var name = menu.get_node("Name/LineEdit").get_text()
	
	var expr = global.Expression.new()
	expr.name = name
	expr.code = code
	
	identifiers.push_back(expr)
	global.evaluate(identifiers)
	
	print(identifiers.back().result)

