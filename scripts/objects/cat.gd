extends BaseObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	$CollisionShape3D.shape = $CollisionShape3D.shape.duplicate()
	$MeshInstance3D.mesh = $MeshInstance3D.mesh.duplicate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	print(body)
	if body is BaseObject:
		if body.id == "kidney":
			body.queue_free()
			$CollisionShape3D.shape.size += Vector3(0.2,0.2,0.2)
			$MeshInstance3D.mesh.size += Vector3(0.2,0.2,0.2)
		elif body.id == "can_of_bees":
			body.queue_free()
			queue_free()
