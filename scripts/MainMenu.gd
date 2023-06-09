extends CanvasLayer


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
	await get_tree().create_timer(0.5).timeout
	goToDevelopmental()

func RegressiveMenuButtonPressed():
	$StartMenu/RegressiveButton.clicked()
	await get_tree().create_timer(0.2).timeout
	exitStartMenu()
	await get_tree().create_timer(0.5).timeout
	goToRegressive()

func RewardButtonPressed():
	$StartMenu/RewardButton.clicked()
	await get_tree().create_timer(0.2).timeout
	exitStartMenu()
	await get_tree().create_timer(0.5).timeout
	goToReward()

func StatisticButtonPressed():
	$StartMenu/StatsButton.clicked()
	await get_tree().create_timer(0.2).timeout
	exitStartMenu()
	await get_tree().create_timer(0.5).timeout
	goToStats()

func exitStartMenu():
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,2000),0.5)
	t.tween_callback(makeStartMenuInvisible)

func makeStartMenuInvisible():
	$StartMenu.visible = false

func makeStartMenuVisible():
	$StartMenu.visible = true

func goToDevelopmental():
	var t = create_tween()
	t.tween_property($DevelopmentalMenu,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(developmentalMenuAnimation)
	$DevelopmentalMenu.makeVisible()

func goToRegressive():
	var t = create_tween()
	t.tween_property($RegressiveMenu,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(regressiveMenuAnimation)
	$RegressiveMenu.makeVisible()

func goToReward():
	var t = create_tween()
	t.tween_property($RegressiveMenu,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(rewardMenuAnimation)
	$RewardMenu.makeVisible()

func goToStats():
	var t = create_tween()
	t.tween_property($RegressiveMenu,"scale",Vector2(1.1,1.1),0.1)
	t.tween_callback(statsMenuAnimation)
	$StatisticsMenu.makeVisible()

func returnFromDevelopmental():
	$DevelopmentalMenu.makeInvisible()
	makeStartMenuVisible()
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,0),0.5)

func returnFromRegressive():
	$RegressiveMenu.makeInvisible()
	makeStartMenuVisible()
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,0),0.5)

func returnFromReward():
	$RewardMenu.makeInvisible()
	makeStartMenuVisible()
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,0),0.5)

func returnFromStats():
	print("2d")
	$StatisticsMenu.makeInvisible()
	makeStartMenuVisible()
	var t = create_tween()
	t.tween_property($StartMenu,"position",Vector2(0,0),0.5)

func developmentalMenuAnimation():
	var t = create_tween()
	t.tween_property($DevelopmentalMenu,"scale",Vector2(1,1),0.1)

func regressiveMenuAnimation():
	var t = create_tween()
	t.tween_property($RegressiveMenu,"scale",Vector2(1,1),0.1)

func rewardMenuAnimation():
	var t = create_tween()
	t.tween_property($RewardMenu,"scale",Vector2(1,1),0.1)

func statsMenuAnimation():
	var t = create_tween()
	t.tween_property($StatisticsMenu,"scale",Vector2(1,1),0.1)
