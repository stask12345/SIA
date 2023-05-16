extends Node2D

func _ready():
	evolutionScreenOn()

func evolutionScreenOn():
	visible = true
	var t = create_tween()
	t.tween_property($ColorRect,"self_modulate",Color(1,1,1,0.9),0.3)
	$AnimationPlayer.play("idle")
