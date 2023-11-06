extends Node2D
class_name Weapon

export(String)var itemName 
export (int) var strength
export (int) var durability
export (int) var maxStrength
export (int) var maxDurability

onready var sprite = $Sprite

func _ready():
	global.setInfo(itemName, "strength", strength)
	durability = maxDurability

func _process(_delta):
	if durability > maxDurability/2:
		sprite.frame = 0
	elif durability < maxDurability/2:
		sprite.frame = 1
	if durability == 0:
		sprite.frame = 2

	set_durability_to_zero()

	if Input.is_action_just_pressed("ui_focus_next"):
		durability -= 1
		print(durability)

func set_durability_to_zero():
	if durability < 0:
		durability = 0

func _on_Area2D_area_entered(area):
	if area.is_in_group("attackable"):
		var itemData = global.getItemByKey(area.get_parent().name, global.itemDataPath)
		var itemStrength: String = itemData["strength"]
		durability -= strength
