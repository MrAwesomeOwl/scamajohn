extends BaseObject

var spin = 0;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spin += delta
	$BlackHole.global_rotation = Vector3(0,spin,0)
