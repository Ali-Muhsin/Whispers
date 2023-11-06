extends KinematicBody2D
class_name Item

var velocity = Vector2.ZERO

export(String)var itemName 
export(String)var path
export(bool)var isTool

func _ready():
	global.setInfo(itemName, "isTool", isTool)
	if isTool:
		global.setInfo(itemName, "path", path)

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += 8
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(_area):
	queue_free()
