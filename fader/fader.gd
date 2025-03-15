extends CanvasLayer

func fade_to_black(message: String, color: Color = Color(0,0,0)):
	$Label.text = message
	$ColorRect.self_modulate = color
	$AnimationPlayer.play("fade_in")
	await Utils.wait(1.5)
	get_tree().change_scene_to_file("res://main.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
