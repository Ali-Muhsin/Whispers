extends Node
class_name dataManage

var items: Dictionary

func _ready() -> void:
	items = readFromJSON("res://JSON/itemData.json")

func setInfo(objName: String, property: String, newProperty) -> void:
	if items.has(objName):
		var item = items[objName]
		if item.has(property):
			item[property] = newProperty
			saveToJSON("res://Save/items.json", items)
			print(property, " updated for ", objName)
		else:
			print(objName, " does not have ", property, " property")
	else:
		print("Item not found: ", objName)

func readFromJSON(path: String) -> Dictionary:
	var file = File.new()
	var data: Dictionary
	if file.file_exists(path):
		file.open(path, File.READ)
		data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		printerr("Invalid path given")
		return data

func saveToJSON(path: String, data: Dictionary) -> void:
	var file = File.new()
	file.open(path, File.WRITE)
	var jsonText = JSON.print(data)  # Use JSON.print to convert dictionary to JSON
	file.store_string(jsonText)
	file.close()

func getItemByKey(key: String) -> Dictionary:
	if items and items.has(key):
		return items[key].duplicate(true)
	else:
		var a: Dictionary
		return a
