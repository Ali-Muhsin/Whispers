extends Node2D
class_name GameObject

export(int)var objectValue
#export(int)var minValue
export(int)var maxValue
export(int)var dropNum

export(bool)var doesDrop
export(PackedScene)var drop

onready var anim := $AnimationPlayer
onready var hitBox := $Area2D

enum state{
One,
Two,
Three,
Four
}

var currentState

func _ready():
	currentState = state.One

func _process(delta):
	match currentState:
		state.One:
			ONE()
		state.Two:
			TWO()
		state.Three:
			THREE()
		state.Four:
			FOUR()

func ONE() -> void:
	pass

func TWO() -> void:
	pass

func THREE() -> void:
	pass

func FOUR() -> void:
	pass

func drop(dropPosition: Vector2, dropNum: int) -> void:
	for i in range(dropNum):
		var dropInstance = drop.instance()
		dropInstance.position = Vector2(dropPosition.x + i * 10, dropPosition.y)
		get_parent().add_child(dropInstance)
		print(i)

func _on_Area2D_area_entered(area) -> void:
	var itemData = global.getItemByKey(area.get_parent().name, global.items)
