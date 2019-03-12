extends Node2D

var timeCount = 0

var snake = []

var direction = Vector2(32, 0)

var up 
var down 
var left 
var right

var food

var scorePoints = 0


func _ready():
	
	randomize()
	
	snake = [$Bodies/Body, $Bodies/Body2, $Bodies/Body3]	
	
	SpawnBody()
	
	up = Vector2(0, -32)
	down = Vector2(0, 32)
	left = Vector2(-32, 0)
	right = Vector2(32, 0)
	
	$Head.connect("gameOver", self, "GameOver")
	
	UpdateScore()

func SpawnBody():

	food = preload("res://Scenes/Food.tscn").instance()
	add_child(food)
	
	food.connect("food_eat", self, "Eated")
	
	var rand_x = (round(rand_range(0, 19))  * 32) - 20
	var rand_y = (round(rand_range(0, 14))  * 32) - 10

	food.position = Vector2(rand_x, rand_y)

func _process(delta):
	timeCount += delta;
	
	if timeCount > 0.5:
		Move()
		timeCount = 0
	
	if Input.is_action_pressed("ui_down") and direction != up:
		direction = down 
	if Input.is_action_pressed("ui_up") and direction != down:
		direction = up
	if Input.is_action_pressed("ui_right") and direction != left:
		direction = right
	if Input.is_action_pressed("ui_left") and direction != right:
		direction = left
	
	if $Head.position.x < -20 or $Head.position.x > 588 or $Head.position.y < -10 or $Head.position.y > 438:
		GameOver()


func Move():
	var headLastPos = $Head.position
	$Head.position += direction
	
	snake.back().position = headLastPos
	snake.push_front(snake.back())
	snake.pop_back()

func Eated():
	var newFood = preload("res://Scenes/Body.tscn").instance()
	$Bodies.add_child(newFood)
	newFood.position = snake.back().position
	snake.append(newFood)
	
	scorePoints += 1
	UpdateScore()
	
	SpawnBody()

func GameOver():
	#print("ACABOU!")	
	get_tree().paused = true
	#get_tree().reload_current_scene()
	$GameOverLabel.show()

func UpdateScore():
	$ScoreLabel.text = "Score: " + str(scorePoints)

func _on_RestartButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
 

