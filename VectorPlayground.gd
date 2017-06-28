extends HBoxContainer

func _ready():
	get_node("VectorPlaygroundMenu").target_space = get_node("ZoomDragControl/ZoomDrag/2DPlane")
