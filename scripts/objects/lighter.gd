extends BaseObject
const fire_scene = preload("res://scenes/fireParticles.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	#if body is BaseObject:
		#if body.id == "lighter": return
		#if body.has_meta("on_fire"): return
		#body.set_meta("on_fire",true)
		#body.add_child(fire_scene.instantiate())
		#await Utils.wait(1)
		#body.queue_free()
	pass
