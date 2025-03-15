extends BaseObject

var bee_scene = preload("res://models/bee.blend")
var process_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	#$CollisionShape3D.shape = $CollisionShape3D.shape.duplicate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_delta = delta
		
func emit_bee():
	var bee = bee_scene.instantiate()
	add_child(bee)
	bee.top_level = true
	bee.global_position = global_position
	bee.global_rotation = Vector3(randf_range(-180,180),randf_range(-180,180),randf_range(-180,180))
	var direction = Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1)).normalized()
	var size = .5
	while size > 0.01:
		await Engine.get_main_loop().process_frame
		bee.global_position += direction * process_delta * 10
		size = Utils.lerp_dt(size,0,.97,process_delta)
		bee.scale = Vector3(size,size,size)
		

func _on_body_entered(body: Node) -> void:
	print(body)
	if body is BaseObject:
		if body.id == "kidney":
			body.queue_free()
			$CollisionShape3D.scale += Vector3(0.05,0.05,0.05)
			$Cat.scale += Vector3(0.05,0.05,0.05)
		elif body.id == "can_of_bees":
			await body.get_absorbed(self)
			$AnimationPlayer.play("bee_explosion")
			await Utils.wait(.5)
			for i in range(20):
				emit_bee()
			#body.queue_free()
			#queue_free()
