extends Control

@export var listItemResource : Resource
@onready var system = get_node("/root/MainScene")
@onready var modifyMenu = get_node("/root/MainScene/MainMenu/DevelopmentalMenu/BottomMenu")
var modifyMode = false

func _ready():
	setUp()

func setUp():
	$Name.text = str(listItemResource.elementName)
	$Reward.text = "Shards: " + str(listItemResource.reward)

func clicked():
	if modifyMode:
		modifyMenu.openModifyMenu(self)
		return
	
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(self.unclickAnimation)
	
	if !listItemResource.used:
		listItemResource.used = true
		$Done.visible = true
		modulate = Color.GRAY
		system.updateExpSystem(listItemResource.reward)
	else:
		listItemResource.used = false
		$Done.visible = false
		modulate = Color.WHITE
		system.updateExpSystem(-listItemResource.reward)
	

func unclickAnimation():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1,1),0.1)
	self_modulate = Color.DARK_GRAY

func modifyModeOn():
	modifyMode = true
	$Modify.visible = true

func modifyModeOff():
	modifyMode = false
	$Modify.visible = false
