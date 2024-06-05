extends Node2D
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var cam_position = Vector2(0, 0)
var target_position = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("main_cam").make_current()
	cam_position = get_node("/root/world/player").position
	get_node("main_cam").align()
	get_node("main_cam").force_update_scroll()

func _process(dt):
	target_position = get_node("/root/world/player").position
	cam_position.x += (target_position.x - cam_position.x) / 14
	cam_position.y += (target_position.y - cam_position.y) / 14
	self.position = cam_position
	get_node("main_cam").align()
	get_node("main_cam").force_update_scroll()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
