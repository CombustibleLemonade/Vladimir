tool
extends Node2D

export(NodePath) var target_node_path = null setget set_target_node_path
var target_node = null
export(Vector2) var target = null setget set_target

var cached_target
var cached_pos

export(int) var width = 4 setget set_width

export(float) var start_offset = 0 setget set_start_offset
export(float) var end_offset = 0 setget set_end_offset
export(float) var side_offset = 0 setget set_side_offset

export(Color) var color = null setget set_color

export(bool) var editor_only = false

func _enter_tree():
	if is_visible():
		set_process(true)

func _ready():
	if is_visible():
		set_process(true)

func _draw():
	if not is_visible():
		return
	
	if target == null:
		return
	
	if color == null:
		color = Color(1,1,1,1)
	
	var points = Vector2Array()
	var colors = ColorArray()
	
	var arrowvec = target - get_global_pos()
	var sidedir = Vector2(arrowvec.y, -arrowvec.x).normalized()
	var sidevec = sidedir * width * 0.5
	var pointvec = arrowvec.normalized() * width
	
	var startoffset = arrowvec.normalized() * start_offset
	var endoffset = -arrowvec.normalized() * end_offset
	var sideoffset = sidedir * side_offset
	
	points.append(sideoffset + startoffset + sidevec)
	colors.append(color)
	points.append(sideoffset + endoffset + sidevec + arrowvec - pointvec)
	colors.append(color)
	points.append(sideoffset + endoffset + 2*sidevec + arrowvec - pointvec)
	colors.append(color)
	points.append(sideoffset + endoffset + arrowvec)
	colors.append(color)
	points.append(sideoffset + endoffset - 2*sidevec + arrowvec - pointvec)
	colors.append(color)
	points.append(sideoffset + endoffset - sidevec + arrowvec - pointvec)
	colors.append(color)
	points.append(sideoffset + startoffset - sidevec)
	colors.append(color)
	
	self.draw_polygon(points, colors)

func set_target(p_target):
	if p_target != cached_target:
		target = p_target
		cached_target = target
		update()

func set_width(p_width):
	width = p_width
	update()

func set_target_node_path(p_target_node_path):
	target_node_path = p_target_node_path
	if null == target_node_path:
		target_node = null
		target = null
	else:
		target_node = get_node(target_node_path)
		if target_node == null:
			target = null

func _process(delta):
	if target_node != null:
		set_target(target_node.get_global_pos())
	if get_global_pos() != cached_pos:
		cached_pos = get_global_pos()
		update()

func is_visible():
	return not editor_only or get_tree().is_editor_hint()

func set_start_offset(value):
	start_offset = value
	update()

func set_end_offset(value):
	end_offset = value
	update()

func set_side_offset(value):
	side_offset = value
	update()

func set_color(value):
	color = value
	update()

