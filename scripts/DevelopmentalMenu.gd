extends Node2D

@export var listOfItems :Array[Resource] = []
@onready var system = get_node("/root/MainScene")
var modifyMode = false

func _ready():
	call_deferred("makeEmptyElement")

func makeEmptyElement():
	var e = ColorRect.new()
	$ScrollContainer/VBoxContainer.add_child(e)

func makeInvisible():
	$BottomMenu.visible = false
	visible = false

func makeVisible():
	$BottomMenu.visible = true
	visible = true

func createNewDevelopmentalItem(item,newOne = false):
	var o = preload("res://resources/ListItemObject.tscn").instantiate()
	o.listItemResource = item
	$ScrollContainer/VBoxContainer.add_child(o)
	listOfItems.append(item)
	if newOne: system.saveData()

func turnOnModifyMode():
	modifyMode = true
	for i in $ScrollContainer/VBoxContainer.get_children():
		if "ListItem" in i.name:
			i.modifyModeOn()

func turnOffModifyMode():
	modifyMode = false
	for i in $ScrollContainer/VBoxContainer.get_children():
		if "ListItem" in i.name:
			i.modifyModeOff()

func exitFromDevelopmental():
	$"..".returnFromDevelopmental()
