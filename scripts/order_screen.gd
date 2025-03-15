extends Control

@onready var game_manager = %GameManager as GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager.on_new_order.connect(func(new_order: Array[String]):
		for child in $GridContainer.get_children():
			child.queue_free()
		for obj in new_order:
			var obj_inst = load("res://scenes/objects/%s.tscn"%obj).instantiate()
			var instance = $ObjectTemplate.duplicate()
			$GridContainer.add_child(instance)
			instance.visible = true
			instance.get_node("Label").text = obj_inst.display_name
			var icon = Utils.iconify_object(obj_inst)
			print(icon)
			instance.get_node("IconContainer").add_child(icon)
		
		$OrdersRemaining.text = "Orders Left: " + str(game_manager.orders_remaining)
		
		var recipient = Names.FIRST_NAMES.pick_random() as String
		recipient = recipient[0].to_upper() + recipient.substr(1)
		$To.text = "To: %s\nRecipient: %s"%[game_manager.STATE_NAMES.pick_random(),recipient]
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
