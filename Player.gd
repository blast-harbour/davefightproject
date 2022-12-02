extends SGKinematicBody2D

const SPEED = 196608
const GRAVITY = 32768
const JUMP = -65536*15

var velocity := SGFixedVector2.new()
var up_direction := SGFixed.vector2(0, -65536)
var jumping = false

func _get_local_input() -> Dictionary:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var input := {}
	input["input_vector"] = input_vector
	input["jump"] = Input.is_action_pressed("jump")
	return input
	
func _network_process(input: Dictionary) -> void:
	var input_vector = input.get("input_vector", Vector2.ZERO)
	if input_vector.x > 0:
		velocity.x = SPEED
	elif input_vector.x < 0:
		velocity.x = SGFixed.mul(SPEED, SGFixed.NEG_ONE)
	else:
		velocity.x = SGFixed.mul(SPEED, 0)
	velocity.y += GRAVITY
	
	var jump = input.get("jump", false)
	if jump == true:
		velocity.y = JUMP
		jumping = true
	else:
		jumping = false
	velocity = move_and_slide(velocity, up_direction)
	

func _save_state() -> Dictionary:
	var state := {
		velocity_x = velocity.x,
		velocity_y = velocity.y,
		jumping = jumping
		
	}
	Utils.save_node_transform_state(self, state)
	return state
	
	
func _load_state(state: Dictionary) -> void:
	Utils.load_node_transform_state(self, state)
	velocity.x = state['velocity_x']
	velocity.y = state['velocity_y']
	jumping = state['jumping']
	sync_to_physics_engine()
