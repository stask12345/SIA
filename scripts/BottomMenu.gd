extends CanvasLayer

var itemToModifyVar
@export var typeOfMenu = "Developmental"
var startingPosition

func openAddMenu():
	$Background/Add.visible = false
	$Background/Exit.visible = false
	$Background/Modify.visible = false
	
	startingPosition = $Background.position 
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(startingPosition.x,startingPosition.y - 365),0.3)
	t.tween_property($Background,"size",Vector2(540,500),0.3)
	t.tween_callback(openAddMenuAnimation)

func openAddMenuAnimation():
	$"..".turnOffModifyMode()
	$Background/AddMenu/Add.text = "Add"
	$Background/AddMenu/Delete.visible = false
	$Background/AddMenu/DecorationLabel.text = "Create new item"
	$Background/AddMenu.visible = true

func hideAddMenu():
	$Background/AddMenu.visible = false
	$Background/AddMenu/NameLabel/LineEdit.text = ""
	
	var t = create_tween()
	t.tween_property($Background,"position",startingPosition,0.3)
	t.tween_property($Background,"size",Vector2(540,135),0.3)
	t.tween_callback(showBottomMenuButtons)

func showBottomMenuButtons():
	$Background/Add.visible = true
	$Background/Exit.visible = true
	$Background/Modify.visible = true

func updateReward(value):
	$Background/AddMenu/ValueLabel.text = "Shards: " + str(value)
	if typeOfMenu == "Reward": $Background/AddMenu/ValueLabel.text = "RP cost: " + str(value)

func addNewDevelopmentalItem():
	if $"..".modifyMode:
		modifyItem()
		return
	
	var r = preload("res://resources/LineItem.tres").duplicate()
	r.elementName = $Background/AddMenu/NameLabel/LineEdit.text
	r.reward = $Background/AddMenu/ValueLabel/HSlider.value
	r.type = typeOfMenu
	$"..".createNewDevelopmentalItem(r,true)
	
	hideAddMenu()

func modifyClicked():
	if !$"..".modifyMode:
		$"..".turnOnModifyMode()
	else:
		$"..".turnOffModifyMode()

func openModifyMenu(itemToModify):
	itemToModifyVar = itemToModify
	$Background/Add.visible = false
	$Background/Exit.visible = false
	$Background/Modify.visible = false
	
	$Background/AddMenu/DecorationLabel.text = "Modify item"
	$Background/AddMenu/NameLabel/LineEdit.text = itemToModify.listItemResource.elementName
	$Background/AddMenu/ValueLabel/HSlider.value = itemToModify.listItemResource.reward
	
	startingPosition = $Background.position 
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(startingPosition.x,startingPosition.y - 365),0.3) # 0 460
	t.tween_property($Background,"size",Vector2(540,500),0.3)
	t.tween_callback(openModifyMenuAnimation)

func openModifyMenuAnimation():
	$Background/AddMenu/Add.text = "Modify"
	$Background/AddMenu/Delete.visible = true
	$Background/AddMenu/Delete/Used.text = "Used: " + str(itemToModifyVar.listItemResource.numberOfUsed)
	$Background/AddMenu.visible = true

func modifyItem():
	itemToModifyVar.listItemResource.elementName = $Background/AddMenu/NameLabel/LineEdit.text
	itemToModifyVar.listItemResource.reward = $Background/AddMenu/ValueLabel/HSlider.value
	itemToModifyVar.setUp()
	$"..".system.saveData()
	
	$"..".turnOffModifyMode()
	hideAddMenu()

func deleteItem():
	$"..".listOfItems.erase(itemToModifyVar.listItemResource)
	itemToModifyVar.queue_free()
	$"..".system.saveData()
	
	$"..".turnOffModifyMode()
	hideAddMenu()
