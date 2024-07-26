extends Node2D

# Load the ball scene and ball script
var ball = null
var ball_script = null

func _ready():
	# Load the ball scene and ball script from ready so they're only loaded once
	ball = preload("res://Ball.tscn")
	ball_script = preload("res://ball.gd")

func _process(_delta):
	
	# Create a new instance of the ball scene and add it to the scene when and where the user clicks
	if Input.is_action_just_pressed("click"):
		# Create a new instance of the ball scene, add it to the scene, and set its position
		var ball_inst = ball.instantiate()
		add_child(ball_inst)
		ball_inst.global_position = get_viewport().get_mouse_position()
		ball_inst.global_position.y = 50 # Fixed Y position for the ball to start at

		# Set the ball's script and call the on_create_ball function
		ball_inst.set_script(ball_script)
		ball_inst.on_create_ball(1)

