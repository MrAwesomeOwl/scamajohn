extends RigidBody3D
class_name BaseObject

@export var id: String
@export var display_name: String
@export var icon_zoom_scale: float = 1.0

func lock_to_box(box: Node3D):
	freeze = true
	reparent(box,true)
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
