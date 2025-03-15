extends Control

@onready var game_manager = %GameManager as GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('asdf"')
	game_manager.on_new_order.connect(func(new_order: Array[String]):
		print("dingus :D")
		$Label.text = str(new_order)
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
