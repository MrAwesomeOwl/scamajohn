extends Node
class_name GameManager

const OBJECT_POOL = ["lighter","cat","black_hole","kidney","can_of_bees","gift_card","nail_jar","t_shirt","nuke","gun"]
const STATE_NAMES = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District ", "of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"]

signal on_new_order(new_order: Array[String])

@export var box: Node3D

var current_order: Array[String] = []
var send_button_debounce = false

var orders_remaining = 10

func new_order():
	current_order = []
	for i in range(clamp(10-orders_remaining,1,6)):
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
	
	if orders_remaining <= 0:
		get_tree().change_scene_to_file("res://win_scene.tscn")
		
	new_order()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Engine.get_main_loop().process_frame
	new_order()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
