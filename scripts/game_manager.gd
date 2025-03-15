extends Node
class_name GameManager

const OBJECT_POOL = ["cube"]

signal on_new_order(new_order: Array[String])

@export var box: Node3D

var current_order: Array[String] = []

func new_order():
	current_order = []
	for i in range(1):
		current_order.append(OBJECT_POOL.pick_random())
	on_new_order.emit(current_order)
	$BoxAnimationPlayer.play("bring_box")

func try_send_order():
	var missing_objects = current_order.duplicate()
	var boxed_objects = []
	for obj in (box.get_node("Hitbox") as Area3D).get_overlapping_bodies():
		if obj is BaseObject:
			boxed_objects.append(obj)
			obj.lock_to_box(box)
			var index = missing_objects.find(obj.id)
			print(index)
			if index >= 0:
				missing_objects.remove_at(index)
	
	$BoxAnimationPlayer.play("send_box")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Engine.get_main_loop().process_frame
	new_order()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
