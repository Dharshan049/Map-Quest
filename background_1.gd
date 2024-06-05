extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var bg_offset
var parallax_rate
var is_secondary = false
var cam_pos
var cam_pos_y
var vertical_offset = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.name.split('_')[2] == '1':
		is_secondary = true
	if self.name.split('_')[1] == '1':
		parallax_rate = -0.04
		self.modulate = Color(0.5, 0.5, 0.6, 1)
	if self.name.split('_')[1] == '2':
		parallax_rate = -0.08
		vertical_offset = 1
		self.modulate = Color(0.5, 0.5, 0.6, 1)
	if self.name.split('_')[1] == '3':
		parallax_rate = -0.12
		vertical_offset = 130
		self.modulate = Color(0.5, 0.6, 0.8, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	cam_pos = get_node("/root/world/camera").position.x
	cam_pos_y = get_node("/root/world/camera").position.y
	bg_offset = cam_pos * parallax_rate + 320 * 1000
	self.position.x = fmod(bg_offset, 320)
	if is_secondary:
		self.position.x = fmod(bg_offset, 320) - 320
	if vertical_offset:
		self.position.y = vertical_offset + cam_pos_y * parallax_rate
