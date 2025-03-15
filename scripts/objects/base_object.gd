extends RigidBody3D
class_name BaseObject

@export var id: String
@export var display_name: String
@export var icon_zoom_scale: float = 1.0

func lock_to_box(box: Node3D):
	freeze = true
	reparent(box,true)
	
func get_absorbed(by: Node3D) -> void:
	var original_position = global_position
	var original_size = scale
	freeze = true
	collision_layer = 0
	collision_mask = 0
	var i = 0
	while i < 1:
		i += .1
		await Utils.wait(0.01)
		global_position = lerp(original_position,by.global_position,i)
		scale = lerp(original_size,Vector3.ZERO,i)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
