extends StaticBody3D

@export var object_scene : String
@onready var object = load(object_scene)

func _ready():
	$Sprite3D/SubViewport/Control.add_child(
		Utils.iconify_object(object.instantiate())
	)

func press():
	var new_object = object.instantiate()
	get_tree().root.add_child(new_object)
	new_object.global_transform.origin = Vector3(3.2, 10, -4.3)
	for i in 20:
		self.position.z -= 0.01
		await Utils.wait(0.01)
	await Utils.wait(0.5)
	for i in 20:
		self.position.z += 0.01
		await Utils.wait(0.01)
