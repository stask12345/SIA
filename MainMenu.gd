extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func DevelopmentalButtonPressed():
	$StartMenu/DevelopmentalButton.clicked()
	await get_tree().create_timer(0.2).timeout
	exitStartMenu()

func exitStartMenu():
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,2000),1)
	t.tween_callback(makeStartMenuInvisible)

func makeStartMenuInvisible():
	$StartMenu.visible = false
