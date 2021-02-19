extends Panel

var graphNum=200
var radius = 150
var circleP = Vector2(200,350)
var myP: PoolVector2Array = [circleP, circleP + Vector2(radius,0)]
var sineHeight:float
var roundAngleStart:int = 0
var roundAngle:int = 0
var roundAngleCounter:int = 0
var theta = 0.0
var drawNewGraphSine:bool = false

var xAngle:float=0
var graphStartPSine:PoolVector2Array = []
var graphEndPSine:PoolVector2Array = []

var graphStartPCos:PoolVector2Array = []
var graphEndPCos:PoolVector2Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_node("Radius").points = myP
	get_node("CoseLine").points = myP
	get_node("SineLine").points = myP
	
	#initialize graphs
	for n in graphNum:
		graphStartPSine.append(Vector2(n*4, 0) + Vector2(400, 175))
		graphEndPSine.append (graphStartPSine[n])
	
		graphStartPCos.append(Vector2(n*4, 0) + Vector2(400, 525))
		graphEndPCos.append (graphStartPCos[n])
			
	
	
	
func _process(delta):
	roundAngleStart = roundAngle
	theta = atan2(get_viewport().get_mouse_position().y - circleP.y, get_viewport().get_mouse_position().x - circleP.x)
	roundAngle = int(theta*180/PI)
	
	roundAngleCounter += roundAngle - roundAngleStart
	#checking for a change of 5 degrees
	update()
		
	
	#updating blue and red Trig lines
	get_node("Radius").points[1] = Vector2(radius*cos(theta), radius*sin(theta)) + circleP 
	get_node("CoseLine").points[1] = myP[0] + Vector2(radius*cos(theta), 0)
	get_node("SineLine").points[0] = get_node("CoseLine").points[1] 
	get_node("SineLine").points[1] = get_node("SineLine").points[0] + Vector2(0,radius*sin(theta))
	
	
#drawing sine lines and cos lines
func _draw():
	#sine line 
	var startHeightSine:Vector2 = Vector2(400,175)
	var sineVec:Vector2 = get_node("SineLine").points[1] - get_node("SineLine").points[0]
	var endHeightLengthSin:float = sineVec.length()*sineVec.sign().y
	var endHeightSine:Vector2 = startHeightSine + Vector2(0, endHeightLengthSin)
	#draw_line(startHeightSine, endHeightSine ,Color(0.0,0.0,1.0),2.0)
	
	#cos line
	var startHeightCos:Vector2 = Vector2(400,525)
	var cosVec:Vector2 = get_node("CoseLine").points[1] - get_node("CoseLine").points[0]
	var endHeightLengthCos:float = -cosVec.length()*cosVec.sign().x
	var endHeightCos:Vector2 = startHeightCos + Vector2(0, endHeightLengthCos)
	#draw_line(startHeightCos, endHeightCos ,Color(1.0,0.0,0.0),2.0)

	#moving lines down
	if abs(roundAngleCounter) > 5:
		roundAngleCounter = 0
		for i in range(graphNum - 1, 0, -1):
			graphEndPSine[i].y = graphEndPSine[i-1].y
			graphEndPCos[i].y = graphEndPCos[i-1].y
			
		graphEndPSine[0] =  Vector2(400,endHeightSine.y)
		graphEndPCos[0] = Vector2(400,endHeightCos.y)
		
			
			
	
	#draw the graphs
	for i in graphNum:
		draw_line(graphStartPSine[i], graphEndPSine[i], Color(0.0, 0.0, 1.0), 1.0)
		draw_line(graphStartPCos[i], graphEndPCos[i], Color(1.0, 0.0, 0.0), 1.0)
	
