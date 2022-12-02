extends Spatial

export(NodePath) var follow2d := SGFixedNode2D

func _process(delta):

	translation = Vector3(follow2d, global_position.y * -1 / 10, 0.0)
	#print("hes still movin")
