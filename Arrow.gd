tool

extends Node2D

signal target_change

export(Vector2) var target_pos setget set_target_pos,get_target_pos
export(Vector2) var target_rotation setget ,get_target_rotation

var crop = 20
var thickness = 3
var is_disabled = false
var color = Color(1, 1, 1)

func _ready():
	set_process(true)
	set_process_input(true)

var previous_pos = Vector2()
func _process(delta):
	redraw()
	if get_node("Target").get_pos() != previous_pos:
		previous_pos = get_node("Target").get_pos()
		emit_signal("target_change")

func redraw():
	update()
	get_node("Target").update()

func set_disabled(var _is_disabled):
	is_disabled = _is_disabled
	if is_disabled:
		color = Color(1.0, 1.0, 1.0, 0.5)
		get_node("Target/Control").hide()
	else:
		color = Color(1.0, 1.0, 1.0)
		get_node("Target/Control").show()
	
	print(is_disabled)
	redraw()

func set_target_pos(p):
	if has_node("Target"):
		get_node("Target").set_pos(p)
		previous_pos = p

func get_target_pos():
	return get_node("Target").get_pos()

func get_target_rotation():
	return get_target_pos().angle()

func _draw():
	var length = get_node("Target").get_pos().length() * get_global_scale().x - crop
	var angle = get_node("Target").get_pos().angle()
	
	var verts = [
		Vector2(thickness, 0),
		Vector2(-thickness, 0),
		Vector2(-thickness, length),
		Vector2(thickness, length)
	]
	
	for i in range(verts.size()):
		verts[i] = verts[i].rotated(angle)
		verts[i] /= get_global_scale()
	
	draw_colored_polygon(verts, color)

func _on_target_item_rect_changed():
	print("asdf")

var base_pos = Vector2()
func input_event( ev ):
	if is_disabled:
		return
	
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == BUTTON_LEFT:
			base_pos = get_node("Target").get_pos()
	
	if ev.type == InputEvent.MOUSE_MOTION:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var tpos = get_node("Target").get_pos()
			get_node("Target").set_pos(tpos + ev.relative_pos / get_global_scale())


