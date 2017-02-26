extends Node2D

signal set_drag(d)
signal move(v)

var bounds = Rect2(Vector2(-20, -20), Vector2(40, 40))

func on_transform_change():
	bounds = get_viewport_rect()
	var r = get_global_transform().affine_inverse()
	var translatedpos = r.translated(bounds.pos)
	bounds = r.xform(bounds)
	
	update()

func _ready():
	on_transform_change()
	set_process(true)

func _process(delta):
	on_transform_change()

func _draw():
	draw_horizontal(bounds, -1, 1)
	draw_vertical(bounds, -1, 1)

# Draws horizontal gridlines
func draw_horizontal(b, minLevel, maxLevel):
	
	var x_begin = b.pos.x
	var x_end = b.pos.x + b.size.x
	
	for level in range(minLevel, maxLevel + 1):
		var scale = pow(10, level)
		for _y in range(b.pos.y / scale, (b.pos.y + b.size.y) / scale + 1):
			var y = scale * _y 
			draw_line(Vector2(x_begin, y), Vector2(x_end, y), Color(1, 1, 1), level - minLevel + 1)

# Draws vertical gridlines
func draw_vertical(b, minLevel, maxLevel):
	
	var y_begin = b.pos.y
	var y_end = b.pos.y + b.size.y
	
	for level in range(minLevel, maxLevel + 1):
		var scale = pow(10, level)
		for _x in range(b.pos.x / scale, (b.pos.x + b.size.x) / scale + 1):
			var x = scale * _x
			draw_line(Vector2(x, y_begin), Vector2(x, y_end), Color(1, 1, 1), level - minLevel + 1)

