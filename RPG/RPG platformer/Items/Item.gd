extends KinematicBody2D
class_name Item

var velocity = Vector2.ZERO

export(String)var itemName 
export(String)var path
export(bool)var equippable
export(bool)var stackable

func _ready():
	global.setInfo(itemName, "path", path)
	global.setInfo(itemName, "equippable", equippable)
	global.setInfo(itemName, "stackable", stackable)

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += 8
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Area2D_area_entered(_area):
	queue_free()