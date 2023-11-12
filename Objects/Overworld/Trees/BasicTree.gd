extends GameObject

func _ready():
	customInit(maxValue)

func _process(delta):
	print(objectValue)

func _on_Area2D_area_entered(area):
	if area.is_in_group("weapons"):
		var itemData = global.getItemByKey(area.get_parent().name, global.items)
		var weaponStrength = itemData["strength"]
		if objectValue > 0:
			$Sprite.frame = $Sprite.frame + weaponStrength
			$Sprite2.frame =$Sprite2.frame + weaponStrength
			objectValue -= weaponStrength
		elif objectValue == weaponStrength or objectValue == 0:
			anim.play("fall")
			hitBox.queue_free()
			currentState = state.Four

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fall":
		drop(Vector2(position.x - 40, position.y))
