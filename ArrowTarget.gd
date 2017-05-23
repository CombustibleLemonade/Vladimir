tool

extends Node2D

func _ready():
	set_process(true)

func _process(delta):
	# Keep global scale constant at Vector2(1, 1)
	set_scale(get_scale() / get_global_scale())
	
	get_node("Control").set_scale(Vector2(1, 1) / get_global_scale())
	get_node("Control").set_pos(- Vector2(20, 20) / get_global_scale())

# Set position override triggering drawing procedure
func set_pos(p):
	if get_pos() == p:
		return
	
	.set_pos(p)
	update()

func _draw():
	var pos = get_pos()
	var angle = pos.angle()
	
	var verts = [
		Vector2(),
		Vector2(-1, -2),
		Vector2(1, -2),
	]
	
	for i in range(verts.size()):
		verts[i] = verts[i].rotated(angle)
		verts[i] *= 10
		verts[i] /= get_global_scale()
	
	draw_colored_polygon(verts, Color(1, 1, 1))
