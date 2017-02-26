tool
extends EditorPlugin

var icon = preload("res://addons/de.lkokemohr.arrow/icon_arrow.png")
var arrowclass = preload("res://addons/de.lkokemohr.arrow/Arrow.gd")

func _enter_tree():
	add_custom_type("Arrow", "Node2D", arrowclass, icon)

func _exit_tree():
	remove_custom_type("Arrow")