extends KinematicBody2D
class_name Item

var velocity := Vector2.ZERO
var selfName := self.name

export(String)var itemName 
export(String)var path
export(bool)var isTool

func _ready():
	var data: Dictionary = {}
	data[self.name] = itemName
	print(data)
	global.setInfo(itemName, "isTool", isTool, global.items, global.itemDataPath)
	global.appendToJSON(global.objectDataPath, data)
	if isTool:
		global.setInfo(itemName, "path", path, global.items, global.itemDataPath)

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += 8
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(_area):
	queue_free()
