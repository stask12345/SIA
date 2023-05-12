extends CanvasLayer

var itemToModifyVar

func openAddMenu():
	$Background/Add.visible = false
	$Background/Exit.visible = false
	$Background/Modify.visible = false
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(0,460),0.3)
	t.tween_property($Background,"size",Vector2(540,500),0.3)
	t.tween_callback(openAddMenuAnimation)

func openAddMenuAnimation():
	$Background/AddMenu/Add.text = "Add"
	$Background/AddMenu.visible = true

func hideAddMenu():
	$Background/AddMenu.visible = false
	$Background/AddMenu/NameLabel/TextEdit.text = ""
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(0,825),0.3)
	t.tween_property($Background,"size",Vector2(540,135),0.3)
	t.tween_callback(showBottomMenuButtons)

func showBottomMenuButtons():
	$Background/Add.visible = true
	$Background/Exit.visible = true
	$Background/Modify.visible = true

func updateReward(value):
	$Background/AddMenu/ValueLabel.text = "Shards: " + str(value)

func addNewDevelopmentalItem():
	if $"..".modifyMode:
		modifyItem()
		return
	
	var r = preload("res://resources/LineItem.tres").duplicate()
	r.elementName = $Background/AddMenu/NameLabel/TextEdit.text
	r.reward = $Background/AddMenu/ValueLabel/HSlider.value
	r.type = "Developmental"
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
	
	$Background/AddMenu/NameLabel/TextEdit.text = itemToModify.listItemResource.elementName
	$Background/AddMenu/ValueLabel/HSlider.value = itemToModify.listItemResource.reward
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(0,460),0.3)
	t.tween_property($Background,"size",Vector2(540,500),0.3)
	t.tween_callback(openModifyMenuAnimation)

func openModifyMenuAnimation():
	$Background/AddMenu/Add.text = "Modify"
	$Background/AddMenu.visible = true

func modifyItem():
	itemToModifyVar.listItemResource.elementName = $Background/AddMenu/NameLabel/TextEdit.text
	itemToModifyVar.listItemResource.reward = $Background/AddMenu/ValueLabel/HSlider.value
	itemToModifyVar.setUp()
	$"..".system.saveData()
	
	hideAddMenu()

