extends Node

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var game_scale = 3
	OS.set_window_size(Vector2(320 * game_scale, 180 * game_scale))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
