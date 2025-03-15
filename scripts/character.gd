extends CharacterBody3D

@onready var game_manager = %GameManager as GameManager

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.1

var mouse_motion_this_frame := Vector2()
var looking_at_object: Node3D
var held_object: BaseObject

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_motion_this_frame += event.xformed_by(get_viewport().get_final_transform()).relative

func _physics_process(delta: float) -> void:
	looking_at_object = $Camera/LookRay.get_collider()
	if Input.is_action_just_pressed("pick_up"):
		if held_object:
			held_object = null
		elif looking_at_object is BaseObject:
			held_object = looking_at_object
		elif looking_at_object.has_meta("isSendButton"):
			game_manager.try_send_order()
			
		elif looking_at_object.has_meta('isButton'):
			looking_at_object.press()
			
	if held_object:
		var ray_length = ($Camera.global_position - $Camera/ObjectlessLookRay.get_collision_point()).length()
		var target_pos = $Camera.global_position - $Camera.basis.z * minf(1.5,ray_length)
		held_object.linear_velocity = (target_pos - held_object.global_position) * 5
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = ($FlatDir.global_basis * Vector3(input_dir.x, 0, input_dir.y) * Vector3(1,0,1)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(delta) -> void:
	if Input.is_action_just_pressed("menu"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Camera.global_rotation_degrees = Vector3(
		clampf($Camera.global_rotation_degrees.x - mouse_motion_this_frame.y * MOUSE_SENS,-89,89),
		wrapf($Camera.global_rotation_degrees.y - mouse_motion_this_frame.x * MOUSE_SENS,-180,180),
		0
	)
	$FlatDir.global_rotation_degrees = $Camera.global_rotation_degrees
	$FlatDir.global_rotation_degrees.x = 0
	$Camera.global_position = global_position + Vector3(0,0.6,0)
	mouse_motion_this_frame = Vector2(0,0)
