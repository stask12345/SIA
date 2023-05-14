@tool
extends Control
@onready var system = get_node("/root/MainScene")

var plot_sin
var x = 0.0
var draw_enabled = false:
	set(value):
		draw_enabled = value
#		if is_instance_valid($Graph2D):
#			$Graph2D.background_color = Color.SLATE_GRAY if draw_enabled else Color.BLACK

func _ready():
	plot_sin = $Graph2D.add_plot_item("Exp Shards", Color.DEEP_SKY_BLUE, 0.5)
	plot_sin.add_point(Vector2(-5,system.stats.listOfDailyBalance[1] - system.stats.listOfDailyBalance[0]))
	plot_sin.add_point(Vector2(-4,system.stats.listOfDailyBalance[2] - system.stats.listOfDailyBalance[1]))
	plot_sin.add_point(Vector2(-3,system.stats.listOfDailyBalance[3] - system.stats.listOfDailyBalance[2]))
	plot_sin.add_point(Vector2(-2,system.stats.listOfDailyBalance[4] - system.stats.listOfDailyBalance[3]))
	plot_sin.add_point(Vector2(-1,system.stats.listOfDailyBalance[5] - system.stats.listOfDailyBalance[4]))
	plot_sin.add_point(Vector2(0,system.stats.listOfDailyBalance[6] - system.stats.listOfDailyBalance[5]))

func _process(_delta):
	if draw_enabled:
		var y: float = sin(x)
		plot_sin.add_point(Vector2(x,y))
		x += 0.1
	
	if draw_enabled and x > $Graph2D.x_max:
		draw_enabled = false

func _on_draw_button_pressed() -> void:
	draw_enabled = true
	plot_sin.clear()
	x = 0.0


func _on_clear_button_pressed() -> void:
	draw_enabled = false
	plot_sin.clear()
	x = 0.0
