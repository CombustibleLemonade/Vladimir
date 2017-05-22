tool

extends Node2D

var target_pos setget set_target_pos,get_target_pos
var target_rotation setget ,get_target_rotation

var crop = 10
var thickness = 3

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	update()
	get_node("Target").update()

func set_target_pos(p):
	get_node("Target").set_pos(p)

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
	
	draw_colored_polygon(verts, Color(1, 1, 1))

func _on_target_item_rect_changed():
	print("asdf")

var base_pos = Vector2()
func input_event( ev ):
	
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == BUTTON_LEFT:
			base_pos = get_node("Target").get_pos()
	
	if ev.type == InputEvent.MOUSE_MOTION:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			var tpos = get_node("Target").get_pos()
			get_node("Target").set_pos(tpos + ev.relative_pos / get_global_scale())


