extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var fog_num
var fog_offset = Vector2(0, 0)
var motion_scale
var motion_ratio
var internal_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fog_num = self.name.split('_')[-1]
	if fog_num == '0':
		fog_offset.x = 60
		fog_offset.y = 70
	if fog_num == '1':
		fog_offset.x = -80
		fog_offset.y = 50
	if fog_num == '2':
		fog_offset.y = 80
	self.modulate = Color(1, 1, 1, 0.025)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(dt) -> void:
	internal_timer += dt
	if fog_num == '0':
		motion_scale = 10
		motion_ratio = 0.4
	if fog_num == '1':
		motion_scale = 5
		motion_ratio = 0.3
	if fog_num == '2':
		motion_scale = 15
		motion_ratio = 0.55
	self.position.x = fog_offset.x + sin(motion_ratio * internal_timer) * motion_scale
	self.position.y = fog_offset.y + sin(motion_ratio * internal_timer * 0.5) * motion_scale
