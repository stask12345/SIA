extends Node2D

@export var listOfItems :Array[Resource] = []
@onready var system = get_node("/root/MainScene")

func makeInvisible():
	$BottomMenu.visible = false
	visible = false

func makeVisible():
	$BottomMenu.visible = true
	visible = true

func createNewDevelopmentalItem(item):
	var o = preload("res://resources/ListItemObject.tscn").instantiate()
	o.listItemResource = item
	$ScrollContainer/VBoxContainer.add_child(o)
	listOfItems.append(item)
	print(listOfItems)
	system.saveData()
