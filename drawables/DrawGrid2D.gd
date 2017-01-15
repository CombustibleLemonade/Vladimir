tool
extends Node2D

export(Rect2) var bounds = Rect2(Vector2(-100, -100), Vector2(200, 200)) setget set_bounds
export(float) var scale = 20 setget set_scale
export(Color) var color = Color(0.1, 0.1, 0.1) setget set_color

func _ready():
	add_vector(Vector2(3, 1), "Vec1")

func set_bounds(b):
	bounds = b
	update()

func set_scale(s):
	scale = s
	update()

func set_color(c):
	color = c
	update()

func _draw():
	var b = bounds
	
	var start_x = ceil(b.pos.x)
	var end_x = ceil(b.end.x)
	
	for x in range(start_x, end_x):
		var start_pos = Vector2(x, b.pos.y) * scale
		var end_pos = Vector2(x, b.end.y) * scale
		
		var thickness = 1
		if x % 10 == 0: thickness += 1
		if x % 100 == 0: thickness += 1
		
		draw_line(start_pos, end_pos, color, thickness)
	
	var start_y = ceil(b.pos.y)
	var end_y = ceil(b.end.y)
	
	for y in range(start_y, end_y):
		var start_pos = Vector2(b.pos.x, y) * scale
		var end_pos = Vector2(b.end.x, y) * scale
		
		var thickness = 1
		if y % 10 == 0: thickness += 1
		if y % 100 == 0: thickness += 1
		
		draw_line(start_pos, end_pos, color, thickness)

# Add a vector to be displayed in the grid
func add_vector(v, name):
	var Vector2D = preload("DrawVector2D.tscn")
	var newvec = Vector2D.instance()
	
	newvec.set_name(name)
	newvec.target = v
	
	add_child(newvec)