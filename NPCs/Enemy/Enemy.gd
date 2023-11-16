extends KinematicBody2D

var speed := 10
onready var player = get_node("/root/Overworld/Player")
export (int) var gravity

enum{
	SEEK,
	CHASE
}

var dir : Vector2 = Vector2.ZERO
var state := SEEK

func _physics_process(delta):
	if state == CHASE:
		update_dir()
		move()
	else:
		pass

func move() -> void:
	var direction : Vector2
	direction = (dir - position).normalized()

	move_and_slide(direction * speed, Vector2.UP)


func update_dir() -> void:
	if player:
		dir = player.position

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		state = CHASE

func _on_Area2D_area_exited(area):
	if area.is_in_group("player"):
		state = SEEK
