extends ColorRect

@onready var system = get_node("/root/MainScene")

func _ready():
	updateStats() 

func updateStats():
	$RewardPoints.text = "Reward Points: " + str(system.stats.rewardPoints)
	$Rank.text = "Rank:" + system.rankNames[system.stats.rank]
	$Bar/Points.text = str(system.stats.expShards) + "/" + str(system.rankGoals[system.stats.rank])
