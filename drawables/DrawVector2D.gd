tool
extends Polygon2D

export(Vector2) var target = Vector2() setget set_target_pos
export(int) var thickness = 1
export(float) var scale = 100.0
export(float) var cut = 3 # Amount to cut off the end

var vecArr = []

func _ready():
	set_process(true)

func _process(delta):
	on_target_change()

func on_target_change():
	target = get_node("Target").get_pos() / scale
	
	var l = 1 - cut / (target.length() * scale)
	
	vecArr = []
	vecArr.push_back(Vector2(0, -thickness))
	vecArr.push_back(Vector2(l, -thickness))
	vecArr.push_back(Vector2(0, thickness))
	vecArr.push_back(Vector2(l, -thickness))
	vecArr.push_back(Vector2(0, thickness))
	vecArr.push_back(Vector2(l, thickness))
	
	for i in range(vecArr.size()):
		var v = vecArr[i]
		v = Vector2(v.x * target.length() * scale, v.y)
		v = v.rotated(target.angle() - PI/2)
		vecArr[i] = v
	
	set_polygon(vecArr)
	get_node("Target").set_rot(target.angle())

func set_target_pos(t):
	if not has_node("Target"):
		return
	
	target = t
	var target_node = get_node("Target")
	target_node.set_pos(target * scale)
