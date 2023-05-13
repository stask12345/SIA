extends Node2D

@export var listOfItems :Array[Resource] = []
@onready var system = get_node("/root/MainScene")
var modifyMode = false

func _ready():
	call_deferred("makeEmptyElement")

func makeEmptyElement():
	$ScrollContainer/VBoxContainer.add_spacer(false)

func makeInvisible():
	$BottomMenu.visible = false
	visible = false

func makeVisible():
	$BottomMenu.visible = true
	visible = true

func createNewDevelopmentalItem(item,newOne = false):
	var o = preload("res://resources/ListItemObject.tscn").instantiate()
	o.listItemResource = item
	if o.listItemResource.type == "Developmental":
		o.get_node("Background").self_modulate = Color("aefa68")
		o.get_node("ButtonDecoration").self_modulate = Color("95e63e")
	if o.listItemResource.type == "Regressive":
		o.get_node("Background").self_modulate = Color("fb3e00") # fc5567
		o.get_node("ButtonDecoration").self_modulate = Color("be2c00") #e40031
	if o.listItemResource.type == "Reward":
		o.get_node("Background").self_modulate = Color("11ffff")
		o.get_node("ButtonDecoration").self_modulate = Color("00e8e8") 
	$ScrollContainer/VBoxContainer.add_child(o)
	$ScrollContainer/VBoxContainer.move_child(o,$ScrollContainer/VBoxContainer.get_child_count()-2)
	
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
	if "DevelopmentalMenu" in name:
		$"..".returnFromDevelopmental()
	if "RegressiveMenu" in name:
		$"..".returnFromRegressive()
	if "RewardMenu" in name:
		$"..".returnFromReward()
