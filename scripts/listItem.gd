extends Control

@export var elementName = ""
@export var used = false
@export var type = ""
@export var reward = 0

func _ready():
	$Name.text = str(elementName)
	$Reward.text = "Shards: " + str(reward)

func setUp():
	pass

func clicked():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.7,1.7),0.1)
	t.tween_callback(self.unclickAnimation)
	
	used = false

func unclickAnimation():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.5,1.5),0.1)
	self_modulate = Color.DARK_GRAY
