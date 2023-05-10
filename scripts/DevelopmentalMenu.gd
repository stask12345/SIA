extends Node2D

@export var listOfItems :Array[Resource] = []

func makeInvisible():
	$BottomMenu.visible = false
	visible = false

func makeVisible():
	$BottomMenu.visible = true
	visible = true
