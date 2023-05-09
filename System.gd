extends Node2D

@export var stats : Resource

var rankNames = ["Newbie","Sleeper","Awakened","Apprentice","Experienced","Succesfull fellow","Ascended","Unyielding","Magician","One in Control","Master of Mind & Body","Supreme Genius", "The Fool"]
var rankGoals = [50]

func _ready():
	var time = Time
	var t = time.get_date_dict_from_system()
	print(t.day)
	pass 


func saveData():
	ResourceSaver.save(stats,"user://save.tres")

func loadData():
	var r = ResourceLoader.load("user://save.tres")
