extends BaseObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	print(body)
	if body is BaseObject:
		if body.id == "gift_card":
			await body.get_absorbed(self)
			Fader.stored_text = "bro that gift card had the nuclear launch codes. you just cooked the entire world"
			get_tree().change_scene_to_file("res://scenes/CutScenes/NukeExplosion.tscn")
