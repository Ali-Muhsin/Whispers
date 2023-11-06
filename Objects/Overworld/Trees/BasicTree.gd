extends GameObject

func _ready():
	objectValue = maxValue

func _on_Area2D_area_entered(area):
	if area.is_in_group("weapons"):
		var itemData = global.getItemByKey(area.get_parent().name, global.itemDataPath)
		var weaponStrength = itemData["strength"]
		if objectValue > 0:
			objectValue -= weaponStrength
		else:
			currentState = state.Four
		print(objectValue)

func _process(delta):
	if objectValue <= 2:
		currentState = state.Two
	if objectValue <= 0:
		currentState = state.Three

func TWO():
	$Sprite.frame = 3

func THREE():
	$Sprite.frame = 4

func FOUR():
	pass
