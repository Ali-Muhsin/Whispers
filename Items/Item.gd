extends KinematicBody2D
class_name Item

var velocity := Vector2.ZERO

export(String)var itemName 
export(String)var path
export(bool)var isTool
export(int)var strength

func _ready():
	var objectData: Dictionary
	var itemData: Dictionary
	var sprite : String = $Sprite.texture.get_path()

	objectData[self.name] = itemName
	itemData[itemName] = {
		"itemName":itemName,
		"path": path,
		"strength": strength,
		"isTool": isTool,
		"sprite": sprite
		} 

	global.appendToJSON(global.objectDataPath, objectData)
	global.appendToJSON(global.itemDataPath, itemData)

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += 8

	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(_area):
	queue_free()
