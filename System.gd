extends Node2D

@export var stats : Resource

var rankNames = ["Newbie","Sleeper","Awakened","Apprentice","Experienced","Succesfull fellow","Ascended","Unyielding","Magician","One in Control","Master of Mind & Body","Supreme Genius", "The Fool"]
var rankGoals = [50,75,100,125,150,150,200,200,250,300,330,400,500]
var savePath = "user://save.tres"

func _init():
	loadData()

func _ready():
	print("ide dalej: " + str(stats.expShards))
	var time = Time #Time regression system #Each day -10
	var t = time.get_date_dict_from_system()
	var d = t.day
	if d != stats.dayOfMonth:
		updateExpSystem(-5)
		stats.dayOfMonth = d
	saveData()

func updateExpSystem(shardsToAdd):
	stats.expShards += shardsToAdd
	if shardsToAdd > 0: #Addind RP for each 50 shards
		stats.collectedExpShards += shardsToAdd
		var recentlyCollected = stats.collectedExpShards - (50*stats.rewardsPointsAdded)
		if recentlyCollected >= 50:
			stats.rewardsPointsAdded += 1
			stats.rewardPoints += 1
	
	if stats.rank == 0 && stats.expShards < 0:
		stats.expShars = 0
	
	if stats.expShard >= rankGoals[stats.rank]: #Level up
		stats.expShard -= rankGoals[stats.rank]
		if stats.rank == stats.maxRank:
			stats.rewardPoints += 3
			stats.maxRank += 1
		stats.rank += 1
	
	if stats.rank != 0 && stats.expShards < 0: #Level down
		stats.rank -= 1
		stats.expShard += rankGoals[stats.rank]
		stats.expShard -= (5+(5*stats.rank))
	
	$TopMenu.updateStats()

func saveData():
	ResourceSaver.save(stats,savePath)

func loadData():
	if ResourceLoader.exists(savePath):
		var r = ResourceLoader.load(savePath)
		stats = r
	else: #We don't have any save to load, so we create one
		var s = preload("res://Stats.tres")
		stats = s
