tool
extends Polygon2D

signal change

export(Vector2) var target = Vector2() setget set_target_pos
export(int) var thickness = 1
export(float) var scale = 100.0
export(float) var cut = 3 # Amount to cut off the end
export(bool) var editable = true

var vecArr = []
var is_moving = false

func _ready():
	set_process(true)
	set_process_input(true)

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
	get_node("Target/TargetRotated").set_rot(target.angle())
	get_node("Target/Label").set_text(str(target))
	
	emit_signal("change")

func set_target_pos(t):
	if not has_node("Target"):
		return
	
	target = t
	var target_node = get_node("Target")
	target_node.set_pos(target * scale)
	
	on_target_change()

func target_input_event( event ):
	if event.type == InputEvent.MOUSE_MOTION and Input.is_action_pressed("drag_object"):
		is_moving = true

func _input(event):
	if is_moving and event.type == InputEvent.MOUSE_MOTION:
		var t = get_node("Target")
		t.set_global_pos(t.get_global_pos() + Vector2(event.relative_x, event.relative_y))
		on_target_change()
	if event.is_action_released("drag_object"):
		is_moving = false
