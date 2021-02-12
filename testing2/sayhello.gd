extends Panel

var radius = 150
var circleP = Vector2(200,300)
var myP: PoolVector2Array = [circleP, circleP + Vector2(radius,0)]
var sineHeight:float;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("Radius").points = myP
	get_node("CoseLine").points = myP
	get_node("SineLine").points = myP
	
var theta = 0.0
func _process(delta):
	theta += delta
	get_node("Radius").points[1] = Vector2(radius*cos(theta), radius*sin(theta)) + circleP 
	get_node("CoseLine").points[1] = myP[0] + Vector2(radius*cos(theta), 0)
	get_node("SineLine").points[0] = get_node("CoseLine").points[1] 
	get_node("SineLine").points[1] = get_node("SineLine").points[0] + Vector2(0,radius*sin(theta))
	update()
	
#drawing sine lines 
func _draw():
	var startHeight:Vector2 = Vector2(400,200)
	var endHeightLength:float = (get_node("SineLine").points[1] - get_node("SineLine").points[0]).length()
	var endHeight:Vector2 = startHeight + Vector2(0, endHeightLength)
	draw_line(startHeight, endHeight ,Color(0.0,0.0,1.0),2.0)
	



