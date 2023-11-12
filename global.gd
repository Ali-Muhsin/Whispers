extends Node
class_name dataManage

var items: Dictionary
var objects: Dictionary
var inventory: Dictionary

var itemDataPath := "res://JSON/itemData.json"
var objectDataPath := "res://JSON/objectData.json"
var inventoryPath := "res://JSON/inventory.json"

export(bool)var reset

func _ready() -> void:
	inventory = readFromJSON(inventoryPath)
	items = readFromJSON(itemDataPath)

	if reset:
		for key in inventory.keys():
			inventory[key]["itemName"] = "NIL"
			inventory[key]["itemCount"] = 0
			inventory[key]["sprite"] = "res://Sprites/UI/Inventory/NILItem.png"

		saveToJSON(inventoryPath, inventory)
#		saveToJSON(objectDataPath, {})
		reloadData()

func reset() -> void:
	var inv = readFromJSON(inventoryPath)
	for key in inv.keys():
		inv[key]["itemName"] = "NIL"
		inv[key]["itemCount"] = 0
		inv[key]["sprite"] = "res://Sprites/UI/Inventory/NILItem.png"

	saveToJSON(inventoryPath, inv)
	saveToJSON(objectDataPath, {})
	reloadData()

func reloadData() -> void:
	items = readFromJSON(itemDataPath)
	objects = readFromJSON(objectDataPath)
	inventory = readFromJSON(inventoryPath)

func setInfo(objName: String, property: String, newProperty, jsonFile: Dictionary, jsonPath: String) -> void:
	if jsonFile.has(objName):
		jsonFile[objName][property] = newProperty
		saveToJSON(jsonPath, jsonFile)
		print(property, " updated")
	else:
		printerr("Item not found: ", objName)


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

func getItemByKey(key, json: Dictionary) -> Dictionary:
	if json and json.has(key):
		return json[key]
	else:
		var a: Dictionary
		return a

func saveToJSON(path: String, SaveData: Dictionary) -> void:
	var file := File.new()
	file.open(path, File.WRITE)
	var jsonText = JSON.print(SaveData)  # Use JSON.print to convert dictionary to JSON
	file.store_string(jsonText)
	file.close()

func appendToJSON(path: String, newData: Dictionary) -> void:
	# Read the existing JSON data
	var existingData = readFromJSON(path)

	# Merge the existing data with the new data
	for key in newData.keys():
		existingData[key] = newData[key]

	# Save the updated JSON data
	saveToJSON(path, existingData)

func setInv(key: String, property: String, newProperty, inv: Dictionary) -> void:
	if inv.has(key):
		inv[key][property] = newProperty
		saveToJSON(inventoryPath, inv)
