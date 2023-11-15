extends KinematicBody2D

export (int) var speed

var dir : Vector2
var seen : bool

func _physics_process(delta):
	move()

func move() -> void:
	print(dir)
	var direction : Vector2
	if seen:
		direction = dir - position
	else:
		direction = dir

	direction = direction.normalized()

	move_and_slide(direction * speed, Vector2.UP)

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		seen = true  # Check if the entered area is the player
		dir = area.position
	else:
		 dir = position
