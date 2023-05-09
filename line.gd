extends Line2D

var distance = 0

# Called when the node enters the scene tree for the first time.
func _ready(): 
	distance = get_point_position(0).distance_to($"../EndMarker".position)
	barProgress(2,6)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func barProgress(minPoints : float,maxPoints : float):
	var percent : float = minPoints/maxPoints
	set_point_position(1,Vector2(get_point_position(0).x + distance*percent,get_point_position(1).y))
