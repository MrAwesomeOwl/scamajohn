extends Node
class_name GameManager

const OBJECT_POOL = ["cube"]

signal on_new_order(new_order: Array[String])

@export var box: Node3D

var current_order: Array[String] = []
var send_button_debounce = false

var orders_remaining = 10

func new_order():
	current_order = []
	for i in range(1):
		current_order.append(OBJECT_POOL.pick_random())
	on_new_order.emit(current_order)
	$BoxAnimationPlayer.play("bring_box")
	await Utils.wait(2)
	send_button_debounce = false

func try_send_order():
	if send_button_debounce == true: return
	send_button_debounce = true
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
	
	await Utils.wait(2)
	for obj in boxed_objects:
		obj.queue_free()
		
	if missing_objects.size() > 0:
		get_tree().change_scene_to_file("res://main.tscn")
		
	orders_remaining -= 1
		
	new_order()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Engine.get_main_loop().process_frame
	new_order()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
