extends Control

@export var listItemResource : Resource
@onready var system = get_node("/root/MainScene")

func _ready():
	$Name.text = str(listItemResource.elementName)
	$Reward.text = "Shards: " + str(listItemResource.reward)

func setUp():
	pass

func clicked():
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
