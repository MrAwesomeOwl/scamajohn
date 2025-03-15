extends Node

var template = preload("res://scenes/3d_icon_template.tscn")

func iconify_object(obj: BaseObject) -> Control:
	var zoom = obj.icon_zoom_scale
	var instance = template.instantiate()
	obj.freeze = true
	instance.get_node("Viewport/Node3D").add_child(obj)
	instance.get_node("Viewport/Node3D/CameraHolder").scale = Vector3(zoom,zoom,zoom)
	return instance

func wait(seconds:float):
	await get_tree().create_timer(seconds).timeout

func lerp_dt(start, goal, alpha: float, dt: float):
	alpha = 1 - pow(alpha , (dt * 60))
	
	return start + (goal - start) * alpha
