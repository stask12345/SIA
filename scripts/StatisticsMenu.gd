extends Node2D

@onready var system = get_node("/root/MainScene")

func makeInvisible():
	visible = false

func makeVisible():
	setUpStats()
	visible = true

func exit():
	print("1d")
	$"..".returnFromStats()

func setUpStats():
	$BasicStats/Rank/Number.text = "Seq. " + str(system.rankNames.size() - system.stats.rank - 1) + " " + str(system.rankNames[system.stats.rank])
	$BasicStats/Experience/Number.text = str(system.stats.positiveNumber) + " / " + str(system.stats.negativeNumber)
	$BasicStats/TotalCollected/Number.text = str(system.stats.collectedExpShards)
	$BasicStats/DaysPlayed/Number.text = str(system.stats.daysPassed)
