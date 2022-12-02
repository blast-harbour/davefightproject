extends SGCollisionShape2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var customshape = false
var shapescene = preload("res://davefightmodel.tscn")
export var dynamic_shape = false
var cube_visual = preload("res://visualizers/CubeVisual.tscn")
var sphere_visual = preload("res://visualizers/SphereVisual.tscn")

var active_visual
export(NodePath) var scene3d

# Called when the node enters the scene tree for the first time.
func _ready():
	if customshape == false:
		if shape is SGRectangleShape2D:
			active_visual = cube_visual.instance()
			get_node(scene3d).add_child(active_visual)
			active_visual.scale = Vector3(global_scale.x, global_scale.y, 1.0)
			active_visual.translation = Vector3(global_position.x / 10, global_position.y * -1 / 10, 0.0)
			active_visual.rotation_degrees = Vector3(0.0, 0.0, global_rotation_degrees * -1)
			print(active_visual.translation)
		if shape is SGCircleShape2D:
			active_visual = sphere_visual.instance()
			get_node(scene3d).add_child(active_visual)
			active_visual.scale = Vector3(global_scale.x, global_scale.y, 1.0)
			active_visual.translation = Vector3(global_position.x / 10, global_position.y * -1 / 10, 0.0)
			active_visual.rotation_degrees = Vector3(0.0, 0.0, global_rotation_degrees * -1)
	else:
		active_visual = shapescene.instance()
		get_node(scene3d).add_child(active_visual)
		active_visual.scale = Vector3(global_scale.x, global_scale.y, 1.0)
		active_visual.translation = Vector3(global_position.x / 10, global_position.y * -1 / 10, 0.0)
		active_visual.rotation_degrees = Vector3(0.0, 0.0, global_rotation_degrees * -1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dynamic_shape == true:
		active_visual.scale = Vector3(global_scale.x, global_scale.y, 1.0)
		active_visual.translation = Vector3(global_position.x / 10, global_position.y * -1 / 10, 0.0)
		active_visual.rotation_degrees = Vector3(0.0, 0.0, global_rotation_degrees * -1)
		#print("hes still movin")
