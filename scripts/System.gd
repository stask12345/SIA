extends Node2D

@export var stats : Resource

var rankNames = ["Newbie","Sleeper","Awakened","Apprentice","Experienced","Succesfull fellow","Ascended","Unyielding","Magician","One in Control","Master of Mind & Body","Supreme Genius", "The Fool"]
var rankGoals = [50,75,100,125,150,150,200,200,250,300,330,400,500]
var savePath = "user://save.tres"
var loaded = false

func _init():
	#DirAccess.remove_absolute(savePath)
	loadData()

func timeUpdate():
	if loaded:
		var time = Time #Time regression system #Each day -10
		var t = time.get_date_dict_from_system()
		var d = t.day
		stats.listOfDailyBalance.append(stats.collectedExpShards)
		stats.listOfDailyBalance.remove_at(0)
		if d != stats.dayOfMonth:
			stats.daysPassed += 1
			stats.dayOfMonth = d
			updateExpSystem(-5)
			for i in stats.listOfResources:
				i.used = false
			for o in $MainMenu/DevelopmentalMenu.listOfItems:
				o.used = false
			for o in $MainMenu/RegressiveMenu.listOfItems:
				o.used = false
			for o in $MainMenu/RewardMenu.listOfItems:
				o.used = false
			for o in $MainMenu/DevelopmentalMenu/ScrollContainer/VBoxContainer.get_children():
				if "ListItem" in o.name:
					o.listItemResource.used = false
					o.setUp()
			for o in $MainMenu/RegressiveMenu/ScrollContainer/VBoxContainer.get_children():
				if "ListItem" in o.name:
					o.listItemResource.used = false
					o.setUp()
			for o in $MainMenu/RewardMenu/ScrollContainer/VBoxContainer.get_children():
				if "ListItem" in o.name:
					o.listItemResource.used = false
					o.setUp()

func updateExpSystem(shardsToAdd):
	stats.expShards += shardsToAdd
	#Adding RP for each 50 shards
	stats.collectedExpShards += shardsToAdd
	if stats.collectedExpShards < 0: stats.collectedExpShards = 0
	var recentlyCollected = stats.collectedExpShards - (50*stats.rewardsPointsAdded)
	if recentlyCollected >= 50:
		stats.rewardsPointsAdded += 1
		stats.rewardPoints += 1
	
	if stats.rank == 0 && stats.expShards < 0:
		stats.expShards = 0
	
	if stats.expShards >= rankGoals[stats.rank]: #Level up
		stats.expShards -= rankGoals[stats.rank]
		if stats.rank == stats.maxRank:
			stats.rewardPoints += 3
			stats.maxRank += 1
		stats.rank += 1
	
	if stats.rank != 0 && stats.expShards < 0: #Level down
		stats.rank -= 1
		stats.expShards += rankGoals[stats.rank]
		stats.expShards -= (5+(5*stats.rank))
	
	$MainMenu/TopMenu.updateStats()
	saveData()

func updateRPSystem(RPToAdd):
	stats.rewardPoints -= RPToAdd
	
	$MainMenu/TopMenu.updateStats()
	saveData()

func saveData():
	stats.listOfResources.clear()
	stats.listOfResources.append_array($MainMenu/DevelopmentalMenu.listOfItems)
	stats.listOfResources.append_array($MainMenu/RegressiveMenu.listOfItems)
	stats.listOfResources.append_array($MainMenu/RewardMenu.listOfItems)
	print(stats.listOfResources)
	
	ResourceSaver.save(stats,savePath, ResourceSaver.FLAG_BUNDLE_RESOURCES)

func loadData():
	if ResourceLoader.exists(savePath):
		var r = ResourceLoader.load(savePath)
		stats = r
		print("1k " + str(r.listOfResources.size()))
		call_deferred("loadListItemResources")
	else: #We don't have any save to load, so we create one
		var s = preload("res://resources/Stats.tres")
		stats = s
		var time = Time #Time regression system #Each day -10
		var t = time.get_date_dict_from_system()
		stats.dayOfMonth = t.day

func loadListItemResources():
	loaded = true
	print("lista " + str(stats.listOfResources))
	for r in stats.listOfResources:
		if r.type == "Developmental":
			$MainMenu/DevelopmentalMenu.createNewDevelopmentalItem(r)
		if r.type == "Regressive":
			$MainMenu/RegressiveMenu.createNewDevelopmentalItem(r)
		if r.type == "Reward":
			$MainMenu/RewardMenu.createNewDevelopmentalItem(r)
	
	timeUpdate()
	print(stats.listOfDailyBalance)
