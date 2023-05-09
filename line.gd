extends Line2D

var distance = 0

func barProgress(minPoints : float,maxPoints : float):
	distance = get_point_position(0).distance_to($"../EndMarker".position)
	var percent : float = minPoints/maxPoints
	set_point_position(1,Vector2(get_point_position(0).x + distance*percent,get_point_position(1).y))
