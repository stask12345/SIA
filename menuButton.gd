extends Sprite2D


func clicked():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.7,1.7),0.1)
	t.tween_callback(self.unclick)

func unclick():
	var t = create_tween()
	t.tween_property(self,"scale",Vector2(1.5,1.5),0.1)
