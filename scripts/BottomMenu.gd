extends CanvasLayer

func openAddMenu():
	$Background/Add.visible = false
	$Background/Exit.visible = false
	$Background/Modify.visible = false
	
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(0,460),0.5)
	t.tween_property($Background,"size",Vector2(540,500),0.5)
	t.tween_callback(openAddMenuAnimation)

func openAddMenuAnimation():
	$Background/AddMenu.visible = true

func hideAddMenu():
	var t = create_tween()
	t.tween_property($Background,"position",Vector2(0,825),0.5)
	t.tween_property($Background,"size",Vector2(540,135),0.5)
