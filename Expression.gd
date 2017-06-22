extends HBoxContainer

onready var global = get_node("/root/Global")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func expression_changed( text ):
	return
	global.evaluate(text)

func expression_entered( text ):
	var e = global.evaluate(text)
	get_node("Evaluation").set_text(str(e))

