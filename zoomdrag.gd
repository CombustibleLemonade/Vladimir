extends Viewport

export(String, FILE, "*.tscn") var environment
export(float) var zoom_factor = 1.1
export(bool) var zoom_to_cursor = true

var instance
var drag = false

func _ready():
	set_process_input(true)
	
	instance = load(environment).instance()
	add_child(instance)
	
	instance.translate(get_rect().size / 2)

func _input(event):
	if drag and event.type == InputEvent.MOUSE_MOTION:
		move(event.relative_pos)
	
	if event.is_action_pressed("move_view"):
		set_drag(true)
	if event.is_action_released("move_view"):
		set_drag(false)
	
	if event.is_action_pressed("zoom_in"):
		zoom(zoom_factor)
	if event.is_action_pressed("zoom_out"):
		zoom(1/zoom_factor)

func zoom(factor):
	var s = get_rect().size
	var pivot = s/2
	if(zoom_to_cursor):
		pivot = get_mouse_pos()
	
	instance.translate(-pivot)
	
	var p = instance.get_pos()
	
	instance.scale(Vector2(factor, factor))
	instance.set_pos( p * factor)
	
	instance.translate(pivot)

func set_drag(d):
	drag = d

func move(v):
	instance.translate(v)
