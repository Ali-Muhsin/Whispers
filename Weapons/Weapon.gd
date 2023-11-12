extends Node2D
class_name Weapon

export(String)var itemName 
#export (int) var strength
export (int) var durability
export (int) var maxStrength
export (int) var maxDurability

onready var sprite = $Sprite
onready var hitBox = $HitBox/CollisionPolygon2D

#var player := self.get_parent().get_parent()

func _ready():
	durability = maxDurability

	print(get_parent().get_parent().name)

	get_parent().get_parent().connect("attack", self, "attack")

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
		var itemData = global.getItemByKey(area.get_parent().name, global.item)
		var itemStrength: String = itemData["strength"]
		durability -= itemStrength

func attack(state: bool) -> void:
	if state == true:
		hitBox.disabled = false
	else:
		hitBox.disabled = true
