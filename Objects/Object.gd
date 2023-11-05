extends Node2D
class_name GameObject

export(int)var objectValue
export(int)var minValue
export(int)var maxValue

enum state{
One,
Two,
Three,
Four
}

var currentState = state.One

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

func _on_Area2D_area_entered(area):
	var itemData = global.getItemByKey(area.get_parent().name, global.itemData)
