extends Control

@export var listItemResource : Resource
@onready var system = get_node("/root/MainScene")
@onready var modifyMenu = get_node("/root/MainScene/MainMenu/DevelopmentalMenu/BottomMenu")
@onready var modifyMenuRecessive = get_node("/root/MainScene/MainMenu/RegressiveMenu/BottomMenu")
@onready var modifyMenuReward = get_node("/root/MainScene/MainMenu/RewardMenu/BottomMenu")
var modifyMode = false

func _ready():
	setUp()

func setUp():
	$Name.text = str(listItemResource.elementName)
	$Reward.text = "Shards: " + str(listItemResource.reward)
	if listItemResource.type == "Reward":
		$Reward.text = "Cost of RP: " + str(listItemResource.reward)
	
	if listItemResource.used:
		$Done.visible = true
		modulate = Color.GRAY
	else:
		print("poprawiam")
		$Done.visible = false
		modulate = Color.WHITE

func clicked():
	if modifyMode:
		if listItemResource.type == "Developmental": modifyMenu.openModifyMenu(self)
		if listItemResource.type == "Regressive": modifyMenuRecessive.openModifyMenu(self)
		if listItemResource.type == "Reward": modifyMenuReward.openModifyMenu(self)
		return
	
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(self.unclickAnimation)
	
	if !listItemResource.used:
		listItemResource.used = true
		listItemResource.numberOfUsed += 1
		if listItemResource.type == "Developmental":
			system.stats.positiveNumber += 1
		if listItemResource.type == "Regressive":
			system.stats.negativeNumber += 1
		setUp()
		if listItemResource.type != "Reward": system.updateExpSystem(listItemResource.reward)
		else:
			if (system.stats.rewardPoints >= listItemResource.reward):
				system.updateRPSystem(listItemResource.reward)
			else:
				listItemResource.used = false
				$Done.visible = false
				modulate = Color.WHITE
	else:
		listItemResource.used = false
		listItemResource.numberOfUsed -= 1
		if listItemResource.type == "Developmental":
			system.stats.positiveNumber -= 1
		if listItemResource.type == "Regressive":
			system.stats.negativeNumber -= 1
		setUp()
		if listItemResource.type != "Reward":
			system.updateExpSystem(-listItemResource.reward)
		else:
			system.updateRPSystem(-listItemResource.reward)
	

func unclickAnimation():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1,1),0.1)

func modifyModeOn():
	modifyMode = true
	$Modify.visible = true

func modifyModeOff():
	modifyMode = false
	$Modify.visible = false
