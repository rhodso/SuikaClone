extends Node2D

var size: int

# Get the size of the ball
func get_ball_size():
	return size

func on_create_ball(_size: int):
	# Create reference vars for ease
	var this_sprite = null
	var this_area = null
	var this_collision_shape = null
	var this_area_shape = null

	# Get the sprite, area, and collision shape
	var my_children = get_children()
	for child in my_children:
		if child is Sprite2D:
			this_sprite = child as Sprite2D
		if child is Area2D:
			this_area = child as Area2D
		if child is CollisionShape2D:
			this_collision_shape = child as CollisionShape2D
			
	for child in this_area.get_children():
		if child is CollisionShape2D:
			this_area_shape = child as CollisionShape2D

	# Test that the sprite, area, and collision shape were found
	if this_sprite == null:
		print("Error: Sprite not found")
	if this_area == null:
		print("Error: Area not found")
	if this_collision_shape == null:
		print("Error: Collision Shape not found")
	if this_area_shape == null:
		print("Error: Area Shape not found")

	# Set the size of the ball
	size = _size

	# Set the sprite to be [size].png, stored in the assets folder
	var texture = load("res://Assets/" + str(size) + ".png")
	if(this_sprite != null):
		this_sprite.texture = texture

	"""******************************************
	* IMPORTANT INFO:                           *
	* 0.1 SCALE DIFF IS EQUIVALENT TO 15 PIXELS *
	******************************************"""

	# Set the scale of the sprite, rigidbody, area, and both collision shapes
	this_sprite.scale = Vector2( 
		((size-1) * 0.05) + 0.1, 
		((size-1) * 0.05) + 0.1
	)

	# Create a new circle shape for the rigidbody's collision shape, and the area's collision shape
	var circle = CircleShape2D.new()
	circle.radius = (((size-1) * 15) + 30) / 2.0
	this_collision_shape.shape = circle
	this_area_shape.shape = circle

	# Attach the script to the area
	var merge_script = load("res://merge.gd")
	this_area.set_script(merge_script)
		
func merge_delete():
	# Disable my area, so it doesn't trigger the merge function again
	var my_children = get_children()
	for child in my_children:
		if child is Area2D:
			child.set("monitoring", false)

	# Delete the node, and all its children
	queue_free()

func merge(mergePos: Vector2):
	# Get our position, and calculate the midpoint between the two positions
	var pos = global_position
	var midPoint = (pos + mergePos) / 2

	# Create a new instance of the ball scene and add it to the scene
	var ball = preload("res://Ball.tscn").instantiate()
	ball.on_create_ball(size + 1)
	ball.global_position = midPoint
	get_parent().add_child(ball)

	# Delete the node, and all its children
	queue_free()

