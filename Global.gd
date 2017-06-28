extends Node

class Identifier:
	var name = ""
	var code = ""
	var refresh = true
	var result

class Expression:
	extends Identifier

class Variable:
	extends Identifier

func evaluate(identifiers):
	var source_code = ""
	
	for id in identifiers:
		if id extends Expression:
			var v = "var " + id.name + " = f_" + id.name + "()\n"
			var e = "func f_" + id.name + "():\n\treturn " + id.code + "\n"
			
			source_code += v + e
		elif id extends Variable:
			var v = "var " + id.name + " = " + id.code + "\n"
			source_code += v
	
	var script = GDScript.new()
	script.set_source_code(source_code)
	script.reload()
	
	var obj = Reference.new()
	obj.set_script(script)
	
	for id in identifiers:
		id.result = obj.get(id.name)
