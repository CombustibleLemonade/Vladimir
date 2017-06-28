extends VBoxContainer

signal expression_entered

onready var global = get_node("/root/Global")
var identifier
var vector_visualization setget set_vector_visualization

func set_vector_visualization(v):
	vector_visualization = v
	vector_visualization.set_disabled(true)

func expression_entered( text ):
	identifier.code = text
	emit_signal("expression_entered")

func name_entered( text ):
	identifier.name = text

func update_expression():
	var res = identifier.result
	get_node("Metadata/Evaluation").set_text(str(res))
	
	if typeof(res) == typeof(Vector2()):
		vector_visualization.set_target_pos(res)
		vector_visualization.show()
	else:
		vector_visualization.hide()

func set_name_text(text):
	get_node("Metadata/Name").set_text(str(text))

func set_code_text(text):
	get_node("Code").set_text(str(text))
