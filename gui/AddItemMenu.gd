extends VBoxContainer

signal add_item(item)

class Item:
	var name = ""

class VectorItem:
	extends Item
	var vec = Vector2()

func on_add_item_pressed():
	var item = VectorItem.new()
	
	var x = float(get_node("Values/x").get_text())
	var y = float(get_node("Values/y").get_text())
	var name = get_node("Name").get_text()
	
	item.vec = Vector2(x, y)
	item.name = name
	
	emit_signal("add_item", item)
