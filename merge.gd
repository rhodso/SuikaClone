extends Node2D

func _on_merge_trigger(_area_rid:RID, area:Area2D, _area_shape_index:int, _local_shape_index:int):
	# Get my parent
	var my_parent = get_parent()
	if(my_parent.get_ball_size() == 9):
		# If we do need to optimize the code, then we could test if the ball 
		# is already at the maximum size, disable merging by stopping 
		# monitoring the signal. 

		# For now, we'll just return for now unless we need to optimize the code
		return

	# Get the parent of the overlapping area
	var parent = area.get_parent()

	# If the parent's ball size is different from my parent's ball size, return
	if parent.get_ball_size() != my_parent.get_ball_size():
		return

	# Call the merge function in the area's parent, and call the merge_delete function in my parent
	parent.merge_delete()
	my_parent.merge(area.global_position)

