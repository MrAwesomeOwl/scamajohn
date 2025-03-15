extends StaticBody3D

@export var object_scene : String
@onready var object = load(object_scene)

func press():
	var new_object = object.instantiate()
	add_child(new_object)
	new_object.global_transform.origin = Vector3(3.2, 10, -4.3)
	for i in 20:
		self.position.z -= 0.01
		await Utils.wait(0.01)
	await Utils.wait(0.5)
	for i in 20:
		self.position.z += 0.01
		await Utils.wait(0.01)
