extends Node2D

func _ready():
	pass

# TODO: implement vector addition
func add_vector(identifier):
	var vector = preload("res://Arrow.tscn").instance()
	add_child(vector)
	return vector

# TODO: implement grid addition
func add_grid(identifier):
	print(identifier)

# TODO: implement removal
func remove(identifier):
	print(identifier)

