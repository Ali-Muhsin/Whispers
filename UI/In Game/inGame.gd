extends Control

func _on_Player_collectItem():
	updateSlot()

func updateSlot():
	global.reloadData()
	print(str(global.inventory["slot1"]["itemCount"]))
	$Slot1/Item1.texture = load(global.inventory["slot1"]["sprite"])
	$Slot1/ItemCount.text = str(global.inventory["slot1"]["itemCount"])
	$Slot2/Item2.texture = load(global.inventory["slot2"]["sprite"])
	$Slot2/ItemCount.text = str(global.inventory["slot2"]["itemCount"])
	$Slot3/Item3.texture = load(global.inventory["slot3"]["sprite"])
	$Slot3/ItemCount.text = str(global.inventory["slot3"]["itemCount"])
	$Slot4/Item4.texture = load(global.inventory["slot4"]["sprite"])
	$Slot4/ItemCount.text = str(global.inventory["slot4"]["itemCount"])
