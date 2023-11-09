extends KinematicBody2D
class_name Player

var right = "ui_right"
var left = "ui_left"
var up = "ui_up"

var velocity = Vector2.ZERO
var direction: Vector2
var gravity = 10
var speed = Vector2(10,210)

var fallGravity = 8
var maxSpeed = 100
var friction = 10
var releaseForce = -70

var isEquipped: bool

enum {
	IDLE,
	AIR,
	MOVE, 
	ATTACK
}

var state = IDLE
var flip = false

onready var sprite = $Body
onready var anim = $AnimationPlayer
onready var hold = $Hold

signal collectItem(spritePath)

func _physics_process(_delta: float) -> void:
	match state:
		IDLE:
			IDLE()
		AIR:
			AIR()
		MOVE:
			MOVE()
		ATTACK:
			ATTACK()

	if direction == Vector2.ZERO and state != ATTACK and is_on_floor():
		state = IDLE
	if !velocity.y == 0:
		state = AIR
	if !direction.x == 0 and state != ATTACK and is_on_floor():
		state = MOVE 
	if Input.is_action_just_pressed("attack1") and is_on_floor():
		state = ATTACK

	animation()
	get_flip()

	direction = get_direction()

#gravity, jump
	if is_on_floor() == false:
		velocity.y += gravity
	if Input.is_action_just_pressed(up):
		if is_on_floor():
			direction.y = -1
	var jump_is_interrupted = Input.is_action_just_released(up) and velocity.y < releaseForce

#set velocity get velocity
	velocity = get_velocity(velocity, speed, direction, jump_is_interrupted)

#Move and slide
	velocity = move_and_slide(velocity, Vector2.UP)

func IDLE() -> void:
	pass

func AIR() -> void:
	pass

func MOVE() -> void:
	if direction.x == 0:
		apply_friction(friction)

func ATTACK() -> void:
	velocity.x = 0

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength(right) - Input.get_action_strength(left),
		-1.0 if Input.is_action_just_pressed(up) and is_on_floor() else 0.0
	)

func get_flip():
	if Input.is_action_just_pressed(right):
		flip = false
	elif Input.is_action_just_pressed(left):
		flip = true
	else:
		pass

func get_velocity(
	linear_velocity: Vector2,
	speed: Vector2,
	direction: Vector2,
	jump_is_interrupted: bool
) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = apply_acceleration(speed.x, direction.x, new_velocity)
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1:
		new_velocity.y = speed.y * direction.y
	if new_velocity.y > 0:
		new_velocity.y += 5
	if jump_is_interrupted: 
		new_velocity.y = releaseForce
	
	return new_velocity 

func animation() -> void:
	if state == MOVE:
		if is_on_floor():
			if velocity.x > 0:
				anim.play("Run")
			elif velocity.x < 0:
				anim.play("RunFlip")
	if state == ATTACK:
		if flip == true:
			anim.play("AttackFlip")
		else:
			anim.play("Attack")
	if state == IDLE:
		if flip == true:
			anim.play("IdleFlip")
		else:
			anim.play("Idle")
	if state == AIR:
		if flip == true:
			anim.play("AirFlip")
		else:
			anim.play("Air")

func apply_acceleration(acceleration: float, direction: float, velocity: Vector2) -> float:
	var xVelocity = move_toward(velocity.x, maxSpeed * direction, acceleration)
	return xVelocity

func apply_friction(friction: int) -> void:
	velocity.x = move_toward(velocity.x, 0, friction)

func _on_AnimationPlayer_animation_finished(finishedAnim) -> void:
	if "Attack" in finishedAnim:
		state = IDLE

func _on_Area2D_area_entered(area):
	if area.is_in_group("items"):
		var inventory = global.inventory
		var objectData = global.readFromJSON(global.objectDataPath)
		var itemName = global.getItemByKey(area.get_parent().name, objectData)
		var itemData = global.getItemByKey(itemName, global.items)
		var itemSprite = global.items[itemName]["Sprite"]
		var isTool: bool = itemData["isTool"] 
		print(itemData)
		if isTool:
			var itemPath: String = itemData["path"]
			var item_resource = load(itemPath)
			var item = item_resource.instance()
			if hold.get_child_count() == 0:
				hold.call_deferred("add_child", item)
		else:
			emit_signal("collectItem", itemSprite)
			# For items with isTool set to false, attempt to add them to the inventory
			for key in inventory.keys():
				var itemCount : int = inventory[key]["itemCount"]
				var slotCapacity : int = inventory[key]["slotCapacity"]
				print(inventory[key]["itemName"])
				if inventory[key]["itemName"] == "NIL" or itemName:
					if inventory[key]["itemCount"] < slotCapacity:
						global.setInv(key, "itemName", itemName)
						if inventory[key]["itemName"] == itemName:
							global.setInv(key, "itemCount", itemCount + 1)
							break
						break
